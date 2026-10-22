-- ============================================================================
-- CHOUKAI N3 — versi "ひっかけ" (jebakan) untuk 6 soal
-- Tujuannya bikin lebih bingung seperti JLPT asli:
--   · pembicara ganti pikiran (「あ、でも…」)
--   · dua angka disebut (satu jebakan)
--   · rencana awal dibatalkan
-- Menimpa hari 1, 3, 6, 12, 32, 40 (on conflict update).
-- ============================================================================

-- HARI 1 · 課題理解 (jebakan: "kirim ke manajer" vs "fotokopi dulu")
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 1, 'kd', '資料とコピー', 'Dokumen dan fotokopi',
'女：あしたの会議の資料、もう準備できた？
男：まだです。今、確認しています。五分ぐらいかかります。
女：じゃあ、できたら、部長に送ってください。
男：あ、それより先に、コピーを十部お願いします。会議で使いますから。
女：わかりました。',
'女：あしたの かいぎの しりょう、もう じゅんび できた？
男：まだです。いま、かくにん しています。ごふんぐらい かかります。
女：じゃあ、できたら、ぶちょうに おくって ください。
男：あ、それより さきに、コピーを じゅうぶ おねがいします。かいぎで つかいますから。
女：わかりました。',
'Perempuan: Materi rapat besok sudah siap?
Pria: Belum. Sekarang saya periksa, butuh sekitar lima menit.
Perempuan: Kalau selesai, kirim dulu ke manajer.
Pria: Eh, sebelum itu, tolong fotokopi sepuluh lembar. Karena dipakai di rapat.
Perempuan: Baik.',
'[{"tanya":"男の人は、女の人にまず何をしてほしいと言いましたか。","pilihan":["資料を十部コピーしてほしい。","資料を部長に送ってほしい。","会議を休んでほしい。","資料を確認してほしい。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 3 · 課題理解 (jebakan: 3 kali vs 2 kali)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 3, 'kd', '薬の回数', 'Berapa kali minum obat',
'医者：のどが痛いんですね。熱は？
男：三十七度五分です。
医者：今日は仕事を休んで、水をたくさん飲んでください。薬は一日三回、食事のあとです。
男：あの、夜も飲みますか。
医者：夜は飲まなくてもいいです。二回でいいですよ。',
'医者：のどが いたいんですね。ねつは？
男：さんじゅうななど ごぶです。
医者：きょうは しごとを やすんで、みずを たくさん のんで ください。くすりは いちにち さんかい、しょくじの あとです。
男：あの、よるも のみますか。
医者：よるは のまなくても いいです。にかいで いいですよ。',
'Dokter: Tenggorokan sakit ya. Panasnya?
Pria: 37,5.
Dokter: Hari ini istirahat kerja, minum air banyak. Obat tiga kali sehari, sesudah makan.
Pria: Malam juga diminum?
Dokter: Malam tidak perlu. Dua kali saja cukup.',
'[{"tanya":"男の人は、薬を一日何回飲みますか。","pilihan":["二回","三回","一回","四回"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 6 · 課題理解 (jebakan: jalan kaki vs naik bus)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 6, 'kd', '駅までの行き方', 'Cara ke stasiun',
'女：すみません、駅までどう行けばいいですか。
男：この道をまっすぐ行って、二つ目の信号を右に曲がってください。
女：二つ目ですね。あ、でも、バスのほうが速いですか。
男：そうですね。三番のバスなら、五分で着きますよ。
女：じゃあ、バスで行きます。',
'女：すみません、えきまで どう いけば いいですか。
男：この みちを まっすぐ いって、ふたつめの しんごうを みぎに まがって ください。
女：ふたつめですね。あ、でも、バスの ほうが はやいですか。
男：そうですね。さんばんの バスなら、ごふんで つきますよ。
女：じゃあ、バスで いきます。',
'Perempuan: Permisi, ke stasiun bagaimana?
Pria: Lurus, di lampu merah kedua belok kanan.
Perempuan: Lampu kedua ya. Eh, tapi bus lebih cepat?
Pria: Betul. Kalau bus nomor tiga, sampai dalam lima menit.
Perempuan: Kalau begitu saya naik bus.',
'[{"tanya":"女の人は、駅までどうやって行きますか。","pilihan":["三番のバスで行きます。","歩いて行きます。","タクシーで行きます。","電車で行きます。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 12 · ポイント理解 (jebakan: dua kali ganti jam)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 12, 'pt', '集まる時間', 'Jam berkumpul',
'男：会議は何時からですか。
女：三時からです。でも、資料がまだできていません。
男：じゃあ、二時半に集まりましょう。
女：すみません、二時半は無理です。二時五十分なら大丈夫です。
男：わかりました。じゃあ、二時五十分にしましょう。',
'男：かいぎは なんじから ですか。
女：さんじから です。でも、しりょうが まだ できて いません。
男：じゃあ、にじはんに あつまりましょう。
女：すみません、にじはんは むりです。にじごじゅっぷんなら だいじょうぶです。
男：わかりました。じゃあ、にじごじゅっぷんに しましょう。',
'Pria: Rapat mulai jam berapa?
Perempuan: Jam tiga. Tapi materinya belum selesai.
Pria: Kalau begitu kumpul jam setengah tiga.
Perempuan: Maaf, setengah tiga tidak bisa. Kalau 2.50 bisa.
Pria: Baik, kita kumpul jam 2.50.',
'[{"tanya":"二人は何時に集まりますか。","pilihan":["二時五十分","二時半","三時","三時十分"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 32 · 課題理解 (jebakan: reservasi ternyata besok)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 32, 'kd', '予約の日', 'Tanggal reservasi',
'女：チェックインをお願いします。
男：お名前は？
女：田中です。
男：田中様でございますね。…申し訳ございません。ご予約はあしたからになっております。
女：えっ。では、今夜は空いていますか。
男：はい、一部屋だけ空いております。',
'女：チェックインを おねがいします。
男：おなまえは？
女：たなかです。
男：たなかさま でございますね。…もうしわけ ございません。ごよやくは あしたからに なって おります。
女：えっ。では、こんやは あいて いますか。
男：はい、ひとへやだけ あいて おります。',
'Perempuan: Saya mau check-in.
Pria: Namanya?
Perempuan: Tanaka.
Pria: Tanaka-sama ya. … Maaf, reservasi Anda mulai besok.
Perempuan: Eh. Kalau begitu malam ini ada kamar kosong?
Pria: Ada, tinggal satu kamar.',
'[{"tanya":"女の人は今夜、どうしますか。","pilihan":["このホテルに一泊します。","予約をキャンセルします。","別のホテルを探します。","家に帰ります。"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;

