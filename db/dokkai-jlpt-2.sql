-- ============================================================================
-- DOKKAI gaya JLPT — Hari 4–13
-- jenis: setsumei (短文) · email (メール) · oshirase (お知らせ)
-- Aman dijalankan berulang (on conflict update).
-- ============================================================================

-- ============================================================================
-- HARI 4 · setsumei — 食べ物・味
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
 'n3', 4, '食べ物・味', '冷凍して節約', 'Bekukan untuk hemat',
'最近、家で料理をする人が増えている。外で食べると高いからだ。しかし、料理は時間がかかる。忙しい人は、三日分をまとめて作って冷凍しておくと、時間もお金も節約できる。',
'さいきん、いえで りょうりを する ひとが ふえている。そとで たべると たかいからだ。しかし、りょうりは じかんが かかる。いそがしい ひとは、みっかぶんを まとめて つくって れいとうして おくと、じかんも おかねも せつやく できる。',
'Belakangan makin banyak orang memasak di rumah. Karena makan di luar mahal. Tapi memasak butuh waktu. Orang sibuk bisa memasak untuk tiga hari sekaligus lalu dibekukan; waktu dan uang jadi hemat.',
'[
 {"tanya":"なぜ家で料理をする人が増えているか。",
  "pilihan":["外で食べると高いから。","料理が簡単になったから。","冷凍が便利になったから。","家にいる時間が長いから。"],"benar":0},
 {"tanya":"忙しい人に、筆者がすすめている方法はどれか。",
  "pilihan":["毎日少しずつ料理をする。","三日分をまとめて作って冷凍する。","外で食べる回数を増やす。","料理を買って帰る。"],"benar":1}
]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set
 tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id,
 teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id,
 soal=excluded.soal, jenis=excluded.jenis;

-- ============================================================================
-- HARI 5 · oshirase — 買い物・お金
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
 'n3', 5, '買い物・お金', 'スーパーのセール', 'Diskon supermarket',
'スーパーからのお知らせ
・セールは今月20日までです。
・野菜と果物は20％引きです。
・お一人様3点までです。
・会員カードをお持ちの方は、さらに5％引きになります。',
'スーパーからの おしらせ
・セールは こんげつ はつかまでです。
・やさいと くだものは にじゅっパーセントびきです。
・おひとりさま さんてんまでです。
・かいいんカードを おもちの かたは、さらに ごパーセントびきに なります。',
'Pengumuman supermarket
・Diskon sampai tanggal 20 bulan ini.
・Sayur dan buah potongan 20%.
・Maksimal 3 item per orang.
・Yang punya kartu anggota dapat potongan tambahan 5%.',
'[
 {"tanya":"セールはいつまでか。",
  "pilihan":["今月の20日まで。","今週の金曜日まで。","来月の5日まで。","今日の夜まで。"],"benar":0},
 {"tanya":"会員カードを持っている人はどうなるか。",
  "pilihan":["20％引きになる。","さらに5％引きになる。","3点までしか買えない。","野菜だけ買える。"],"benar":1},
 {"tanya":"野菜は何点まで買えるか。",
  "pilihan":["1点まで。","3点まで。","5点まで。","決まっていない。"],"benar":1}
]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set
 tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id,
 teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id,
 soal=excluded.soal, jenis=excluded.jenis;

-- ============================================================================
-- HARI 6 · oshirase — 交通・道
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
 'n3', 6, '交通・道', 'バスの時刻表', 'Jadwal bus',
'バスの時刻表
・このバスは駅前から病院まで行きます。
・朝は15分おき、昼は30分おきに来ます。
・土曜日と日曜日は本数が少ないです。
・切符は車内で買ってください。',
'バスの じこくひょう
・この バスは えきまえから びょういんまで いきます。
・あさは じゅうごふんおき、ひるは さんじゅっぷんおきに きます。
・どようびと にちようびは ほんすうが すくないです。
・きっぷは しゃないで かって ください。',
'Jadwal bus
・Bus ini dari depan stasiun sampai rumah sakit.
・Pagi tiap 15 menit, siang tiap 30 menit.
・Sabtu dan Minggu jumlahnya sedikit.
・Belilah tiket di dalam bus.',
'[
 {"tanya":"昼間は、どのくらいおきにバスが来るか。",
  "pilihan":["15分おき。","30分おき。","1時間おき。","決まっていない。"],"benar":1},
 {"tanya":"切符はどこで買うか。",
  "pilihan":["駅前の窓口で買う。","車内で買う。","病院で買う。","買わなくてもいい。"],"benar":1}
]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set
 tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id,
 teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id,
 soal=excluded.soal, jenis=excluded.jenis;

