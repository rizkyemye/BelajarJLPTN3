-- ============================================================================
-- DOKKAI gaya JLPT — Hari 14–42 (dibuat gen-dokkai-jlpt.py)
-- ① 短文 ② お知らせ ③ メール, bergiliran. Soal bahasa Jepang, 4 pilihan.
-- Aman dijalankan berulang (on conflict update).
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 14, '趣味・スポーツ', '趣味・スポーツ', 'hobi & olahraga',
'漫画について、よく聞かれます。わたしは勝つことが大切だと思います。でも、走ることも必要です。泳ぐことを忘れないでください。',
'まんがについて、よく聞かれます。わたしはかつことが大切だと思います。でも、はしることも必要です。およぐことを忘れないでください。',
'Tentang komik, sering ditanyakan. Saya rasa menang itu penting. Tetapi berlari juga perlu. Jangan lupa berenang.',
'[{"tanya": "何についてよく聞かれますか。", "pilihan": ["勝つこと", "走ること", "泳ぐこと", "漫画"], "benar": 3}, {"tanya": "筆者が大切だと思っているのはどれですか。", "pilihan": ["泳ぐこと", "走ること", "勝つこと", "漫画"], "benar": 2}, {"tanya": "何を忘れないでくださいと言っていますか。", "pilihan": ["泳ぐこと", "勝つこと", "漫画", "走ること"], "benar": 0}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 15, '旅行・宿', '旅行・宿', 'perjalanan & penginapan',
'お知らせ・海外は、今週の金曜日までです。・出発が必要です。・城のときは、受付に言ってください。・観光客は、来週からです。',
'おしらせ・かいがいは、こんしゅうの きんようびまでです。・しゅっぱつが ひつよう です。・しろのときは、うけつけに いって ください。・かんこうきゃくは、らいしゅうから です。',
'Pengumuman ・luar negeri sampai Jumat pekan ini. ・keberangkatan diperlukan. ・Kalau kastel, bilang ke resepsionis. ・turis mulai pekan depan.',
'[{"tanya": "何が今週の金曜日までですか。", "pilihan": ["観光客", "海外", "出発", "城"], "benar": 1}, {"tanya": "何が必要ですか。", "pilihan": ["海外", "観光客", "城", "出発"], "benar": 3}, {"tanya": "城のときは、どうしますか。", "pilihan": ["電話をかけません。", "家に帰ります。", "受付に言います。", "何もしません。"], "benar": 2}, {"tanya": "観光客はいつからですか。", "pilihan": ["来週からです。", "家に帰ります。", "何もしません。", "電話をかけません。"], "benar": 0}]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 16, '街・場所', '街・場所', 'kota & tempat',
'件名：後ろのお知らせみなさん通ることは、明日の午後三時からです。遠いことを持ってきてください。質問がある人は、メールで連絡してください。',
'けんめい：うしろの おしらせみなさんとおることは、あしたの ごご さんじから です。とおいことを もってきて ください。しつもんが ある ひとは、メールで れんらくして ください。',
'Subjek: Pemberitahuan belakang Semua, melewati besok mulai jam 3 sore. Mohon bawa jauh. Yang ada pertanyaan, hubungi lewat surel.',
'[{"tanya": "何についてのお知らせですか。", "pilihan": ["後ろ", "遠いこと", "商店街", "通ること"], "benar": 0}, {"tanya": "通ることはいつですか。", "pilihan": ["電話をかけません。", "家に帰ります。", "何もしません。", "明日の午後三時からです。"], "benar": 3}, {"tanya": "何を持ってきますか。", "pilihan": ["通ること", "商店街", "遠いこと", "後ろ"], "benar": 2}, {"tanya": "質問がある人はどうしますか。", "pilihan": ["何もしません。", "電話をかけません。", "メールで連絡します。", "家に帰ります。"], "benar": 2}]'::jsonb, 'email')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 17, '動詞① 毎日の動作', '動詞① 毎日の動作', 'verba: kegiatan harian',
'描くことについて、よく聞かれます。わたしは取ることが大切だと思います。でも、開けることも必要です。片付けることを忘れないでください。',
'かくことについて、よく聞かれます。わたしはとることが大切だと思います。でも、あけることも必要です。かたづけることを忘れないでください。',
'Tentang menggambar, sering ditanyakan. Saya rasa mengambil itu penting. Tetapi membuka juga perlu. Jangan lupa merapikan.',
'[{"tanya": "何についてよく聞かれますか。", "pilihan": ["開けること", "描くこと", "片付けること", "取ること"], "benar": 1}, {"tanya": "筆者が大切だと思っているのはどれですか。", "pilihan": ["開けること", "取ること", "片付けること", "描くこと"], "benar": 1}, {"tanya": "何を忘れないでくださいと言っていますか。", "pilihan": ["開けること", "片付けること", "取ること", "描くこと"], "benar": 1}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 18, '動詞② 考える・伝える', '動詞② 考える・伝える', 'verba: berpikir & menyampaikan',
'お知らせ・紹介することは、今週の金曜日までです。・認めることが必要です。・案内することのときは、受付に言ってください。・考えることは、来週からです。',
'おしらせ・しょうかいすることは、こんしゅうの きんようびまでです。・みとめることが ひつよう です。・あんないすることのときは、うけつけに いって ください。・かんがえることは、らいしゅうから です。',
'Pengumuman ・memperkenalkan sampai Jumat pekan ini. ・mengakui diperlukan. ・Kalau memandu, bilang ke resepsionis. ・berpikir mulai pekan depan.',
'[{"tanya": "何が今週の金曜日までですか。", "pilihan": ["認めること", "紹介すること", "案内すること", "考えること"], "benar": 1}, {"tanya": "何が必要ですか。", "pilihan": ["紹介すること", "考えること", "認めること", "案内すること"], "benar": 2}, {"tanya": "案内することのときは、どうしますか。", "pilihan": ["家に帰ります。", "何もしません。", "電話をかけません。", "受付に言います。"], "benar": 3}, {"tanya": "考えることはいつからですか。", "pilihan": ["家に帰ります。", "来週からです。", "何もしません。", "電話をかけません。"], "benar": 1}]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 19, '動詞③ 変化と移動', '動詞③ 変化と移動', 'verba: perubahan & perpindahan',
'件名：枯れることのお知らせみなさん割れることは、明日の午後三時からです。減ることを持ってきてください。質問がある人は、メールで連絡してください。',
'けんめい：かれることの おしらせみなさんわれることは、あしたの ごご さんじから です。へることを もってきて ください。しつもんが ある ひとは、メールで れんらくして ください。',
'Subjek: Pemberitahuan layu / mati (tanaman) Semua, pecah besok mulai jam 3 sore. Mohon bawa berkurang. Yang ada pertanyaan, hubungi lewat surel.',
'[{"tanya": "何についてのお知らせですか。", "pilihan": ["割れること", "続くこと", "枯れること", "減ること"], "benar": 2}, {"tanya": "割れることはいつですか。", "pilihan": ["電話をかけません。", "家に帰ります。", "何もしません。", "明日の午後三時からです。"], "benar": 3}, {"tanya": "何を持ってきますか。", "pilihan": ["枯れること", "続くこと", "割れること", "減ること"], "benar": 3}, {"tanya": "質問がある人はどうしますか。", "pilihan": ["電話をかけません。", "メールで連絡します。", "何もしません。", "家に帰ります。"], "benar": 1}]'::jsonb, 'email')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 20, '形容詞・い', '形容詞・い', 'adjektiva -i',
'うるさいことについて、よく聞かれます。わたしは重いことが大切だと思います。でも、痛いことも必要です。易しいことを忘れないでください。',
'うるさいことについて、よく聞かれます。わたしはおもいことが大切だと思います。でも、いたいことも必要です。やさしいことを忘れないでください。',
'Tentang berisik, sering ditanyakan. Saya rasa berat itu penting. Tetapi sakit / nyeri juga perlu. Jangan lupa mudah.',
'[{"tanya": "何についてよく聞かれますか。", "pilihan": ["重いこと", "うるさいこと", "易しいこと", "痛いこと"], "benar": 1}, {"tanya": "筆者が大切だと思っているのはどれですか。", "pilihan": ["うるさいこと", "痛いこと", "重いこと", "易しいこと"], "benar": 2}, {"tanya": "何を忘れないでくださいと言っていますか。", "pilihan": ["痛いこと", "重いこと", "うるさいこと", "易しいこと"], "benar": 3}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 21, '形容詞・な', '形容詞・な', 'adjektiva -na',
'お知らせ・貧しいことは、今週の金曜日までです。・迷惑なことが必要です。・新鮮なことのときは、受付に言ってください。・簡単なことは、来週からです。',
'おしらせ・まずしいことは、こんしゅうの きんようびまでです。・めいわくなことが ひつよう です。・しんせんなことのときは、うけつけに いって ください。・かんたんなことは、らいしゅうから です。',
'Pengumuman ・miskin sampai Jumat pekan ini. ・merepotkan diperlukan. ・Kalau segar, bilang ke resepsionis. ・mudah / sederhana mulai pekan depan.',
'[{"tanya": "何が今週の金曜日までですか。", "pilihan": ["貧しいこと", "新鮮なこと", "簡単なこと", "迷惑なこと"], "benar": 0}, {"tanya": "何が必要ですか。", "pilihan": ["貧しいこと", "簡単なこと", "新鮮なこと", "迷惑なこと"], "benar": 3}, {"tanya": "新鮮なことのときは、どうしますか。", "pilihan": ["何もしません。", "電話をかけません。", "受付に言います。", "家に帰ります。"], "benar": 2}, {"tanya": "簡単なことはいつからですか。", "pilihan": ["来週からです。", "家に帰ります。", "何もしません。", "電話をかけません。"], "benar": 0}]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 22, '副詞①', '副詞①', 'adverbia 1',
'きょうは「たしかに」という言葉を習いました。この言葉は「すぐ」と関係があります。先生は「たくさん」を使うと説明しました。わたしは「はっきり」の意味が分かりました。',
'きょうは「たしかに」という ことばを ならいました。この ことばは「すぐ」と かんけいが あります。せんせいは「たくさん」を つかうと せつめい しました。わたしは「はっきり」の いみが わかりました。',
'Hari ini saya belajar kata “memang benar”. Kata ini berhubungan dengan “langsung”. Guru menjelaskan bahwa “banyak” dipakai. Saya mengerti arti “jelas”.',
'[{"tanya": "きょう、何という言葉を習いましたか。", "pilihan": ["すぐ", "たくさん", "「たしかに」", "たしかに"], "benar": 2}, {"tanya": "この言葉と関係がある言葉はどれですか。", "pilihan": ["たくさん", "すぐ", "「すぐ」", "たしかに"], "benar": 2}, {"tanya": "だれが使い方を説明しましたか。", "pilihan": ["家に帰ります。", "電話をかけません。", "何もしません。", "先生"], "benar": 3}, {"tanya": "「はっきり」について、何が分かりましたか。", "pilihan": ["何もしません。", "電話をかけません。", "意味が分かりました。", "家に帰ります。"], "benar": 2}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 23, '副詞②・つなぎ言葉', '副詞②・つなぎ言葉', 'adverbia & kata sambung',
'きょうは「あまり」という言葉を習いました。この言葉は「今すぐ」と関係があります。先生は「かなり」を使うと説明しました。わたしは「一度」の意味が分かりました。',
'きょうは「あまり」という ことばを ならいました。この ことばは「いますぐ」と かんけいが あります。せんせいは「かなり」を つかうと せつめい しました。わたしは「いちど」の いみが わかりました。',
'Hari ini saya belajar kata “tidak begitu”. Kata ini berhubungan dengan “sekarang juga”. Guru menjelaskan bahwa “cukup” dipakai. Saya mengerti arti “sekali”.',
'[{"tanya": "きょう、何という言葉を習いましたか。", "pilihan": ["「あまり」", "あまり", "今すぐ", "かなり"], "benar": 0}, {"tanya": "この言葉と関係がある言葉はどれですか。", "pilihan": ["今すぐ", "「今すぐ」", "あまり", "かなり"], "benar": 1}, {"tanya": "だれが使い方を説明しましたか。", "pilihan": ["何もしません。", "電話をかけません。", "家に帰ります。", "先生"], "benar": 3}, {"tanya": "「一度」について、何が分かりましたか。", "pilihan": ["家に帰ります。", "電話をかけません。", "意味が分かりました。", "何もしません。"], "benar": 2}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 24, '擬音語・擬態語', '擬音語・擬態語', 'onomatope',
'きょうは「ゆったり」という言葉を習いました。この言葉は「ぺこぺこ」と関係があります。先生は「ぺらぺら」を使うと説明しました。わたしは「がっかり」の意味が分かりました。',
'きょうは「ゆったり」という ことばを ならいました。この ことばは「ぺこぺこ」と かんけいが あります。せんせいは「ぺらぺら」を つかうと せつめい しました。わたしは「がっかり」の いみが わかりました。',
'Hari ini saya belajar kata “lega / santai”. Kata ini berhubungan dengan “sangat lapar”. Guru menjelaskan bahwa “fasih” dipakai. Saya mengerti arti “kecewa”.',
'[{"tanya": "きょう、何という言葉を習いましたか。", "pilihan": ["ぺこぺこ", "ゆったり", "「ゆったり」", "ぺらぺら"], "benar": 2}, {"tanya": "この言葉と関係がある言葉はどれですか。", "pilihan": ["ゆったり", "「ぺこぺこ」", "ぺこぺこ", "ぺらぺら"], "benar": 1}, {"tanya": "だれが使い方を説明しましたか。", "pilihan": ["先生", "家に帰ります。", "電話をかけません。", "何もしません。"], "benar": 0}, {"tanya": "「がっかり」について、何が分かりましたか。", "pilihan": ["意味が分かりました。", "電話をかけません。", "家に帰ります。", "何もしません。"], "benar": 0}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 25, '複合語・よく使う名詞', '複合語・よく使う名詞', 'kata majemuk & nomina umum',
'件名：待ち合わせのお知らせみなさん食料品は、明日の午後三時からです。切手を持ってきてください。質問がある人は、メールで連絡してください。',
'けんめい：まちあわせの おしらせみなさんしょくりょうひんは、あしたの ごご さんじから です。きってを もってきて ください。しつもんが ある ひとは、メールで れんらくして ください。',
'Subjek: Pemberitahuan janji temu Semua, bahan makanan besok mulai jam 3 sore. Mohon bawa perangko. Yang ada pertanyaan, hubungi lewat surel.',
'[{"tanya": "何についてのお知らせですか。", "pilihan": ["引っ越し", "食料品", "切手", "待ち合わせ"], "benar": 3}, {"tanya": "食料品はいつですか。", "pilihan": ["明日の午後三時からです。", "家に帰ります。", "何もしません。", "電話をかけません。"], "benar": 0}, {"tanya": "何を持ってきますか。", "pilihan": ["切手", "食料品", "引っ越し", "待ち合わせ"], "benar": 0}, {"tanya": "質問がある人はどうしますか。", "pilihan": ["メールで連絡します。", "家に帰ります。", "電話をかけません。", "何もしません。"], "benar": 0}]'::jsonb, 'email')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 26, '社会・出来事', '社会・出来事', 'masyarakat & peristiwa',
'犯罪について、よく聞かれます。わたしは産業が大切だと思います。でも、報道も必要です。対応を忘れないでください。',
'はんざいについて、よく聞かれます。わたしはさんぎょうが大切だと思います。でも、ほうどうも必要です。たいおうを忘れないでください。',
'Tentang kejahatan, sering ditanyakan. Saya rasa industri itu penting. Tetapi pemberitaan juga perlu. Jangan lupa penanganan.',
'[{"tanya": "何についてよく聞かれますか。", "pilihan": ["産業", "犯罪", "対応", "報道"], "benar": 1}, {"tanya": "筆者が大切だと思っているのはどれですか。", "pilihan": ["報道", "犯罪", "産業", "対応"], "benar": 2}, {"tanya": "何を忘れないでくださいと言っていますか。", "pilihan": ["犯罪", "対応", "産業", "報道"], "benar": 1}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 27, '文化・行事', '文化・行事', 'budaya & acara',
'お知らせ・芸術は、今週の金曜日までです。・慣習が必要です。・箸のときは、受付に言ってください。・民話は、来週からです。',
'おしらせ・げいじゅつは、こんしゅうの きんようびまでです。・かんしゅうが ひつよう です。・はしのときは、うけつけに いって ください。・みんわは、らいしゅうから です。',
'Pengumuman ・seni sampai Jumat pekan ini. ・kebiasaan turun-temurun diperlukan. ・Kalau sumpit, bilang ke resepsionis. ・cerita rakyat mulai pekan depan.',
'[{"tanya": "何が今週の金曜日までですか。", "pilihan": ["民話", "芸術", "慣習", "箸"], "benar": 1}, {"tanya": "何が必要ですか。", "pilihan": ["箸", "慣習", "芸術", "民話"], "benar": 1}, {"tanya": "箸のときは、どうしますか。", "pilihan": ["家に帰ります。", "受付に言います。", "電話をかけません。", "何もしません。"], "benar": 1}, {"tanya": "民話はいつからですか。", "pilihan": ["家に帰ります。", "何もしません。", "電話をかけません。", "来週からです。"], "benar": 3}]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 28, 'ビジネス・連絡', 'ビジネス・連絡', 'bisnis & korespondensi',
'件名：在庫のお知らせみなさん見積もりは、明日の午後三時からです。宛先を持ってきてください。質問がある人は、メールで連絡してください。',
'けんめい：ざいこの おしらせみなさんみつもりは、あしたの ごご さんじから です。あてさきを もってきて ください。しつもんが ある ひとは、メールで れんらくして ください。',
'Subjek: Pemberitahuan stok Semua, estimasi biaya besok mulai jam 3 sore. Mohon bawa alamat tujuan. Yang ada pertanyaan, hubungi lewat surel.',
'[{"tanya": "何についてのお知らせですか。", "pilihan": ["見積もり", "件名", "宛先", "在庫"], "benar": 3}, {"tanya": "見積もりはいつですか。", "pilihan": ["明日の午後三時からです。", "電話をかけません。", "家に帰ります。", "何もしません。"], "benar": 0}, {"tanya": "何を持ってきますか。", "pilihan": ["見積もり", "在庫", "件名", "宛先"], "benar": 3}, {"tanya": "質問がある人はどうしますか。", "pilihan": ["メールで連絡します。", "家に帰ります。", "何もしません。", "電話をかけません。"], "benar": 0}]'::jsonb, 'email')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 29, '数・量・程度', '数・量・程度', 'angka & ukuran',
'割合について、よく聞かれます。わたしは以下が大切だと思います。でも、広さも必要です。回を忘れないでください。',
'わりあいについて、よく聞かれます。わたしはいかが大切だと思います。でも、ひろさも必要です。かいを忘れないでください。',
'Tentang proporsi, sering ditanyakan. Saya rasa kurang dari itu penting. Tetapi luas juga perlu. Jangan lupa kali.',
'[{"tanya": "何についてよく聞かれますか。", "pilihan": ["割合", "回", "広さ", "以下"], "benar": 0}, {"tanya": "筆者が大切だと思っているのはどれですか。", "pilihan": ["回", "以下", "割合", "広さ"], "benar": 1}, {"tanya": "何を忘れないでくださいと言っていますか。", "pilihan": ["以下", "回", "広さ", "割合"], "benar": 1}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 30, '重要語レビュー①', '重要語レビュー①', 'kata penting 1',
'お知らせ・可能性は、今週の金曜日までです。・条件が必要です。・内容のときは、受付に言ってください。・興味は、来週からです。',
'おしらせ・かのうせいは、こんしゅうの きんようびまでです。・じょうけんが ひつよう です。・ないようのときは、うけつけに いって ください。・きょうみは、らいしゅうから です。',
'Pengumuman ・kemungkinan sampai Jumat pekan ini. ・syarat diperlukan. ・Kalau isi, bilang ke resepsionis. ・minat mulai pekan depan.',
'[{"tanya": "何が今週の金曜日までですか。", "pilihan": ["興味", "可能性", "内容", "条件"], "benar": 1}, {"tanya": "何が必要ですか。", "pilihan": ["条件", "可能性", "内容", "興味"], "benar": 0}, {"tanya": "内容のときは、どうしますか。", "pilihan": ["電話をかけません。", "受付に言います。", "家に帰ります。", "何もしません。"], "benar": 1}, {"tanya": "興味はいつからですか。", "pilihan": ["何もしません。", "来週からです。", "家に帰ります。", "電話をかけません。"], "benar": 1}]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 31, '重要語レビュー②', '重要語レビュー②', 'kata penting 2',
'件名：能力のお知らせみなさん共通は、明日の午後三時からです。向上を持ってきてください。質問がある人は、メールで連絡してください。',
'けんめい：のうりょくの おしらせみなさんきょうつうは、あしたの ごご さんじから です。こうじょうを もってきて ください。しつもんが ある ひとは、メールで れんらくして ください。',
'Subjek: Pemberitahuan kemampuan Semua, kesamaan besok mulai jam 3 sore. Mohon bawa peningkatan. Yang ada pertanyaan, hubungi lewat surel.',
'[{"tanya": "何についてのお知らせですか。", "pilihan": ["向上", "能力", "共通", "義務"], "benar": 1}, {"tanya": "共通はいつですか。", "pilihan": ["何もしません。", "明日の午後三時からです。", "家に帰ります。", "電話をかけません。"], "benar": 1}, {"tanya": "何を持ってきますか。", "pilihan": ["向上", "共通", "能力", "義務"], "benar": 0}, {"tanya": "質問がある人はどうしますか。", "pilihan": ["メールで連絡します。", "何もしません。", "電話をかけません。", "家に帰ります。"], "benar": 0}]'::jsonb, 'email')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 32, '宿泊・ホテル', '宿泊・ホテル', 'menginap & hotel',
'点検について、よく聞かれます。わたしは禁煙が大切だと思います。でも、滞在日数も必要です。延長を忘れないでください。',
'てんけんについて、よく聞かれます。わたしはきんえんが大切だと思います。でも、たいざいんすうも必要です。えんちょうを忘れないでください。',
'Tentang pemeriksaan, sering ditanyakan. Saya rasa dilarang merokok itu penting. Tetapi jumlah hari tinggal juga perlu. Jangan lupa perpanjangan.',
'[{"tanya": "何についてよく聞かれますか。", "pilihan": ["滞在日数", "点検", "禁煙", "延長"], "benar": 1}, {"tanya": "筆者が大切だと思っているのはどれですか。", "pilihan": ["点検", "延長", "滞在日数", "禁煙"], "benar": 3}, {"tanya": "何を忘れないでくださいと言っていますか。", "pilihan": ["点検", "禁煙", "延長", "滞在日数"], "benar": 2}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 33, '接客・応対', '接客・応対', 'melayani tamu',
'お知らせ・説明は、今週の金曜日までです。・接客が必要です。・要望のときは、受付に言ってください。・返答は、来週からです。',
'おしらせ・せつめいは、こんしゅうの きんようびまでです。・せっきゃくが ひつよう です。・ようぼうのときは、うけつけに いって ください。・へんとうは、らいしゅうから です。',
'Pengumuman ・penjelasan sampai Jumat pekan ini. ・melayani tamu diperlukan. ・Kalau permintaan, bilang ke resepsionis. ・balasan mulai pekan depan.',
'[{"tanya": "何が今週の金曜日までですか。", "pilihan": ["要望", "説明", "返答", "接客"], "benar": 1}, {"tanya": "何が必要ですか。", "pilihan": ["接客", "説明", "返答", "要望"], "benar": 0}, {"tanya": "要望のときは、どうしますか。", "pilihan": ["電話をかけません。", "受付に言います。", "何もしません。", "家に帰ります。"], "benar": 1}, {"tanya": "返答はいつからですか。", "pilihan": ["何もしません。", "電話をかけません。", "来週からです。", "家に帰ります。"], "benar": 2}]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 34, '厨房・調理', '厨房・調理', 'dapur & memasak',
'件名：廃棄のお知らせみなさん器具は、明日の午後三時からです。冷凍を持ってきてください。質問がある人は、メールで連絡してください。',
'けんめい：はいきの おしらせみなさんきぐは、あしたの ごご さんじから です。れいとうを もってきて ください。しつもんが ある ひとは、メールで れんらくして ください。',
'Subjek: Pemberitahuan pembuangan Semua, peralatan besok mulai jam 3 sore. Mohon bawa pembekuan. Yang ada pertanyaan, hubungi lewat surel.',
'[{"tanya": "何についてのお知らせですか。", "pilihan": ["廃棄", "賞味期限", "器具", "冷凍"], "benar": 0}, {"tanya": "器具はいつですか。", "pilihan": ["電話をかけません。", "家に帰ります。", "明日の午後三時からです。", "何もしません。"], "benar": 2}, {"tanya": "何を持ってきますか。", "pilihan": ["廃棄", "冷凍", "器具", "賞味期限"], "benar": 1}, {"tanya": "質問がある人はどうしますか。", "pilihan": ["メールで連絡します。", "家に帰ります。", "何もしません。", "電話をかけません。"], "benar": 0}]'::jsonb, 'email')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 35, 'レストラン・ホール', 'レストラン・ホール', 'ruang makan',
'席数について、よく聞かれます。わたしは食べ放題が大切だと思います。でも、料理説明も必要です。給水を忘れないでください。',
'せきすうについて、よく聞かれます。わたしはたべほうだいが大切だと思います。でも、りょうりせつめいも必要です。きゅうすいを忘れないでください。',
'Tentang jumlah kursi, sering ditanyakan. Saya rasa makan sepuasnya itu penting. Tetapi penjelasan hidangan juga perlu. Jangan lupa pengisian air.',
'[{"tanya": "何についてよく聞かれますか。", "pilihan": ["席数", "給水", "食べ放題", "料理説明"], "benar": 0}, {"tanya": "筆者が大切だと思っているのはどれですか。", "pilihan": ["席数", "給水", "食べ放題", "料理説明"], "benar": 2}, {"tanya": "何を忘れないでくださいと言っていますか。", "pilihan": ["給水", "席数", "料理説明", "食べ放題"], "benar": 0}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 36, '電話・メール', '電話・メール', 'telepon & surel',
'お知らせ・内線は、今週の金曜日までです。・受付時間が必要です。・暗号のときは、受付に言ってください。・録音は、来週からです。',
'おしらせ・ないせんは、こんしゅうの きんようびまでです。・うけつけじかんが ひつよう です。・あんごうのときは、うけつけに いって ください。・ろくおんは、らいしゅうから です。',
'Pengumuman ・ekstensi sampai Jumat pekan ini. ・jam layanan diperlukan. ・Kalau kata sandi, bilang ke resepsionis. ・rekaman mulai pekan depan.',
'[{"tanya": "何が今週の金曜日までですか。", "pilihan": ["暗号", "受付時間", "内線", "録音"], "benar": 2}, {"tanya": "何が必要ですか。", "pilihan": ["内線", "受付時間", "暗号", "録音"], "benar": 1}, {"tanya": "暗号のときは、どうしますか。", "pilihan": ["電話をかけません。", "家に帰ります。", "受付に言います。", "何もしません。"], "benar": 2}, {"tanya": "録音はいつからですか。", "pilihan": ["家に帰ります。", "来週からです。", "何もしません。", "電話をかけません。"], "benar": 1}]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 37, '予約・受付', '予約・受付', 'reservasi & penerimaan',
'件名：取消のお知らせみなさん加算は、明日の午後三時からです。明細を持ってきてください。質問がある人は、メールで連絡してください。',
'けんめい：とりけしの おしらせみなさんかさんは、あしたの ごご さんじから です。めいさいを もってきて ください。しつもんが ある ひとは、メールで れんらくして ください。',
'Subjek: Pemberitahuan pembatalan Semua, penambahan biaya besok mulai jam 3 sore. Mohon bawa rincian. Yang ada pertanyaan, hubungi lewat surel.',
'[{"tanya": "何についてのお知らせですか。", "pilihan": ["満室", "取消", "明細", "加算"], "benar": 1}, {"tanya": "加算はいつですか。", "pilihan": ["明日の午後三時からです。", "何もしません。", "家に帰ります。", "電話をかけません。"], "benar": 0}, {"tanya": "何を持ってきますか。", "pilihan": ["明細", "加算", "取消", "満室"], "benar": 0}, {"tanya": "質問がある人はどうしますか。", "pilihan": ["電話をかけません。", "メールで連絡します。", "何もしません。", "家に帰ります。"], "benar": 1}]'::jsonb, 'email')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 38, '会計・レジ', '会計・レジ', 'pembayaran & kasir',
'署名について、よく聞かれます。わたしは釣り合わせが大切だと思います。でも、税抜も必要です。釣り銭を忘れないでください。',
'しょめいについて、よく聞かれます。わたしはつりあわせが大切だと思います。でも、ぜいぬきも必要です。つりせんを忘れないでください。',
'Tentang tanda tangan, sering ditanyakan. Saya rasa penyeimbangan kas itu penting. Tetapi tanpa pajak juga perlu. Jangan lupa uang kembalian.',
'[{"tanya": "何についてよく聞かれますか。", "pilihan": ["署名", "釣り銭", "税抜", "釣り合わせ"], "benar": 0}, {"tanya": "筆者が大切だと思っているのはどれですか。", "pilihan": ["税抜", "釣り合わせ", "釣り銭", "署名"], "benar": 1}, {"tanya": "何を忘れないでくださいと言っていますか。", "pilihan": ["釣り銭", "釣り合わせ", "署名", "税抜"], "benar": 0}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 39, '苦情・トラブル', '苦情・トラブル', 'keluhan & masalah',
'お知らせ・漏水は、今週の金曜日までです。・補償が必要です。・手順書のときは、受付に言ってください。・誠意は、来週からです。',
'おしらせ・ろうすいは、こんしゅうの きんようびまでです。・ほしょうが ひつよう です。・てじゅんしょのときは、うけつけに いって ください。・せいいは、らいしゅうから です。',
'Pengumuman ・kebocoran air sampai Jumat pekan ini. ・kompensasi diperlukan. ・Kalau panduan prosedur, bilang ke resepsionis. ・itikad baik mulai pekan depan.',
'[{"tanya": "何が今週の金曜日までですか。", "pilihan": ["手順書", "補償", "漏水", "誠意"], "benar": 2}, {"tanya": "何が必要ですか。", "pilihan": ["手順書", "漏水", "補償", "誠意"], "benar": 2}, {"tanya": "手順書のときは、どうしますか。", "pilihan": ["受付に言います。", "家に帰ります。", "何もしません。", "電話をかけません。"], "benar": 0}, {"tanya": "誠意はいつからですか。", "pilihan": ["家に帰ります。", "来週からです。", "何もしません。", "電話をかけません。"], "benar": 1}]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 40, 'シフト・スタッフ', 'シフト・スタッフ', 'shift & rekan kerja',
'件名：連携のお知らせみなさん後輩は、明日の午後三時からです。申し送りを持ってきてください。質問がある人は、メールで連絡してください。',
'けんめい：れんけいの おしらせみなさんこうはいは、あしたの ごご さんじから です。もうしおくりを もってきて ください。しつもんが ある ひとは、メールで れんらくして ください。',
'Subjek: Pemberitahuan kerja sama tim Semua, junior besok mulai jam 3 sore. Mohon bawa serah terima tugas. Yang ada pertanyaan, hubungi lewat surel.',
'[{"tanya": "何についてのお知らせですか。", "pilihan": ["後輩", "連携", "勤務表", "申し送り"], "benar": 1}, {"tanya": "後輩はいつですか。", "pilihan": ["電話をかけません。", "明日の午後三時からです。", "家に帰ります。", "何もしません。"], "benar": 1}, {"tanya": "何を持ってきますか。", "pilihan": ["連携", "後輩", "勤務表", "申し送り"], "benar": 3}, {"tanya": "質問がある人はどうしますか。", "pilihan": ["家に帰ります。", "電話をかけません。", "メールで連絡します。", "何もしません。"], "benar": 2}]'::jsonb, 'email')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 41, '季節・行事', '季節・行事', 'musim & acara',
'旬について、よく聞かれます。わたしは花火が大切だと思います。でも、献立表も必要です。大雪を忘れないでください。',
'しゅんについて、よく聞かれます。わたしははなびが大切だと思います。でも、こんだてひょうも必要です。おおゆきを忘れないでください。',
'Tentang musim terbaik, sering ditanyakan. Saya rasa kembang api itu penting. Tetapi daftar menu juga perlu. Jangan lupa salju lebat.',
'[{"tanya": "何についてよく聞かれますか。", "pilihan": ["旬", "大雪", "花火", "献立表"], "benar": 0}, {"tanya": "筆者が大切だと思っているのはどれですか。", "pilihan": ["大雪", "旬", "献立表", "花火"], "benar": 3}, {"tanya": "何を忘れないでくださいと言っていますか。", "pilihan": ["旬", "大雪", "花火", "献立表"], "benar": 1}]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;

insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis) values
('n3', 42, '重要語③', '重要語③', 'kata penting ③',
'お知らせ・達成は、今週の金曜日までです。・工夫が必要です。・負担のときは、受付に言ってください。・自覚は、来週からです。',
'おしらせ・たっせいは、こんしゅうの きんようびまでです。・くふうが ひつよう です。・ふたんのときは、うけつけに いって ください。・じかくは、らいしゅうから です。',
'Pengumuman ・pencapaian sampai Jumat pekan ini. ・upaya kreatif diperlukan. ・Kalau beban, bilang ke resepsionis. ・kesadaran diri mulai pekan depan.',
'[{"tanya": "何が今週の金曜日までですか。", "pilihan": ["負担", "自覚", "工夫", "達成"], "benar": 3}, {"tanya": "何が必要ですか。", "pilihan": ["負担", "工夫", "自覚", "達成"], "benar": 1}, {"tanya": "負担のときは、どうしますか。", "pilihan": ["受付に言います。", "電話をかけません。", "何もしません。", "家に帰ります。"], "benar": 0}, {"tanya": "自覚はいつからですか。", "pilihan": ["来週からです。", "何もしません。", "家に帰ります。", "電話をかけません。"], "benar": 0}]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id, soal=excluded.soal, jenis=excluded.jenis;
