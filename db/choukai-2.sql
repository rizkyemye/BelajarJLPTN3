-- ============================================================================
-- CHOUKAI N3 — Hari 9–25
-- Urutan audio: ① pertanyaan → ② percakapan → ③ pertanyaan lagi (seperti JLPT)
-- Aman dijalankan berulang (on conflict update).
-- ============================================================================

-- HARI 9 · 課題理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 9, 'kd', 'テストの勉強', 'Belajar untuk ujian',
'女：あしたのテスト、もう勉強した？
男：まだです。きょうの夜、やります。
女：教科書だけじゃなくて、ノートも見たほうがいいよ。
男：そうですね。じゃあ、ノートも読みます。',
'女：あしたの テスト、もう べんきょう した？
男：まだです。きょうの よる、やります。
女：きょうかしょ だけじゃなくて、ノートも みた ほうが いいよ。
男：そうですね。じゃあ、ノートも よみます。',
'Perempuan: Ujian besok sudah belajar?
Pria: Belum. Nanti malam.
Perempuan: Bukan cuma buku teks, catatan juga sebaiknya dibaca.
Pria: Betul. Kalau begitu catatan juga saya baca.',
'[{"tanya":"男の人はこれから何をしますか。","pilihan":["きょうの夜、教科書とノートを勉強します。","今すぐ寝ます。","女の人にノートを貸します。","テストを受けません。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 10 · ポイント理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 10, 'pt', 'ハイキング', 'Hiking',
'男：あした、ハイキングに行きますか。
女：天気が心配です。午後から雨だそうです。
男：じゃあ、朝のうちに行きましょう。
女：そうですね。お昼には帰りましょう。',
'男：あした、ハイキングに いきますか。
女：てんきが しんぱいです。ごごから あめだ そうです。
男：じゃあ、あさの うちに いきましょう。
女：そうですね。おひるには かえりましょう。',
'Pria: Besok jadi hiking?
Perempuan: Saya khawatir cuaca. Katanya siang mulai hujan.
Pria: Kalau begitu kita pergi pagi-pagi.
Perempuan: Betul. Kita pulang sebelum siang.',
'[{"tanya":"二人はどうしますか。","pilihan":["朝のうちに行って、お昼に帰ります。","雨が降っても、夜までいます。","ハイキングをやめます。","午後から行きます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 11 · 課題理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 11, 'kd', 'けんか', 'Bertengkar',
'女：どうしたの？元気がないね。
男：きのう、友だちとけんかしてしまって。
女：ちゃんと話した？
男：いいえ。あとで電話してみます。',
'女：どうしたの？げんきが ないね。
男：きのう、ともだちと けんか してしまって。
女：ちゃんと はなした？
男：いいえ。あとで でんわして みます。',
'Perempuan: Kenapa? Kamu kelihatan tidak bersemangat.
Pria: Kemarin saya bertengkar dengan teman.
Perempuan: Sudah bicara baik-baik?
Pria: Belum. Nanti saya coba telepon.',
'[{"tanya":"男の人はこれから何をしますか。","pilihan":["友だちに電話します。","友だちを無視します。","女の人と出かけます。","すぐに寝ます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 12 · ポイント理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 12, 'pt', '会議の時間', 'Jam rapat',
'男：会議は何時からですか。
女：三時からです。でも、資料がまだできていません。
男：じゃあ、二時半に集まりましょう。
女：わかりました。',
'男：かいぎは なんじから ですか。
女：さんじから です。でも、しりょうが まだ できて いません。
男：じゃあ、にじはんに あつまりましょう。
女：わかりました。',
'Pria: Rapat mulai jam berapa?
Perempuan: Jam tiga. Tapi materinya belum selesai.
Pria: Kalau begitu kita kumpul jam setengah tiga.
Perempuan: Baik.',
'[{"tanya":"二人は何時に集まりますか。","pilihan":["二時半","三時","二時","三時半"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 13 · 発話表現
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 13, 'hw', 'コピー機', 'Mesin fotokopi',
'ナレーション：コピー機が動かなくて、困っています。受付の人に何と言いますか。
女：すみません、コピー機が動かないんですが、見てもらえますか。',
'ナレーション：コピーきが うごかなくて、こまって います。うけつけの ひとに なんと いいますか。
女：すみません、コピーきが うごかないんですが、みて もらえますか。',
'Narasi: Mesin fotokopi tidak mau jalan dan kamu bingung. Apa yang kamu katakan ke resepsionis?
Perempuan: Permisi, mesin fotokopinya tidak jalan, bisa dicek?',
'[{"tanya":"このとき、何と言いますか。","pilihan":["すみません、コピー機が動かないんですが、見てもらえますか。","すみません、コピー機を買ってもいいですか。","すみません、ここは何時までですか。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 14 · 課題理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 14, 'kd', 'テニス', 'Tenis',
'男：週末、何をしますか。
女：テニスをします。一緒にどうですか。
男：いいですね。でも、ラケットがありません。
女：じゃあ、貸してあげますよ。',
'男：しゅうまつ、なにを しますか。
女：テニスを します。いっしょに どうですか。
男：いいですね。でも、ラケットが ありません。
女：じゃあ、かして あげますよ。',
'Pria: Akhir pekan ngapain?
Perempuan: Main tenis. Ikut?
Pria: Boleh. Tapi saya tidak punya raket.
Perempuan: Nanti saya pinjamkan.',
'[{"tanya":"女の人は男の人に何をしますか。","pilihan":["ラケットを貸します。","テニスをやめます。","ラケットを買います。","一人で行きます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 15 · ポイント理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 15, 'pt', 'ホテル', 'Hotel',
'女：このホテル、駅から近いですか。
男：はい、歩いて五分です。でも、部屋は少し狭いです。
女：安いですから、いいですよ。',
'女：この ホテル、えきから ちかい ですか。
男：はい、あるいて ごふんです。でも、へやは すこし せまいです。
女：やすいですから、いいですよ。',
'Perempuan: Hotel ini dekat stasiun?
Pria: Ya, jalan kaki lima menit. Tapi kamarnya agak sempit.
Perempuan: Karena murah, tidak apa-apa.',
'[{"tanya":"女の人はなぜこのホテルにしますか。","pilihan":["安いから。","駅から遠いから。","部屋が広いから。","新しくてきれいだから。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 16 · 課題理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 16, 'kd', '銀行と郵便局', 'Bank dan kantor pos',
'男：すみません、銀行はどこですか。
女：この道をまっすぐ行くと、右にあります。
男：ありがとうございます。あと、郵便局は？
女：銀行のとなりです。',
'男：すみません、ぎんこうは どこですか。
女：この みちを まっすぐ いくと、みぎに あります。
男：ありがとうございます。あと、ゆうびんきょくは？
女：ぎんこうの となりです。',
'Pria: Permisi, bank di mana?
Perempuan: Lurus di jalan ini, ada di kanan.
Pria: Terima kasih. Kalau kantor pos?
Perempuan: Di sebelah bank.',
'[{"tanya":"郵便局はどこにありますか。","pilihan":["銀行のとなり","銀行の向かい","駅の前","この道の左"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 17 · 課題理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 17, 'kd', '荷物', 'Barang bawaan',
'女：この荷物、重いですね。手伝いましょうか。
男：ありがとうございます。じゃあ、上の階まで運んでください。
女：わかりました。',
'女：この にもつ、おもいですね。てつだいましょうか。
男：ありがとうございます。じゃあ、うえの かいまで はこんで ください。
女：わかりました。',
'Perempuan: Barang ini berat ya. Saya bantu?
Pria: Terima kasih. Kalau begitu tolong bawa sampai lantai atas.
Perempuan: Baik.',
'[{"tanya":"女の人は何をしますか。","pilihan":["荷物を上の階まで運びます。","荷物を下の階に置きます。","男の人を待ちます。","エレベーターを直します。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 18 · ポイント理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 18, 'pt', '連絡', 'Menghubungi',
'男：田中さんに伝えましたか。
女：はい。でも、まだ返事がありません。
男：じゃあ、もう一度連絡してみてください。',
'男：たなかさんに つたえましたか。
女：はい。でも、まだ へんじが ありません。
男：じゃあ、もう いちど れんらくして みて ください。',
'Pria: Sudah disampaikan ke Tanaka-san?
Perempuan: Sudah. Tapi belum ada balasan.
Pria: Kalau begitu coba hubungi sekali lagi.',
'[{"tanya":"女の人はこれから何をしますか。","pilihan":["田中さんにもう一度連絡します。","田中さんを待ちます。","男の人に返事を書きます。","会議をやめます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 19 · 課題理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 19, 'kd', '引っ越し', 'Pindahan',
'女：引っ越しはいつですか。
男：来月の五日です。荷物が多くて大変です。
女：友だちに手伝ってもらったらどうですか。
男：そうします。',
'女：ひっこしは いつですか。
男：らいげつの いつかです。にもつが おおくて たいへんです。
女：ともだちに てつだって もらったら どうですか。
男：そうします。',
'Perempuan: Pindahan kapan?
Pria: Tanggal lima bulan depan. Barangnya banyak, repot.
Perempuan: Bagaimana kalau minta bantuan teman?
Pria: Baiklah begitu.',
'[{"tanya":"男の人はどうしますか。","pilihan":["友だちに手伝ってもらいます。","引っ越しをやめます。","一人で運びます。","来月まで待ちます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 20 · ポイント理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 20, 'pt', 'ラーメン', 'Ramen',
'男：この店のラーメンはどうですか。
女：とてもおいしいですよ。でも、少し高いです。
男：じゃあ、安い店に行きましょう。',
'男：この みせの ラーメンは どうですか。
女：とても おいしいですよ。でも、すこし たかいです。
男：じゃあ、やすい みせに いきましょう。',
'Pria: Ramen di toko ini bagaimana?
Perempuan: Sangat enak. Tapi agak mahal.
Pria: Kalau begitu kita ke toko yang murah.',
'[{"tanya":"男の人はなぜ別の店に行きますか。","pilihan":["この店は少し高いから。","この店はまずいから。","この店は遠いから。","この店は休みだから。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 21 · ポイント理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 21, 'pt', '新しい課長', 'Kepala seksi baru',
'女：新しい課長はどうですか。
男：とても親切で、説明が上手です。
女：いいですね。前の課長は少し厳しかったですから。',
'女：あたらしい かちょうは どうですか。
男：とても しんせつで、せつめいが じょうずです。
女：いいですね。まえの かちょうは すこし きびしかったですから。',
'Perempuan: Kepala seksi baru bagaimana?
Pria: Sangat baik dan pandai menjelaskan.
Perempuan: Bagus ya. Kepala sebelumnya agak keras.',
'[{"tanya":"男の人は新しい課長についてどう言っていますか。","pilihan":["親切で、説明が上手だ。","厳しくて、説明が少ない。","よく休む。","仕事が遅い。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 22 · 即時応答
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 22, 'sk', 'なかなか', 'Susah sekali',
'女：この問題、すぐに分かりましたか。',
'女：この もんだい、すぐに わかりましたか。',
'Perempuan: Soal ini langsung paham?',
'[{"tanya":"このとき、男の人は何と言いますか。","pilihan":["いいえ、なかなか分かりませんでした。","いいえ、問題ではありません。","はい、すぐに帰ります。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 23 · 課題理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 23, 'kd', '雨と試合', 'Hujan dan pertandingan',
'男：雨が降っていますね。
女：だから、試合は中止かもしれません。
男：じゃあ、家で休みましょう。',
'男：あめが ふって いますね。
女：だから、しあいは ちゅうし かもしれません。
男：じゃあ、いえで やすみましょう。',
'Pria: Hujan ya.
Perempuan: Makanya pertandingan mungkin dibatalkan.
Pria: Kalau begitu kita istirahat di rumah.',
'[{"tanya":"二人はどうしますか。","pilihan":["家で休みます。","試合に出ます。","傘を買いに行きます。","会社へ行きます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 24 · 即時応答
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 24, 'sk', '部屋が汚い', 'Kamar kotor',
'女：この部屋、どうしたの？とても汚れているね。',
'女：この へや、どうしたの？とても よごれて いるね。',
'Perempuan: Kamar ini kenapa? Sangat kotor.',
'[{"tanya":"このとき、男の人は何と言いますか。","pilihan":["ごめん、すぐに片づけるよ。","はい、とてもきれいだよ。","いいえ、部屋じゃないよ。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 25 · 課題理解
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 25, 'kd', '書類の提出', 'Menyerahkan dokumen',
'女：この書類、いつまでに出せばいいですか。
男：金曜日までにお願いします。
女：わかりました。あと、コピーも必要ですか。
男：いいえ、大丈夫です。',
'女：この しょるい、いつまでに だせば いいですか。
男：きんようびまでに おねがいします。
女：わかりました。あと、コピーも ひつよう ですか。
男：いいえ、だいじょうぶです。',
'Perempuan: Dokumen ini paling lambat kapan?
Pria: Mohon sampai hari Jumat.
Perempuan: Baik. Perlu fotokopi juga?
Pria: Tidak, tidak perlu.',
'[{"tanya":"女の人は何をしなければなりませんか。","pilihan":["金曜日までに書類を出します。","書類をコピーします。","月曜日までに電話します。","書類を捨てます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;
