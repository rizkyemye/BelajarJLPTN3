-- ============================================================================
-- UPLOAD KANJI N3 — satu file. Tempel di Supabase SQL Editor → Run.
-- Isi: tabel kanji + review_kanji + fungsi SRS + 42 hari (422 kanji)
-- Aman dijalankan berulang (if not exists / on conflict do nothing)
-- Butuh: tabel public.profiles (sudah ada dari skema.sql)
-- ============================================================================

-- ============================================================================
-- KANJI — kartu kanji + jadwal review sendiri
--
-- Kartu: depan kanji · belakang onyomi, kunyomi, arti, bushu, 3 kosakata
-- ============================================================================

-- ---------- 1. tabel kanji ----------
create table if not exists public.kanji (
  id         bigint generated always as identity primary key,
  level      text not null check (level in ('n5','n4','n3')),
  hari_ke    int  not null check (hari_ke >= 1),
  urutan     int  not null check (urutan between 1 and 20),

  kanji      text not null,
  onyomi     text,             -- ケイ・キョウ
  kunyomi    text,             -- へ.る
  arti       text not null,

  bushu      text,             -- 糸
  arti_bushu text,             -- benang

  kata       jsonb not null default '[]'::jsonb,  -- 3 kosakata: [{"k","y","a"}]

  created_at timestamptz not null default now(),
  unique (level, hari_ke, urutan),
  unique (level, kanji)
);

create index if not exists kanji_hari_idx on public.kanji (level, hari_ke, urutan);

-- ---------- 2. jadwal (fungsi murni, dipakai kanji & kosakata) ----------
create or replace function public.jadwal_berikut(p_tahap smallint, p_nilai text)
returns table (tahap smallint, jeda int)
language sql
immutable
as $$
  select
    t.tahap,
    (array[1, 3, 7, 14, 30])[greatest(1, least(5, t.tahap))] as jeda
  from (
    select case
      when p_nilai = 'lupa'  then 1
      when p_nilai = 'hafal' then least(5, greatest(1, coalesce(p_tahap, 0) + 1))
      else greatest(1, coalesce(p_tahap, 0))
    end::smallint as tahap
  ) t;
$$;

grant execute on function public.jadwal_berikut(smallint, text) to authenticated;

-- ---------- 3. review kanji ----------
create table if not exists public.review_kanji (
  user_id     uuid   not null references public.profiles(id) on delete cascade,
  kanji_id    bigint not null references public.kanji(id) on delete cascade,
  hari_ke     int    not null,
  status      text   not null default 'belum'
              check (status in ('belum','hafal','ulang')),
  tahap       smallint not null default 0,
  jatuh_tempo date,
  terakhir    date,
  dinilai_at  timestamptz,
  primary key (user_id, kanji_id)
);

create index if not exists review_kanji_tempo_idx on public.review_kanji (user_id, jatuh_tempo);

-- ---------- 4. nilai satu kanji ----------
create or replace function public.nilai_kanji(p_id bigint, p_nilai text)
returns table (tahap smallint, jatuh_tempo date)
language plpgsql
security definer
set search_path = public
as $$
declare
  t smallint;
  j int;
  lama smallint;
begin
  select r.tahap into lama
  from public.review_kanji r
  where r.user_id = auth.uid() and r.kanji_id = p_id;

  if lama is null then
    return;
  end if;

  select s.tahap, s.jeda into t, j from public.jadwal_berikut(lama, p_nilai) s;

  update public.review_kanji r
     set tahap       = t,
         jatuh_tempo = current_date + j,
         terakhir    = current_date,
         dinilai_at  = now(),
         status      = case when p_nilai = 'lupa' then 'ulang' else 'hafal' end
   where r.user_id = auth.uid() and r.kanji_id = p_id;

  return query select t, current_date + j;
end;
$$;

grant execute on function public.nilai_kanji(bigint, text) to authenticated;

-- ---------- 5. buka hari kanji (siapkan antrian) ----------
create or replace function public.mulai_hari_kanji(p_level text, p_hari int)
returns text
language plpgsql
security definer
set search_path = public
as $$
begin
  -- kanji berdiri sendiri: hari N terbuka kalau semua kanji hari N-1 sudah dinilai
  if p_hari > 1 and exists (
    select 1
    from public.review_kanji r
    join public.kanji k on k.id = r.kanji_id
    where r.user_id = auth.uid()
      and k.level   = p_level
      and k.hari_ke = p_hari - 1
      and r.status  = 'belum'
  ) then
    return 'terkunci';
  end if;

  insert into public.review_kanji (user_id, kanji_id, hari_ke, status)
  select auth.uid(), k.id, p_hari, 'belum'
  from public.kanji k
  where k.level = p_level and k.hari_ke = p_hari
  on conflict (user_id, kanji_id) do nothing;

  return 'mulai';
end;
$$;

grant execute on function public.mulai_hari_kanji(text, int) to authenticated;

-- ---------- 6. antrian review kanji ----------
create or replace function public.antrian_kanji(p_level text)
returns table (
  id bigint, kanji text, onyomi text, kunyomi text, arti text,
  bushu text, arti_bushu text, kata jsonb, tahap smallint
)
language sql
security definer
stable
set search_path = public
as $$
  select k.id, k.kanji, k.onyomi, k.kunyomi, k.arti,
         k.bushu, k.arti_bushu, k.kata, r.tahap
  from public.review_kanji r
  join public.kanji k on k.id = r.kanji_id
  where r.user_id = auth.uid()
    and k.level   = p_level
    and r.jatuh_tempo <= current_date
  order by r.jatuh_tempo, r.tahap, k.urutan
  limit 40;
$$;

grant execute on function public.antrian_kanji(text) to authenticated;

create or replace function public.jumlah_antrian_kanji(p_level text)
returns int
language sql
security definer
stable
set search_path = public
as $$
  select count(*)::int
  from public.review_kanji r
  join public.kanji k on k.id = r.kanji_id
  where r.user_id = auth.uid()
    and k.level = p_level
    and r.jatuh_tempo <= current_date;
$$;

grant execute on function public.jumlah_antrian_kanji(text) to authenticated;

-- ---------- 7. RLS ----------
alter table public.kanji        enable row level security;
alter table public.review_kanji enable row level security;

drop policy if exists "baca kanji" on public.kanji;
create policy "baca kanji"
  on public.kanji for select to authenticated using (true);

drop policy if exists "admin kelola kanji" on public.kanji;
create policy "admin kelola kanji"
  on public.kanji for all to authenticated
  using (public.apakah_admin()) with check (public.apakah_admin());

drop policy if exists "baca review kanji sendiri" on public.review_kanji;
create policy "baca review kanji sendiri"
  on public.review_kanji for select using (user_id = auth.uid());

drop policy if exists "tulis review kanji sendiri" on public.review_kanji;
create policy "tulis review kanji sendiri"
  on public.review_kanji for insert with check (user_id = auth.uid());

drop policy if exists "ubah review kanji sendiri" on public.review_kanji;
create policy "ubah review kanji sendiri"
  on public.review_kanji for update
  using (user_id = auth.uid()) with check (user_id = auth.uid());

-- ---------- 8. cek ----------
select count(*) as jumlah_kanji from public.kanji;


-- ============================================================================
-- DATA — 42 hari · 422 kanji
-- ============================================================================

-- ============================================================================
-- KANJI N3 — Hari 1 (10 kanji)
-- Tema: 経済・社会 (ekonomi & masyarakat) — nyambung dengan kosakata hari 1–31
-- ============================================================================

insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
('n3', 1,  1, '経', 'ケイ・キョウ', 'へ.る', 'lewat / mengelola', '糸', 'benang', '[
  {"k":"経済","y":"けいざい","a":"ekonomi"},
  {"k":"経験","y":"けいけん","a":"pengalaman"},
  {"k":"経由","y":"けいゆ","a":"melalui"}
]'::jsonb),

('n3', 1,  2, '験', 'ケン・ゲン', 'ため.す', 'menguji / tanda', '馬', 'kuda', '[
  {"k":"試験","y":"しけん","a":"ujian"},
  {"k":"経験","y":"けいけん","a":"pengalaman"},
  {"k":"実験","y":"じっけん","a":"eksperimen"}
]'::jsonb),

('n3', 1,  3, '済', 'サイ', 'す.む', 'selesai / beres', '水', 'air', '[
  {"k":"経済","y":"けいざい","a":"ekonomi"},
  {"k":"返済","y":"へんさい","a":"pelunasan"},
  {"k":"済む","y":"すむ","a":"selesai"}
]'::jsonb),

('n3', 1,  4, '政', 'セイ・ショウ', 'まつりごと', 'pemerintahan', '攴', 'memukul', '[
  {"k":"政府","y":"せいふ","a":"pemerintah"},
  {"k":"政治","y":"せいじ","a":"politik"},
  {"k":"政策","y":"せいさく","a":"kebijakan"}
]'::jsonb),

('n3', 1,  5, '治', 'ジ・チ', 'おさ.める・なお.る', 'memerintah / menyembuhkan', '水', 'air', '[
  {"k":"政治","y":"せいじ","a":"politik"},
  {"k":"治る","y":"なおる","a":"sembuh"},
  {"k":"治療","y":"ちりょう","a":"pengobatan"}
]'::jsonb),

('n3', 1,  6, '府', 'フ', null, 'pemerintah daerah', '广', 'rumah beratap', '[
  {"k":"政府","y":"せいふ","a":"pemerintah"},
  {"k":"大阪府","y":"おおさかふ","a":"Prefektur Osaka"},
  {"k":"府立","y":"ふりつ","a":"milik prefektur"}
]'::jsonb),

('n3', 1,  7, '議', 'ギ', null, 'musyawarah / rapat', '言', 'kata', '[
  {"k":"会議","y":"かいぎ","a":"rapat"},
  {"k":"議論","y":"ぎろん","a":"diskusi"},
  {"k":"議員","y":"ぎいん","a":"anggota dewan"}
]'::jsonb),

('n3', 1,  8, '員', 'イン', null, 'anggota', '口', 'mulut', '[
  {"k":"社員","y":"しゃいん","a":"karyawan"},
  {"k":"店員","y":"てんいん","a":"pramuniaga"},
  {"k":"全員","y":"ぜんいん","a":"semua orang"}
]'::jsonb),

('n3', 1,  9, '産', 'サン', 'う.む・う.まれる', 'melahirkan / produksi', '生', 'lahir', '[
  {"k":"産業","y":"さんぎょう","a":"industri"},
  {"k":"生産","y":"せいさん","a":"produksi"},
  {"k":"出産","y":"しゅっさん","a":"persalinan"}
]'::jsonb),

('n3', 1, 10, '業', 'ギョウ・ゴウ', 'わざ', 'usaha / pekerjaan', '木', 'pohon', '[
  {"k":"卒業","y":"そつぎょう","a":"kelulusan"},
  {"k":"業務","y":"ぎょうむ","a":"urusan pekerjaan"},
  {"k":"産業","y":"さんぎょう","a":"industri"}
]'::jsonb)

on conflict (level, kanji) do nothing;

-- tema hari ini
insert into public.tema_hari (level, hari_ke, tema, arti)
values ('n3', 1, '生活・経済', 'kehidupan & ekonomi')
on conflict (level, hari_ke) do nothing;

-- cek
select urutan, kanji, onyomi, kunyomi, arti, bushu, jsonb_array_length(kata) as jml_kata
from public.kanji where level = 'n3' and hari_ke = 1 order by urutan;

