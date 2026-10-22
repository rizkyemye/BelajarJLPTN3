-- Auto-generated oleh buat-kanji-sql.py

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
