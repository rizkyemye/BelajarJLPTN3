-- ============================================================================
-- CHOUKAI N3 · soal mendengar gaya JLPT (tanpa file audio — dibacakan suara
-- perangkat lewat Web Speech, jadi 0 MB & bisa diulang)
--
-- Kolom:
--   jenis : kd (課題理解) · pt (ポイント理解) · hw (発話表現) · sk (即時応答)
--   skrip_jp / skrip_furi : percakapan, satu baris = satu pembicara
--                           (contoh: 女：あしたの会議、資料は？)
--   soal  : jsonb [{tanya, pilihan[4], benar}]
--
-- Aman dijalankan berulang (on conflict update).
-- ============================================================================
create table if not exists public.choukai (
  id        bigserial primary key,
  level     text not null default 'n3',
  hari_ke   int  not null,
  jenis     text not null default 'kd',
  judul_jp  text,
  judul_id  text,
  skrip_jp  text not null,
  skrip_furi text,
  teks_id   text,
  soal      jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  unique (level, hari_ke)
);
alter table public.choukai enable row level security;
drop policy if exists "baca choukai" on public.choukai;
create policy "baca choukai" on public.choukai for select to authenticated using (true);
drop policy if exists "admin tulis choukai" on public.choukai;
create policy "admin tulis choukai" on public.choukai for all to authenticated
  using (public.apakah_admin()) with check (public.apakah_admin());
-- ============================================================================
-- HARI 1 · 課題理解 (kd)
-- ============================================================================
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal)
values (
  'n3', 1, 'kd', '資料の確認', 'Memastikan dokumen',
'女：あしたの会議の資料、もう準備できた？
男：まだです。今、確認しています。五分ぐらいかかります。
女：じゃあ、できたら、先に部長に送ってください。
男：はい。わかりました。',
'女：あしたの かいぎの しりょう、もう じゅんび できた？
男：まだです。いま、かくにん しています。ごふんぐらい かかります。
女：じゃあ、できたら、さきに ぶちょうに おくって ください。
男：はい。わかりました。',
'Perempuan: Dokumen rapat besok sudah siap?
Pria: Belum. Sekarang sedang saya periksa. Butuh sekitar lima menit.
Perempuan: Kalau begitu, kalau sudah selesai, kirim dulu ke manajer.
Pria: Baik, mengerti.',
'[
 {"tanya":"男の人はこれから何をしますか。",
  "pilihan":[
    "資料の確認をしてから、部長に送ります。",
    "資料の確認をやめて、会議に出ます。",
    "部長に電話して、聞きます。",
    "女の人に資料を渡します。"
  ],"benar":0}
]'::jsonb
)
on conflict (level, hari_ke) do update set
  jenis = excluded.jenis, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  skrip_jp = excluded.skrip_jp, skrip_furi = excluded.skrip_furi,
  teks_id = excluded.teks_id, soal = excluded.soal;
-- ============================================================================
-- HARI 2 · ポイント理解 (pt)
-- ============================================================================
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal)
values (
  'n3', 2, 'pt', '週末', 'Akhir pekan',
'女：田中さん、週末は何をしましたか。
男：家族と祖母の家へ行きました。祖母が八十歳になったので。
女：そうですか。お元気でしたか。
男：はい、元気でした。でも、階段が大変そうでした。',
'女：たなかさん、しゅうまつは なにを しましたか。
男：かぞくと そぼの いえへ いきました。そぼが はちじゅっさいに なったので。
女：そうですか。おげんきでしたか。
男：はい、げんきでした。でも、かいだんが たいへんそうでした。',
'Perempuan: Tanaka-san, akhir pekan kemarin ngapain?
Pria: Pergi ke rumah nenek bersama keluarga. Karena nenek sudah 80 tahun.
Perempuan: Oh begitu. Beliau sehat?
Pria: Sehat. Tapi kelihatannya susah naik tangga.',
'[
 {"tanya":"男の人はなぜ祖母の家へ行きましたか。",
  "pilihan":[
    "祖母の誕生日だったからです。",
    "祖母が病気になったからです。",
    "家を掃除するためです。",
    "家族と旅行するためです。"
  ],"benar":0}
]'::jsonb
)
on conflict (level, hari_ke) do update set
  jenis = excluded.jenis, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  skrip_jp = excluded.skrip_jp, skrip_furi = excluded.skrip_furi,
  teks_id = excluded.teks_id, soal = excluded.soal;