-- ============================================================================
-- HARI 7 · email — 住まい・部屋
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
 'n3', 7, '住まい・部屋', '水道工事のお知らせ', 'Pemberitahuan perbaikan air',
'件名：水道工事のお知らせ
住民のみなさん
12月3日の午前9時から午後3時まで、水道の工事があります。この間、水が使えません。前の日に、水をペットボトルなどに用意しておいてください。工事が終わったら、少し水を出してから使ってください。',
'けんめい：すいどうこうじの おしらせ
じゅうみんの みなさん
じゅうにがつ みっか（すいようび）の ごぜん くじから ごご さんじまで、すいどうの こうじが あります。この あいだ、みずが つかえません。まえのひに、みずを ペットボトルなどに よういして おいて ください。こうじが おわったら、すこし みずを だしてから つかって ください。',
'Subjek: Pemberitahuan perbaikan pipa air
Warga sekalian,
Tanggal 3 Desember dari jam 9 pagi sampai 3 sore akan ada perbaikan pipa air. Selama itu air tidak bisa dipakai. Mohon siapkan air di botol pada hari sebelumnya. Setelah perbaikan selesai, buang sedikit air dulu sebelum dipakai.',
'[
 {"tanya":"水が使えないのはいつか。",
  "pilihan":["12月3日の午前9時から午後3時まで。","12月3日の朝だけ。","今週中ずっと。","工事が終わったあと。"],"benar":0},
 {"tanya":"前の日に何をしておかなければならないか。",
  "pilihan":["水を用意しておく。","工事の人に電話する。","部屋を掃除する。","水を全部捨てる。"],"benar":0},
 {"tanya":"工事が終わったあと、どうするか。",
  "pilihan":["すぐに水を飲む。","少し水を出してから使う。","水を使わない。","受付に連絡する。"],"benar":1}
]'::jsonb, 'email')
on conflict (level, hari_ke) do update set
 tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id,
 teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id,
 soal=excluded.soal, jenis=excluded.jenis;

-- ============================================================================
-- HARI 8 · email — 仕事・会社
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
 'n3', 8, '仕事・会社', '会議の時間変更', 'Perubahan jam rapat',
'件名：会議の時間変更
田中さん
明日の会議は、10時から11時に変更になりました。会議室は同じです。資料は今日中に送ってください。もし間に合わないときは、私に知らせてください。
山田',
'けんめい：かいぎの じかん へんこう
たなかさん
あしたの かいぎは、じゅうじから じゅういちじに へんこうに なりました。かいぎしつは おなじです。しりょうは きょうじゅうに おくって ください。もし まにあわない ときは、わたしに しらせて ください。
やまだ',
'Subjek: Perubahan jam rapat
Tanaka-san,
Rapat besok diubah menjadi jam 10 sampai 11. Ruangannya sama. Mohon kirim materi hari ini. Kalau tidak bisa selesai, kabari saya.
Yamada',
'[
 {"tanya":"会議は何時から何時までになったか。",
  "pilihan":["10時から11時まで。","9時から10時まで。","11時から12時まで。","時間は変わっていない。"],"benar":0},
 {"tanya":"資料はいつまでに送らなければならないか。",
  "pilihan":["今日中。","明日の朝。","会議のあと。","来週の月曜日。"],"benar":0},
 {"tanya":"資料が間に合わないとき、どうするか。",
  "pilihan":["会議を休む。","山田さんに知らせる。","会議室を変える。","自分で資料を作る。"],"benar":1}
]'::jsonb, 'email')
on conflict (level, hari_ke) do update set
 tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id,
 teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id,
 soal=excluded.soal, jenis=excluded.jenis;

