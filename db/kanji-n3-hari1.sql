-- ============================================================================
-- KANJI N3 — Hari 1 (10 kanji)
-- Tema: 経済・社会 (ekonomi & masyarakat) — nyambung dengan kosakata hari 1–31
-- Jalankan setelah kanji.sql
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