-- ============================================================================
-- HARI 3 · 課題理解 (kd)
-- ============================================================================
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal)
values (
  'n3', 3, 'kd', '病院で', 'Di rumah sakit',
'医者：のどが痛いんですね。熱は？
男：三十七度五分です。
医者：今日は仕事を休んで、水をたくさん飲んでください。薬は一日三回、食事のあとです。
男：わかりました。',
'医者：のどが いたいんですね。ねつは？
男：さんじゅうななど ごぶです。
医者：きょうは しごとを やすんで、みずを たくさん のんで ください。くすりは いちにち さんかい、しょくじの あとです。
男：わかりました。',
'Dokter: Sakit tenggorokan ya. Panasnya?
Pria: 37,5 derajat.
Dokter: Hari ini istirahat kerja, minum air banyak-banyak. Obat tiga kali sehari, sesudah makan.
Pria: Mengerti.',
'[
 {"tanya":"男の人は今日、どうしなければなりませんか。",
  "pilihan":[
    "仕事を休んで、水をたくさん飲みます。",
    "仕事をして、薬を飲みません。",
    "食事をしてから、病院へ行きます。",
    "一日三回、運動します。"
  ],"benar":0}
]'::jsonb
)
on conflict (level, hari_ke) do update set
  jenis = excluded.jenis, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  skrip_jp = excluded.skrip_jp, skrip_furi = excluded.skrip_furi,
  teks_id = excluded.teks_id, soal = excluded.soal;
-- ============================================================================
-- HARI 4 · 即時応答 (sk)
-- ============================================================================
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal)
values (
  'n3', 4, 'sk', '辛すぎる', 'Terlalu pedas',
'女：これ、ちょっと辛すぎない？',
'女：これ、ちょっと からすぎない？',
'Perempuan: Ini agak terlalu pedas, ya?',
'[
 {"tanya":"このとき、男の人は何と言いますか。",
  "pilihan":[
    "うん、もう少し甘くしたほうがいいね。",
    "はい、とてもおいしいです。",
    "いいえ、私は食べません。"
  ],"benar":0}
]'::jsonb
)
on conflict (level, hari_ke) do update set
  jenis = excluded.jenis, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  skrip_jp = excluded.skrip_jp, skrip_furi = excluded.skrip_furi,
  teks_id = excluded.teks_id, soal = excluded.soal;
-- ============================================================================
-- HARI 5 · 発話表現 (hw)
-- ============================================================================
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal)
values (
  'n3', 5, 'hw', '色が違う', 'Warnanya beda',
'ナレーション：店で買ったシャツの色が、家に帰ってから違うことに気づきました。店の人に何と言いますか。
女：すみません、このシャツ、色が違うんですが、交換してもらえますか。',
'ナレーション：みせで かった シャツの いろが、いえに かえってから ちがう ことに きづきました。みせの ひとに なんと いいますか。
女：すみません、この シャツ、いろが ちがうんですが、こうかん してもらえますか。',
'Narasi: Setelah pulang, kamu sadar warna kemeja yang dibeli di toko berbeda. Apa yang kamu katakan ke penjaga toko?
Perempuan: Permisi, kemeja ini warnanya berbeda, bisakah ditukar?',
'[
 {"tanya":"このとき、何と言いますか。",
  "pilihan":[
    "すみません、このシャツ、色が違うんですが、交換してもらえますか。",
    "すみません、このシャツはとても安いですね。",
    "すみません、このシャツを捨ててもいいですか。"
  ],"benar":0}
]'::jsonb
)
on conflict (level, hari_ke) do update set
  jenis = excluded.jenis, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  skrip_jp = excluded.skrip_jp, skrip_furi = excluded.skrip_furi,
  teks_id = excluded.teks_id, soal = excluded.soal;