-- ============================================================================
-- HARI 9 · setsumei — 学校・勉強
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
 'n3', 9, '学校・勉強', '覚え方', 'Cara menghafal',
'言葉を覚えるとき、書いて覚える人と、聞いて覚える人がいる。自分に合った方法で覚えるのが一番だ。ただし、覚えたかどうかは、自分でテストしてみないと分からない。テストして、間違えたところをまた覚える。これが一番早い。',
'ことばを おぼえる とき、かいて おぼえる ひとと、きいて おぼえる ひとが いる。じぶんに あった ほうほうで おぼえるのが いちばんだ。ただし、おぼえたか どうかは、じぶんで テストして みないと わからない。テストして、まちがえた ところを また おぼえる。これが いちばん はやい。',
'Saat menghafal kata, ada orang yang menghafal dengan menulis dan ada yang dengan mendengar. Menghafal dengan cara yang cocok untuk diri sendiri adalah yang terbaik. Namun, apakah sudah hafal atau belum, tidak akan tahu tanpa mencoba menguji diri. Uji diri, lalu hafalkan lagi bagian yang salah. Ini yang paling cepat.',
'[
 {"tanya":"この文章で筆者が一番言いたいことは何か。",
  "pilihan":["自分でテストして、間違えたところを覚え直すのが一番早い。","書いて覚える方法が一番いい。","聞いて覚える方法が一番いい。","テストはしなくてもいい。"],"benar":0},
 {"tanya":"覚え方について、文章はどう言っているか。",
  "pilihan":["自分に合った方法で覚えるのがいい。","必ず書いて覚えなければならない。","人と同じ方法で覚えたほうがいい。","覚える方法は一つしかない。"],"benar":0}
]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set
 tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id,
 teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id,
 soal=excluded.soal, jenis=excluded.jenis;

-- ============================================================================
-- HARI 10 · oshirase — 天気・自然
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
 'n3', 10, '天気・自然', '台風のお知らせ', 'Pemberitahuan topan',
'台風のお知らせ
・明日の午後、強い風と雨になります。
・外に出ないでください。
・電車は止まる可能性があります。
・水と食べ物を準備してください。',
'たいふうの おしらせ
・あしたの ごご、つよい かぜと あめに なります。
・そとに でないで ください。
・でんしゃは とまる かのうせいが あります。
・みずと たべものを じゅんびして ください。',
'Pemberitahuan topan
・Besok siang akan ada angin kencang dan hujan.
・Jangan keluar rumah.
・Kereta mungkin berhenti.
・Siapkan air dan makanan.',
'[
 {"tanya":"明日の午後、天気はどうなるか。",
  "pilihan":["強い風と雨になる。","晴れて暖かくなる。","雪がたくさん降る。","何も変わらない。"],"benar":0},
 {"tanya":"準備しておかなければならないものはどれか。",
  "pilihan":["水と食べ物","傘と長ぐつ","電車の切符","地図とお金"],"benar":0},
 {"tanya":"電車について、どう言っているか。",
  "pilihan":["止まる可能性がある。","必ず動く。","本数が増える。","無料になる。"],"benar":0}
]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set
 tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id,
 teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id,
 soal=excluded.soal, jenis=excluded.jenis;

-- ============================================================================
-- HARI 11 · setsumei — 感情・性格
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
 'n3', 11, '感情・性格', '失敗したとき', 'Saat gagal',
'失敗したとき、人はどうするだろうか。すぐに言い訳をする人もいる。しかし、まず自分が何を間違えたかを考えることが大切だ。反省して、次の行動を変えれば、失敗は経験になる。',
'しっぱいした とき、ひとは どうするだろうか。すぐに いいわけを する ひとも いる。しかし、まず じぶんが なにを まちがえたかを かんがえる ことが たいせつだ。はんせいして、つぎの こうどうを かえれば、しっぱいは けいけんに なる。',
'Saat gagal, apa yang orang lakukan? Ada juga yang langsung mencari alasan. Tetapi yang penting adalah memikirkan dulu apa yang salah pada diri sendiri. Kalau merenung dan mengubah tindakan berikutnya, kegagalan menjadi pengalaman.',
'[
 {"tanya":"筆者は失敗したとき、まず何をすることが大切だと言っているか。",
  "pilihan":["自分が何を間違えたかを考える。","すぐに言い訳をする。","人に謝る。","失敗を忘れる。"],"benar":0},
 {"tanya":"反省して行動を変えると、失敗はどうなるか。",
  "pilihan":["経験になる。","なくなる。","増える。","問題になる。"],"benar":0}
]'::jsonb, 'setsumei')
on conflict (level, hari_ke) do update set
 tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id,
 teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id,
 soal=excluded.soal, jenis=excluded.jenis;

