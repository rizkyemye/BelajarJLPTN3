-- ============================================================================
-- FURIGANA · contoh kalimat
--
-- Tambah kolom contoh_furi (bacaan hiragana dari contoh_jp).
-- Aplikasi menyelaraskan kanji dengan kana ini, lalu memasang <ruby>.
--
-- Jalankan di SQL Editor. Aman diulang.
-- ============================================================================

-- 1. kolom baru
alter table public.kosakata
  add column if not exists contoh_furi text;

comment on column public.kosakata.contoh_furi is
  'Bacaan hiragana penuh dari contoh_jp, dengan spasi antar kata opsional';

-- 2. isi 25 kata hari 1
update public.kosakata k
set contoh_furi = v.furi
from (values
  (1,  'せいかつが いそがしい。'),
  (2,  'いい けいけんに なる。'),
  (3,  'ふたりの かんけいは ふかい。'),
  (4,  'せつめいが ひつようだ。'),
  (5,  'もんだいを かいけつする。'),
  (6,  'じょうしに そうだんする。'),
  (7,  'よやくを かくにんする。'),
  (8,  'りょこうの じゅんびを する。'),
  (9,  'つかいかたを せつめいする。'),
  (10, 'あとで れんらくします。'),
  (11, 'やくそくを まもる。'),
  (12, 'けっかを きたいしている。'),
  (13, 'えいがの かんそうを きく。'),
  (14, 'じぶんの いけんを いう。'),
  (15, 'あかるい せいかくだ。'),
  (16, 'きもちが つたわる。'),
  (17, 'あんしんしてください。'),
  (18, 'えんりょしないで ください。'),
  (19, 'いたみを がまんする。'),
  (20, 'しっぱいから まなぶ。'),
  (21, 'せいこうを いのる。'),
  (22, 'どりょくは かならず むくわれる。'),
  (23, 'はやおきが しゅうかんだ。'),
  (24, 'あたらしい ことに ちょうせんする。'),
  (25, 'もくひょうを たっせいした。')
) as v(urutan, furi)
where k.level = 'n3' and k.hari_ke = 1 and k.urutan = v.urutan;

-- 3. cek
select urutan, kanji, contoh_jp, contoh_furi
from public.kosakata
where level = 'n3' and hari_ke = 1
order by urutan;