-- ============================================================================
-- HARI 6 · 課題理解 (kd)
-- ============================================================================
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal)
values (
  'n3', 6, 'kd', '道を聞く', 'Menanyakan jalan',
'女：すみません、駅までどう行けばいいですか。
男：この道をまっすぐ行って、二つ目の信号を右に曲がってください。駅は左側です。
女：二つ目の信号ですね。バスでも行けますか。
男：はい、三番のバスです。',
'女：すみません、えきまで どう いけば いいですか。
男：この みちを まっすぐ いって、ふたつめの しんごうを みぎに まがって ください。えきは ひだりがわです。
女：ふたつめの しんごうですね。バスでも いけますか。
男：はい、さんばんの バスです。',
'Perempuan: Permisi, bagaimana cara ke stasiun?
Pria: Lurus di jalan ini, lalu di lampu merah kedua belok kanan. Stasiunnya di sebelah kiri.
Perempuan: Lampu merah kedua, ya. Bisa naik bus juga?
Pria: Bisa, bus nomor tiga.',
'[
 {"tanya":"女の人は駅までどう行きますか。",
  "pilihan":[
    "まっすぐ行って、二つ目の信号を右に曲がって行きます。",
    "一つ目の信号を左に曲がって行きます。",
    "三番のバスに乗って行きます。",
    "男の人と一緒に歩いて行きます。"
  ],"benar":0}
]'::jsonb
)
on conflict (level, hari_ke) do update set
  jenis = excluded.jenis, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  skrip_jp = excluded.skrip_jp, skrip_furi = excluded.skrip_furi,
  teks_id = excluded.teks_id, soal = excluded.soal;
-- ============================================================================
-- HARI 7 · ポイント理解 (pt)
-- ============================================================================
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal)
values (
  'n3', 7, 'pt', '新しい部屋', 'Kamar baru',
'男：新しい部屋はどうですか。
女：駅から近くて便利です。でも、少し狭いです。
男：家具は？
女：引っ越しのときに、全部捨てました。今は、机とベッドだけです。',
'男：あたらしい へやは どうですか。
女：えきから ちかくて べんりです。でも、すこし せまいです。
男：かぐは？
女：ひっこしの ときに、ぜんぶ すてました。いまは、つくえと ベッドだけです。',
'Pria: Kamar barunya bagaimana?
Perempuan: Dekat stasiun jadi praktis. Tapi agak sempit.
Pria: Perabotnya?
Perempuan: Waktu pindahan, semuanya saya buang. Sekarang hanya meja dan tempat tidur.',
'[
 {"tanya":"女の人は、今どんな部屋に住んでいますか。",
  "pilihan":[
    "駅に近いですが、狭くて、家具が少ない部屋です。",
    "駅から遠くて、とても広い部屋です。",
    "家具がたくさんある、広い部屋です。",
    "駅の近くにある、古い店です。"
  ],"benar":0}
]'::jsonb
)
on conflict (level, hari_ke) do update set
  jenis = excluded.jenis, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  skrip_jp = excluded.skrip_jp, skrip_furi = excluded.skrip_furi,
  teks_id = excluded.teks_id, soal = excluded.soal;
-- ============================================================================
-- HARI 8 · 即時応答 (sk)
-- ============================================================================
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal)
values (
  'n3', 8, 'sk', '書類', 'Dokumen',
'男：この書類、あしたの朝までに終わりますか。',
'男：この しょるい、あしたの あさまでに おわりますか。',
'Pria: Dokumen ini selesai sebelum besok pagi?',
'[
 {"tanya":"このとき、女の人は何と言いますか。",
  "pilihan":[
    "はい、今夜中にやっておきます。",
    "いいえ、書類ではありません。",
    "あしたは休みです。"
  ],"benar":0}
]'::jsonb
)
on conflict (level, hari_ke) do update set
  jenis = excluded.jenis, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  skrip_jp = excluded.skrip_jp, skrip_furi = excluded.skrip_furi,
  teks_id = excluded.teks_id, soal = excluded.soal;
-- cek: select hari_ke, jenis, jsonb_array_length(soal) from public.choukai order by hari_ke;