-- HARI 40 · 課題理解 (jebakan: 7:30 → 7:45)
insert into public.choukai (level, hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal) values
('n3', 40, 'kd', '何時に来る', 'Jam berapa datang',
'男：あしたのシフト、何時からですか。
女：八時からです。でも、七時半に来てください。
男：七時半ですね。
女：あ、ごめんなさい。あしたは七時四十五分でも大丈夫です。
男：じゃあ、七時四十五分に行きます。',
'男：あしたの シフト、なんじから ですか。
女：はちじから です。でも、しちじはんに きて ください。
男：しちじはん ですね。
女：あ、ごめんなさい。あしたは しちじ よんじゅうごふんでも だいじょうぶです。
男：じゃあ、しちじ よんじゅうごふんに いきます。',
'Pria: Shift besok dari jam berapa?
Perempuan: Dari jam delapan. Tapi datang jam 7.30.
Pria: 7.30 ya.
Perempuan: Ah maaf, besok 7.45 juga tidak apa-apa.
Pria: Kalau begitu saya datang 7.45.',
'[{"tanya":"男の人は何時に来ますか。","pilihan":["七時四十五分","七時半","八時","八時十五分"],"benar":0}]'::jsonb)
on conflict (level, hari_ke) do update set jenis=excluded.jenis, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id, skrip_jp=excluded.skrip_jp, skrip_furi=excluded.skrip_furi, teks_id=excluded.teks_id, soal=excluded.soal;
