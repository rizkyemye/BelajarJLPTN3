-- ============================================================================
-- BUNPOU N3 — 129 pola tata bahasa
-- Jalankan di Supabase → SQL Editor → Run. Aman diulang.
-- ============================================================================

create table if not exists public.bunpou (
  id          bigint generated always as identity primary key,
  level       text not null default 'n3' check (level in ('n5','n4','n3')),
  urutan      int  not null,
  tema_jp     text not null,
  tema_id     text not null,
  pola        text not null,
  arti        text not null,
  rumus       text not null,
  penjelasan  text not null,
  contoh_jp   text not null,
  contoh_furi text,
  contoh_id   text,
  unique (level, urutan)
);

-- kalau tabel versi lama sudah ada (kolomnya bernama `bentuk`)
do $$
begin
  if exists (select 1 from information_schema.columns
             where table_schema='public' and table_name='bunpou' and column_name='bentuk') then
    alter table public.bunpou rename column bentuk to rumus;
  end if;
end $$;

alter table public.bunpou add column if not exists penjelasan text;

alter table public.bunpou enable row level security;

drop policy if exists "baca bunpou" on public.bunpou;
create policy "baca bunpou" on public.bunpou for select to authenticated using (true);

drop policy if exists "admin kelola bunpou" on public.bunpou;
create policy "admin kelola bunpou" on public.bunpou for all
  using (public.apakah_admin()) with check (public.apakah_admin());

