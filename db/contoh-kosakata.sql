-- ============================================================================
-- CONTOH BAHAN · N3 Hari 1 — 25 kosakata
-- Tema: 生活 (kehidupan) · kata kerja abstrak & perasaan
-- Jalankan setelah belajar.sql
-- ============================================================================

insert into public.kosakata (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_id) values
('n3', 1,  1, '生活', 'せいかつ', 'kehidupan sehari-hari', 'nomina',
  '生活が忙しい。', 'Kehidupan sehari-hari (ku) sibuk.'),
('n3', 1,  2, '経験', 'けいけん', 'pengalaman', 'nomina',
  'いい経験になる。', 'Akan jadi pengalaman yang baik.'),
('n3', 1,  3, '関係', 'かんけい', 'hubungan', 'nomina',
  '二人の関係は深い。', 'Hubungan keduanya erat.'),
('n3', 1,  4, '必要', 'ひつよう', 'perlu / kebutuhan', 'na-adjektiva',
  '説明が必要だ。', 'Penjelasannya diperlukan.'),
('n3', 1,  5, '解決', 'かいけつ', 'penyelesaian', 'nomina',
  '問題を解決する。', 'Menyelesaikan masalah.'),
('n3', 1,  6, '相談', 'そうだん', 'berkonsultasi', 'nomina',
  '上司に相談する。', 'Berkonsultasi dengan atasan.'),
('n3', 1,  7, '確認', 'かくにん', 'konfirmasi / memastikan', 'nomina',
  '予約を確認する。', 'Memastikan reservasinya.'),
('n3', 1,  8, '準備', 'じゅんび', 'persiapan', 'nomina',
  '旅行の準備をする。', 'Menyiapkan perjalanan.'),
('n3', 1,  9, '説明', 'せつめい', 'penjelasan', 'nomina',
  '使い方を説明する。', 'Menjelaskan cara pakainya.'),
('n3', 1, 10, '連絡', 'れんらく', 'kabar / menghubungi', 'nomina',
  '後で連絡します。', 'Saya kabari nanti.'),
('n3', 1, 11, '約束', 'やくそく', 'janji', 'nomina',
  '約束を守る。', 'Menepati janji.'),
('n3', 1, 12, '期待', 'きたい', 'harapan / mengharapkan', 'nomina',
  '結果を期待している。', 'Saya menantikan hasilnya.'),
('n3', 1, 13, '感想', 'かんそう', 'kesan', 'nomina',
  '映画の感想を聞く。', 'Menanyakan kesan tentang filmnya.'),
('n3', 1, 14, '意見', 'いけん', 'pendapat', 'nomina',
  '自分の意見を言う。', 'Menyampaikan pendapat sendiri.'),
('n3', 1, 15, '性格', 'せいかく', 'sifat / watak', 'nomina',
  '明るい性格だ。', 'Wataknya ceria.'),
('n3', 1, 16, '気持ち', 'きもち', 'perasaan', 'nomina',
  '気持ちが伝わる。', 'Perasaannya tersampaikan.'),
('n3', 1, 17, '安心', 'あんしん', 'tenang / lega', 'nomina',
  '安心してください。', 'Silakan tenang.'),
('n3', 1, 18, '遠慮', 'えんりょ', 'sungkan / menahan diri', 'nomina',
  '遠慮しないでください。', 'Jangan sungkan.'),
('n3', 1, 19, '我慢', 'がまん', 'menahan / bersabar', 'nomina',
  '痛みを我慢する。', 'Menahan sakit.'),
('n3', 1, 20, '失敗', 'しっぱい', 'kegagalan', 'nomina',
  '失敗から学ぶ。', 'Belajar dari kegagalan.'),
('n3', 1, 21, '成功', 'せいこう', 'keberhasilan', 'nomina',
  '成功を祈る。', 'Mendoakan keberhasilan.'),
('n3', 1, 22, '努力', 'どりょく', 'usaha', 'nomina',
  '努力は必ず報われる。', 'Usaha pasti berbuah.'),
('n3', 1, 23, '習慣', 'しゅうかん', 'kebiasaan', 'nomina',
  '早起きが習慣だ。', 'Bangun pagi adalah kebiasaan.'),
('n3', 1, 24, '挑戦', 'ちょうせん', 'tantangan / menantang', 'nomina',
  '新しいことに挑戦する。', 'Menantang hal baru.'),
('n3', 1, 25, '達成', 'たっせい', 'pencapaian', 'nomina',
  '目標を達成した。', 'Mencapai tujuannya.')
on conflict (level, hari_ke, urutan) do nothing;

-- cek hasil
select level, hari_ke, count(*) as jumlah
from public.kosakata
group by level, hari_ke
order by level, hari_ke;