-- ===== Kanji Hari 2 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 2, 1, '出', 'シュツ・スイ', 'で.る・だ.す・い.でる', 'keluar / mengeluarkan', '凵', 'wadah terbuka', '[{"k": "出張", "y": "しゅっちょう", "a": "perjalanan dinas"}, {"k": "出発", "y": "しゅっぱつ", "a": "keberangkatan"}, {"k": "思い出", "y": "おもいで", "a": "kenangan"}]'::jsonb),
  ('n3', 2, 2, '合', 'ゴウ・ガッ・カッ', 'あ.う・あ.い・あ.わす', 'cocok / bergabung', '口', 'mulut', '[{"k": "知り合い", "y": "しりあい", "a": "kenalan"}, {"k": "合格", "y": "ごうかく", "a": "lulus (ujian)"}, {"k": "試合", "y": "しあい", "a": "pertandingan"}]'::jsonb),
  ('n3', 2, 3, '味', 'ミ', 'あじ・あじ.わう', 'rasa', '口', 'mulut', '[{"k": "味", "y": "あじ", "a": "rasa"}, {"k": "味噌", "y": "みそ", "a": "miso"}, {"k": "美味しい", "y": "おいしい", "a": "enak"}]'::jsonb),
  ('n3', 2, 4, '書', 'ショ', 'か.く', 'menulis', '曰', 'berkata', '[{"k": "図書館", "y": "としょかん", "a": "perpustakaan"}, {"k": "教科書", "y": "きょうかしょ", "a": "buku pelajaran"}, {"k": "辞書", "y": "じしょ", "a": "kamus"}]'::jsonb),
  ('n3', 2, 5, '大', 'ダイ・タイ', 'おお.きい', 'besar', '大', 'besar', '[{"k": "大人", "y": "おとな", "a": "orang dewasa"}, {"k": "大人しい", "y": "おとなしい", "a": "pendiam"}, {"k": "大会", "y": "たいかい", "a": "turnamen"}]'::jsonb),
  ('n3', 2, 6, '手', 'シュ・ズ', 'て', 'tangan', '手', 'tangan', '[{"k": "手", "y": "て", "a": "tangan"}, {"k": "苦手", "y": "にがて", "a": "kurang bisa"}, {"k": "選手", "y": "せんしゅ", "a": "pemain"}]'::jsonb),
  ('n3', 2, 7, '気', 'キ・ケ', 'いき・き', 'semangat / udara', '气', 'uap', '[{"k": "病気", "y": "びょうき", "a": "penyakit"}, {"k": "元気", "y": "げんき", "a": "sehat / bersemangat"}, {"k": "電気", "y": "でんき", "a": "listrik / lampu"}]'::jsonb),
  ('n3', 2, 8, '物', 'ブツ・モツ', 'もの', 'benda', '牛', 'sapi', '[{"k": "果物", "y": "くだもの", "a": "buah"}, {"k": "荷物", "y": "にもつ", "a": "barang bawaan"}, {"k": "建物", "y": "たてもの", "a": "bangunan"}]'::jsonb),
  ('n3', 2, 9, '所', 'ショ', 'ところ・どころ・とこ', 'tempat', '戶', 'pintu', '[{"k": "台所", "y": "だいどころ", "a": "dapur"}, {"k": "近所", "y": "きんじょ", "a": "lingkungan sekitar"}, {"k": "名所", "y": "めいしょ", "a": "tempat terkenal"}]'::jsonb),
  ('n3', 2, 10, '事', 'ジ・ズ', 'こと・つか.う・つか.える', 'hal / urusan', '亅', 'kait', '[{"k": "仕事", "y": "しごと", "a": "pekerjaan"}, {"k": "返事", "y": "へんじ", "a": "balasan"}, {"k": "大事", "y": "だいじ", "a": "penting"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 3 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 3, 1, '会', 'カイ・エ', 'あ.う・あ.わせる・あつ.まる', 'bertemu / perkumpulan', '人', 'orang', '[{"k": "会社", "y": "かいしゃ", "a": "perusahaan"}, {"k": "会議", "y": "かいぎ", "a": "rapat"}, {"k": "大会", "y": "たいかい", "a": "turnamen"}]'::jsonb),
  ('n3', 3, 2, '日', 'ニチ・ジツ', 'ひ', 'hari / matahari', '日', 'matahari', '[{"k": "今日", "y": "きょう", "a": "hari ini"}, {"k": "明日", "y": "あした", "a": "besok"}, {"k": "昨日", "y": "きのう", "a": "kemarin"}]'::jsonb),
  ('n3', 3, 3, '料', 'リョウ', null, 'bahan / biaya', '斗', 'takaran', '[{"k": "料理", "y": "りょうり", "a": "masakan"}, {"k": "料金", "y": "りょうきん", "a": "tarif / biaya"}, {"k": "無料", "y": "むりょう", "a": "gratis"}]'::jsonb),
  ('n3', 3, 4, '場', 'ジョウ・チョウ', 'ば', 'tempat / arena', '土', 'tanah', '[{"k": "売り場", "y": "うりば", "a": "bagian penjualan"}, {"k": "駐車場", "y": "ちゅうしゃじょう", "a": "tempat parkir"}, {"k": "場所", "y": "ばしょ", "a": "tempat"}]'::jsonb),
  ('n3', 3, 5, '道', 'ドウ・トウ', 'みち・いう', 'jalan', '辵', 'berjalan', '[{"k": "道", "y": "みち", "a": "jalan"}, {"k": "歩道", "y": "ほどう", "a": "trotoar"}, {"k": "水道", "y": "すいどう", "a": "air ledeng"}]'::jsonb),
  ('n3', 3, 6, '入', 'ニュウ・ジュ', 'い.る・い.れる・はい.る', 'masuk', '入', 'masuk', '[{"k": "押し入れ", "y": "おしいれ", "a": "lemari dinding"}, {"k": "入学", "y": "にゅうがく", "a": "masuk sekolah"}, {"k": "入口", "y": "いりぐち", "a": "pintu masuk"}]'::jsonb),
  ('n3', 3, 7, '上', 'ジョウ・ショウ・シャン', 'うえ・かみ・あ.げる', 'atas / naik', '一', 'satu', '[{"k": "上司", "y": "じょうし", "a": "atasan"}, {"k": "上手", "y": "じょうず", "a": "pandai"}, {"k": "上がる", "y": "あがる", "a": "naik"}]'::jsonb),
  ('n3', 3, 8, '意', 'イ', null, 'maksud / perhatian', '心', 'hati', '[{"k": "注意する", "y": "ちゅういする", "a": "berhati-hati / menegur"}, {"k": "得意", "y": "とくい", "a": "unggul / menguasai"}, {"k": "用意", "y": "ようい", "a": "persiapan"}]'::jsonb),
  ('n3', 3, 9, '家', 'カ・ケ', 'いえ・や・うち', 'rumah / keluarga', '宀', 'atap rumah', '[{"k": "家族", "y": "かぞく", "a": "keluarga"}, {"k": "家", "y": "いえ", "a": "rumah"}, {"k": "家具", "y": "かぐ", "a": "perabot"}]'::jsonb),
  ('n3', 3, 10, '間', 'カン・ケン', 'あいだ・ま・あい', 'jarak / antara', '門', 'pintu besar', '[{"k": "仲間", "y": "なかま", "a": "rekan / teman"}, {"k": "間違える", "y": "まちがえる", "a": "salah / keliru"}, {"k": "時間", "y": "じかん", "a": "waktu"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 4 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 4, 1, '人', 'ジン・ニン', 'ひと', 'orang', '人', 'orang', '[{"k": "恋人", "y": "こいびと", "a": "kekasih"}, {"k": "大人", "y": "おとな", "a": "orang dewasa"}, {"k": "一人暮らし", "y": "ひとりぐらし", "a": "tinggal sendiri"}]'::jsonb),
  ('n3', 4, 2, '一', 'イチ・イツ', 'ひと.つ', 'satu', '一', 'satu', '[{"k": "一人暮らし", "y": "ひとりぐらし", "a": "tinggal sendiri"}, {"k": "一日中", "y": "いちにちじゅう", "a": "sepanjang hari"}, {"k": "一度", "y": "いちど", "a": "sekali"}]'::jsonb),
  ('n3', 4, 3, '口', 'コウ・ク', 'くち', 'mulut', '口', 'mulut', '[{"k": "口", "y": "くち", "a": "mulut"}, {"k": "入口", "y": "いりぐち", "a": "pintu masuk"}, {"k": "出口", "y": "でぐち", "a": "pintu keluar"}]'::jsonb),
  ('n3', 4, 4, '理', 'リ', 'ことわり', 'alasan / logika', '玉', 'permata', '[{"k": "料理", "y": "りょうり", "a": "masakan"}, {"k": "無理", "y": "むり", "a": "mustahil / memaksakan"}, {"k": "料理人", "y": "りょうりにん", "a": "juru masak"}]'::jsonb),
  ('n3', 4, 5, '切', 'セツ・サイ', 'き.る・き.り・き.れる', 'memotong', '刀', 'pedang', '[{"k": "切符", "y": "きっぷ", "a": "tiket"}, {"k": "締め切り", "y": "しめきり", "a": "tenggat"}, {"k": "親切", "y": "しんせつ", "a": "ramah"}]'::jsonb),
  ('n3', 4, 6, '信', 'シン', null, 'percaya', '人', 'orang', '[{"k": "信号", "y": "しんごう", "a": "lampu lalu lintas"}, {"k": "信じる", "y": "しんじる", "a": "percaya"}, {"k": "返信", "y": "へんしん", "a": "balasan"}]'::jsonb),
  ('n3', 4, 7, '社', 'シャ', 'やしろ', 'perusahaan / kuil', '示', 'altar', '[{"k": "会社", "y": "かいしゃ", "a": "perusahaan"}, {"k": "社員", "y": "しゃいん", "a": "karyawan"}, {"k": "神社", "y": "じんじゃ", "a": "kuil Shinto"}]'::jsonb),
  ('n3', 4, 8, '面', 'メン・ベン', 'おも・おもて・つら', 'wajah / permukaan', '面', 'wajah', '[{"k": "面接", "y": "めんせつ", "a": "wawancara kerja"}, {"k": "真面目", "y": "まじめ", "a": "rajin / serius"}, {"k": "面白い", "y": "おもしろい", "a": "menarik / lucu"}]'::jsonb),
  ('n3', 4, 9, '習', 'シュウ・ジュ', 'なら.う・なら.い', 'belajar', '羽', 'bulu', '[{"k": "練習", "y": "れんしゅう", "a": "latihan"}, {"k": "習う", "y": "ならう", "a": "belajar (dari guru)"}, {"k": "復習", "y": "ふくしゅう", "a": "mengulang pelajaran"}]'::jsonb),
  ('n3', 4, 10, '予', 'ヨ・シャ', 'あらかじ.め', 'sebelumnya / rencana', '亅', 'kait', '[{"k": "予習", "y": "よしゅう", "a": "belajar sebelum kelas"}, {"k": "予定", "y": "よてい", "a": "rencana"}, {"k": "予約", "y": "よやく", "a": "reservasi"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 5 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 5, 1, '明', 'メイ・ミョウ・ミン', 'あ.かり・あか.るい・あか.るむ', 'terang / jelas', '日', 'matahari', '[{"k": "明るい", "y": "あかるい", "a": "ceria"}, {"k": "明日", "y": "あした", "a": "besok"}, {"k": "説明する", "y": "せつめいする", "a": "menjelaskan"}]'::jsonb),
  ('n3', 5, 2, '内', 'ナイ・ダイ', 'うち', 'dalam', '冂', 'kurungan', '[{"k": "案内", "y": "あんない", "a": "memandu"}, {"k": "案内所", "y": "あんないじょ", "a": "kantor informasi"}, {"k": "国内", "y": "こくない", "a": "dalam negeri"}]'::jsonb),
  ('n3', 5, 3, '通', 'ツウ・ツ', 'とお.る・とお.り・とお.す', 'lewat / lalu-lalang', '辵', 'berjalan', '[{"k": "通る", "y": "とおる", "a": "melewati"}, {"k": "通り", "y": "とおり", "a": "jalan (besar)"}, {"k": "通う", "y": "かよう", "a": "bolak-balik"}]'::jsonb),
  ('n3', 5, 4, '度', 'ド・ト・タク', 'たび', 'derajat / kali', '广', 'rumah beratap', '[{"k": "一度", "y": "いちど", "a": "sekali"}, {"k": "二度", "y": "にど", "a": "dua kali"}, {"k": "制度", "y": "せいど", "a": "sistem / aturan"}]'::jsonb),
  ('n3', 5, 5, '性', 'セイ・ショウ', 'さが', 'sifat / gender', '心', 'hati', '[{"k": "男性", "y": "だんせい", "a": "pria"}, {"k": "女性", "y": "じょせい", "a": "wanita"}, {"k": "可能性", "y": "かのうせい", "a": "kemungkinan"}]'::jsonb),
  ('n3', 5, 6, '目', 'モク・ボク', 'め', 'mata', '目', 'mata', '[{"k": "目", "y": "め", "a": "mata"}, {"k": "真面目", "y": "まじめ", "a": "rajin / serius"}, {"k": "目標", "y": "もくひょう", "a": "target"}]'::jsonb),
  ('n3', 5, 7, '品', 'ヒン・ホン', 'しな', 'barang / mutu', '口', 'mulut', '[{"k": "商品", "y": "しょうひん", "a": "barang dagangan"}, {"k": "部品", "y": "ぶひん", "a": "suku cadang"}, {"k": "食料品", "y": "しょくりょうひん", "a": "bahan makanan"}]'::jsonb),
  ('n3', 5, 8, '約', 'ヤク', 'つづ.まる・つづ.める・つづま.やか', 'janji / ringkas', '糸', 'benang', '[{"k": "節約", "y": "せつやく", "a": "berhemat"}, {"k": "契約", "y": "けいやく", "a": "kontrak"}, {"k": "予約", "y": "よやく", "a": "reservasi"}]'::jsonb),
  ('n3', 5, 9, '電', 'デン', null, 'listrik', '雨', 'hujan', '[{"k": "電車", "y": "でんしゃ", "a": "kereta listrik"}, {"k": "電気", "y": "でんき", "a": "listrik / lampu"}, {"k": "電話", "y": "でんわ", "a": "telepon"}]'::jsonb),
  ('n3', 5, 10, '行', 'コウ・ギョウ・アン', 'い.く・ゆ.く・おこな.う', 'pergi / baris', '行', 'jalan', '[{"k": "飛行機", "y": "ひこうき", "a": "pesawat"}, {"k": "旅行", "y": "りょこう", "a": "perjalanan"}, {"k": "銀行", "y": "ぎんこう", "a": "bank"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 6 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 6, 1, '時', 'ジ', 'とき', 'waktu / jam', '日', 'matahari', '[{"k": "時刻表", "y": "じこくひょう", "a": "jadwal keberangkatan"}, {"k": "時給", "y": "じきゅう", "a": "upah per jam"}, {"k": "時間", "y": "じかん", "a": "waktu"}]'::jsonb),
  ('n3', 6, 2, '部', 'ブ', null, 'bagian', '邑', 'kampung', '[{"k": "部屋", "y": "へや", "a": "kamar"}, {"k": "部署", "y": "ぶしょ", "a": "divisi"}, {"k": "部品", "y": "ぶひん", "a": "suku cadang"}]'::jsonb),
  ('n3', 6, 3, '報', 'ホウ', 'むく.いる', 'laporan / kabar', '土', 'tanah', '[{"k": "報告", "y": "ほうこく", "a": "laporan"}, {"k": "情報", "y": "じょうほう", "a": "informasi"}, {"k": "天気予報", "y": "てんきよほう", "a": "prakiraan cuaca"}]'::jsonb),
  ('n3', 6, 4, '話', 'ワ', 'はな.す・はなし', 'bicara / cerita', '言', 'kata', '[{"k": "電話", "y": "でんわ", "a": "telepon"}, {"k": "話す", "y": "はなす", "a": "berbicara"}, {"k": "話し合い", "y": "はなしあい", "a": "diskusi"}]'::jsonb),
  ('n3', 6, 5, '生', 'セイ・ショウ', 'い.きる・い.かす・い.ける', 'hidup / lahir', '生', 'lahir', '[{"k": "先生", "y": "せんせい", "a": "guru"}, {"k": "生徒", "y": "せいと", "a": "murid"}, {"k": "生まれる", "y": "うまれる", "a": "lahir"}]'::jsonb),
  ('n3', 6, 6, '先', 'セン', 'さき・ま.ず', 'depan / lebih dulu', '儿', 'kaki manusia', '[{"k": "先生", "y": "せんせい", "a": "guru"}, {"k": "先に", "y": "さきに", "a": "lebih dulu"}, {"k": "宛先", "y": "あてさき", "a": "alamat tujuan"}]'::jsonb),
  ('n3', 6, 7, '成', 'セイ・ジョウ', 'な.る・な.す', 'menjadi / berhasil', '戈', 'tombak', '[{"k": "成績", "y": "せいせき", "a": "nilai (sekolah)"}, {"k": "成果", "y": "せいか", "a": "hasil kerja"}, {"k": "成長", "y": "せいちょう", "a": "pertumbuhan"}]'::jsonb),
  ('n3', 6, 8, '地', 'チ・ジ', null, 'tanah / daratan', '土', 'tanah', '[{"k": "地震", "y": "じしん", "a": "gempa bumi"}, {"k": "地図", "y": "ちず", "a": "peta"}, {"k": "地下鉄", "y": "ちかてつ", "a": "kereta bawah tanah"}]'::jsonb),
  ('n3', 6, 9, '感', 'カン', null, 'rasa / kesan', '心', 'hati', '[{"k": "感情", "y": "かんじょう", "a": "emosi"}, {"k": "感じる", "y": "かんじる", "a": "merasakan"}, {"k": "感謝", "y": "かんしゃ", "a": "rasa syukur"}]'::jsonb),
  ('n3', 6, 10, '心', 'シン', 'こころ', 'hati', '心', 'hati', '[{"k": "心配", "y": "しんぱい", "a": "khawatir"}, {"k": "熱心", "y": "ねっしん", "a": "rajin / bersemangat"}, {"k": "中心", "y": "ちゅうしん", "a": "pusat"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 7 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 7, 1, '後', 'ゴ・コウ', 'のち・うし.ろ・うしろ', 'belakang / sesudah', '彳', 'langkah', '[{"k": "後悔", "y": "こうかい", "a": "penyesalan"}, {"k": "最後に", "y": "さいごに", "a": "terakhir"}, {"k": "後ろ", "y": "うしろ", "a": "belakang"}]'::jsonb),
  ('n3', 7, 2, '着', 'チャク・ジャク', 'き.る・き.せる・つ.く', 'memakai / tiba', '目', 'mata', '[{"k": "落ち着く", "y": "おちつく", "a": "tenang / rileks"}, {"k": "到着", "y": "とうちゃく", "a": "kedatangan"}, {"k": "着る", "y": "きる", "a": "memakai (atasan)"}]'::jsonb),
  ('n3', 7, 3, '中', 'チュウ', 'なか・うち・あた.る', 'tengah / dalam', '丨', 'garis vertikal', '[{"k": "途中", "y": "とちゅう", "a": "di tengah jalan"}, {"k": "一日中", "y": "いちにちじゅう", "a": "sepanjang hari"}, {"k": "中心", "y": "ちゅうしん", "a": "pusat"}]'::jsonb),
  ('n3', 7, 4, '期', 'キ・ゴ', null, 'periode', '月', 'bulan', '[{"k": "期間", "y": "きかん", "a": "periode"}, {"k": "期限", "y": "きげん", "a": "batas waktu"}, {"k": "納期", "y": "のうき", "a": "tenggat pengiriman"}]'::jsonb),
  ('n3', 7, 5, '付', 'フ', 'つ.ける・つ.け・つ.く', 'menempel / melampirkan', '人', 'orang', '[{"k": "片付ける", "y": "かたづける", "a": "merapikan"}, {"k": "片付け", "y": "かたづけ", "a": "merapikan"}, {"k": "味付け", "y": "あじつけ", "a": "bumbu"}]'::jsonb),
  ('n3', 7, 6, '分', 'ブン・フン・ブ', 'わ.ける・わ.け・わ.かれる', 'menit / mengerti / bagian', '刀', 'pedang', '[{"k": "分かる", "y": "わかる", "a": "mengerti"}, {"k": "十分", "y": "じゅうぶん", "a": "cukup"}, {"k": "半分", "y": "はんぶん", "a": "setengah"}]'::jsonb),
  ('n3', 7, 7, '決', 'ケツ', 'き.める・き.まる・さ.く', 'memutuskan', '水', 'air', '[{"k": "決める", "y": "きめる", "a": "memutuskan"}, {"k": "決まる", "y": "きまる", "a": "ditentukan"}, {"k": "決意", "y": "けつい", "a": "tekad"}]'::jsonb),
  ('n3', 7, 8, '数', 'スウ・ス・サク', 'かず・かぞ.える・しばしば', 'angka', '攴', 'memukul', '[{"k": "数える", "y": "かぞえる", "a": "menghitung"}, {"k": "数", "y": "かず", "a": "jumlah"}, {"k": "多数", "y": "たすう", "a": "banyak orang"}]'::jsonb),
  ('n3', 7, 9, '知', 'チ', 'し.る・し.らせる', 'tahu', '矢', 'panah', '[{"k": "知り合い", "y": "しりあい", "a": "kenalan"}, {"k": "知る", "y": "しる", "a": "tahu"}, {"k": "承知", "y": "しょうち", "a": "mengerti (formal)"}]'::jsonb),
  ('n3', 7, 10, '風', 'フウ・フ', 'かぜ', 'angin / gaya', '風', 'angin', '[{"k": "風邪", "y": "かぜ", "a": "masuk angin"}, {"k": "風呂", "y": "ふろ", "a": "bak mandi"}, {"k": "風", "y": "かぜ", "a": "angin"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 8 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 8, 1, '食', 'ショク・ジキ', 'く.う・く.らう・た.べる', 'makan', '食', 'makan', '[{"k": "食材", "y": "しょくざい", "a": "bahan makanan"}, {"k": "食べ過ぎ", "y": "たべすぎ", "a": "makan berlebihan"}, {"k": "食料品", "y": "しょくりょうひん", "a": "bahan makanan"}]'::jsonb),
  ('n3', 8, 2, '空', 'クウ', 'そら・あ.く・あ.き', 'langit / kosong', '穴', 'lubang', '[{"k": "空腹", "y": "くうふく", "a": "lapar"}, {"k": "空港", "y": "くうこう", "a": "bandara"}, {"k": "空", "y": "そら", "a": "langit"}]'::jsonb),
  ('n3', 8, 3, '段', 'ダン・タン', null, 'tingkat / undakan', '殳', 'senjata', '[{"k": "値段", "y": "ねだん", "a": "harga"}, {"k": "階段", "y": "かいだん", "a": "tangga"}, {"k": "手段", "y": "しゅだん", "a": "cara / sarana"}]'::jsonb),
  ('n3', 8, 4, '金', 'キン・コン・ゴン', 'かね', 'uang / emas', '金', 'emas', '[{"k": "料金", "y": "りょうきん", "a": "tarif / biaya"}, {"k": "現金", "y": "げんきん", "a": "uang tunai"}, {"k": "貯金", "y": "ちょきん", "a": "tabungan"}]'::jsonb),
  ('n3', 8, 5, '引', 'イン', 'ひ.く・ひ.ける', 'menarik', '弓', 'busur', '[{"k": "割引", "y": "わりびき", "a": "diskon"}, {"k": "引っ越す", "y": "ひっこす", "a": "pindah rumah"}, {"k": "引っ越し", "y": "ひっこし", "a": "pindahan"}]'::jsonb),
  ('n3', 8, 6, '割', 'カツ', 'わ.る・わり・わ.り', 'membagi / rasio', '刀', 'pedang', '[{"k": "割引", "y": "わりびき", "a": "diskon"}, {"k": "時間割", "y": "じかんわり", "a": "jadwal pelajaran"}, {"k": "割合", "y": "わりあい", "a": "proporsi"}]'::jsonb),
  ('n3', 8, 7, '安', 'アン', 'やす.い・やす.まる・やす', 'murah / aman', '宀', 'atap rumah', '[{"k": "安い", "y": "やすい", "a": "murah"}, {"k": "安全", "y": "あんぜん", "a": "aman"}, {"k": "不安", "y": "ふあん", "a": "gelisah"}]'::jsonb),
  ('n3', 8, 8, '売', 'バイ', 'う.る・う.れる', 'menjual', '士', 'ksatria', '[{"k": "売る", "y": "うる", "a": "menjual"}, {"k": "売り場", "y": "うりば", "a": "bagian penjualan"}, {"k": "売上", "y": "うりあげ", "a": "penjualan"}]'::jsonb),
  ('n3', 8, 9, '返', 'ヘン', 'かえ.す・かえ.る', 'mengembalikan', '辵', 'berjalan', '[{"k": "返す", "y": "かえす", "a": "mengembalikan"}, {"k": "返事", "y": "へんじ", "a": "balasan"}, {"k": "返信", "y": "へんしん", "a": "balasan"}]'::jsonb),
  ('n3', 8, 10, '交', 'コウ', 'まじ.わる・まじ.える・ま.じる', 'bergantian / bercampur', '亠', 'penutup atas', '[{"k": "交換", "y": "こうかん", "a": "menukar"}, {"k": "交差点", "y": "こうさてん", "a": "persimpangan"}, {"k": "交番", "y": "こうばん", "a": "pos polisi"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 9 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 9, 1, '給', 'キュウ', 'たま.う・たも.う', 'gaji / memberi', '糸', 'benang', '[{"k": "給料", "y": "きゅうりょう", "a": "gaji"}, {"k": "時給", "y": "じきゅう", "a": "upah per jam"}, {"k": "有給", "y": "ゆうきゅう", "a": "cuti berbayar"}]'::jsonb),
  ('n3', 9, 2, '車', 'シャ', 'くるま', 'kendaraan', '車', 'kendaraan', '[{"k": "電車", "y": "でんしゃ", "a": "kereta listrik"}, {"k": "車", "y": "くるま", "a": "mobil"}, {"k": "駐車場", "y": "ちゅうしゃじょう", "a": "tempat parkir"}]'::jsonb),
  ('n3', 9, 3, '機', 'キ', 'はた', 'mesin / kesempatan', '木', 'pohon', '[{"k": "飛行機", "y": "ひこうき", "a": "pesawat"}, {"k": "機械", "y": "きかい", "a": "mesin"}, {"k": "機会", "y": "きかい", "a": "kesempatan"}]'::jsonb),
  ('n3', 9, 4, '自', 'ジ・シ', 'みずか.ら・おの.ずから・おの.ずと', 'sendiri', '自', 'diri', '[{"k": "自転車", "y": "じてんしゃ", "a": "sepeda"}, {"k": "自然", "y": "しぜん", "a": "alam"}, {"k": "自由", "y": "じゆう", "a": "bebas"}]'::jsonb),
  ('n3', 9, 5, '転', 'テン', 'ころ.がる・ころ.げる・ころ.がす', 'berputar / pindah', '車', 'kendaraan', '[{"k": "自転車", "y": "じてんしゃ", "a": "sepeda"}, {"k": "運転", "y": "うんてん", "a": "menyetir"}, {"k": "転送", "y": "てんそう", "a": "meneruskan"}]'::jsonb),
  ('n3', 9, 6, '天', 'テン', 'あまつ・あめ', 'langit', '大', 'besar', '[{"k": "天井", "y": "てんじょう", "a": "langit-langit"}, {"k": "天気", "y": "てんき", "a": "cuaca"}, {"k": "天気予報", "y": "てんきよほう", "a": "prakiraan cuaca"}]'::jsonb),
  ('n3', 9, 7, '洗', 'セン', 'あら.う', 'mencuci', '水', 'air', '[{"k": "洗濯", "y": "せんたく", "a": "mencuci (pakaian)"}, {"k": "洗う", "y": "あらう", "a": "mencuci"}, {"k": "洗濯物", "y": "せんたくもの", "a": "cucian"}]'::jsonb),
  ('n3', 9, 8, '近', 'キン・コン', 'ちか.い', 'dekat', '辵', 'berjalan', '[{"k": "近所", "y": "きんじょ", "a": "lingkungan sekitar"}, {"k": "最近", "y": "さいきん", "a": "akhir-akhir ini"}, {"k": "近く", "y": "ちかく", "a": "dekat"}]'::jsonb),
  ('n3', 9, 9, '頼', 'ライ', 'たの.む・たの.もしい・たよ.る', 'meminta / mempercayakan', '頁', 'kepala', '[{"k": "依頼", "y": "いらい", "a": "permintaan"}, {"k": "頼む", "y": "たのむ", "a": "meminta"}, {"k": "頼る", "y": "たよる", "a": "bergantung / minta tolong"}]'::jsonb),
  ('n3', 9, 10, '名', 'メイ・ミョウ', 'な', 'nama', '口', 'mulut', '[{"k": "名刺", "y": "めいし", "a": "kartu nama"}, {"k": "名所", "y": "めいしょ", "a": "tempat terkenal"}, {"k": "名前", "y": "なまえ", "a": "nama"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 10 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 10, 1, '教', 'キョウ', 'おし.える・おそ.わる', 'mengajar', '攴', 'memukul', '[{"k": "教室", "y": "きょうしつ", "a": "ruang kelas"}, {"k": "教科書", "y": "きょうかしょ", "a": "buku pelajaran"}, {"k": "教える", "y": "おしえる", "a": "mengajar"}]'::jsonb),
  ('n3', 10, 2, '月', 'ゲツ・ガツ', 'つき', 'bulan', '月', 'bulan', '[{"k": "月", "y": "つき", "a": "bulan"}, {"k": "来月", "y": "らいげつ", "a": "bulan depan"}, {"k": "正月", "y": "しょうがつ", "a": "tahun baru Jepang"}]'::jsonb),
  ('n3', 10, 3, '定', 'テイ・ジョウ', 'さだ.める・さだ.まる・さだ.か', 'tetap / menetapkan', '宀', 'atap rumah', '[{"k": "予定", "y": "よてい", "a": "rencana"}, {"k": "設定", "y": "せってい", "a": "pengaturan"}, {"k": "定価", "y": "ていか", "a": "harga resmi"}]'::jsonb),
  ('n3', 10, 4, '最', 'サイ・シュ', 'もっと.も・つま', 'paling', '曰', 'berkata', '[{"k": "最近", "y": "さいきん", "a": "akhir-akhir ini"}, {"k": "最後に", "y": "さいごに", "a": "terakhir"}, {"k": "最大", "y": "さいだい", "a": "maksimum"}]'::jsonb),
  ('n3', 10, 5, '画', 'ガ・カク・エ', 'えが.く・かく.する・かぎ.る', 'gambar', '田', 'sawah', '[{"k": "画面", "y": "がめん", "a": "layar"}, {"k": "映画", "y": "えいが", "a": "film"}, {"k": "計画", "y": "けいかく", "a": "rencana"}]'::jsonb),
  ('n3', 10, 6, '続', 'ゾク・ショク・コウ', 'つづ.く・つづ.ける・つぐ.ない', 'melanjutkan', '糸', 'benang', '[{"k": "続ける", "y": "つづける", "a": "melanjutkan"}, {"k": "続く", "y": "つづく", "a": "berlanjut"}, {"k": "接続", "y": "せつぞく", "a": "koneksi"}]'::jsonb),
  ('n3', 10, 7, '下', 'カ・ゲ', 'した・しも・もと', 'bawah / turun', '一', 'satu', '[{"k": "下手", "y": "へた", "a": "tidak pandai"}, {"k": "下がる", "y": "さがる", "a": "turun"}, {"k": "以下", "y": "いか", "a": "kurang dari"}]'::jsonb),
  ('n3', 10, 8, '案', 'アン', 'つくえ', 'ide / rancangan', '木', 'pohon', '[{"k": "案内", "y": "あんない", "a": "memandu"}, {"k": "案内所", "y": "あんないじょ", "a": "kantor informasi"}, {"k": "提案", "y": "ていあん", "a": "usulan"}]'::jsonb),
  ('n3', 10, 9, '国', 'コク', 'くに', 'negara', '囗', 'kurungan penuh', '[{"k": "国内", "y": "こくない", "a": "dalam negeri"}, {"k": "出国", "y": "しゅっこく", "a": "keluar negeri"}, {"k": "入国", "y": "にゅうこく", "a": "masuk negara"}]'::jsonb),
  ('n3', 10, 10, '待', 'タイ', 'ま.つ', 'menunggu', '彳', 'langkah', '[{"k": "待つ", "y": "まつ", "a": "menunggu"}, {"k": "待ち合わせ", "y": "まちあわせ", "a": "janji temu"}, {"k": "待ち時間", "y": "まちじかん", "a": "waktu tunggu"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 11 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 11, 1, '見', 'ケン', 'み.る・み.える・み.せる', 'melihat', '見', 'melihat', '[{"k": "見る", "y": "みる", "a": "melihat"}, {"k": "花見", "y": "はなみ", "a": "melihat bunga"}, {"k": "見積もり", "y": "みつもり", "a": "estimasi biaya"}]'::jsonb),
  ('n3', 11, 2, '変', 'ヘン', 'か.わる・か.わり・か.える', 'berubah / aneh', '夂', 'kaki lambat', '[{"k": "変える", "y": "かえる", "a": "mengubah"}, {"k": "変わる", "y": "かわる", "a": "berubah"}, {"k": "変", "y": "へん", "a": "aneh"}]'::jsonb),
  ('n3', 11, 3, '小', 'ショウ', 'ちい.さい', 'kecil', '小', 'kecil', '[{"k": "小さい", "y": "ちいさい", "a": "kecil"}, {"k": "小包", "y": "こづつみ", "a": "paket"}, {"k": "最小", "y": "さいしょう", "a": "minimum"}]'::jsonb),
  ('n3', 11, 4, '新', 'シン', 'あたら.しい・あら.た', 'baru', '斤', 'kapak', '[{"k": "新しい", "y": "あたらしい", "a": "baru"}, {"k": "新幹線", "y": "しんかんせん", "a": "shinkansen"}, {"k": "更新", "y": "こうしん", "a": "pembaruan"}]'::jsonb),
  ('n3', 11, 5, '少', 'ショウ', 'すく.ない・すこ.し', 'sedikit', '小', 'kecil', '[{"k": "少ない", "y": "すくない", "a": "sedikit"}, {"k": "少し", "y": "すこし", "a": "sedikit"}, {"k": "減少", "y": "げんしょう", "a": "pengurangan"}]'::jsonb),
  ('n3', 11, 6, '特', 'トク', null, 'khusus', '牛', 'sapi', '[{"k": "特別", "y": "とくべつ", "a": "istimewa"}, {"k": "特に", "y": "とくに", "a": "terutama"}, {"k": "特徴", "y": "とくちょう", "a": "ciri khas"}]'::jsonb),
  ('n3', 11, 7, '方', 'ホウ', 'かた', 'cara / arah', '方', 'arah', '[{"k": "方針", "y": "ほうしん", "a": "kebijakan / arah"}, {"k": "方法", "y": "ほうほう", "a": "metode"}, {"k": "一方", "y": "いっぽう", "a": "di sisi lain"}]'::jsonb),
  ('n3', 11, 8, '能', 'ノウ', 'よ.く・あた.う', 'kemampuan', '肉', 'daging', '[{"k": "能力", "y": "のうりょく", "a": "kemampuan"}, {"k": "才能", "y": "さいのう", "a": "bakat"}, {"k": "機能", "y": "きのう", "a": "fungsi"}]'::jsonb),
  ('n3', 11, 9, '力', 'リョク・リキ・リイ', 'ちから', 'tenaga', '力', 'tenaga', '[{"k": "能力", "y": "のうりょく", "a": "kemampuan"}, {"k": "協力", "y": "きょうりょく", "a": "kerja sama"}, {"k": "実力", "y": "じつりょく", "a": "kemampuan nyata"}]'::jsonb),
  ('n3', 11, 10, '親', 'シン', 'おや・した.しい・した.しむ', 'orang tua / akrab', '見', 'melihat', '[{"k": "両親", "y": "りょうしん", "a": "orang tua"}, {"k": "親戚", "y": "しんせき", "a": "kerabat"}, {"k": "親切", "y": "しんせつ", "a": "ramah"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 12 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 12, 1, '子', 'シ・ス・ツ', 'こ・ね', 'anak', '子', 'anak', '[{"k": "息子", "y": "むすこ", "a": "anak laki-laki"}, {"k": "子供", "y": "こども", "a": "anak"}, {"k": "双子", "y": "ふたご", "a": "kembar"}]'::jsonb),
  ('n3', 12, 2, '熱', 'ネツ', 'あつ.い', 'panas / demam', '火', 'api', '[{"k": "熱", "y": "ねつ", "a": "demam"}, {"k": "熱心", "y": "ねっしん", "a": "rajin / bersemangat"}, {"k": "熱い", "y": "あつい", "a": "panas (benda)"}]'::jsonb),
  ('n3', 12, 3, '動', 'ドウ', 'うご.く・うご.かす', 'bergerak', '力', 'tenaga', '[{"k": "運動", "y": "うんどう", "a": "olahraga"}, {"k": "動く", "y": "うごく", "a": "bergerak / berfungsi"}, {"k": "感動", "y": "かんどう", "a": "terharu"}]'::jsonb),
  ('n3', 12, 4, '果', 'カ', 'は.たす・はた.す・は.てる', 'buah / hasil', '木', 'pohon', '[{"k": "果物", "y": "くだもの", "a": "buah"}, {"k": "結果", "y": "けっか", "a": "hasil"}, {"k": "成果", "y": "せいか", "a": "hasil kerja"}]'::jsonb),
  ('n3', 12, 5, '油', 'ユ・ユウ', 'あぶら', 'minyak', '水', 'air', '[{"k": "油", "y": "あぶら", "a": "minyak"}, {"k": "醤油", "y": "しょうゆ", "a": "kecap asin"}, {"k": "油っこい", "y": "あぶらっこい", "a": "berminyak"}]'::jsonb),
  ('n3', 12, 6, '節', 'セツ・セチ', 'ふし・のっと', 'sendi / berhemat', '竹', 'bambu', '[{"k": "節約", "y": "せつやく", "a": "berhemat"}, {"k": "季節", "y": "きせつ", "a": "musim"}, {"k": "節分", "y": "せつぶん", "a": "setsubun"}]'::jsonb),
  ('n3', 12, 7, '歩', 'ホ・ブ・フ', 'ある.く・あゆ.む', 'berjalan', '止', 'berhenti', '[{"k": "歩道", "y": "ほどう", "a": "trotoar"}, {"k": "歩く", "y": "あるく", "a": "berjalan"}, {"k": "進歩", "y": "しんぽ", "a": "kemajuan"}]'::jsonb),
  ('n3', 12, 8, '遅', 'チ', 'おく.れる・おく.らす・おそ.い', 'terlambat / lambat', '辵', 'berjalan', '[{"k": "遅れる", "y": "おくれる", "a": "terlambat"}, {"k": "遅刻", "y": "ちこく", "a": "terlambat masuk"}, {"k": "遅い", "y": "おそい", "a": "lambat"}]'::jsonb),
  ('n3', 12, 9, '屋', 'オク', 'や', 'atap / toko', '尸', 'jenazah', '[{"k": "部屋", "y": "へや", "a": "kamar"}, {"k": "屋根", "y": "やね", "a": "atap"}, {"k": "屋上", "y": "おくじょう", "a": "atap gedung"}]'::jsonb),
  ('n3', 12, 10, '台', 'ダイ・タイ', 'うてな・われ・つかさ', 'alas / unit (mesin)', '口', 'mulut', '[{"k": "台所", "y": "だいどころ", "a": "dapur"}, {"k": "台風", "y": "たいふう", "a": "topan"}, {"k": "台", "y": "だい", "a": "unit (mesin)"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 13 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 13, 1, '関', 'カン', 'せき・かか.わる・からくり', 'berhubungan', '門', 'pintu besar', '[{"k": "玄関", "y": "げんかん", "a": "pintu masuk"}, {"k": "関心", "y": "かんしん", "a": "perhatian"}, {"k": "関係", "y": "かんけい", "a": "hubungan"}]'::jsonb),
  ('n3', 13, 2, '具', 'グ', 'そな.える・つぶさ.に', 'alat', '八', 'delapan', '[{"k": "家具", "y": "かぐ", "a": "perabot"}, {"k": "道具", "y": "どうぐ", "a": "alat"}, {"k": "具体的", "y": "ぐたいてき", "a": "konkret"}]'::jsonb),
  ('n3', 13, 3, '越', 'エツ・オツ', 'こ.す・こ.える', 'melewati', '走', 'berlari', '[{"k": "引っ越す", "y": "ひっこす", "a": "pindah rumah"}, {"k": "越える", "y": "こえる", "a": "melewati"}, {"k": "引っ越し", "y": "ひっこし", "a": "pindahan"}]'::jsonb),
  ('n3', 13, 4, '住', 'ジュウ・ヂュウ・チュウ', 'す.む・す.まう', 'tinggal', '人', 'orang', '[{"k": "住む", "y": "すむ", "a": "tinggal"}, {"k": "住所", "y": "じゅうしょ", "a": "alamat"}, {"k": "住宅", "y": "じゅうたく", "a": "perumahan"}]'::jsonb),
  ('n3', 13, 5, '残', 'ザン・サン', 'のこ.る・のこ.す・そこな.う', 'tersisa', '歹', 'tulang', '[{"k": "残業", "y": "ざんぎょう", "a": "lembur"}, {"k": "残る", "y": "のこる", "a": "tersisa"}, {"k": "残り", "y": "のこり", "a": "sisa"}]'::jsonb),
  ('n3', 13, 6, '辞', 'ジ', 'や.める・いな.む', 'kata / mengundurkan diri', '辛', 'pedas', '[{"k": "辞める", "y": "やめる", "a": "berhenti (kerja)"}, {"k": "辞書", "y": "じしょ", "a": "kamus"}, {"k": "お辞儀", "y": "おじぎ", "a": "membungkuk"}]'::jsonb),
  ('n3', 13, 7, '学', 'ガク', 'まな.ぶ', 'belajar', '子', 'anak', '[{"k": "学校", "y": "がっこう", "a": "sekolah"}, {"k": "入学", "y": "にゅうがく", "a": "masuk sekolah"}, {"k": "進学", "y": "しんがく", "a": "melanjutkan sekolah"}]'::jsonb),
  ('n3', 13, 8, '題', 'ダイ', null, 'topik / judul', '頁', 'kepala', '[{"k": "宿題", "y": "しゅくだい", "a": "pekerjaan rumah"}, {"k": "問題", "y": "もんだい", "a": "masalah"}, {"k": "課題", "y": "かだい", "a": "tugas / tantangan"}]'::jsonb),
  ('n3', 13, 9, '音', 'オン・イン・-ノン', 'おと・ね', 'bunyi', '音', 'suara', '[{"k": "発音", "y": "はつおん", "a": "pelafalan"}, {"k": "音", "y": "おと", "a": "bunyi"}, {"k": "音楽", "y": "おんがく", "a": "musik"}]'::jsonb),
  ('n3', 13, 10, '違', 'イ', 'ちが.う・ちが.い・ちが.える', 'berbeda', '辵', 'berjalan', '[{"k": "間違える", "y": "まちがえる", "a": "salah / keliru"}, {"k": "違う", "y": "ちがう", "a": "berbeda"}, {"k": "違い", "y": "ちがい", "a": "perbedaan"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 14 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 14, 1, '山', 'サン・セン', 'やま', 'gunung', '山', 'gunung', '[{"k": "山", "y": "やま", "a": "gunung"}, {"k": "火山", "y": "かざん", "a": "gunung berapi"}, {"k": "登山", "y": "とざん", "a": "mendaki gunung"}]'::jsonb),
  ('n3', 14, 2, '今', 'コン・キン', 'いま', 'sekarang', '人', 'orang', '[{"k": "今日", "y": "きょう", "a": "hari ini"}, {"k": "今週", "y": "こんしゅう", "a": "minggu ini"}, {"k": "今すぐ", "y": "いますぐ", "a": "sekarang juga"}]'::jsonb),
  ('n3', 14, 3, '年', 'ネン', 'とし', 'tahun', '干', 'kering', '[{"k": "去年", "y": "きょねん", "a": "tahun lalu"}, {"k": "毎年", "y": "まいとし", "a": "tiap tahun"}, {"k": "年末", "y": "ねんまつ", "a": "akhir tahun"}]'::jsonb),
  ('n3', 14, 4, '毎', 'マイ', 'ごと', 'setiap', '毋', 'jangan', '[{"k": "毎週", "y": "まいしゅう", "a": "tiap minggu"}, {"k": "毎月", "y": "まいつき", "a": "tiap bulan"}, {"k": "毎年", "y": "まいとし", "a": "tiap tahun"}]'::jsonb),
  ('n3', 14, 5, '利', 'リ', 'き.く', 'untung / manfaat', '刀', 'pedang', '[{"k": "便利", "y": "べんり", "a": "praktis"}, {"k": "利益", "y": "りえき", "a": "keuntungan"}, {"k": "権利", "y": "けんり", "a": "hak"}]'::jsonb),
  ('n3', 14, 6, '楽', 'ガク・ラク・ゴウ', 'たの.しい・たの.しむ・この.む', 'senang', '木', 'pohon', '[{"k": "音楽", "y": "おんがく", "a": "musik"}, {"k": "楽器", "y": "がっき", "a": "alat musik"}, {"k": "楽しい", "y": "たのしい", "a": "menyenangkan"}]'::jsonb),
  ('n3', 14, 7, '歌', 'カ', 'うた・うた.う', 'lagu', '欠', 'kurang', '[{"k": "歌", "y": "うた", "a": "lagu"}, {"k": "歌舞伎", "y": "かぶき", "a": "kabuki"}, {"k": "歌う", "y": "うたう", "a": "menyanyi"}]'::jsonb),
  ('n3', 14, 8, '選', 'セン', 'えら.ぶ・え.る・よ.る', 'memilih', '辵', 'berjalan', '[{"k": "選手", "y": "せんしゅ", "a": "pemain"}, {"k": "選ぶ", "y": "えらぶ", "a": "memilih"}, {"k": "選挙", "y": "せんきょ", "a": "pemilu"}]'::jsonb),
  ('n3', 14, 9, '集', 'シュウ', 'あつ.まる・あつ.める・つど.う', 'mengumpulkan', '隹', 'burung kecil', '[{"k": "集める", "y": "あつめる", "a": "mengumpulkan"}, {"k": "集まる", "y": "あつまる", "a": "berkumpul"}, {"k": "集中", "y": "しゅうちゅう", "a": "konsentrasi"}]'::jsonb),
  ('n3', 14, 10, '観', 'カン', 'み.る・しめ.す', 'mengamati / menonton', '見', 'melihat', '[{"k": "観戦", "y": "かんせん", "a": "menonton pertandingan"}, {"k": "観光", "y": "かんこう", "a": "wisata"}, {"k": "観光客", "y": "かんこうきゃく", "a": "turis"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 15 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 15, 1, '思', 'シ', 'おも.う・おもえら.く・おぼ.す', 'berpikir / merasa', '心', 'hati', '[{"k": "思い出", "y": "おもいで", "a": "kenangan"}, {"k": "思う", "y": "おもう", "a": "merasa / berpikir"}, {"k": "思い出す", "y": "おもいだす", "a": "mengingat kembali"}]'::jsonb),
  ('n3', 15, 2, '術', 'ジュツ', 'すべ', 'teknik', '行', 'jalan', '[{"k": "美術館", "y": "びじゅつかん", "a": "museum seni"}, {"k": "芸術", "y": "げいじゅつ", "a": "seni"}, {"k": "技術", "y": "ぎじゅつ", "a": "teknologi / teknik"}]'::jsonb),
  ('n3', 15, 3, '立', 'リツ・リュウ・リットル', 'た.つ・た.てる', 'berdiri', '立', 'berdiri', '[{"k": "立つ", "y": "たつ", "a": "berdiri"}, {"k": "立派", "y": "りっぱ", "a": "megah / hebat"}, {"k": "立場", "y": "たちば", "a": "posisi / sudut pandang"}]'::jsonb),
  ('n3', 15, 4, '認', 'ニン', 'みと.める・したた.める', 'mengakui', '言', 'kata', '[{"k": "認める", "y": "みとめる", "a": "mengakui"}, {"k": "承認", "y": "しょうにん", "a": "persetujuan"}, {"k": "確認", "y": "かくにん", "a": "konfirmasi / memastikan"}]'::jsonb),
  ('n3', 15, 5, '進', 'シン', 'すす.む・すす.める', 'maju', '辵', 'berjalan', '[{"k": "進む", "y": "すすむ", "a": "maju / berjalan"}, {"k": "進歩", "y": "しんぽ", "a": "kemajuan"}, {"k": "進学", "y": "しんがく", "a": "melanjutkan sekolah"}]'::jsonb),
  ('n3', 15, 6, '長', 'チョウ', 'なが.い・おさ', 'panjang / ketua', '長', 'panjang', '[{"k": "長い", "y": "ながい", "a": "panjang"}, {"k": "成長", "y": "せいちょう", "a": "pertumbuhan"}, {"k": "長さ", "y": "ながさ", "a": "panjang"}]'::jsonb),
  ('n3', 15, 7, '正', 'セイ・ショウ', 'ただ.しい・ただ.す・まさ', 'benar', '止', 'berhenti', '[{"k": "正しい", "y": "ただしい", "a": "benar"}, {"k": "正直", "y": "しょうじき", "a": "jujur"}, {"k": "正月", "y": "しょうがつ", "a": "tahun baru Jepang"}]'::jsonb),
  ('n3', 15, 8, '全', 'ゼン', 'まった.く・すべ.て', 'seluruh', '入', 'masuk', '[{"k": "安全", "y": "あんぜん", "a": "aman"}, {"k": "全部", "y": "ぜんぶ", "a": "semua"}, {"k": "全然", "y": "ぜんぜん", "a": "sama sekali (negatif)"}]'::jsonb),
  ('n3', 15, 9, '必', 'ヒツ', 'かなら.ず', 'pasti', '心', 'hati', '[{"k": "必ず", "y": "かならず", "a": "pasti"}, {"k": "必要性", "y": "ひつようせい", "a": "keperluan"}, {"k": "必要", "y": "ひつよう", "a": "perlu / kebutuhan"}]'::jsonb),
  ('n3', 15, 10, '実', 'ジツ・シツ', 'み・みの.る・まこと', 'nyata / buah', '宀', 'atap rumah', '[{"k": "実は", "y": "じつは", "a": "sebenarnya"}, {"k": "実行", "y": "じっこう", "a": "pelaksanaan"}, {"k": "実力", "y": "じつりょく", "a": "kemampuan nyata"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 16 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 16, 1, '記', 'キ', 'しる.す', 'mencatat', '言', 'kata', '[{"k": "日記", "y": "にっき", "a": "buku harian"}, {"k": "記事", "y": "きじ", "a": "artikel"}, {"k": "記憶", "y": "きおく", "a": "ingatan"}]'::jsonb),
  ('n3', 16, 2, '用', 'ヨウ', 'もち.いる', 'memakai / urusan', '用', 'memakai', '[{"k": "用意", "y": "ようい", "a": "persiapan"}, {"k": "費用", "y": "ひよう", "a": "biaya"}, {"k": "信用", "y": "しんよう", "a": "kepercayaan / kredibilitas"}]'::jsonb),
  ('n3', 16, 3, '件', 'ケン', 'くだん', 'hal / perkara', '人', 'orang', '[{"k": "事件", "y": "じけん", "a": "insiden"}, {"k": "件名", "y": "けんめい", "a": "subjek"}, {"k": "条件", "y": "じょうけん", "a": "syarat"}]'::jsonb),
  ('n3', 16, 4, '相', 'ソウ・ショウ', null, 'saling / wujud', '目', 'mata', '[{"k": "相撲", "y": "すもう", "a": "sumo"}, {"k": "相談する", "y": "そうだんする", "a": "berkonsultasi"}, {"k": "相談", "y": "そうだん", "a": "berkonsultasi"}]'::jsonb),
  ('n3', 16, 5, '計', 'ケイ', 'はか.る・はか.らう', 'mengukur / total', '言', 'kata', '[{"k": "会計", "y": "かいけい", "a": "akuntansi"}, {"k": "合計", "y": "ごうけい", "a": "total"}, {"k": "計画", "y": "けいかく", "a": "rencana"}]'::jsonb),
  ('n3', 16, 6, '連', 'レン', 'つら.なる・つら.ねる・つ.れる', 'rangkaian / menghubungkan', '辵', 'berjalan', '[{"k": "連絡先", "y": "れんらくさき", "a": "kontak"}, {"k": "家族連れ", "y": "かぞくづれ", "a": "rombongan keluarga"}, {"k": "連絡", "y": "れんらく", "a": "kabar / menghubungi"}]'::jsonb),
  ('n3', 16, 7, '談', 'ダン', null, 'berbicara', '言', 'kata', '[{"k": "面談", "y": "めんだん", "a": "pertemuan / wawancara"}, {"k": "相談する", "y": "そうだんする", "a": "berkonsultasi"}, {"k": "相談", "y": "そうだん", "a": "berkonsultasi"}]'::jsonb),
  ('n3', 16, 8, '以', 'イ', 'もっ.て', 'lebih dari / sejak', '人', 'orang', '[{"k": "以上", "y": "いじょう", "a": "lebih dari"}, {"k": "以下", "y": "いか", "a": "kurang dari"}, {"k": "以内", "y": "いない", "a": "dalam batas"}]'::jsonb),
  ('n3', 16, 9, '的', 'テキ', 'まと', 'bersifat', '白', 'putih', '[{"k": "目的", "y": "もくてき", "a": "tujuan"}, {"k": "具体的", "y": "ぐたいてき", "a": "konkret"}, {"k": "一般的", "y": "いっぱんてき", "a": "umum"}]'::jsonb),
  ('n3', 16, 10, '想', 'ソウ・ソ', 'おも.う', 'pikiran', '心', 'hati', '[{"k": "想像", "y": "そうぞう", "a": "imajinasi"}, {"k": "予想", "y": "よそう", "a": "perkiraan"}, {"k": "感想", "y": "かんそう", "a": "kesan"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 17 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 17, 1, '価', 'カ・ケ', 'あたい', 'nilai', '人', 'orang', '[{"k": "定価", "y": "ていか", "a": "harga resmi"}, {"k": "物価", "y": "ぶっか", "a": "harga barang"}, {"k": "評価", "y": "ひょうか", "a": "penilaian"}]'::jsonb),
  ('n3', 17, 2, '席', 'セキ', 'むしろ', 'kursi', '巾', 'kain', '[{"k": "座席", "y": "ざせき", "a": "kursi"}, {"k": "出席", "y": "しゅっせき", "a": "kehadiran"}, {"k": "欠席", "y": "けっせき", "a": "tidak hadir"}]'::jsonb),
  ('n3', 17, 3, '職', 'ショク・ソク', null, 'pekerjaan', '耳', 'telinga', '[{"k": "就職", "y": "しゅうしょく", "a": "mendapat pekerjaan"}, {"k": "転職", "y": "てんしょく", "a": "pindah kerja"}, {"k": "職場", "y": "しょくば", "a": "tempat kerja"}]'::jsonb),
  ('n3', 17, 4, '族', 'ゾク', null, 'keluarga / suku', '方', 'arah', '[{"k": "家族", "y": "かぞく", "a": "keluarga"}, {"k": "家族連れ", "y": "かぞくづれ", "a": "rombongan keluarga"}]'::jsonb),
  ('n3', 17, 5, '兄', 'ケイ・キョウ', 'あに', 'kakak laki-laki', '儿', 'kaki manusia', '[{"k": "兄", "y": "あに", "a": "kakak laki-laki"}, {"k": "兄弟", "y": "きょうだい", "a": "saudara kandung"}]'::jsonb),
  ('n3', 17, 6, '弟', 'テイ・ダイ・デ', 'おとうと', 'adik laki-laki', '弓', 'busur', '[{"k": "弟", "y": "おとうと", "a": "adik laki-laki"}, {"k": "兄弟", "y": "きょうだい", "a": "saudara kandung"}]'::jsonb),
  ('n3', 17, 7, '祖', 'ソ', null, 'leluhur', '示', 'altar', '[{"k": "祖父", "y": "そふ", "a": "kakek"}, {"k": "祖母", "y": "そぼ", "a": "nenek"}]'::jsonb),
  ('n3', 17, 8, '彼', 'ヒ', 'かれ・かの・か.の', 'dia (pria)', '彳', 'langkah', '[{"k": "彼", "y": "かれ", "a": "dia (pria)"}, {"k": "彼女", "y": "かのじょ", "a": "dia (wanita)"}]'::jsonb),
  ('n3', 17, 9, '女', 'ジョ・ニョ・ニョウ', 'おんな・め', 'perempuan', '女', 'perempuan', '[{"k": "彼女", "y": "かのじょ", "a": "dia (wanita)"}, {"k": "女性", "y": "じょせい", "a": "wanita"}]'::jsonb),
  ('n3', 17, 10, '体', 'タイ・テイ', 'からだ・かたち', 'tubuh', '人', 'orang', '[{"k": "体", "y": "からだ", "a": "tubuh"}, {"k": "具体的", "y": "ぐたいてき", "a": "konkret"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 18 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 18, 1, '足', 'ソク', 'あし・た.りる・た.る', 'kaki / cukup', '足', 'kaki', '[{"k": "足", "y": "あし", "a": "kaki"}, {"k": "満足", "y": "まんぞく", "a": "puas"}]'::jsonb),
  ('n3', 18, 2, '指', 'シ', 'ゆび・さ.す', 'jari / menunjuk', '手', 'tangan', '[{"k": "指", "y": "ゆび", "a": "jari"}, {"k": "指示", "y": "しじ", "a": "instruksi"}]'::jsonb),
  ('n3', 18, 3, '病', 'ビョウ・ヘイ', 'や.む・やまい', 'sakit / penyakit', '疒', 'sakit', '[{"k": "病気", "y": "びょうき", "a": "penyakit"}, {"k": "病院", "y": "びょういん", "a": "rumah sakit"}]'::jsonb),
  ('n3', 18, 4, '我', 'ガ', 'われ・わ', 'diri sendiri', '戈', 'tombak', '[{"k": "怪我", "y": "けが", "a": "cedera"}, {"k": "我慢", "y": "がまん", "a": "menahan / bersabar"}]'::jsonb),
  ('n3', 18, 5, '痛', 'ツウ', 'いた.い・いた.む・いた.ましい', 'nyeri', '疒', 'sakit', '[{"k": "痛み", "y": "いたみ", "a": "rasa sakit"}, {"k": "痛い", "y": "いたい", "a": "sakit / nyeri"}]'::jsonb),
  ('n3', 18, 6, '眠', 'ミン', 'ねむ.る・ねむ.い', 'tidur / mengantuk', '目', 'mata', '[{"k": "眠い", "y": "ねむい", "a": "mengantuk"}, {"k": "睡眠", "y": "すいみん", "a": "tidur"}]'::jsonb),
  ('n3', 18, 7, '運', 'ウン', 'はこ.ぶ', 'membawa / keberuntungan', '辵', 'berjalan', '[{"k": "運動", "y": "うんどう", "a": "olahraga"}, {"k": "運転", "y": "うんてん", "a": "menyetir"}]'::jsonb),
  ('n3', 18, 8, '噌', 'ソウ・ショウ・ソ', 'かまびす.しい', 'pasta kedelai (miso)', '口', 'mulut', '[{"k": "味噌", "y": "みそ", "a": "miso"}, {"k": "味噌汁", "y": "みそしる", "a": "sup miso"}]'::jsonb),
  ('n3', 18, 9, '苦', 'ク', 'くる.しい・くる.しむ・くる.しめる', 'pahit / susah', '艸', 'rumput', '[{"k": "苦い", "y": "にがい", "a": "pahit"}, {"k": "苦手", "y": "にがて", "a": "kurang bisa"}]'::jsonb),
  ('n3', 18, 10, '美', 'ビ・ミ', 'うつく.しい', 'indah', '羊', 'domba', '[{"k": "美味しい", "y": "おいしい", "a": "enak"}, {"k": "美術館", "y": "びじゅつかん", "a": "museum seni"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 19 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 19, 1, '払', 'フツ・ヒツ・ホツ', 'はら.う', 'membayar', '手', 'tangan', '[{"k": "支払う", "y": "しはらう", "a": "membayar"}, {"k": "払う", "y": "はらう", "a": "membayar"}]'::jsonb),
  ('n3', 19, 2, '支', 'シ', 'ささ.える・つか.える・か.う', 'menopang / cabang', '支', 'cabang', '[{"k": "支払う", "y": "しはらう", "a": "membayar"}, {"k": "支え", "y": "ささえ", "a": "penopang / dukungan"}]'::jsonb),
  ('n3', 19, 3, '現', 'ゲン', 'あらわ.れる・あらわ.す・うつつ', 'nyata / muncul', '玉', 'permata', '[{"k": "現金", "y": "げんきん", "a": "uang tunai"}, {"k": "現地", "y": "げんち", "a": "lokasi setempat"}]'::jsonb),
  ('n3', 19, 4, '無', 'ム・ブ', 'な.い', 'tidak ada / gratis', '火', 'api', '[{"k": "無料", "y": "むりょう", "a": "gratis"}, {"k": "無理", "y": "むり", "a": "mustahil / memaksakan"}]'::jsonb),
  ('n3', 19, 5, '店', 'テン', 'みせ・たな', 'toko', '广', 'rumah beratap', '[{"k": "店", "y": "みせ", "a": "toko"}, {"k": "商店街", "y": "しょうてんがい", "a": "kawasan pertokoan"}]'::jsonb),
  ('n3', 19, 6, '商', 'ショウ', 'あきな.う', 'berdagang', '口', 'mulut', '[{"k": "商品", "y": "しょうひん", "a": "barang dagangan"}, {"k": "商店街", "y": "しょうてんがい", "a": "kawasan pertokoan"}]'::jsonb),
  ('n3', 19, 7, '換', 'カン', 'か.える・か.わる', 'menukar', '手', 'tangan', '[{"k": "交換", "y": "こうかん", "a": "menukar"}, {"k": "乗り換え", "y": "のりかえ", "a": "transit / ganti kendaraan"}]'::jsonb),
  ('n3', 19, 8, '布', 'フ・ホ', 'ぬの・し.く・きれ', 'kain', '巾', 'kain', '[{"k": "財布", "y": "さいふ", "a": "dompet"}, {"k": "布団", "y": "ふとん", "a": "futon"}]'::jsonb),
  ('n3', 19, 9, '釣', 'チョウ', 'つ.る・つ.り', 'memancing', '金', 'emas', '[{"k": "お釣り", "y": "おつり", "a": "uang kembalian"}, {"k": "釣り", "y": "つり", "a": "memancing"}]'::jsonb),
  ('n3', 19, 10, '乗', 'ジョウ・ショウ', 'の.る・の.せる', 'naik (kendaraan)', '丿', 'coretan kiri', '[{"k": "乗る", "y": "のる", "a": "naik (kendaraan)"}, {"k": "乗り換え", "y": "のりかえ", "a": "transit / ganti kendaraan"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 20 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 20, 1, '港', 'コウ', 'みなと', 'pelabuhan', '水', 'air', '[{"k": "空港", "y": "くうこう", "a": "bandara"}, {"k": "港", "y": "みなと", "a": "pelabuhan"}]'::jsonb),
  ('n3', 20, 2, '滞', 'タイ・テイ', 'とどこお.る', 'tinggal sementara', '水', 'air', '[{"k": "渋滞", "y": "じゅうたい", "a": "macet"}, {"k": "滞在", "y": "たいざい", "a": "masa tinggal"}]'::jsonb),
  ('n3', 20, 3, '刻', 'コク', 'きざ.む・きざ.み', 'mengukir / waktu', '刀', 'pedang', '[{"k": "時刻表", "y": "じこくひょう", "a": "jadwal keberangkatan"}, {"k": "遅刻", "y": "ちこく", "a": "terlambat masuk"}]'::jsonb),
  ('n3', 20, 4, '急', 'キュウ', 'いそ.ぐ・いそ.ぎ・せ.く', 'cepat / mendesak', '心', 'hati', '[{"k": "急ぐ", "y": "いそぐ", "a": "bergegas"}, {"k": "急に", "y": "きゅうに", "a": "tiba-tiba"}]'::jsonb),
  ('n3', 20, 5, '向', 'コウ', 'む.く・む.い・む.ける', 'menghadap', '口', 'mulut', '[{"k": "向かう", "y": "むかう", "a": "menuju"}, {"k": "向上", "y": "こうじょう", "a": "peningkatan"}]'::jsonb),
  ('n3', 20, 6, '曲', 'キョク', 'ま.がる・ま.げる・くま', 'melengkung / lagu', '曰', 'berkata', '[{"k": "曲がる", "y": "まがる", "a": "berbelok"}, {"k": "曲がり角", "y": "まがりかど", "a": "tikungan"}]'::jsonb),
  ('n3', 20, 7, '復', 'フク', 'また', 'kembali', '彳', 'langkah', '[{"k": "往復", "y": "おうふく", "a": "pulang-pergi"}, {"k": "復習", "y": "ふくしゅう", "a": "mengulang pelajaran"}]'::jsonb),
  ('n3', 20, 8, '階', 'カイ', 'きざはし', 'lantai / tingkat', '阜', 'bukit', '[{"k": "階段", "y": "かいだん", "a": "tangga"}, {"k": "段階", "y": "だんかい", "a": "tahap"}]'::jsonb),
  ('n3', 20, 9, '水', 'スイ', 'みず', 'air', '水', 'air', '[{"k": "水道", "y": "すいどう", "a": "air ledeng"}, {"k": "洪水", "y": "こうずい", "a": "banjir"}]'::jsonb),
  ('n3', 20, 10, '濯', 'タク', 'すす.ぐ・ゆす.ぐ', 'mencuci', '水', 'air', '[{"k": "洗濯", "y": "せんたく", "a": "mencuci (pakaian)"}, {"k": "洗濯物", "y": "せんたくもの", "a": "cucian"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 21 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 21, 1, '広', 'コウ', 'ひろ.い・ひろ.まる・ひろ.める', 'luas', '广', 'rumah beratap', '[{"k": "広い", "y": "ひろい", "a": "luas"}, {"k": "広さ", "y": "ひろさ", "a": "luas"}]'::jsonb),
  ('n3', 21, 2, '司', 'シ', 'つかさど.る', 'mengurus', '口', 'mulut', '[{"k": "上司", "y": "じょうし", "a": "atasan"}, {"k": "寿司", "y": "すし", "a": "sushi"}]'::jsonb),
  ('n3', 21, 3, '同', 'ドウ', 'おな.じ', 'sama', '口', 'mulut', '[{"k": "同僚", "y": "どうりょう", "a": "rekan kerja"}, {"k": "同じ", "y": "おなじ", "a": "sama"}]'::jsonb),
  ('n3', 21, 4, '張', 'チョウ', 'は.る', 'membentang / bersikeras', '弓', 'busur', '[{"k": "出張", "y": "しゅっちょう", "a": "perjalanan dinas"}, {"k": "緊張", "y": "きんちょう", "a": "tegang"}]'::jsonb),
  ('n3', 21, 5, '休', 'キュウ', 'やす.む・やす.まる・やす.める', 'istirahat', '人', 'orang', '[{"k": "休み", "y": "やすみ", "a": "libur"}, {"k": "休憩", "y": "きゅうけい", "a": "istirahat sejenak"}]'::jsonb),
  ('n3', 21, 6, '接', 'セツ・ショウ', 'つ.ぐ', 'bersentuhan', '手', 'tangan', '[{"k": "面接", "y": "めんせつ", "a": "wawancara kerja"}, {"k": "接続", "y": "せつぞく", "a": "koneksi"}]'::jsonb),
  ('n3', 21, 7, '告', 'コク', 'つ.げる', 'memberi tahu', '口', 'mulut', '[{"k": "報告", "y": "ほうこく", "a": "laporan"}, {"k": "報告する", "y": "ほうこくする", "a": "melaporkan"}]'::jsonb),
  ('n3', 21, 8, '真', 'シン', 'ま・まこと', 'benar / asli', '目', 'mata', '[{"k": "真面目", "y": "まじめ", "a": "rajin / serius"}, {"k": "写真", "y": "しゃしん", "a": "foto"}]'::jsonb),
  ('n3', 21, 9, '試', 'シ', 'こころ.みる・ため.す', 'mencoba / ujian', '言', 'kata', '[{"k": "試験", "y": "しけん", "a": "ujian"}, {"k": "試合", "y": "しあい", "a": "pertandingan"}]'::jsonb),
  ('n3', 21, 10, '格', 'カク・コウ・キャク', null, 'tingkat / status', '木', 'pohon', '[{"k": "合格", "y": "ごうかく", "a": "lulus (ujian)"}, {"k": "性格", "y": "せいかく", "a": "sifat / watak"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 22 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 22, 1, '図', 'ズ・ト', 'え・はか.る', 'gambar / rencana', '囗', 'kurungan penuh', '[{"k": "図書館", "y": "としょかん", "a": "perpustakaan"}, {"k": "地図", "y": "ちず", "a": "peta"}]'::jsonb),
  ('n3', 22, 2, '館', 'カン', 'やかた・たて', 'gedung', '食', 'makan', '[{"k": "図書館", "y": "としょかん", "a": "perpustakaan"}, {"k": "美術館", "y": "びじゅつかん", "a": "museum seni"}]'::jsonb),
  ('n3', 22, 3, '問', 'モン', 'と.う・と.い・とん', 'bertanya', '口', 'mulut', '[{"k": "質問", "y": "しつもん", "a": "pertanyaan"}, {"k": "問題", "y": "もんだい", "a": "masalah"}]'::jsonb),
  ('n3', 22, 4, '忘', 'ボウ', 'わす.れる', 'lupa', '心', 'hati', '[{"k": "忘れる", "y": "わすれる", "a": "lupa"}, {"k": "忘れ物", "y": "わすれもの", "a": "barang tertinggal"}]'::jsonb),
  ('n3', 22, 5, '文', 'ブン・モン', 'ふみ・あや', 'tulisan / kalimat', '文', 'tulisan', '[{"k": "作文", "y": "さくぶん", "a": "karangan"}, {"k": "文化", "y": "ぶんか", "a": "budaya"}]'::jsonb),
  ('n3', 22, 6, '発', 'ハツ・ホツ', 'た.つ・あば.く・おこ.る', 'berangkat / menerbitkan', '癶', 'kaki terbuka', '[{"k": "発音", "y": "はつおん", "a": "pelafalan"}, {"k": "出発", "y": "しゅっぱつ", "a": "keberangkatan"}]'::jsonb),
  ('n3', 22, 7, '温', 'オン', 'あたた.か・あたた.かい・あたた.まる', 'hangat', '水', 'air', '[{"k": "気温", "y": "きおん", "a": "suhu udara"}, {"k": "温泉", "y": "おんせん", "a": "sumber air panas"}]'::jsonb),
  ('n3', 22, 8, '海', 'カイ', 'うみ', 'laut', '水', 'air', '[{"k": "海", "y": "うみ", "a": "laut"}, {"k": "海外", "y": "かいがい", "a": "luar negeri"}]'::jsonb),
  ('n3', 22, 9, '花', 'カ・ケ', 'はな', 'bunga', '艸', 'rumput', '[{"k": "花", "y": "はな", "a": "bunga"}, {"k": "花見", "y": "はなみ", "a": "melihat bunga"}]'::jsonb),
  ('n3', 22, 10, '然', 'ゼン・ネン', 'しか・しか.り・しか.し', 'begitu / keadaan', '火', 'api', '[{"k": "自然", "y": "しぜん", "a": "alam"}, {"k": "全然", "y": "ぜんぜん", "a": "sama sekali (negatif)"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 23 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 23, 1, '情', 'ジョウ・セイ', 'なさ.け', 'perasaan / keadaan', '心', 'hati', '[{"k": "感情", "y": "かんじょう", "a": "emosi"}, {"k": "情報", "y": "じょうほう", "a": "informasi"}]'::jsonb),
  ('n3', 23, 2, '優', 'ユウ・ウ', 'やさ.しい・すぐ.れる・まさ.る', 'unggul / lembut', '人', 'orang', '[{"k": "優しい", "y": "やさしい", "a": "baik hati"}, {"k": "優先", "y": "ゆうせん", "a": "prioritas"}]'::jsonb),
  ('n3', 23, 3, '満', 'マン・バン', 'み.ちる・み.つ・み.たす', 'penuh', '水', 'air', '[{"k": "満足", "y": "まんぞく", "a": "puas"}, {"k": "満員", "y": "まんいん", "a": "penuh (orang)"}]'::jsonb),
  ('n3', 23, 4, '悔', 'カイ', 'く.いる・く.やむ・くや.しい', 'menyesal', '心', 'hati', '[{"k": "後悔", "y": "こうかい", "a": "penyesalan"}, {"k": "悔しい", "y": "くやしい", "a": "kesal / menyesal"}]'::jsonb),
  ('n3', 23, 5, '落', 'ラク', 'お.ちる・お.ち・お.とす', 'jatuh', '艸', 'rumput', '[{"k": "落ち着く", "y": "おちつく", "a": "tenang / rileks"}, {"k": "落ちる", "y": "おちる", "a": "jatuh"}]'::jsonb),
  ('n3', 23, 6, '昨', 'サク', null, 'kemarin', '日', 'matahari', '[{"k": "昨日", "y": "きのう", "a": "kemarin"}, {"k": "一昨日", "y": "おととい", "a": "kemarin lusa"}]'::jsonb),
  ('n3', 23, 7, '週', 'シュウ', null, 'minggu', '辵', 'berjalan', '[{"k": "今週", "y": "こんしゅう", "a": "minggu ini"}, {"k": "毎週", "y": "まいしゅう", "a": "tiap minggu"}]'::jsonb),
  ('n3', 23, 8, '来', 'ライ・タイ', 'く.る・きた.る・きた.す', 'datang', '木', 'pohon', '[{"k": "来月", "y": "らいげつ", "a": "bulan depan"}, {"k": "将来", "y": "しょうらい", "a": "masa depan"}]'::jsonb),
  ('n3', 23, 9, '将', 'ショウ・ソウ', 'まさ.に・はた・まさ', 'akan / panglima', '寸', 'ukuran', '[{"k": "将来", "y": "しょうらい", "a": "masa depan"}, {"k": "将棋", "y": "しょうぎ", "a": "shogi"}]'::jsonb),
  ('n3', 23, 10, '早', 'ソウ・サッ', 'はや.い・はや・はや.まる', 'cepat / pagi', '日', 'matahari', '[{"k": "早い", "y": "はやい", "a": "cepat / awal"}, {"k": "早口", "y": "はやくち", "a": "bicara cepat"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 24 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 24, 1, '壊', 'カイ・エ', 'こわ.す・こわ.れる・やぶ.る', 'rusak', '土', 'tanah', '[{"k": "壊れる", "y": "こわれる", "a": "rusak"}, {"k": "壊す", "y": "こわす", "a": "merusak"}]'::jsonb),
  ('n3', 24, 2, '直', 'チョク・ジキ・ジカ', 'ただ.ちに・なお.す・なお.る', 'langsung / memperbaiki', '目', 'mata', '[{"k": "直す", "y": "なおす", "a": "memperbaiki"}, {"k": "正直", "y": "しょうじき", "a": "jujur"}]'::jsonb),
  ('n3', 24, 3, '像', 'ゾウ', null, 'gambar / patung', '人', 'orang', '[{"k": "映像", "y": "えいぞう", "a": "gambar bergerak"}, {"k": "想像", "y": "そうぞう", "a": "imajinasi"}]'::jsonb),
  ('n3', 24, 4, '映', 'エイ', 'うつ.る・うつ.す・は.える', 'memantulkan / menampilkan', '日', 'matahari', '[{"k": "映像", "y": "えいぞう", "a": "gambar bergerak"}, {"k": "映画", "y": "えいが", "a": "film"}]'::jsonb),
  ('n3', 24, 5, '送', 'ソウ', 'おく.る', 'mengirim', '辵', 'berjalan', '[{"k": "送る", "y": "おくる", "a": "mengirim"}, {"k": "転送", "y": "てんそう", "a": "meneruskan"}]'::jsonb),
  ('n3', 24, 6, '届', 'カイ', 'とど.ける・とど.く', 'tiba / sampai', '尸', 'jenazah', '[{"k": "届く", "y": "とどく", "a": "tiba / terkirim"}, {"k": "届ける", "y": "とどける", "a": "mengantarkan"}]'::jsonb),
  ('n3', 24, 7, '登', 'トウ・ト・ドウ', 'のぼ.る・あ.がる', 'mendaki / mendaftar', '癶', 'kaki terbuka', '[{"k": "登録", "y": "とうろく", "a": "pendaftaran"}, {"k": "登山", "y": "とざん", "a": "mendaki gunung"}]'::jsonb),
  ('n3', 24, 8, '便', 'ベン・ビン', 'たよ.り', 'nyaman / surat', '人', 'orang', '[{"k": "便利", "y": "べんり", "a": "praktis"}, {"k": "郵便局", "y": "ゆうびんきょく", "a": "kantor pos"}]'::jsonb),
  ('n3', 24, 9, '読', 'ドク・トク・トウ', 'よ.む', 'membaca', '言', 'kata', '[{"k": "読書", "y": "どくしょ", "a": "membaca buku"}, {"k": "読む", "y": "よむ", "a": "membaca"}]'::jsonb),
  ('n3', 24, 10, '戦', 'セン', 'いくさ・たたか.う・おのの.く', 'perang', '戈', 'tombak', '[{"k": "観戦", "y": "かんせん", "a": "menonton pertandingan"}, {"k": "挑戦", "y": "ちょうせん", "a": "tantangan / menantang"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 25 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 25, 1, '光', 'コウ', 'ひか.る・ひかり', 'cahaya', '儿', 'kaki manusia', '[{"k": "観光", "y": "かんこう", "a": "wisata"}, {"k": "観光客", "y": "かんこうきゃく", "a": "turis"}]'::jsonb),
  ('n3', 25, 2, '市', 'シ', 'いち', 'kota / pasar', '巾', 'kain', '[{"k": "市役所", "y": "しやくしょ", "a": "balai kota"}, {"k": "市民", "y": "しみん", "a": "warga kota"}]'::jsonb),
  ('n3', 25, 3, '番', 'バン', 'つが.い', 'nomor', '田', 'sawah', '[{"k": "交番", "y": "こうばん", "a": "pos polisi"}, {"k": "番目", "y": "ばんめ", "a": "ke- (urutan)"}]'::jsonb),
  ('n3', 25, 4, '角', 'カク', 'かど・つの', 'sudut / tanduk', '角', 'tanduk', '[{"k": "角", "y": "かど", "a": "sudut / tikungan"}, {"k": "曲がり角", "y": "まがりかど", "a": "tikungan"}]'::jsonb),
  ('n3', 25, 5, '前', 'ゼン', 'まえ', 'depan', '刀', 'pedang', '[{"k": "前", "y": "まえ", "a": "depan"}, {"k": "名前", "y": "なまえ", "a": "nama"}]'::jsonb),
  ('n3', 25, 6, '遠', 'エン・オン', 'とお.い', 'jauh', '辵', 'berjalan', '[{"k": "遠い", "y": "とおい", "a": "jauh"}, {"k": "遠慮", "y": "えんりょ", "a": "sungkan / menahan diri"}]'::jsonb),
  ('n3', 25, 7, '座', 'ザ', 'すわ.る', 'duduk', '广', 'rumah beratap', '[{"k": "座る", "y": "すわる", "a": "duduk"}, {"k": "座席", "y": "ざせき", "a": "kursi"}]'::jsonb),
  ('n3', 25, 8, '開', 'カイ', 'ひら.く・ひら.き・ひら.ける', 'membuka', '門', 'pintu besar', '[{"k": "開ける", "y": "あける", "a": "membuka"}, {"k": "開く", "y": "あく", "a": "terbuka"}]'::jsonb),
  ('n3', 25, 9, '閉', 'ヘイ', 'と.じる・と.ざす・し.める', 'menutup', '門', 'pintu besar', '[{"k": "閉める", "y": "しめる", "a": "menutup"}, {"k": "閉まる", "y": "しまる", "a": "tertutup"}]'::jsonb),
  ('n3', 25, 10, '取', 'シュ', 'と.る・と.り・とり', 'mengambil', '又', 'tangan kanan', '[{"k": "取る", "y": "とる", "a": "mengambil"}, {"k": "取引", "y": "とりひき", "a": "transaksi"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 26 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 26, 1, '持', 'ジ', 'も.つ・も.てる', 'memegang', '手', 'tangan', '[{"k": "持つ", "y": "もつ", "a": "membawa / memegang"}, {"k": "気持ち", "y": "きもち", "a": "perasaan"}]'::jsonb),
  ('n3', 26, 2, '呼', 'コ', 'よ.ぶ', 'memanggil', '口', 'mulut', '[{"k": "呼ぶ", "y": "よぶ", "a": "memanggil"}, {"k": "呼吸", "y": "こきゅう", "a": "pernapasan"}]'::jsonb),
  ('n3', 26, 3, '片', 'ヘン', 'かた', 'sebelah / keping', '片', 'keping', '[{"k": "片付ける", "y": "かたづける", "a": "merapikan"}, {"k": "片付け", "y": "かたづけ", "a": "merapikan"}]'::jsonb),
  ('n3', 26, 4, '比', 'ヒ', 'くら.べる', 'membandingkan', '比', 'banding', '[{"k": "比べる", "y": "くらべる", "a": "membandingkan"}, {"k": "比較", "y": "ひかく", "a": "perbandingan"}]'::jsonb),
  ('n3', 26, 5, '伝', 'デン・テン', 'つた.わる・つた.える・つた.う', 'menyampaikan', '人', 'orang', '[{"k": "伝える", "y": "つたえる", "a": "menyampaikan"}, {"k": "伝統", "y": "でんとう", "a": "tradisi"}]'::jsonb),
  ('n3', 26, 6, '説', 'セツ・ゼイ', 'と.く', 'penjelasan / teori', '言', 'kata', '[{"k": "説明する", "y": "せつめいする", "a": "menjelaskan"}, {"k": "説明", "y": "せつめい", "a": "penjelasan"}]'::jsonb),
  ('n3', 26, 7, '断', 'ダン', 'た.つ・ことわ.る・さだ.める', 'memutus / menolak', '斤', 'kapak', '[{"k": "断る", "y": "ことわる", "a": "menolak"}, {"k": "判断", "y": "はんだん", "a": "penilaian"}]'::jsonb),
  ('n3', 26, 8, '謝', 'シャ', 'あやま.る', 'berterima kasih / minta maaf', '言', 'kata', '[{"k": "謝る", "y": "あやまる", "a": "meminta maaf"}, {"k": "感謝", "y": "かんしゃ", "a": "rasa syukur"}]'::jsonb),
  ('n3', 26, 9, '始', 'シ', 'はじ.める・はじ.まる', 'mulai', '女', 'perempuan', '[{"k": "始まる", "y": "はじまる", "a": "dimulai"}, {"k": "始める", "y": "はじめる", "a": "memulai"}]'::jsonb),
  ('n3', 26, 10, '増', 'ゾウ', 'ま.す・ま.し・ふ.える', 'bertambah', '土', 'tanah', '[{"k": "増える", "y": "ふえる", "a": "bertambah"}, {"k": "増加", "y": "ぞうか", "a": "penambahan"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 27 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 27, 1, '減', 'ゲン', 'へ.る・へ.らす', 'berkurang', '水', 'air', '[{"k": "減る", "y": "へる", "a": "berkurang"}, {"k": "減少", "y": "げんしょう", "a": "pengurangan"}]'::jsonb),
  ('n3', 27, 2, '育', 'イク', 'そだ.つ・そだ.ち・そだ.てる', 'membesarkan', '肉', 'daging', '[{"k": "育つ", "y": "そだつ", "a": "tumbuh"}, {"k": "教育", "y": "きょういく", "a": "pendidikan"}]'::jsonb),
  ('n3', 27, 3, '重', 'ジュウ・チョウ', 'え・おも.い・おも.り', 'berat', '里', 'desa', '[{"k": "重い", "y": "おもい", "a": "berat"}, {"k": "重さ", "y": "おもさ", "a": "berat"}]'::jsonb),
  ('n3', 27, 4, '多', 'タ', 'おお.い・まさ.に・まさ.る', 'banyak', '夕', 'senja', '[{"k": "多い", "y": "おおい", "a": "banyak"}, {"k": "多数", "y": "たすう", "a": "banyak orang"}]'::jsonb),
  ('n3', 27, 5, '危', 'キ', 'あぶ.ない・あや.うい・あや.ぶむ', 'berbahaya', '卩', 'lambang sendi', '[{"k": "危ない", "y": "あぶない", "a": "berbahaya"}, {"k": "危険", "y": "きけん", "a": "bahaya"}]'::jsonb),
  ('n3', 27, 6, '別', 'ベツ', 'わか.れる・わ.ける', 'terpisah / lain', '刀', 'pedang', '[{"k": "特別", "y": "とくべつ", "a": "istimewa"}, {"k": "別に", "y": "べつに", "a": "tidak begitu"}]'::jsonb),
  ('n3', 27, 7, '確', 'カク・コウ', 'たし.か・たし.かめる', 'pasti', '石', 'batu', '[{"k": "確か", "y": "たしか", "a": "pasti"}, {"k": "確認", "y": "かくにん", "a": "konfirmasi / memastikan"}]'::jsonb),
  ('n3', 27, 8, '由', 'ユ・ユウ・ユイ', 'よし・よ.る', 'alasan', '田', 'sawah', '[{"k": "自由", "y": "じゆう", "a": "bebas"}, {"k": "理由", "y": "りゆう", "a": "alasan"}]'::jsonb),
  ('n3', 27, 9, '険', 'ケン', 'けわ.しい', 'curam / berisiko', '阜', 'bukit', '[{"k": "危険", "y": "きけん", "a": "bahaya"}, {"k": "保険", "y": "ほけん", "a": "asuransi"}]'::jsonb),
  ('n3', 27, 10, '丁', 'チョウ・テイ・チン', 'ひのと', 'rapi / dewasa', '一', 'satu', '[{"k": "丁寧", "y": "ていねい", "a": "sopan / teliti"}, {"k": "丁度", "y": "ちょうど", "a": "tepat"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 28 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 28, 1, '冷', 'レイ', 'つめ.たい・ひ.える・ひ.や', 'dingin', '冫', 'es', '[{"k": "冷たい", "y": "つめたい", "a": "dingin (benda)"}, {"k": "冷蔵庫", "y": "れいぞうこ", "a": "kulkas"}]'::jsonb),
  ('n3', 28, 2, '葉', 'ヨウ', 'は', 'daun', '艸', 'rumput', '[{"k": "葉書", "y": "はがき", "a": "kartu pos"}, {"k": "紅葉", "y": "こうよう", "a": "daun musim gugur"}]'::jsonb),
  ('n3', 28, 3, '加', 'カ', 'くわ.える・くわ.わる', 'menambah', '力', 'tenaga', '[{"k": "参加", "y": "さんか", "a": "partisipasi"}, {"k": "増加", "y": "ぞうか", "a": "penambahan"}]'::jsonb),
  ('n3', 28, 4, '法', 'ホウ・ハッ・ホッ', 'のり', 'hukum / cara', '水', 'air', '[{"k": "法律", "y": "ほうりつ", "a": "hukum"}, {"k": "方法", "y": "ほうほう", "a": "metode"}]'::jsonb),
  ('n3', 28, 5, '故', 'コ', 'ゆえ・ふる.い・もと', 'sebab / almarhum', '攴', 'memukul', '[{"k": "事故", "y": "じこ", "a": "kecelakaan"}, {"k": "故障", "y": "こしょう", "a": "kerusakan"}]'::jsonb),
  ('n3', 28, 6, '火', 'カ', 'ひ', 'api', '火', 'api', '[{"k": "火事", "y": "かじ", "a": "kebakaran"}, {"k": "火山", "y": "かざん", "a": "gunung berapi"}]'::jsonb),
  ('n3', 28, 7, '民', 'ミン', 'たみ', 'rakyat', '氏', 'marga', '[{"k": "市民", "y": "しみん", "a": "warga kota"}, {"k": "民話", "y": "みんわ", "a": "cerita rakyat"}]'::jsonb),
  ('n3', 28, 8, '保', 'ホ・ホウ', 'たも.つ', 'menjaga', '人', 'orang', '[{"k": "保険", "y": "ほけん", "a": "asuransi"}, {"k": "保証", "y": "ほしょう", "a": "jaminan"}]'::jsonb),
  ('n3', 28, 9, '世', 'セイ・セ・ソウ', 'よ', 'dunia / generasi', '一', 'satu', '[{"k": "世の中", "y": "よのなか", "a": "kehidupan sosial"}, {"k": "お世話", "y": "おせわ", "a": "bantuan / dukungan"}]'::jsonb),
  ('n3', 28, 10, '対', 'タイ・ツイ', 'あいて・こた.える・そろ.い', 'berhadapan', '寸', 'ukuran', '[{"k": "対応", "y": "たいおう", "a": "penanganan"}, {"k": "対策", "y": "たいさく", "a": "tindakan penanganan"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 29 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 29, 1, '化', 'カ・ケ', 'ば.ける・ば.かす・ふ.ける', 'berubah menjadi', '匕', 'sendok', '[{"k": "文化", "y": "ぶんか", "a": "budaya"}, {"k": "変化", "y": "へんか", "a": "perubahan"}]'::jsonb),
  ('n3', 29, 2, '儀', 'ギ', null, 'upacara / tata cara', '人', 'orang', '[{"k": "お辞儀", "y": "おじぎ", "a": "membungkuk"}, {"k": "礼儀", "y": "れいぎ", "a": "tata krama"}]'::jsonb),
  ('n3', 29, 3, '敬', 'ケイ・キョウ', 'うやま.う', 'hormat', '攴', 'memukul', '[{"k": "敬語", "y": "けいご", "a": "bahasa sopan"}, {"k": "尊敬", "y": "そんけい", "a": "rasa hormat"}]'::jsonb),
  ('n3', 29, 4, '慣', 'カン', 'な.れる・な.らす', 'terbiasa', '心', 'hati', '[{"k": "慣習", "y": "かんしゅう", "a": "kebiasaan turun-temurun"}, {"k": "習慣", "y": "しゅうかん", "a": "kebiasaan"}]'::jsonb),
  ('n3', 29, 5, '承', 'ショウ・ジョウ', 'うけたまわ.る・う.ける', 'menerima / menyetujui', '手', 'tangan', '[{"k": "承知", "y": "しょうち", "a": "mengerti (formal)"}, {"k": "承認", "y": "しょうにん", "a": "persetujuan"}]'::jsonb),
  ('n3', 29, 6, '印', 'イン', 'しるし・しる.す', 'cap / tanda', '卩', 'lambang sendi', '[{"k": "印刷", "y": "いんさつ", "a": "mencetak"}, {"k": "印象", "y": "いんしょう", "a": "kesan"}]'::jsonb),
  ('n3', 29, 7, '納', 'ノウ・ナッ・ナ', 'おさ.める・おさ.まる', 'menyimpan / menyerahkan', '糸', 'benang', '[{"k": "納期", "y": "のうき", "a": "tenggat pengiriman"}, {"k": "納品", "y": "のうひん", "a": "pengiriman barang"}]'::jsonb),
  ('n3', 29, 8, '絡', 'ラク', 'から.む・から.まる', 'berjalin / menghubungi', '糸', 'benang', '[{"k": "連絡先", "y": "れんらくさき", "a": "kontak"}, {"k": "連絡", "y": "れんらく", "a": "kabar / menghubungi"}]'::jsonb),
  ('n3', 29, 9, '平', 'ヘイ・ビョウ・ヒョウ', 'たい.ら・たい.らげる・ひら', 'datar / damai', '干', 'kering', '[{"k": "平均", "y": "へいきん", "a": "rata-rata"}, {"k": "平等", "y": "びょうどう", "a": "kesetaraan"}]'::jsonb),
  ('n3', 29, 10, '容', 'ヨウ', 'い.れる', 'isi / memuat', '宀', 'atap rumah', '[{"k": "内容", "y": "ないよう", "a": "isi"}, {"k": "容量", "y": "ようりょう", "a": "kapasitas"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 30 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 30, 1, '解', 'カイ・ゲ', 'と.く・と.かす・と.ける', 'membuka / mengerti', '角', 'tanduk', '[{"k": "理解", "y": "りかい", "a": "pemahaman"}, {"k": "解決", "y": "かいけつ", "a": "penyelesaian"}]'::jsonb),
  ('n3', 30, 2, '興', 'コウ・キョウ', 'おこ.る・おこ.す', 'bangkit / minat', '臼', 'lesung', '[{"k": "興味", "y": "きょうみ", "a": "minat"}, {"k": "興奮", "y": "こうふん", "a": "terangsang / bersemangat"}]'::jsonb),
  ('n3', 30, 3, '識', 'シキ', 'し.る・しる.す', 'pengetahuan / mengenali', '言', 'kata', '[{"k": "知識", "y": "ちしき", "a": "pengetahuan"}, {"k": "意識", "y": "いしき", "a": "kesadaran"}]'::jsonb),
  ('n3', 30, 4, '庭', 'テイ', 'にわ', 'halaman', '广', 'rumah beratap', '[{"k": "家庭", "y": "かてい", "a": "rumah tangga"}, {"k": "庭", "y": "にわ", "a": "halaman"}]'::jsonb),
  ('n3', 30, 5, '庫', 'コ・ク', 'くら', 'gudang', '广', 'rumah beratap', '[{"k": "冷蔵庫", "y": "れいぞうこ", "a": "kulkas"}, {"k": "在庫", "y": "ざいこ", "a": "stok"}]'::jsonb),
  ('n3', 30, 6, '在', 'ザイ', 'あ.る', 'ada', '土', 'tanah', '[{"k": "滞在", "y": "たいざい", "a": "masa tinggal"}, {"k": "在庫", "y": "ざいこ", "a": "stok"}]'::jsonb),
  ('n3', 30, 7, '束', 'ソク', 'たば・たば.ねる・つか', 'ikat / berkas', '木', 'pohon', '[{"k": "約束する", "y": "やくそくする", "a": "berjanji"}, {"k": "約束", "y": "やくそく", "a": "janji"}]'::jsonb),
  ('n3', 30, 8, '要', 'ヨウ', 'い.る・かなめ', 'perlu / pokok', '襾', 'barat', '[{"k": "必要性", "y": "ひつようせい", "a": "keperluan"}, {"k": "必要", "y": "ひつよう", "a": "perlu / kebutuhan"}]'::jsonb),
  ('n3', 30, 9, '両', 'リョウ', 'てる・ふたつ', 'kedua', '一', 'satu', '[{"k": "両親", "y": "りょうしん", "a": "orang tua"}]'::jsonb),
  ('n3', 30, 10, '姉', 'シ', 'あね・はは', 'kakak perempuan', '女', 'perempuan', '[{"k": "姉", "y": "あね", "a": "kakak perempuan"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 31 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 31, 1, '妹', 'マイ', 'いもうと', 'adik perempuan', '女', 'perempuan', '[{"k": "妹", "y": "いもうと", "a": "adik perempuan"}]'::jsonb),
  ('n3', 31, 2, '父', 'フ', 'ちち', 'ayah', '父', 'ayah', '[{"k": "祖父", "y": "そふ", "a": "kakek"}]'::jsonb),
  ('n3', 31, 3, '母', 'ボ', 'はは・も', 'ibu', '毋', 'jangan', '[{"k": "祖母", "y": "そぼ", "a": "nenek"}]'::jsonb),
  ('n3', 31, 4, '夫', 'フ・フウ・ブ', 'おっと・それ', 'suami', '大', 'besar', '[{"k": "夫", "y": "おっと", "a": "suami"}]'::jsonb),
  ('n3', 31, 5, '妻', 'サイ', 'つま', 'istri', '女', 'perempuan', '[{"k": "妻", "y": "つま", "a": "istri"}]'::jsonb),
  ('n3', 31, 6, '息', 'ソク', 'いき', 'napas / anak', '心', 'hati', '[{"k": "息子", "y": "むすこ", "a": "anak laki-laki"}]'::jsonb),
  ('n3', 31, 7, '娘', 'ジョウ', 'むすめ・こ', 'anak perempuan', '女', 'perempuan', '[{"k": "娘", "y": "むすめ", "a": "anak perempuan"}]'::jsonb),
  ('n3', 31, 8, '戚', 'ソク・セキ', 'いた.む・うれ.える・みうち', 'kerabat', '戈', 'tombak', '[{"k": "親戚", "y": "しんせき", "a": "kerabat"}]'::jsonb),
  ('n3', 31, 9, '隣', 'リン', 'とな.る・となり', 'sebelah', '阜', 'bukit', '[{"k": "隣", "y": "となり", "a": "sebelah / tetangga"}]'::jsonb),
  ('n3', 31, 10, '仲', 'チュウ', 'なか', 'hubungan', '人', 'orang', '[{"k": "仲間", "y": "なかま", "a": "rekan / teman"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 32 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 32, 1, '恋', 'レン', 'こ.う・こい・こい.しい', 'cinta', '心', 'hati', '[{"k": "恋人", "y": "こいびと", "a": "kekasih"}]'::jsonb),
  ('n3', 32, 2, '供', 'キョウ・ク・クウ', 'そな.える・とも', 'menemani / anak', '人', 'orang', '[{"k": "子供", "y": "こども", "a": "anak"}]'::jsonb),
  ('n3', 32, 3, '男', 'ダン・ナン', 'おとこ・お', 'laki-laki', '田', 'sawah', '[{"k": "男性", "y": "だんせい", "a": "pria"}]'::jsonb),
  ('n3', 32, 4, '暮', 'ボ', 'く.れる・く.らす', 'hidup / senja', '日', 'matahari', '[{"k": "一人暮らし", "y": "ひとりぐらし", "a": "tinggal sendiri"}]'::jsonb),
  ('n3', 32, 5, '頭', 'トウ・ズ・ト', 'あたま・かしら・かぶり', 'kepala', '頁', 'kepala', '[{"k": "頭", "y": "あたま", "a": "kepala"}]'::jsonb),
  ('n3', 32, 6, '顔', 'ガン', 'かお', 'wajah', '頁', 'kepala', '[{"k": "顔", "y": "かお", "a": "wajah"}]'::jsonb),
  ('n3', 32, 7, '耳', 'ジ', 'みみ', 'telinga', '耳', 'telinga', '[{"k": "耳", "y": "みみ", "a": "telinga"}]'::jsonb),
  ('n3', 32, 8, '背', 'ハイ', 'せ・せい・そむ.く', 'punggung / tinggi', '肉', 'daging', '[{"k": "背", "y": "せ", "a": "tinggi badan / punggung"}]'::jsonb),
  ('n3', 32, 9, '邪', 'ジャ', 'よこし.ま', 'jahat', '邑', 'kampung', '[{"k": "風邪", "y": "かぜ", "a": "masuk angin"}]'::jsonb),
  ('n3', 32, 10, '怪', 'カイ・ケ', 'あや.しい・あや.しむ', 'aneh', '心', 'hati', '[{"k": "怪我", "y": "けが", "a": "cedera"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 33 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 33, 1, '薬', 'ヤク', 'くすり', 'obat', '艸', 'rumput', '[{"k": "薬", "y": "くすり", "a": "obat"}]'::jsonb),
  ('n3', 33, 2, '医', 'イ', 'い.やす・い.する・くすし', 'kedokteran', '匸', 'peti', '[{"k": "医者", "y": "いしゃ", "a": "dokter"}]'::jsonb),
  ('n3', 33, 3, '者', 'シャ', 'もの', 'orang', '老', 'tua', '[{"k": "医者", "y": "いしゃ", "a": "dokter"}]'::jsonb),
  ('n3', 33, 4, '院', 'イン', null, 'gedung / institusi', '阜', 'bukit', '[{"k": "病院", "y": "びょういん", "a": "rumah sakit"}]'::jsonb),
  ('n3', 33, 5, '疲', 'ヒ', 'つか.れる・つか.らす', 'lelah', '疒', 'sakit', '[{"k": "疲れる", "y": "つかれる", "a": "lelah"}]'::jsonb),
  ('n3', 33, 6, '元', 'ゲン・ガン', 'もと', 'asal / semangat', '儿', 'kaki manusia', '[{"k": "元気", "y": "げんき", "a": "sehat / bersemangat"}]'::jsonb),
  ('n3', 33, 7, '康', 'コウ', null, 'sehat', '广', 'rumah beratap', '[{"k": "健康", "y": "けんこう", "a": "kesehatan"}]'::jsonb),
  ('n3', 33, 8, '健', 'ケン', 'すこ.やか', 'sehat', '人', 'orang', '[{"k": "健康", "y": "けんこう", "a": "kesehatan"}]'::jsonb),
  ('n3', 33, 9, '睡', 'スイ', 'ねむ.る・ねむ.い', 'tidur', '目', 'mata', '[{"k": "睡眠", "y": "すいみん", "a": "tidur"}]'::jsonb),
  ('n3', 33, 10, '材', 'ザイ', null, 'bahan', '木', 'pohon', '[{"k": "食材", "y": "しょくざい", "a": "bahan makanan"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 34 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 34, 1, '肉', 'ニク', 'しし', 'daging', '肉', 'daging', '[{"k": "肉", "y": "にく", "a": "daging"}]'::jsonb),
  ('n3', 34, 2, '魚', 'ギョ', 'うお・さかな', 'ikan', '魚', 'ikan', '[{"k": "魚", "y": "さかな", "a": "ikan"}]'::jsonb),
  ('n3', 34, 3, '菜', 'サイ', 'な', 'sayur', '艸', 'rumput', '[{"k": "野菜", "y": "やさい", "a": "sayur"}]'::jsonb),
  ('n3', 34, 4, '野', 'ヤ・ショ', 'の', 'ladang', '里', 'desa', '[{"k": "野菜", "y": "やさい", "a": "sayur"}]'::jsonb),
  ('n3', 34, 5, '米', 'ベイ・マイ・メエトル', 'こめ・よね', 'beras', '米', 'beras', '[{"k": "米", "y": "こめ", "a": "beras"}]'::jsonb),
  ('n3', 34, 6, '卵', 'ラン', 'たまご', 'telur', '卩', 'lambang sendi', '[{"k": "卵", "y": "たまご", "a": "telur"}]'::jsonb),
  ('n3', 34, 7, '塩', 'エン', 'しお', 'garam', '土', 'tanah', '[{"k": "塩", "y": "しお", "a": "garam"}]'::jsonb),
  ('n3', 34, 8, '砂', 'サ・シャ', 'すな', 'pasir', '石', 'batu', '[{"k": "砂糖", "y": "さとう", "a": "gula"}]'::jsonb),
  ('n3', 34, 9, '糖', 'トウ', null, 'gula', '米', 'beras', '[{"k": "砂糖", "y": "さとう", "a": "gula"}]'::jsonb),
  ('n3', 34, 10, '醤', 'ショウ', 'ひしお', 'kecap', '酉', 'arak', '[{"k": "醤油", "y": "しょうゆ", "a": "kecap asin"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 35 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 35, 1, '甘', 'カン', 'あま.い・あま.える・あま.やかす', 'manis', '甘', 'manis', '[{"k": "甘い", "y": "あまい", "a": "manis"}]'::jsonb),
  ('n3', 35, 2, '辛', 'シン', 'から.い・つら.い・かのと', 'pedas', '辛', 'pedas', '[{"k": "辛い", "y": "からい", "a": "pedas"}]'::jsonb),
  ('n3', 35, 3, '酸', 'サン', 'す.い', 'asam', '酉', 'arak', '[{"k": "酸っぱい", "y": "すっぱい", "a": "asam"}]'::jsonb),
  ('n3', 35, 4, '焼', 'ショウ', 'や.く・や.き・や.ける', 'membakar', '火', 'api', '[{"k": "焼く", "y": "やく", "a": "membakar / memanggang"}]'::jsonb),
  ('n3', 35, 5, '煮', 'シャ', 'に.る・に.える・に.やす', 'merebus', '火', 'api', '[{"k": "煮る", "y": "にる", "a": "merebus"}]'::jsonb),
  ('n3', 35, 6, '揚', 'ヨウ', 'あ.げる・あ.がる', 'menggoreng / mengangkat', '手', 'tangan', '[{"k": "揚げる", "y": "あげる", "a": "menggoreng"}]'::jsonb),
  ('n3', 35, 7, '混', 'コン', 'ま.じる・ま.ざる・ま.ぜる', 'mencampur', '水', 'air', '[{"k": "混ぜる", "y": "まぜる", "a": "mengaduk"}]'::jsonb),
  ('n3', 35, 8, '過', 'カ', 'す.ぎる・す.ごす・あやま.ち', 'melewati / berlebihan', '辵', 'berjalan', '[{"k": "食べ過ぎ", "y": "たべすぎ", "a": "makan berlebihan"}]'::jsonb),
  ('n3', 35, 9, '腹', 'フク', 'はら', 'perut', '肉', 'daging', '[{"k": "空腹", "y": "くうふく", "a": "lapar"}]'::jsonb),
  ('n3', 35, 10, '値', 'チ', 'ね・あたい', 'nilai / harga', '人', 'orang', '[{"k": "値段", "y": "ねだん", "a": "harga"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 36 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 36, 1, '高', 'コウ', 'たか.い・たか・たか.まる', 'tinggi / mahal', '高', 'tinggi', '[{"k": "高い", "y": "たかい", "a": "mahal / tinggi"}]'::jsonb),
  ('n3', 36, 2, '買', 'バイ', 'か.う', 'membeli', '貝', 'kerang', '[{"k": "買う", "y": "かう", "a": "membeli"}]'::jsonb),
  ('n3', 36, 3, '袋', 'タイ・ダイ', 'ふくろ', 'kantong', '衣', 'pakaian', '[{"k": "袋", "y": "ふくろ", "a": "kantong"}]'::jsonb),
  ('n3', 36, 4, '財', 'ザイ・サイ・ゾク', 'たから', 'harta', '貝', 'kerang', '[{"k": "財布", "y": "さいふ", "a": "dompet"}]'::jsonb),
  ('n3', 36, 5, '貯', 'チョ', 'た.める・たくわ.える', 'menabung', '貝', 'kerang', '[{"k": "貯金", "y": "ちょきん", "a": "tabungan"}]'::jsonb),
  ('n3', 36, 6, '借', 'シャク', 'か.りる', 'meminjam', '人', 'orang', '[{"k": "借りる", "y": "かりる", "a": "meminjam"}]'::jsonb),
  ('n3', 36, 7, '貸', 'タイ', 'か.す', 'meminjamkan', '貝', 'kerang', '[{"k": "貸す", "y": "かす", "a": "meminjamkan"}]'::jsonb),
  ('n3', 36, 8, '駅', 'エキ', null, 'stasiun', '馬', 'kuda', '[{"k": "駅", "y": "えき", "a": "stasiun"}]'::jsonb),
  ('n3', 36, 9, '符', 'フ', null, 'tanda / tiket', '竹', 'bambu', '[{"k": "切符", "y": "きっぷ", "a": "tiket"}]'::jsonb),
  ('n3', 36, 10, '降', 'コウ・ゴ', 'お.りる・お.ろす・ふ.る', 'turun', '阜', 'bukit', '[{"k": "降りる", "y": "おりる", "a": "turun (kendaraan)"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 37 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 37, 1, '飛', 'ヒ', 'と.ぶ・と.ばす', 'terbang', '飛', 'terbang', '[{"k": "飛行機", "y": "ひこうき", "a": "pesawat"}]'::jsonb),
  ('n3', 37, 2, '点', 'テン', 'つ.ける・つ.く・た.てる', 'titik / nilai', '火', 'api', '[{"k": "交差点", "y": "こうさてん", "a": "persimpangan"}]'::jsonb),
  ('n3', 37, 3, '差', 'サ', 'さ.す・さ.し', 'perbedaan', '工', 'kerja', '[{"k": "交差点", "y": "こうさてん", "a": "persimpangan"}]'::jsonb),
  ('n3', 37, 4, '号', 'ゴウ', 'さけ.ぶ・よびな', 'nomor', '口', 'mulut', '[{"k": "信号", "y": "しんごう", "a": "lampu lalu lintas"}]'::jsonb),
  ('n3', 37, 5, '駐', 'チュウ', null, 'parkir / menetap', '馬', 'kuda', '[{"k": "駐車場", "y": "ちゅうしゃじょう", "a": "tempat parkir"}]'::jsonb),
  ('n3', 37, 6, '渋', 'ジュウ・シュウ', 'しぶ・しぶ.い・しぶ.る', 'sepat / macet', '水', 'air', '[{"k": "渋滞", "y": "じゅうたい", "a": "macet"}]'::jsonb),
  ('n3', 37, 7, '表', 'ヒョウ', 'おもて・あらわ.す・あらわ.れる', 'permukaan / tabel', '衣', 'pakaian', '[{"k": "時刻表", "y": "じこくひょう", "a": "jadwal keberangkatan"}]'::jsonb),
  ('n3', 37, 8, '渡', 'ト', 'わた.る・わた.す', 'menyeberang', '水', 'air', '[{"k": "渡る", "y": "わたる", "a": "menyeberang"}]'::jsonb),
  ('n3', 37, 9, '離', 'リ', 'はな.れる・はな.す', 'terpisah', '隹', 'burung kecil', '[{"k": "距離", "y": "きょり", "a": "jarak"}]'::jsonb),
  ('n3', 37, 10, '距', 'キョ', 'へだ.たる・けづめ', 'jarak', '足', 'kaki', '[{"k": "距離", "y": "きょり", "a": "jarak"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 38 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 38, 1, '往', 'オウ', 'い.く・いにしえ・さき.に', 'pergi', '彳', 'langkah', '[{"k": "往復", "y": "おうふく", "a": "pulang-pergi"}]'::jsonb),
  ('n3', 38, 2, '呂', 'ロ・リョ', 'せぼね', 'komponen 風呂 (mandi)', '口', 'mulut', '[{"k": "風呂", "y": "ふろ", "a": "bak mandi"}]'::jsonb),
  ('n3', 38, 3, '玄', 'ゲン', 'くろ・くろ.い', 'komponen 玄関 (pintu masuk)', '玄', 'gelap', '[{"k": "玄関", "y": "げんかん", "a": "pintu masuk"}]'::jsonb),
  ('n3', 38, 4, '窓', 'ソウ・ス', 'まど・てんまど・けむだし', 'jendela', '穴', 'lubang', '[{"k": "窓", "y": "まど", "a": "jendela"}]'::jsonb),
  ('n3', 38, 5, '壁', 'ヘキ', 'かべ', 'dinding', '土', 'tanah', '[{"k": "壁", "y": "かべ", "a": "dinding"}]'::jsonb),
  ('n3', 38, 6, '床', 'ショウ', 'とこ・ゆか', 'lantai', '广', 'rumah beratap', '[{"k": "床", "y": "ゆか", "a": "lantai"}]'::jsonb),
  ('n3', 38, 7, '井', 'セイ・ショウ', 'い', 'sumur', '二', 'dua', '[{"k": "天井", "y": "てんじょう", "a": "langit-langit"}]'::jsonb),
  ('n3', 38, 8, '鍵', 'ケン', 'かぎ', 'kunci', '金', 'emas', '[{"k": "鍵", "y": "かぎ", "a": "kunci"}]'::jsonb),
  ('n3', 38, 9, '押', 'オウ', 'お.す・お.さえる・おさ.える', 'mendorong', '手', 'tangan', '[{"k": "押し入れ", "y": "おしいれ", "a": "lemari dinding"}]'::jsonb),
  ('n3', 38, 10, '除', 'ジョ・ジ', 'のぞ.く', 'menyingkirkan', '阜', 'bukit', '[{"k": "掃除", "y": "そうじ", "a": "membersihkan"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 39 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 39, 1, '掃', 'ソウ・シュ', 'は.く', 'menyapu', '手', 'tangan', '[{"k": "掃除", "y": "そうじ", "a": "membersihkan"}]'::jsonb),
  ('n3', 39, 2, '賃', 'チン', null, 'sewa / upah', '貝', 'kerang', '[{"k": "家賃", "y": "やちん", "a": "uang sewa"}]'::jsonb),
  ('n3', 39, 3, '狭', 'キョウ・コウ', 'せま.い・せば.める・せば.まる', 'sempit', '犬', 'anjing', '[{"k": "狭い", "y": "せまい", "a": "sempit"}]'::jsonb),
  ('n3', 39, 4, '綺', 'キ', 'あや', 'indah (dalam 綺麗)', '糸', 'benang', '[{"k": "綺麗", "y": "きれい", "a": "bersih / indah"}]'::jsonb),
  ('n3', 39, 5, '麗', 'レイ', 'うるわ.しい・うら.らか', 'indah (dalam 綺麗)', '鹿', 'rusa', '[{"k": "綺麗", "y": "きれい", "a": "bersih / indah"}]'::jsonb),
  ('n3', 39, 6, '静', 'セイ・ジョウ', 'しず.か・しず.まる・しず.める', 'tenang', '青', 'biru muda', '[{"k": "静か", "y": "しずか", "a": "tenang"}]'::jsonb),
  ('n3', 39, 7, '仕', 'シ・ジ', 'つか.える', 'melayani / bekerja', '人', 'orang', '[{"k": "仕事", "y": "しごと", "a": "pekerjaan"}]'::jsonb),
  ('n3', 39, 8, '僚', 'リョウ', null, 'rekan', '人', 'orang', '[{"k": "同僚", "y": "どうりょう", "a": "rekan kerja"}]'::jsonb),
  ('n3', 39, 9, '勤', 'キン・ゴン', 'つと.める・つと.まる・いそ.しむ', 'bekerja / rajin', '力', 'tenaga', '[{"k": "勤める", "y": "つとめる", "a": "bekerja di"}]'::jsonb),
  ('n3', 39, 10, '営', 'エイ', 'いとな.む・いとな.み', 'menjalankan usaha', '口', 'mulut', '[{"k": "営業", "y": "えいぎょう", "a": "pemasaran"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 40 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 40, 1, '契', 'ケイ', 'ちぎ.る', 'berjanji / kontrak', '大', 'besar', '[{"k": "契約", "y": "けいやく", "a": "kontrak"}]'::jsonb),
  ('n3', 40, 2, '依', 'イ・エ', 'よ.る', 'bergantung', '人', 'orang', '[{"k": "依頼", "y": "いらい", "a": "permintaan"}]'::jsonb),
  ('n3', 40, 3, '締', 'テイ', 'し.まる・し.まり・し.める', 'mengencangkan / menutup', '糸', 'benang', '[{"k": "締め切り", "y": "しめきり", "a": "tenggat"}]'::jsonb),
  ('n3', 40, 4, '署', 'ショ', null, 'kantor (polisi)', '网', 'jala', '[{"k": "部署", "y": "ぶしょ", "a": "divisi"}]'::jsonb),
  ('n3', 40, 5, '刺', 'シ', 'さ.す・さ.さる・さ.し', 'menusuk', '刀', 'pedang', '[{"k": "名刺", "y": "めいし", "a": "kartu nama"}]'::jsonb),
  ('n3', 40, 6, '資', 'シ', null, 'modal / sumber', '貝', 'kerang', '[{"k": "資料", "y": "しりょう", "a": "dokumen / bahan"}]'::jsonb),
  ('n3', 40, 7, '忙', 'ボウ・モウ', 'いそが.しい・せわ.しい・おそ.れる', 'sibuk', '心', 'hati', '[{"k": "忙しい", "y": "いそがしい", "a": "sibuk"}]'::jsonb),
  ('n3', 40, 8, '校', 'コウ・キョウ', null, 'sekolah', '木', 'pohon', '[{"k": "学校", "y": "がっこう", "a": "sekolah"}]'::jsonb),
  ('n3', 40, 9, '授', 'ジュ', 'さず.ける・さず.かる', 'mengajarkan / memberikan', '手', 'tangan', '[{"k": "授業", "y": "じゅぎょう", "a": "pelajaran"}]'::jsonb),
  ('n3', 40, 10, '宿', 'シュク', 'やど・やど.る・やど.す', 'penginapan', '宀', 'atap rumah', '[{"k": "宿題", "y": "しゅくだい", "a": "pekerjaan rumah"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 41 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 41, 1, '徒', 'ト', 'いたずら・あだ', 'murid', '彳', 'langkah', '[{"k": "生徒", "y": "せいと", "a": "murid"}]'::jsonb),
  ('n3', 41, 2, '室', 'シツ', 'むろ', 'ruangan', '宀', 'atap rumah', '[{"k": "教室", "y": "きょうしつ", "a": "ruang kelas"}]'::jsonb),
  ('n3', 41, 3, '科', 'カ', null, 'jurusan / bagian', '禾', 'padi', '[{"k": "教科書", "y": "きょうかしょ", "a": "buku pelajaran"}]'::jsonb),
  ('n3', 41, 4, '練', 'レン', 'ね.る・ね.り', 'melatih', '糸', 'benang', '[{"k": "練習", "y": "れんしゅう", "a": "latihan"}]'::jsonb),
  ('n3', 41, 5, '質', 'シツ・シチ・チ', 'たち・ただ.す・もと', 'kualitas', '貝', 'kerang', '[{"k": "質問", "y": "しつもん", "a": "pertanyaan"}]'::jsonb),
  ('n3', 41, 6, '覚', 'カク', 'おぼ.える・さ.ます・さ.める', 'ingat / menyadari', '見', 'melihat', '[{"k": "覚える", "y": "おぼえる", "a": "mengingat / menghafal"}]'::jsonb),
  ('n3', 41, 7, '績', 'セキ', null, 'hasil / prestasi', '糸', 'benang', '[{"k": "成績", "y": "せいせき", "a": "nilai (sekolah)"}]'::jsonb),
  ('n3', 41, 8, '卒', 'ソツ・シュツ', 'そっ.する・お.える・お.わる', 'lulus / tamat', '十', 'sepuluh', '[{"k": "卒業", "y": "そつぎょう", "a": "lulus sekolah"}]'::jsonb),
  ('n3', 41, 9, '作', 'サク・サ', 'つく.る・つく.り', 'membuat', '人', 'orang', '[{"k": "作文", "y": "さくぶん", "a": "karangan"}]'::jsonb),
  ('n3', 41, 10, '晴', 'セイ', 'は.れる・は.れ・は.らす', 'cerah', '日', 'matahari', '[{"k": "晴れ", "y": "はれ", "a": "cerah"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== Kanji Hari 42 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 42, 1, '曇', 'ドン', 'くも.る', 'berawan', '日', 'matahari', '[{"k": "曇り", "y": "くもり", "a": "berawan"}]'::jsonb),
  ('n3', 42, 2, '雨', 'ウ', 'あめ', 'hujan', '雨', 'hujan', '[{"k": "雨", "y": "あめ", "a": "hujan"}]'::jsonb),
  ('n3', 42, 3, '雪', 'セツ', 'ゆき', 'salju', '雨', 'hujan', '[{"k": "雪", "y": "ゆき", "a": "salju"}]'::jsonb),
  ('n3', 42, 4, '暑', 'ショ', 'あつ.い', 'panas (cuaca)', '日', 'matahari', '[{"k": "暑い", "y": "あつい", "a": "panas"}]'::jsonb),
  ('n3', 42, 5, '寒', 'カン', 'さむ.い', 'dingin', '宀', 'atap rumah', '[{"k": "寒い", "y": "さむい", "a": "dingin"}]'::jsonb),
  ('n3', 42, 6, '涼', 'リョウ', 'すず.しい・すず.む・すず.やか', 'sejuk', '水', 'air', '[{"k": "涼しい", "y": "すずしい", "a": "sejuk"}]'::jsonb),
  ('n3', 42, 7, '暖', 'ダン・ノン', 'あたた.か・あたた.かい・あたた.まる', 'hangat', '日', 'matahari', '[{"k": "暖かい", "y": "あたたかい", "a": "hangat"}]'::jsonb),
  ('n3', 42, 8, '川', 'セン', 'かわ', 'sungai', '巛', 'sungai', '[{"k": "川", "y": "かわ", "a": "sungai"}]'::jsonb),
  ('n3', 42, 9, '森', 'シン', 'もり', 'hutan', '木', 'pohon', '[{"k": "森", "y": "もり", "a": "hutan"}]'::jsonb),
  ('n3', 42, 10, '木', 'ボク・モク', 'き', 'pohon', '木', 'pohon', '[{"k": "木", "y": "き", "a": "pohon"}]'::jsonb)
on conflict (level, kanji) do nothing;

-- ===== tambahan Hari 42 =====
insert into public.kanji
  (level, hari_ke, urutan, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata)
values
  ('n3', 42, 11, '石', 'セキ・シャク・コク', 'いし', 'batu', '石', 'batu', '[{"k": "石", "y": "いし", "a": "batu"}]'::jsonb),
  ('n3', 42, 12, '星', 'セイ・ショウ', 'ほし', 'bintang', '日', 'matahari', '[{"k": "星", "y": "ほし", "a": "bintang"}]'::jsonb)
on conflict (level, kanji) do nothing;