-- ============================================================================
-- HARI 12 · email — 時間・予定
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
 'n3', 12, '時間・予定', '来週の予定', 'Rencana pekan depan',
'件名：来週の予定
みなさん
来週の月曜日は休みです。火曜日から金曜日まで、いつもの時間に集まってください。木曜日は、午後から別の場所で作業します。場所は後で連絡します。',
'けんめい：らいしゅうの よてい
みなさん
らいしゅうの げつようびは やすみです。かようびから きんようびまで、いつもの じかんに あつまって ください。もくようびは、ごごから べつの ばしょで さぎょうします。ばしょは あとで れんらくします。',
'Subjek: Rencana pekan depan
Semua,
Senin pekan depan libur. Selasa sampai Jumat berkumpul pada jam biasa. Kamis mulai sore bekerja di tempat lain. Tempatnya saya kabari nanti.',
'[
 {"tanya":"休みなのはいつか。",
  "pilihan":["来週の月曜日。","来週の木曜日。","火曜日から金曜日。","土曜日と日曜日。"],"benar":0},
 {"tanya":"木曜日はどうするか。",
  "pilihan":["午後から別の場所で作業する。","一日中休む。","朝から会議をする。","いつもと違う時間に集まる。"],"benar":0},
 {"tanya":"作業する場所はいつ分かるか。",
  "pilihan":["後で連絡がある。","もう分かっている。","当日に聞く。","誰も知らない。"],"benar":0}
]'::jsonb, 'email')
on conflict (level, hari_ke) do update set
 tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id,
 teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id,
 soal=excluded.soal, jenis=excluded.jenis;

-- ============================================================================
-- HARI 13 · oshirase — 機械・通信
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
 'n3', 13, '機械・通信', 'コピー機の使い方', 'Cara memakai mesin fotokopi',
'コピー機の使い方
・コピーするときは、まずカードを入れてください。
・カードがないと、使えません。
・紙が詰まったときは、ふたを開けて紙を取ってください。
・こわれたときは、受付に言ってください。',
'コピーきの つかいかた
・コピーする ときは、まず カードを いれて ください。
・カードが ないと、つかえません。
・かみが つまった ときは、ふたを あけて かみを とって ください。
・こわれた ときは、うけつけに いって ください。',
'Cara memakai mesin fotokopi
・Saat memfotokopi, masukkan kartu dulu.
・Tanpa kartu, tidak bisa dipakai.
・Kalau kertas macet, buka tutupnya dan ambil kertasnya.
・Kalau rusak, bilang ke resepsionis.',
'[
 {"tanya":"コピーするために必要なものは何か。",
  "pilihan":["カード","お金","紙とペン","受付の許可"],"benar":0},
 {"tanya":"紙が詰まったとき、どうするか。",
  "pilihan":["ふたを開けて紙を取る。","受付に電話する。","機械を止めたままにする。","新しい紙を入れる。"],"benar":0},
 {"tanya":"機械がこわれたとき、どうするか。",
  "pilihan":["受付に言う。","自分で直す。","そのままにする。","別の階へ運ぶ。"],"benar":1}
]'::jsonb, 'oshirase')
on conflict (level, hari_ke) do update set
 tema=excluded.tema, judul_jp=excluded.judul_jp, judul_id=excluded.judul_id,
 teks_jp=excluded.teks_jp, teks_furi=excluded.teks_furi, teks_id=excluded.teks_id,
 soal=excluded.soal, jenis=excluded.jenis;
