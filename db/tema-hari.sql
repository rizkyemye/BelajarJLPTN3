-- ============================================================================
-- TEMA PER HARI
-- Satu baris = satu hari. Disimpan terpisah supaya tidak diulang 30x.
-- Jalankan SEKALI di SQL Editor. Aman diulang.
-- ============================================================================

create table if not exists public.tema_hari (
  level   text not null check (level in ('n5','n4','n3')),
  hari_ke int  not null check (hari_ke >= 1),
  tema    text not null,          -- versi Jepang, mis. 家族・人
  arti    text,                   -- versi Indonesia, mis. keluarga & orang
  primary key (level, hari_ke)
);

alter table public.tema_hari enable row level security;

drop policy if exists "baca tema" on public.tema_hari;
create policy "baca tema"
  on public.tema_hari for select
  to authenticated
  using (true);

drop policy if exists "admin kelola tema" on public.tema_hari;
create policy "admin kelola tema"
  on public.tema_hari for all
  to authenticated
  using (public.apakah_admin())
  with check (public.apakah_admin());

-- ---------- isi N3 hari 1–31 ----------
insert into public.tema_hari (level, hari_ke, tema, arti) values
  ('n3',  1, '生活',                   'kehidupan sehari-hari'),
  ('n3',  2, '家族・人',               'keluarga & orang'),
  ('n3',  3, '体・健康',               'tubuh & kesehatan'),
  ('n3',  4, '食べ物・味',             'makanan & rasa'),
  ('n3',  5, '買い物・お金',           'belanja & uang'),
  ('n3',  6, '交通・道',               'transportasi & jalan'),
  ('n3',  7, '住まい・部屋',           'rumah & kamar'),
  ('n3',  8, '仕事・会社',             'kerja & kantor'),
  ('n3',  9, '学校・勉強',             'sekolah & belajar'),
  ('n3', 10, '天気・自然',             'cuaca & alam'),
  ('n3', 11, '感情・性格',             'perasaan & sifat'),
  ('n3', 12, '時間・予定',             'waktu & rencana'),
  ('n3', 13, '機械・通信',             'mesin & komunikasi'),
  ('n3', 14, '趣味・スポーツ',         'hobi & olahraga'),
  ('n3', 15, '旅行・宿',               'perjalanan & penginapan'),
  ('n3', 16, '街・場所',               'kota & tempat'),
  ('n3', 17, '動詞① 毎日の動作',       'verba: kegiatan harian'),
  ('n3', 18, '動詞② 考える・伝える',   'verba: berpikir & menyampaikan'),
  ('n3', 19, '動詞③ 変化と移動',       'verba: perubahan & perpindahan'),
  ('n3', 20, '形容詞・い',             'adjektiva -i'),
  ('n3', 21, '形容詞・な',             'adjektiva -na'),
  ('n3', 22, '副詞①',                 'adverbia 1'),
  ('n3', 23, '副詞②・つなぎ言葉',      'adverbia & kata sambung'),
  ('n3', 24, '擬音語・擬態語',         'onomatope'),
  ('n3', 25, '複合語・よく使う名詞',   'kata majemuk & nomina umum'),
  ('n3', 26, '社会・出来事',           'masyarakat & peristiwa'),
  ('n3', 27, '文化・行事',             'budaya & acara'),
  ('n3', 28, 'ビジネス・連絡',         'bisnis & korespondensi'),
  ('n3', 29, '数・量・程度',           'angka & ukuran'),
  ('n3', 30, '重要語レビュー①',        'kata penting 1'),
  ('n3', 31, '重要語レビュー②',        'kata penting 2')
on conflict (level, hari_ke) do update
  set tema = excluded.tema, arti = excluded.arti;

-- cek
select hari_ke, tema, arti from public.tema_hari where level = 'n3' order by hari_ke;
