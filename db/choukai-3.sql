-- ============================================================================
-- CHOUKAI N3 — Hari 26–42
-- ============================================================================

-- HARI 26 · ポイント理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 26, 'pt', '町の変化', 'Perubahan kota',
'男：この町も変わりましたね。
女：ええ。前は小さな店が多かったですが、今はビルが増えました。
男：少し寂しいですね。',
'男：この まちも かわりましたね。
女：ええ。まえは ちいさな みせが おおかったですが、いまは ビルが ふえました。
男：すこし さびしいですね。',
'Pria: Kota ini juga berubah ya.
Perempuan: Iya. Dulu banyak toko kecil, sekarang gedung bertambah.
Pria: Agak sepi rasanya.',
'[{"tanya":"女の人は町がどう変わったと言っていますか。","pilihan":["小さな店が減って、ビルが増えた。","店が全部なくなった。","人が少なくなった。","何も変わっていない。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 27 · 課題理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 27, 'kd', 'お祭り', 'Festival',
'女：週末のお祭り、行きますか。
男：行きたいですが、人でいっぱいでしょう。
女：じゃあ、朝早く行きましょう。
男：そうしましょう。',
'女：しゅうまつの おまつり、いきますか。
男：いきたいですが、ひとで いっぱいでしょう。
女：じゃあ、あさ はやく いきましょう。
男：そうしましょう。',
'Perempuan: Festival akhir pekan, ikut?
Pria: Mau, tapi pasti penuh orang.
Perempuan: Kalau begitu kita pergi pagi-pagi.
Pria: Ayo begitu.',
'[{"tanya":"二人はどうしますか。","pilihan":["朝早くお祭りに行きます。","お祭りに行きません。","夜にお祭りへ行きます。","一日中待ちます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 28 · ポイント理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 28, 'pt', 'メールの返事', 'Balasan surel',
'男：山本さんからメールが来ましたか。
女：いいえ、まだです。三日も待っています。
男：じゃあ、電話で聞いてみましょう。',
'男：やまもとさんから メールが きましたか。
女：いいえ、まだです。みっかも まって います。
男：じゃあ、でんわで きいて みましょう。',
'Pria: Sudah ada surel dari Yamamoto-san?
Perempuan: Belum. Sudah tiga hari saya menunggu.
Pria: Kalau begitu kita tanya lewat telepon.',
'[{"tanya":"二人はこれからどうしますか。","pilihan":["山本さんに電話します。","メールをもう一度書きます。","あと三日待ちます。","山本さんに会いに行きます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 29 · ポイント理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 29, 'pt', '人数と料理', 'Jumlah orang dan makanan',
'女：パーティーは何人ぐらい来ますか。
男：十人ぐらいだと思います。
女：じゃあ、料理は十五人分作りましょうか。
男：そうですね。少し多いほうがいいです。',
'女：パーティーは なんにんぐらい きますか。
男：じゅうにんぐらいだと おもいます。
女：じゃあ、りょうりは じゅうごにんぶん つくりましょうか。
男：そうですね。すこし おおい ほうが いいです。',
'Perempuan: Pesta datang berapa orang? Pria: Kira-kira sepuluh. Perempuan: Kalau begitu masak untuk lima belas porsi?',
'[{"tanya":"料理は何人分作りますか。","pilihan":["十人分","十五人分","五人分","二十人分"],"benar":1}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 30 · 課題理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 30, 'kd', '復習', 'Mengulang',
'男：来週、テストがありますね。
女：はい。苦手なところが多いです。
男：じゃあ、いっしょに復習しませんか。
女：ぜひお願いします。',
'男：らいしゅう、テストが ありますね。
女：はい。にがてな ところが おおいです。
男：じゃあ、いっしょに ふくしゅう しませんか。
女：ぜひ おねがいします。',
'Pria: Pekan depan ada ujian ya.
Perempuan: Iya. Banyak bagian yang saya lemah.
Pria: Mau mengulang bersama?
Perempuan: Boleh, tolong.',
'[{"tanya":"女の人はこれから何をしますか。","pilihan":["男の人といっしょに復習します。","テストを受けません。","一人で勉強します。","先生に手紙を書きます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 31 · 即時応答
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 31, 'sk', '忙しい', 'Sibuk',
'女：今、ちょっと手伝ってもらえますか。',
'女：いま、ちょっと てつだって もらえますか。',
'Perempuan: Bisa bantu sedikit sekarang?',
'[{"tanya":"このとき、男の人は何と言いますか。","pilihan":["はい、何をすればいいですか。","いいえ、私は忙しくありません。","はい、もう帰ります。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 32 · 課題理解 (hotel)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 32, 'kd', 'チェックイン', 'Check-in',
'女：チェックインをお願いします。
男：かしこまりました。お名前は？
女：田中です。予約してあります。
男：少々お待ちください。',
'女：チェックインを おねがいします。
男：かしこまりました。おなまえは？
女：たなかです。よやくして あります。
男：しょうしょう おまち ください。',
'Perempuan: Saya mau check-in.
Pria: Baik. Namanya?
Perempuan: Tanaka. Sudah ada reservasi.
Pria: Mohon tunggu sebentar.',
'[{"tanya":"女の人はこれからどうしますか。","pilihan":["少し待ちます。","部屋を掃除します。","予約をします。","帰ります。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 33 · 発話表現
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 33, 'hw', '部屋の鍵', 'Kunci kamar',
'ナレーション：お客様が部屋の鍵をなくしてしまいました。何と言いますか。
女：鍵をなくされたんですね。すぐに新しい鍵をお持ちしますので、少々お待ちください。',
'ナレーション：おきゃくさまが へやの かぎを なくして しまいました。なんと いいますか。
女：かぎを なくされたんですね。すぐに あたらしい かぎを おもちしますので、しょうしょう おまち ください。',
'Narasi: Tamu kehilangan kunci kamar. Apa yang kamu katakan?
Perempuan: Kuncinya hilang ya. Saya akan segera bawa kunci baru, mohon tunggu sebentar.',
'[{"tanya":"このとき、何と言いますか。","pilihan":["新しい鍵をお持ちしますので、少々お待ちください。","鍵はありませんので、帰ってください。","自分で探してください。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 34 · 課題理解 (kitchen)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 34, 'kd', '厨房', 'Dapur',
'男：スープの味はどうですか。
女：少し薄いと思います。
男：じゃあ、もう少し塩を入れましょう。
女：はい、そうします。',
'男：スープの あじは どうですか。
女：すこし うすいと おもいます。
男：じゃあ、もう すこし しおを いれましょう。
女：はい、そうします。',
'Pria: Rasanya sup bagaimana?
Perempuan: Menurut saya agak hambar.
Pria: Kalau begitu tambahkan garam sedikit.
Perempuan: Baik.',
'[{"tanya":"女の人はこれから何をしますか。","pilihan":["スープに塩を入れます。","スープを捨てます。","新しい料理を作ります。","味を変えません。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 35 · ポイント理解 (hall)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 35, 'pt', '席の案内', 'Mengantar ke meja',
'女：窓側の席と、奥の席、どちらがよろしいですか。
男：静かなほうがいいです。
女：では、奥のお席へご案内します。',
'女：まどぎわの せきと、おくの せき、どちらが よろしいですか。
男：しずかな ほうが いいです。
女：では、おくの おせきへ ごあんない します。',
'Perempuan: Dekat jendela atau di dalam, mana yang Anda inginkan?
Pria: Yang lebih tenang.
Perempuan: Kalau begitu saya antar ke meja bagian dalam.',
'[{"tanya":"男の人はどんな席を選びましたか。","pilihan":["静かな奥の席","窓側の席","入口の席","テラスの席"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 36 · 発話表現 (phone)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 36, 'hw', '電話', 'Telepon',
'ナレーション：電話で、相手の名前がよく聞こえませんでした。何と言いますか。
女：恐れ入ります。お名前をもう一度お願いできますか。',
'ナレーション：でんわで、あいての なまえが よく きこえませんでした。なんと いいますか。
女：おそれいります。おなまえを もう いちど おねがい できますか。',
'Narasi: Di telepon, nama lawan bicara tidak terdengar jelas. Apa yang kamu katakan?
Perempuan: Maaf, boleh ulangi nama Anda sekali lagi?',
'[{"tanya":"このとき、何と言いますか。","pilihan":["お名前をもう一度お願いできますか。","お名前は要りません。","電話を切ってもいいですか。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 37 · 課題理解 (reservation)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 37, 'kd', '予約', 'Reservasi',
'女：今夜、二人で予約できますか。
男：申し訳ありません。今夜は満室です。
女：じゃあ、あしたは？
男：あしたは大丈夫です。',
'女：こんや、ふたりで よやく できますか。
男：もうしわけ ありません。こんやは まんしつです。
女：じゃあ、あしたは？
男：あしたは だいじょうぶです。',
'Perempuan: Malam ini bisa reservasi untuk dua orang?
Pria: Maaf, malam ini penuh.
Perempuan: Kalau besok?
Pria: Besok bisa.',
'[{"tanya":"二人はいつ予約しますか。","pilihan":["あした","今夜","来週","予約しません"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 38 · ポイント理解 (kasir)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 38, 'pt', 'お会計', 'Pembayaran',
'女：お会計はご一緒ですか、別々ですか。
男：別々でお願いします。
女：かしこまりました。',
'女：おかいけいは ごいっしょ ですか、べつべつ ですか。
男：べつべつで おねがいします。
女：かしこまりました。',
'Perempuan: Pembayarannya jadi satu atau terpisah?
Pria: Terpisah.
Perempuan: Baik.',
'[{"tanya":"男の人はどう払いますか。","pilihan":["別々に払う","一緒に払う","カードで払わない","払わない"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 39 · 即時応答 (complaint)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 39, 'sk', '苦情', 'Keluhan',
'女：すみません、この料理、少し冷めているんですが。',
'女：すみません、この りょうり、すこし さめているんですが。',
'Perempuan: Permisi, makanan ini agak dingin.',
'[{"tanya":"このとき、店の人は何と言いますか。","pilihan":["申し訳ございません。すぐに温め直します。","いいえ、料理ではありません。","お会計はあちらです。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 40 · 課題理解 (shift)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 40, 'kd', 'シフト', 'Shift',
'男：あしたのシフト、何時からですか。
女：八時からです。でも、七時半に来てください。
男：わかりました。制服は？
女：いつもの制服で大丈夫です。',
'男：あしたの シフト、なんじから ですか。
女：はちじから です。でも、しちじはんに きて ください。
男：わかりました。せいふくは？
女：いつもの せいふくで だいじょうぶです。',
'Pria: Shift besok mulai jam berapa?
Perempuan: Jam delapan. Tapi datang jam setengah delapan.
Pria: Baik. Seragamnya?
Perempuan: Seragam seperti biasa.',
'[{"tanya":"男の人は何時に来なければなりませんか。","pilihan":["七時半","八時","八時半","七時"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 41 · ポイント理解 (season)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 41, 'pt', '冬の準備', 'Persiapan musim dingin',
'女：もう冬の準備をしましたか。
男：いいえ。まだ雪が降っていませんから。
女：でも、来週から寒くなるそうですよ。
男：じゃあ、今週、タイヤを替えます。',
'女：もう ふゆの じゅんびを しましたか。
男：いいえ。まだ ゆきが ふって いませんから。
女：でも、らいしゅうから さむく なる そうですよ。
男：じゃあ、こんしゅう、タイヤを かえます。',
'Perempuan: Sudah siap-siap musim dingin?
Pria: Belum. Kan belum turun salju.
Perempuan: Tapi katanya mulai pekan depan dingin.
Pria: Kalau begitu pekan ini saya ganti ban.',
'[{"tanya":"男の人はなぜ今週タイヤを替えるのか。","pilihan":["来週から寒くなるそうだから。","雪が降っているから。","車を買ったから。","旅行に行くから。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 42 · 即時応答
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 42, 'sk', 'お礼', 'Ucapan terima kasih',
'女：先日は、本当にありがとうございました。',
'女：せんじつは、ほんとうに ありがとう ございました。',
'Perempuan: Kemarin benar-benar terima kasih banyak.',
'[{"tanya":"このとき、男の人は何と言いますか。","pilihan":["いいえ、どういたしまして。","はい、先日ではありません。","いいえ、ありがとうございます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;