-- ---------- isi 129 pola ----------
insert into public.bunpou
  (level, urutan, tema_jp, tema_id, pola, arti, rumus, penjelasan, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 1, '動詞の形', 'bentuk kata kerja', 'ながら', 'sambil melakukan', 'V-ます（ます dihapus）＋ ながら', 'Dua kegiatan dikerjakan oleh satu orang pada waktu yang sama. Subjeknya harus sama, dan kegiatan kedua menjadi fokus kalimat.', '音楽を聞きながら勉強します。', 'おんがくを ききながら べんきょうします。', 'Saya belajar sambil mendengarkan musik.'),
  ('n3', 2, '動詞の形', 'bentuk kata kerja', 'たことがある', 'pernah melakukan', 'V-た ＋ ことがある', 'Menceritakan pengalaman yang pernah dialami sampai sekarang. Kalau belum pernah, akhirannya menjadi たことがない.', '京都へ行ったことがあります。', 'きょうとへ いったことが あります。', 'Saya pernah pergi ke Kyoto.'),
  ('n3', 3, '動詞の形', 'bentuk kata kerja', 'てしまう', 'terlanjur / selesai sepenuhnya', 'V-て ＋ しまう', 'Menunjukkan pekerjaan selesai tuntas, atau sesuatu yang terjadi tanpa diniatkan (terlanjur). Sering bernada menyesal.', 'ケーキを全部食べてしまいました。', 'けーきを ぜんぶ たべて しまいました。', 'Kuenya terlanjur kumakan semua.'),
  ('n3', 4, '動詞の形', 'bentuk kata kerja', 'ておく', 'melakukan dulu untuk persiapan', 'V-て ＋ おく', 'Melakukan sesuatu lebih dulu untuk persiapan, supaya keadaan nanti sudah siap.', '会議の前に資料を準備しておきます。', 'かいぎの まえに しりょうを じゅんびして おきます。', 'Saya siapkan dokumennya dulu sebelum rapat.'),
  ('n3', 5, '動詞の形', 'bentuk kata kerja', 'てみる', 'coba melakukan', 'V-て ＋ みる', 'Mencoba melakukan sesuatu untuk melihat hasilnya. Tidak menjamin berhasil.', 'この料理を食べてみてください。', 'この りょうりを たべて みて ください。', 'Coba makan masakan ini.'),
  ('n3', 6, '動詞の形', 'bentuk kata kerja', 'てある', 'sudah dalam keadaan (hasil tindakan)', 'V-て ＋ ある', 'Keadaan sekarang adalah hasil dari tindakan seseorang sebelumnya, dan keadaan itu masih berlangsung.', '窓が開けてあります。', 'まどが あけて あります。', 'Jendelanya sudah dibuka (dan tetap terbuka).'),
  ('n3', 7, '推量', 'dugaan', 'そうだ', 'kelihatannya (dari penglihatan)', 'V-ます(basis)／A-い／A-な ＋ そうだ', 'Dugaan berdasarkan penglihatan langsung. Bentuknya menempel pada dasar kata: おいしい→おいしそう、静か→静かそう.', 'この店の料理はおいしそうです。', 'この みせの りょうりは おいしそうです。', 'Masakan toko ini kelihatan enak.'),
  ('n3', 8, '推量', 'dugaan', 'らしい', 'tampaknya / katanya', 'Kata benda／bentuk biasa ＋ らしい', 'Dugaan berdasarkan kabar atau ciri yang khas. Lebih objektif daripada みたいだ.', '明日は雨らしいです。', 'あしたは あめ らしいです。', 'Katanya besok hujan.'),
  ('n3', 9, '推量', 'dugaan', 'みたいだ', 'seperti / mirip', 'Kata benda／bentuk biasa ＋ みたいだ', 'Perbandingan atau dugaan yang santai, banyak dipakai dalam percakapan. Seperti ようだ tetapi lebih lisan.', '彼は子どものみたいです。', 'かれは こどもの みたいです。', 'Dia seperti anak kecil.'),
  ('n3', 10, '推量', 'dugaan', 'ようだ', 'sepertinya (dugaan halus)', 'Bentuk biasa ＋ ようだ', 'Dugaan halus berdasarkan bukti atau kesan. Lebih formal dan tertulis daripada みたいだ.', '誰か来たようです。', 'だれか きた ようです。', 'Sepertinya ada yang datang.'),
  ('n3', 11, '推量', 'dugaan', 'かもしれない', 'mungkin', 'Bentuk biasa ＋ かもしれない', 'Kemungkinan yang tidak pasti. Tingkat keyakinannya paling rendah di antara dugaan.', '少し遅れるかもしれません。', 'すこし おくれる かもしれません。', 'Mungkin saya agak terlambat.'),
  ('n3', 12, '判断', 'penilaian', 'はずだ', 'seharusnya / semestinya', 'Bentuk biasa ＋ はずだ', 'Kesimpulan logis: seharusnya begitu menurut alasan yang masuk akal.', '彼はもう着いているはずです。', 'かれは もう ついている はずです。', 'Dia seharusnya sudah sampai.'),
  ('n3', 13, '判断', 'penilaian', 'わけだ', 'wajar saja / berarti', 'Bentuk biasa ＋ わけだ', 'Kesimpulan wajar: memang begitu seharusnya, setelah tahu sebabnya.', 'エアコンが壊れた。暑いわけだ。', 'えあこんが こわれた。あつい わけだ。', 'AC-nya rusak. Wajar saja panas.'),
  ('n3', 14, '判断', 'penilaian', 'わけではない', 'bukan berarti', 'Bentuk biasa ＋ わけではない', 'Menyangkal kesimpulan orang lain dengan halus: bukan berarti begitu.', '嫌いなわけではありません。', 'きらいな わけでは ありません。', 'Bukan berarti saya tidak suka.'),
  ('n3', 15, '判断', 'penilaian', 'ことにする', 'memutuskan (kemauan sendiri)', 'V-辞書形 ＋ ことにする', 'Keputusan diambil oleh pembicara sendiri, berdasarkan kemauan sendiri.', '来月から早起きすることにしました。', 'らいげつから はやおきする ことに しました。', 'Saya memutuskan bangun pagi mulai bulan depan.'),
  ('n3', 16, '意志・変化', 'kemauan & perubahan', 'ことになる', 'menjadi / diputuskan (oleh keadaan)', 'V-辞書形 ＋ ことになる', 'Keputusan atau hasil yang muncul dari keadaan atau pihak lain, bukan dari kemauan sendiri.', '来年、大阪へ転勤することになりました。', 'らいねん、おおさかへ てんきんする ことに なりました。', 'Tahun depan saya dipindahkan ke Osaka.'),
  ('n3', 17, '意志・変化', 'kemauan & perubahan', 'ようにする', 'berusaha agar', 'V-辞書形／V-ない ＋ ようにする', 'Berusaha agar kebiasaan atau keadaan tertentu terwujud. Fokusnya pada usaha, bukan hasil.', '毎日野菜を食べるようにしています。', 'まいにち やさいを たべる ように しています。', 'Saya berusaha makan sayur setiap hari.'),
  ('n3', 18, '意志・変化', 'kemauan & perubahan', 'ようになる', 'menjadi bisa / mulai', 'V-辞書形 ＋ ようになる', 'Perubahan kemampuan atau kebiasaan dari tidak bisa menjadi bisa.', '日本語が話せるようになりました。', 'にほんごが はなせる ように なりました。', 'Saya jadi bisa berbicara bahasa Jepang.'),
  ('n3', 19, '意志・変化', 'kemauan & perubahan', 'ために', 'untuk / demi', 'V-辞書形／N＋の ＋ ために', 'Menyatakan tujuan. Kalau subjeknya kata benda, dipakai のために.', '家族のために働いています。', 'かぞくの ために はたらいて います。', 'Saya bekerja demi keluarga.'),
  ('n3', 20, '目的・様態', 'tujuan & cara', 'ように', 'agar / supaya', 'V-辞書形／V-ない ＋ ように', 'Menyatakan tujuan berupa keadaan yang diharapkan. Berbeda dengan ために, kata kerjanya biasanya bentuk potensial atau negatif.', '忘れないように書いてください。', 'わすれない ように かいて ください。', 'Tolong tulis supaya tidak lupa.'),
  ('n3', 21, '目的・様態', 'tujuan & cara', 'のに', 'padahal', 'Bentuk biasa ＋ のに', 'Menyatakan pertentangan atau kekecewaan: padahal sudah begitu, tetapi hasilnya tidak sesuai.', '一生懸命勉強したのに、不合格でした。', 'いっしょうけんめい べんきょうした のに、ふごうかく でした。', 'Padahal sudah belajar keras, tetap tidak lulus.'),
  ('n3', 22, '目的・様態', 'tujuan & cara', 'ても', 'walaupun', 'V-て ＋ も', 'Menyatakan bahwa hasilnya tetap sama walaupun ada keadaan yang biasanya menghalangi.', '雨が降っても行きます。', 'あめが ふっても いきます。', 'Walaupun hujan, saya tetap pergi.'),
  ('n3', 23, '目的・様態', 'tujuan & cara', 'ば', 'kalau (syarat)', 'V-ば形', 'Bentuk syarat paling netral. Cocok untuk syarat umum, bukan permintaan langsung.', '時間があれば、手伝います。', 'じかんが あれば、てつだいます。', 'Kalau ada waktu, saya bantu.'),
  ('n3', 24, '条件', 'syarat', 'たら', 'kalau / setelah', 'V-たら', 'Syarat yang menekankan urutan: setelah hal pertama terjadi, hal kedua menyusul.', '家に着いたら電話してください。', 'いえに ついたら でんわして ください。', 'Kalau sudah sampai rumah, tolong telepon.'),
  ('n3', 25, '条件', 'syarat', 'なら', 'kalau soal', 'N ＋ なら', 'Mengambil topik yang sudah disebut lawan bicara, lalu memberi syarat atau saran tentang topik itu.', '日本なら、どこへ行きたいですか。', 'にほんなら、どこへ いきたいですか。', 'Kalau soal Jepang, mau pergi ke mana?'),
  ('n3', 26, '条件', 'syarat', 'と', 'kalau (pasti terjadi)', 'V-辞書形 ＋ と', 'Syarat yang hasilnya otomatis dan pasti, misalnya aturan mesin atau hukum alam.', 'このボタンを押すと、ドアが開きます。', 'この ぼたんを おすと、どあが あきます。', 'Kalau tombol ini ditekan, pintunya terbuka.'),
  ('n3', 27, '条件', 'syarat', 'うちに', 'selagi / sebelum berubah', 'V-ている／A-い ＋ うちに', 'Selagi keadaan masih seperti sekarang, lakukan sesuatu sebelum berubah.', '温かいうちに食べてください。', 'あたたかい うちに たべて ください。', 'Makanlah selagi masih hangat.'),
  ('n3', 28, '条件', 'syarat', 'あいだ', 'selama / sementara', 'V-ている／N＋の ＋ あいだ', 'Selama rentang waktu tertentu, suatu keadaan berlangsung terus.', '休みのあいだ、ずっと寝ていました。', 'やすみの あいだ、ずっと ねて いました。', 'Selama libur, saya terus tidur.'),
  ('n3', 29, '時間・並列', 'waktu & penambahan', 'たびに', 'setiap kali', 'V-辞書形／N＋の ＋ たびに', 'Setiap kali peristiwa pertama terjadi, peristiwa kedua selalu menyusul.', '旅行のたびに写真を撮ります。', 'りょこうの たびに しゃしんを とります。', 'Setiap kali bepergian, saya memotret.'),
  ('n3', 30, '時間・並列', 'waktu & penambahan', 'し', 'dan juga (menyebut alasan)', 'Bentuk biasa ＋ し', 'Menyebutkan dua hal atau lebih sebagai alasan atau ciri, biasanya untuk mendukung kesimpulan.', 'この店は安いし、おいしいです。', 'この みせは やすいし、おいしいです。', 'Toko ini murah, dan juga enak.'),
  ('n3', 31, '状態', 'keadaan', 'てばかりいる', 'terus-menerus melakukan', 'V-て ＋ ばかりいる', 'Menyatakan kebiasaan yang berulang terus, biasanya bernada mengeluh.', '彼は遊んでばかりいる。', 'かれは あそんで ばかりいる。', 'Dia terus-menerus main.'),
  ('n3', 32, '授受', 'memberi & menerima', 'てほしい', 'ingin orang lain melakukan', 'V-て ＋ ほしい', 'Mengharapkan orang lain melakukan sesuatu untuk kita.', '早く返事をしてほしいです。', 'はやく へんじを して ほしいです。', 'Saya ingin kamu cepat membalas.'),
  ('n3', 33, '授受', 'memberi & menerima', 'てもらう', 'menerima jasa', 'V-て ＋ もらう', 'Menerima bantuan atau jasa dari orang lain.', '友達に日本語を教えてもらいました。', 'ともだちに にほんごを おしえて もらいました。', 'Saya dibantu teman belajar bahasa Jepang.'),
  ('n3', 34, '授受', 'memberi & menerima', 'てくれる', 'diberi jasa', 'V-て ＋ くれる', 'Orang lain melakukan sesuatu untuk kita; fokus pada rasa terima kasih.', '母が弁当を作ってくれました。', 'ははが べんとうを つくって くれました。', 'Ibu membuatkan bekal untuk saya.'),
  ('n3', 35, '授受', 'memberi & menerima', 'てあげる', 'memberi jasa', 'V-て ＋ あげる', 'Kita melakukan sesuatu untuk orang lain.', '弟に宿題を教えてあげました。', 'おとうとに しゅくだいを おしえて あげました。', 'Saya mengajari PR adik.'),
  ('n3', 36, '授受', 'memberi & menerima', 'ていただく', 'menerima jasa (sopan)', 'V-て ＋ いただく', 'Versi sopan てもらう, untuk atasan atau tamu.', '部長に説明していただきました。', 'ぶちょうに せつめいして いただきました。', 'Saya dijelaskan oleh kepala bagian.'),
  ('n3', 37, '授受', 'memberi & menerima', 'てくださる', 'memberi jasa (sopan)', 'V-て ＋ くださる', 'Versi sopan てくれる.', '先生が直してくださいました。', 'せんせいが なおして くださいました。', 'Guru memperbaikinya untuk saya.'),
  ('n3', 38, '使役・依頼', 'kausatif & permintaan', 'させられる', 'dipaksa melakukan', 'V-させる ＋ 受身', 'Bentuk kausatif-pasif: melakukan karena terpaksa.', '毎日残業させられています。', 'まいにち ざんぎょう させられて います。', 'Saya dipaksa lembur setiap hari.'),
  ('n3', 39, '使役・依頼', 'kausatif & permintaan', 'させる', 'menyuruh / membiarkan', 'V-させる', 'Menyuruh atau membiarkan orang lain melakukan.', '子どもを外で遊ばせます。', 'こどもを そとで あそばせます。', 'Saya membiarkan anak bermain di luar.'),
  ('n3', 40, '使役・依頼', 'kausatif & permintaan', 'てもらえないか', 'boleh minta tolong…?', 'V-て ＋ もらえないか', 'Permintaan sopan yang tidak memaksa.', 'この書類を確認してもらえませんか。', 'この しょるいを かくにんして もらえませんか。', 'Boleh minta tolong cek dokumen ini?'),
  ('n3', 41, '依頼・命令', 'permintaan & perintah', 'お〜ください', 'mohon melakukan', 'お ＋ V-ます(basis) ＋ ください', 'Permintaan sopan untuk tindakan orang lain.', 'こちらにお掛けください。', 'こちらに おかけ ください。', 'Silakan duduk di sini.'),
  ('n3', 42, '依頼・命令', 'permintaan & perintah', 'ご〜ください', 'mohon melakukan', 'ご ＋ N ＋ ください', 'Sama seperti お〜ください, untuk kata berawalan ご.', 'ご利用ください。', 'ごりよう ください。', 'Silakan digunakan.'),
  ('n3', 43, '依頼・命令', 'permintaan & perintah', 'なさい', 'perintah halus', 'V-ます(basis) ＋ なさい', 'Perintah lembut, biasanya dari orang tua atau guru.', '早く寝なさい。', 'はやく ねなさい。', 'Cepat tidur.'),
  ('n3', 44, '依頼・命令', 'permintaan & perintah', 'な', 'jangan', 'V-辞書形 ＋ な', 'Larangan tegas dengan nada kasar.', '触るな。', 'さわるな。', 'Jangan sentuh.'),
  ('n3', 45, '義務・禁止', 'kewajiban & larangan', 'てはいけない', 'tidak boleh', 'V-て ＋ はいけない', 'Larangan berdasarkan aturan.', 'ここで写真を撮ってはいけません。', 'ここで しゃしんを とっては いけません。', 'Tidak boleh memotret di sini.'),
  ('n3', 46, '義務・禁止', 'kewajiban & larangan', 'なくてもいい', 'tidak perlu', 'V-ない(basis) ＋ くてもいい', 'Menyatakan sesuatu tidak wajib.', '明日は来なくてもいいです。', 'あしたは こなくても いいです。', 'Besok tidak perlu datang.'),
  ('n3', 47, '義務・禁止', 'kewajiban & larangan', 'なければならない', 'harus', 'V-ない(basis) ＋ ければならない', 'Kewajiban karena aturan atau keadaan.', '毎日薬を飲まなければなりません。', 'まいにち くすりを のまなければ なりません。', 'Saya harus minum obat setiap hari.'),
  ('n3', 48, '義務・禁止', 'kewajiban & larangan', 'なくてはならない', 'harus', 'V-ない(basis) ＋ くてはならない', 'Sama dengan なければならない, sedikit lebih formal.', '明日までに報告しなくてはなりません。', 'あしたまでに ほうこく しなくては なりません。', 'Saya harus melapor sebelum besok.'),
  ('n3', 49, '義務・禁止', 'kewajiban & larangan', 'ざるを得ない', 'terpaksa', 'V-ない(basis) ＋ ざるを得ない', 'Tidak ada pilihan lain selain melakukan.', 'バスがないので歩かざるを得ません。', 'ばすが ないので あるかざるを えません。', 'Karena tidak ada bus, saya terpaksa jalan.'),
  ('n3', 50, '限定・添加', 'batasan & penambahan', 'しか〜ない', 'hanya', 'N／V ＋ しか ＋ ない', 'Hanya itu saja, menekankan keterbatasan.', '水しかありません。', 'みず しか ありません。', 'Hanya ada air.'),
  ('n3', 51, '限定・添加', 'batasan & penambahan', 'ばかりか', 'bukan hanya', 'Bentuk biasa ＋ ばかりか', 'Menambahkan hal lain yang lebih mengejutkan.', '彼は英語ばかりか、中国語も話せます。', 'かれは えいご ばかりか、ちゅうごくごも はなせます。', 'Dia bukan hanya Inggris, Mandarin juga bisa.'),
  ('n3', 52, '限定・添加', 'batasan & penambahan', 'だけでなく', 'tidak hanya', 'Bentuk biasa ＋ だけでなく', 'Menambahkan hal lain sederajat.', '肉だけでなく、魚も食べます。', 'にく だけでなく、さかなも たべます。', 'Bukan hanya daging, ikan juga saya makan.'),
  ('n3', 53, '程度・時制', 'tingkat & waktu', 'ほど', 'sejauh / sedemikian', 'N ＋ ほど', 'Menyatakan tingkat atau perkiraan.', '泣きたいほど嬉しいです。', 'なきたい ほど うれしいです。', 'Senang sampai ingin menangis.'),
  ('n3', 54, '程度・時制', 'tingkat & waktu', 'くらい', 'kira-kira / sampai', 'N ／ bentuk biasa ＋ くらい', 'Perkiraan jumlah atau tingkat ringan.', '十分くらい待ってください。', 'じゅっぷん くらい まって ください。', 'Tolong tunggu sekitar sepuluh menit.'),
  ('n3', 55, '程度・時制', 'tingkat & waktu', 'ばかり', 'baru saja', 'V-た ＋ ばかり', 'Baru saja terjadi.', '今帰ったばかりです。', 'いま かえった ばかりです。', 'Saya baru saja pulang.'),
  ('n3', 56, '程度・時制', 'tingkat & waktu', 'ところだ', 'baru akan / sedang', 'V-辞書形／V-ている ＋ ところだ', 'Menunjukkan tahap tindakan.', '今出かけるところです。', 'いま でかける ところです。', 'Saya baru akan berangkat.'),
  ('n3', 57, '程度・時制', 'tingkat & waktu', 'ところだった', 'hampir saja', 'V-辞書形 ＋ ところだった', 'Hampir terjadi, tetapi tidak jadi.', 'もう少しで転ぶところでした。', 'もう すこしで ころぶ ところでした。', 'Tadi hampir saja jatuh.'),
  ('n3', 58, '程度・時制', 'tingkat & waktu', 'つもりだ', 'berniat', 'V-辞書形 ＋ つもりだ', 'Menyatakan rencana pribadi.', '来年日本へ行くつもりです。', 'らいねん にほんへ いく つもりです。', 'Saya berniat ke Jepang tahun depan.'),
  ('n3', 59, '意志・判断', 'kemauan & penilaian', 'ようと思う', 'berpikir untuk', 'V-よう ＋ と思う', 'Niat yang masih dipertimbangkan.', '早く寝ようと思います。', 'はやく ねようと おもいます。', 'Saya pikir mau tidur cepat.'),
  ('n3', 60, '意志・判断', 'kemauan & penilaian', 'べきだ', 'sepatutnya', 'V-辞書形 ＋ べきだ', 'Kewajiban moral, bukan aturan tertulis.', '約束は守るべきです。', 'やくそくは まもる べきです。', 'Janji sepatutnya ditepati.'),
  ('n3', 61, '意志・判断', 'kemauan & penilaian', 'べきではない', 'tidak sepatutnya', 'V-辞書形 ＋ べきではない', 'Larangan moral.', '人の悪口を言うべきではない。', 'ひと の わるぐちを いう べきでは ない。', 'Tidak sepatutnya membicarakan keburukan orang.'),
  ('n3', 62, '意志・判断', 'kemauan & penilaian', 'ことだ', 'sebaiknya', 'V-辞書形／V-ない ＋ ことだ', 'Saran atau nasihat.', '早く病院へ行くことです。', 'はやく びょういんへ いく ことです。', 'Sebaiknya cepat ke rumah sakit.'),
  ('n3', 63, '意志・判断', 'kemauan & penilaian', 'ものだ', 'memang begitulah', 'Bentuk biasa ＋ ものだ', 'Menyatakan hal yang wajar atau umum.', '年を取ると忘れやすくなるものです。', 'としを とると わすれやすく なるものです。', 'Kalau bertambah tua memang mudah lupa.'),
  ('n3', 64, '理由', 'sebab', 'ものだから', 'karena', 'Bentuk biasa ＋ ものだから', 'Alasan yang dibawa sebagai pembelaan.', '雨が降ったものだから、遅れました。', 'あめが ふった ものだから、おくれました。', 'Karena hujan, saya terlambat.'),
  ('n3', 65, '理由', 'sebab', 'おかげで', 'berkat', 'N＋の／V-た ＋ おかげで', 'Hasil baik karena sesuatu.', '先生のおかげで合格しました。', 'せんせいの おかげで ごうかく しました。', 'Berkat guru saya lulus.'),
  ('n3', 66, '理由', 'sebab', 'せいで', 'gara-gara', 'N＋の／V-た ＋ せいで', 'Hasil buruk karena sesuatu.', '寝坊したせいで遅刻しました。', 'ねぼうした せいで ちこく しました。', 'Gara-gara kesiangan saya terlambat.'),
  ('n3', 67, '対象', 'sasaran', 'について', 'tentang', 'N ＋ について', 'Membahas topik.', '日本の文化について話しました。', 'にほんの ぶんか について はなしました。', 'Kami bicara tentang budaya Jepang.'),
  ('n3', 68, '対象', 'sasaran', 'に対して', 'terhadap', 'N ＋ に対して', 'Sikap atau tindakan yang ditujukan kepada pihak lain.', 'お客様に対して丁寧に話します。', 'おきゃくさま に たいして ていねいに はなします。', 'Saya bicara sopan terhadap tamu.'),
  ('n3', 69, '対象', 'sasaran', 'にとって', 'bagi', 'N ＋ にとって', 'Dari sudut pandang pihak tertentu.', '私にとって家族が一番大切です。', 'わたしに とって かぞくが いちばん たいせつです。', 'Bagi saya keluarga paling penting.'),
  ('n3', 70, '対象', 'sasaran', 'によって', 'oleh / tergantung', 'N ＋ によって', 'Pelaku dalam kalimat pasif, atau sebab perbedaan.', 'この絵は彼によって描かれました。', 'この えは かれに よって かかれました。', 'Lukisan ini dibuat oleh dia.'),
  ('n3', 71, '立場・比較', 'posisi & perbandingan', 'として', 'sebagai', 'N ＋ として', 'Menunjukkan peran atau status.', '彼は先生として働いています。', 'かれは せんせい として はたらいて います。', 'Dia bekerja sebagai guru.'),
  ('n3', 72, '立場・比較', 'posisi & perbandingan', 'に比べて', 'dibandingkan', 'N ＋ に比べて', 'Membandingkan dua hal.', '去年に比べて寒いです。', 'きょねん に くらべて さむいです。', 'Dibanding tahun lalu, lebih dingin.'),
  ('n3', 73, '立場・比較', 'posisi & perbandingan', 'に代わって', 'menggantikan', 'N ＋ に代わって', 'Bertindak sebagai pengganti.', '私が部長に代わって説明します。', 'わたしが ぶちょう に かわって せつめい します。', 'Saya menggantikan kepala bagian menjelaskan.'),
  ('n3', 74, '立場・比較', 'posisi & perbandingan', 'を通じて', 'melalui', 'N ＋ を通じて', 'Lewat perantara atau media.', '友人を通じて知り合いました。', 'ゆうじんを つうじて しりあいました。', 'Kami berkenalan lewat teman.'),
  ('n3', 75, '限定・断定', 'batasan & kepastian', 'に限る', 'paling baik', 'N／V-辞書形 ＋ に限る', 'Menyatakan pilihan terbaik.', '夏はビールに限ります。', 'なつは びーる に かぎります。', 'Kalau musim panas, bir paling enak.'),
  ('n3', 76, '限定・断定', 'batasan & kepastian', 'に限って', 'khusus', 'N ＋ に限って', 'Hanya pada kasus tertentu, sering bernada heran.', 'うちの子に限って嘘はつきません。', 'うちの こ に かぎって うそは つきません。', 'Anak saya khususnya tidak akan berbohong.'),
  ('n3', 77, '限定・断定', 'batasan & kepastian', 'に違いない', 'pasti', 'Bentuk biasa ＋ に違いない', 'Keyakinan yang kuat.', '彼は犯人に違いありません。', 'かれは はんにん に ちがいありません。', 'Dia pasti pelakunya.'),
  ('n3', 78, '限定・断定', 'batasan & kepastian', 'に決まっている', 'sudah pasti', 'Bentuk biasa ＋ に決まっている', 'Kepastian yang dianggap jelas.', 'そんなの無理に決まっています。', 'そんなの むり に きまって います。', 'Begitu jelas tidak mungkin.'),
  ('n3', 79, '否定・言い換え', 'penyangkalan & penjelasan ulang', 'とは限らない', 'belum tentu', 'Bentuk biasa ＋ とは限らない', 'Menyangkal anggapan umum.', '高い物がいいとは限りません。', 'たかい もの が いい とは かぎりません。', 'Barang mahal belum tentu bagus.'),
  ('n3', 80, '否定・言い換え', 'penyangkalan & penjelasan ulang', 'というより', 'lebih tepatnya', 'Bentuk biasa ＋ というより', 'Membetulkan cara menyebut.', '嫌いというより、苦手なんです。', 'きらい というより、にがて なんです。', 'Bukan benci, lebih tepatnya tidak mahir.'),
  ('n3', 81, '否定・言い換え', 'penyangkalan & penjelasan ulang', 'というのは', 'adalah bahwa', 'Bentuk biasa ＋ というのは', 'Menjelaskan makna sesuatu.', '敬語というのは、難しいです。', 'けいご というのは、むずかしいです。', 'Bahasa sopan itu memang sulit.'),
  ('n3', 82, '否定・言い換え', 'penyangkalan & penjelasan ulang', 'ということだ', 'artinya / katanya', 'Bentuk biasa ＋ ということだ', 'Menyimpulkan atau meneruskan kabar.', '休みは明日だということです。', 'やすみは あした だ ということです。', 'Katanya liburnya besok.'),
  ('n3', 83, '比況・状態', 'perbandingan & keadaan', 'ように見える', 'kelihatan seperti', 'Bentuk biasa ＋ ように見える', 'Tampilan dari luar.', '彼は元気なように見えます。', 'かれは げんきな ように みえます。', 'Dia kelihatan sehat.'),
  ('n3', 84, '比況・状態', 'perbandingan & keadaan', 'かのようだ', 'seakan-akan', 'Bentuk biasa ＋ かのようだ', 'Perumpamaan yang dilebih-lebihkan.', '冬が来たかのように寒いです。', 'ふゆが きた かのように さむいです。', 'Dinginnya seakan-akan musim dingin tiba.'),
  ('n3', 85, '比況・状態', 'perbandingan & keadaan', 'ふりをする', 'berpura-pura', 'V-た／N＋の ＋ ふりをする', 'Berbuat seolah tidak tahu atau tidak merasa.', '知らないふりをしました。', 'しらない ふりを しました。', 'Saya berpura-pura tidak tahu.'),
  ('n3', 86, '比況・状態', 'perbandingan & keadaan', 'まま', 'dibiarkan begitu', 'V-た／V-ない ＋ まま', 'Keadaan yang tidak berubah.', '窓を開けたまま寝ました。', 'まどを あけた まま ねました。', 'Saya tidur dengan jendela tetap terbuka.'),
  ('n3', 87, '比況・状態', 'perbandingan & keadaan', 'っぱなし', 'dibiarkan terus', 'V-ます(basis) ＋ っぱなし', 'Dibiarkan tanpa dirapikan, sedikit negatif.', '水を出しっぱなしにしないでください。', 'みずを だしっぱなし に しないで ください。', 'Jangan biarkan air mengalir terus.'),
  ('n3', 88, '逆接・変化', 'pertentangan & perubahan', 'ながらも', 'meskipun', 'V-ます(basis)／A-い ＋ ながらも', 'Pertentangan yang halus.', '狭いながらも快適な部屋です。', 'せまい ながらも かいてきな へやです。', 'Meskipun sempit, kamarnya nyaman.'),
  ('n3', 89, '逆接・変化', 'pertentangan & perubahan', 'つつある', 'sedang berlangsung', 'V-ます(basis) ＋ つつある', 'Perubahan yang sedang berlangsung.', '日本語が上手になりつつあります。', 'にほんごが じょうずに なりつつ あります。', 'Bahasa Jepang saya sedang makin baik.'),
  ('n3', 90, '逆接・変化', 'pertentangan & perubahan', '一方だ', 'terus semakin', 'V-辞書形 ＋ 一方だ', 'Perubahan yang bergerak satu arah terus.', '物価は上がる一方です。', 'ぶっかは あがる いっぽうです。', 'Harga terus naik.'),
  ('n3', 91, '逆接・変化', 'pertentangan & perubahan', 'わけにはいかない', 'tidak boleh (karena tanggung jawab)', 'V-辞書形 ＋ わけにはいかない', 'Tidak bisa dilakukan karena alasan sosial atau moral.', '明日は試験だから休むわけにはいかない。', 'あしたは しけん だから やすむ わけには いかない。', 'Besok ujian, jadi tidak bisa libur.'),
  ('n3', 92, '可能・程度', 'kemungkinan & tingkat', 'ようがない', 'tidak ada cara', 'V-ます(basis) ＋ ようがない', 'Tidak mungkin karena tidak ada caranya.', '名前が分からないので連絡しようがない。', 'なまえが わからないので れんらく しようが ない。', 'Karena tidak tahu namanya, tidak ada cara menghubungi.'),
  ('n3', 93, '可能・程度', 'kemungkinan & tingkat', 'かねる', 'sulit untuk', 'V-ます(basis) ＋ かねる', 'Menolak dengan cara sopan.', 'その件はお答えしかねます。', 'その けんは おこたえ しかねます。', 'Soal itu sulit saya jawab.'),
  ('n3', 94, '可能・程度', 'kemungkinan & tingkat', 'かねない', 'mungkin (buruk)', 'V-ます(basis) ＋ かねない', 'Kemungkinan hasil buruk.', 'そんなに働いたら倒れかねません。', 'そんなに はたらいたら たおれ かねません。', 'Kalau kerja begitu, bisa jadi dia pingsan.'),
  ('n3', 95, '可能・程度', 'kemungkinan & tingkat', 'きる', 'selesai sepenuhnya', 'V-ます(basis) ＋ きる', 'Melakukan sampai habis atau tuntas.', '全部食べきりました。', 'ぜんぶ たべきりました。', 'Saya habiskan semuanya.'),
  ('n3', 96, '可能・程度', 'kemungkinan & tingkat', 'きれない', 'tidak bisa habis', 'V-ます(basis) ＋ きれない', 'Tidak sanggup menyelesaikan.', 'こんなに多くは食べきれません。', 'こんなに おおくは たべきれません。', 'Sebanyak ini tidak bisa kuhabiskan.'),
  ('n3', 97, '傾向・様子', 'kecenderungan & rupa', 'がち', 'cenderung', 'V-ます(basis)／N ＋ がち', 'Sering terjadi, biasanya bernada negatif.', '冬は風邪を引きがちです。', 'ふゆは かぜを ひきがちです。', 'Musim dingin cenderung masuk angin.'),
  ('n3', 98, '傾向・様子', 'kecenderungan & rupa', '気味', 'agak / sedikit', 'V-ます(basis)／N ＋ ぎみ', 'Sedikit menunjukkan gejala.', '疲れ気味です。', 'つかれ ぎみです。', 'Saya agak kelelahan.'),
  ('n3', 99, '傾向・様子', 'kecenderungan & rupa', 'っぽい', 'mirip / mudah', 'N／V-ます(basis) ＋ っぽい', 'Berkesan seperti sesuatu, atau mudah terjadi.', '彼は子どもっぽいです。', 'かれは こどもっぽいです。', 'Dia kekanak-kanakan.'),
  ('n3', 100, '傾向・様子', 'kecenderungan & rupa', 'だらけ', 'penuh', 'N ＋ だらけ', 'Penuh dengan sesuatu, biasanya negatif.', '部屋がほこりだらけです。', 'へやが ほこり だらけです。', 'Kamarnya penuh debu.'),
  ('n3', 101, '傾向・様子', 'kecenderungan & rupa', 'まみれ', 'berlumur', 'N ＋ まみれ', 'Berlumur sesuatu berupa cairan atau kotoran.', '汗まみれになりました。', 'あせ まみれに なりました。', 'Saya jadi berlumuran keringat.'),
  ('n3', 102, '数量・時間', 'jumlah & waktu', 'ずつ', 'masing-masing', 'N ＋ ずつ', 'Jumlah yang dibagi rata.', '一人ずつ配ってください。', 'ひとり ずつ くばって ください。', 'Tolong bagikan satu per orang.'),
  ('n3', 103, '数量・時間', 'jumlah & waktu', 'おきに', 'setiap selang', 'N ＋ おきに', 'Interval waktu atau jarak tertentu.', '一時間おきに電車が来ます。', 'いちじかん おきに でんしゃが きます。', 'Kereta datang setiap satu jam.'),
  ('n3', 104, '数量・時間', 'jumlah & waktu', 'ぶりに', 'setelah sekian lama', 'N ＋ ぶりに', 'Setelah jeda yang lama.', '3年ぶりに日本へ行きました。', 'さんねん ぶりに にほんへ いきました。', 'Saya ke Jepang setelah tiga tahun.'),
  ('n3', 105, '数量・時間', 'jumlah & waktu', 'うちは', 'selama masih', 'V-ている／A-い ＋ うちは', 'Selama keadaan itu masih berlangsung.', '若いうちは無理ができます。', 'わかい うちは むりが できます。', 'Selama masih muda, bisa memaksakan diri.'),
  ('n3', 106, '数量・時間', 'jumlah & waktu', '間は', 'selama', 'N＋の／V-ている ＋ 間は', 'Selama periode tertentu.', '日本にいる間は日本語で話します。', 'にほんに いる あいだは にほんごで はなします。', 'Selama di Jepang, saya bicara bahasa Jepang.'),
  ('n3', 107, '時・条件', 'waktu & syarat', 'たとたん', 'begitu', 'V-た ＋ とたん', 'Peristiwa mendadak tepat setelahnya.', 'ドアを開けたとたん、音が止まった。', 'どあを あけた とたん、おとが とまった。', 'Begitu pintu dibuka, suaranya berhenti.'),
  ('n3', 108, '時・条件', 'waktu & syarat', '次第', 'segera setelah', 'V-ます(basis) ＋ 次第', 'Setelah itu langsung dilakukan.', '着き次第連絡します。', 'つき しだい れんらく します。', 'Begitu tiba, saya hubungi.'),
  ('n3', 109, '時・条件', 'waktu & syarat', '次第だ', 'tergantung', 'N ＋ 次第だ', 'Bergantung sepenuhnya pada sesuatu.', '成功するかは努力次第です。', 'せいこう するかは どりょく しだいです。', 'Berhasil atau tidak tergantung usaha.'),
  ('n3', 110, '時・条件', 'waktu & syarat', '上で', 'setelah / dalam hal', 'V-た／N＋の ＋ 上で', 'Setelah melakukan sesuatu lebih dulu.', 'よく考えた上で決めます。', 'よく かんがえた うえで きめます。', 'Saya putuskan setelah mempertimbangkan.'),
  ('n3', 111, '累加・結果', 'tambahan & hasil', '上に', 'selain itu', 'Bentuk biasa ＋ 上に', 'Menambahkan hal lain yang searah.', 'この店は安い上に、おいしいです。', 'この みせは やすい うえに、おいしいです。', 'Toko ini selain murah, juga enak.'),
  ('n3', 112, '累加・結果', 'tambahan & hasil', '上は', 'karena sudah', 'V-た／V-辞書形 ＋ 上は', 'Konsekuensi setelah berketetapan.', 'やる上は最後までやります。', 'やる うえは さいごまで やります。', 'Kalau sudah mengerjakan, sampai akhir.'),
  ('n3', 113, '累加・結果', 'tambahan & hasil', '末に', 'akhirnya', 'V-た／N＋の ＋ 末に', 'Hasil setelah proses panjang.', '考えた末に決めました。', 'かんがえた すえに きめました。', 'Akhirnya saya putuskan setelah berpikir panjang.'),
  ('n3', 114, '累加・結果', 'tambahan & hasil', 'あげく', 'ujung-ujungnya', 'V-た／N＋の ＋ あげく', 'Hasil buruk setelah usaha panjang.', '悩んだあげく、諦めました。', 'なやんだ あげく、あきらめました。', 'Setelah lama bingung, akhirnya menyerah.'),
  ('n3', 115, '転換', 'peralihan topik', 'ところが', 'namun', 'Bentuk biasa ＋ ところが', 'Pertentangan dengan dugaan.', '行ってみました。ところが閉まっていました。', 'いって みました。ところが しまって いました。', 'Saya coba pergi. Namun ternyata tutup.'),
  ('n3', 116, '転換', 'peralihan topik', 'ところで', 'ngomong-ngomong', 'Bentuk biasa ＋ ところで', 'Mengganti topik pembicaraan.', 'ところで、仕事はどうですか。', 'ところで、しごとは どうですか。', 'Ngomong-ngomong, pekerjaanmu bagaimana?'),
  ('n3', 117, '転換', 'peralihan topik', 'ところに', 'ketika (tepat saat)', 'V-ている／V-た ＋ ところに', 'Tepat saat keadaan berlangsung.', '出かけようとしているところに電話が来ました。', 'でかけようと している ところに でんわが きました。', 'Saat hendak berangkat, telepon datang.'),
  ('n3', 118, '逆接・感嘆', 'pertentangan & seruan', 'ものの', 'walaupun', 'Bentuk biasa ＋ ものの', 'Mengakui sesuatu lalu bertentangan.', '買ったものの、使っていません。', 'かった ものの、つかって いません。', 'Sudah kubeli, tetapi belum kupakai.'),
  ('n3', 119, '逆接・感嘆', 'pertentangan & seruan', 'ものなら', 'kalau sampai', 'V-可能形 ＋ ものなら', 'Syarat yang sulit atau berlebihan.', '帰れるものなら帰りたい。', 'かえれる ものなら かえりたい。', 'Kalau bisa pulang, saya ingin pulang.'),
  ('n3', 120, '逆接・感嘆', 'pertentangan & seruan', 'ものか', 'tidak akan', 'V-辞書形 ＋ ものか', 'Penolakan tegas.', 'あんな店、二度行くものか。', 'あんな みせ、にど いく ものか。', 'Toko seperti itu, tidak akan kudatangi lagi.'),
  ('n3', 121, '逆接・感嘆', 'pertentangan & seruan', 'ことか', 'betapa', 'Bentuk biasa ＋ ことか', 'Menyatakan perasaan yang kuat.', 'どんなに嬉しかったことか。', 'どんなに うれしかった ことか。', 'Betapa senangnya saya.'),
  ('n3', 122, '逆接・感嘆', 'pertentangan & seruan', 'ことなく', 'tanpa', 'V-辞書形 ＋ ことなく', 'Melakukan sesuatu tanpa hal lain.', '休むことなく働いています。', 'やすむ ことなく はたらいて います。', 'Saya bekerja tanpa berhenti.'),
  ('n3', 123, 'その他', 'lain-lain', 'かわりに', 'sebagai ganti', 'V-辞書形／N＋の ＋ かわりに', 'Pengganti atau kompensasi.', '日曜に出るかわりに、月曜は休みます。', 'にちように でる かわりに、げつようは やすみます。', 'Sebagai ganti masuk hari Minggu, Senin libur.'),
  ('n3', 124, 'その他', 'lain-lain', 'つもりだった', 'dulu berniat', 'V-辞書形 ＋ つもりだった', 'Niat masa lalu yang tidak terlaksana.', '行くつもりでしたが、行けませんでした。', 'いく つもりでしたが、いけませんでした。', 'Dulu berniat pergi, tapi tidak bisa.'),
  ('n3', 125, 'その他', 'lain-lain', 'やすい', 'mudah', 'V-ます(basis) ＋ やすい', 'Mudah dilakukan.', 'この本は読みやすいです。', 'この ほんは よみやすいです。', 'Buku ini mudah dibaca.'),
  ('n3', 126, 'その他', 'lain-lain', 'にくい', 'sulit', 'V-ます(basis) ＋ にくい', 'Sulit dilakukan.', 'この字は小さくて読みにくいです。', 'この じは ちいさくて よみにくいです。', 'Tulisan ini kecil dan sulit dibaca.'),
  ('n3', 127, 'その他', 'lain-lain', 'すぎる', 'terlalu', 'V-ます(basis)／A-い(basis) ＋ すぎる', 'Melebihi batas wajar.', '昨日飲みすぎました。', 'きのう のみすぎました。', 'Kemarin saya minum terlalu banyak.'),
  ('n3', 128, 'その他', 'lain-lain', 'たがる', 'ingin (orang lain)', 'V-ます(basis) ＋ たがる', 'Menyatakan keinginan orang lain, bukan diri sendiri.', '子どもは外で遊びたがります。', 'こどもは そとで あそびたがります。', 'Anak ingin bermain di luar.'),
  ('n3', 129, 'その他', 'lain-lain', 'てもかまわない', 'tidak masalah kalau', 'V-て ＋ もかまわない', 'Memberi izin.', 'ここに座ってもかまいませんか。', 'ここに すわっても かまいませんか。', 'Boleh saya duduk di sini?')
on conflict (level, urutan) do update set
  tema_jp = excluded.tema_jp, tema_id = excluded.tema_id,
  pola = excluded.pola, arti = excluded.arti, rumus = excluded.rumus,
  penjelasan = excluded.penjelasan, contoh_jp = excluded.contoh_jp,
  contoh_furi = excluded.contoh_furi, contoh_id = excluded.contoh_id;

select count(*) as jumlah_pola from public.bunpou where level = 'n3';
