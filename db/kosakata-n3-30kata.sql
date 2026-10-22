-- Auto-generated oleh gen-kosakata.py

-- ===== Hari 1 · 生活 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 1, 26, '意識', 'いしき', 'kesadaran', 'nomina', '意識が高いです。', 'いしきが たかいです。', 'Kesadarannya tinggi.'),
  ('n3', 1, 27, '信用', 'しんよう', 'kepercayaan / kredibilitas', 'nomina', '信用が大切です。', 'しんようが たいせつです。', 'Kepercayaan itu penting.'),
  ('n3', 1, 28, '決意', 'けつい', 'tekad', 'nomina', '決意しました。', 'けついしました。', 'Saya sudah bertekad.'),
  ('n3', 1, 29, '反省', 'はんせい', 'refleksi diri', 'nomina', '少し反省しています。', 'すこし はんせいしています。', 'Saya sedikit merenung.'),
  ('n3', 1, 30, '支え', 'ささえ', 'penopang / dukungan', 'nomina', '家族が支えです。', 'かぞくが ささえです。', 'Keluarga adalah penopang saya.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 2 · 家族・人 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 2, 1, '家族', 'かぞく', 'keluarga', 'nomina', '家族は四人です。', 'かぞくは よにんです。', 'Keluarga saya empat orang.'),
  ('n3', 2, 2, '両親', 'りょうしん', 'orang tua', 'nomina', '両親は元気です。', 'りょうしんは げんきです。', 'Orang tua saya sehat.'),
  ('n3', 2, 3, '兄', 'あに', 'kakak laki-laki', 'nomina', '兄は会社員です。', 'あには かいしゃいんです。', 'Kakak saya pegawai perusahaan.'),
  ('n3', 2, 4, '姉', 'あね', 'kakak perempuan', 'nomina', '姉は看護師です。', 'あねは かんごしです。', 'Kakak saya perawat.'),
  ('n3', 2, 5, '弟', 'おとうと', 'adik laki-laki', 'nomina', '弟は大学生です。', 'おとうとは だいがくせいです。', 'Adik saya mahasiswa.'),
  ('n3', 2, 6, '妹', 'いもうと', 'adik perempuan', 'nomina', '妹は高校生です。', 'いもうとは こうこうせいです。', 'Adik saya siswa SMA.'),
  ('n3', 2, 7, '祖父', 'そふ', 'kakek', 'nomina', '祖父は八十歳です。', 'そふは はちじゅっさいです。', 'Kakek saya delapan puluh tahun.'),
  ('n3', 2, 8, '祖母', 'そぼ', 'nenek', 'nomina', '祖母は料理が上手です。', 'そぼは りょうりが じょうずです。', 'Nenek pandai memasak.'),
  ('n3', 2, 9, '夫', 'おっと', 'suami', 'nomina', '夫は料理を作ります。', 'おっとは りょうりを つくります。', 'Suami saya memasak.'),
  ('n3', 2, 10, '妻', 'つま', 'istri', 'nomina', '妻と旅行します。', 'つまと りょこうします。', 'Saya bepergian dengan istri.'),
  ('n3', 2, 11, '息子', 'むすこ', 'anak laki-laki', 'nomina', '息子は五歳です。', 'むすこは ごさいです。', 'Anak laki-laki saya lima tahun.'),
  ('n3', 2, 12, '娘', 'むすめ', 'anak perempuan', 'nomina', '娘は学校へ行きます。', 'むすめは がっこうへ いきます。', 'Anak perempuan saya pergi ke sekolah.'),
  ('n3', 2, 13, '親戚', 'しんせき', 'kerabat', 'nomina', '親戚が集まりました。', 'しんせきが あつまりました。', 'Kerabat berkumpul.'),
  ('n3', 2, 14, '隣', 'となり', 'sebelah / tetangga', 'nomina', '隣の家は静かです。', 'となりの いえは しずかです。', 'Rumah sebelah tenang.'),
  ('n3', 2, 15, '仲間', 'なかま', 'rekan / teman', 'nomina', '仲間と一緒に働きます。', 'なかまと いっしょに はたらきます。', 'Saya bekerja bersama rekan.'),
  ('n3', 2, 16, '恋人', 'こいびと', 'kekasih', 'nomina', '恋人ができました。', 'こいびとが できました。', 'Saya sekarang punya kekasih.'),
  ('n3', 2, 17, '彼', 'かれ', 'dia (pria)', 'nomina', '彼はエンジニアです。', 'かれは エンジニアです。', 'Dia seorang insinyur.'),
  ('n3', 2, 18, '彼女', 'かのじょ', 'dia (wanita)', 'nomina', '彼女は日本語を教えます。', 'かのじょは にほんごを おしえます。', 'Dia mengajar bahasa Jepang.'),
  ('n3', 2, 19, '大人', 'おとな', 'orang dewasa', 'nomina', '大人も参加できます。', 'おとなも さんかできます。', 'Orang dewasa juga bisa ikut.'),
  ('n3', 2, 20, '子供', 'こども', 'anak', 'nomina', '子供が公園で遊んでいます。', 'こどもが こうえんで あそんでいます。', 'Anak-anak bermain di taman.'),
  ('n3', 2, 21, '男性', 'だんせい', 'pria', 'nomina', '男性の社員が多いです。', 'だんせいの しゃいんが おおいです。', 'Karyawan prianya banyak.'),
  ('n3', 2, 22, '女性', 'じょせい', 'wanita', 'nomina', '女性の医者は増えています。', 'じょせいの いしゃは ふえています。', 'Dokter wanita bertambah.'),
  ('n3', 2, 23, '知り合い', 'しりあい', 'kenalan', 'nomina', '知り合いが札幌にいます。', 'しりあいが さっぽろに います。', 'Saya punya kenalan di Sapporo.'),
  ('n3', 2, 24, '兄弟', 'きょうだい', 'saudara kandung', 'nomina', '兄弟は三人います。', 'きょうだいは さんにん います。', 'Saudara saya tiga orang.'),
  ('n3', 2, 25, '一人暮らし', 'ひとりぐらし', 'tinggal sendiri', 'nomina', '今は一人暮らしです。', 'いまは ひとりぐらしです。', 'Sekarang saya tinggal sendiri.'),
  ('n3', 2, 26, '家庭', 'かてい', 'rumah tangga', 'nomina', '家庭が大事です。', 'かていが だいじです。', 'Rumah tangga itu penting.'),
  ('n3', 2, 27, '双子', 'ふたご', 'kembar', 'nomina', '双子の兄弟です。', 'ふたごの きょうだいです。', 'Saudara kembar.'),
  ('n3', 2, 28, '甥', 'おい', 'keponakan laki-laki', 'nomina', '甥が来ました。', 'おいが きました。', 'Keponakan saya datang.'),
  ('n3', 2, 29, '姪', 'めい', 'keponakan perempuan', 'nomina', '姪は学生です。', 'めいは がくせいです。', 'Keponakan saya seorang pelajar.'),
  ('n3', 2, 30, '家族連れ', 'かぞくづれ', 'rombongan keluarga', 'nomina', '家族連れが多いです。', 'かぞくづれが おおいです。', 'Banyak keluarga yang datang.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 3 · 体・健康 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 3, 1, '体', 'からだ', 'tubuh', 'nomina', '体が疲れました。', 'からだが つかれました。', 'Tubuh saya lelah.'),
  ('n3', 3, 2, '頭', 'あたま', 'kepala', 'nomina', '頭が痛いです。', 'あたまが いたいです。', 'Kepala saya sakit.'),
  ('n3', 3, 3, '顔', 'かお', 'wajah', 'nomina', '顔を洗います。', 'かおを あらいます。', 'Saya mencuci wajah.'),
  ('n3', 3, 4, '目', 'め', 'mata', 'nomina', '目が赤いです。', 'めが あかいです。', 'Mata saya merah.'),
  ('n3', 3, 5, '耳', 'みみ', 'telinga', 'nomina', '耳が痛いです。', 'みみが いたいです。', 'Telinga saya sakit.'),
  ('n3', 3, 6, '口', 'くち', 'mulut', 'nomina', '口を大きく開けてください。', 'くちを おおきく あけてください。', 'Tolong buka mulut lebar-lebar.'),
  ('n3', 3, 7, '手', 'て', 'tangan', 'nomina', '手を洗ってください。', 'てを あらってください。', 'Tolong cuci tangan.'),
  ('n3', 3, 8, '足', 'あし', 'kaki', 'nomina', '足が長いです。', 'あしが ながいです。', 'Kakinya panjang.'),
  ('n3', 3, 9, '指', 'ゆび', 'jari', 'nomina', '指を切りました。', 'ゆびを きりました。', 'Jari saya terpotong.'),
  ('n3', 3, 10, '背', 'せ', 'tinggi badan / punggung', 'nomina', '背が高いですね。', 'せが たかいですね。', 'Badanmu tinggi ya.'),
  ('n3', 3, 11, '熱', 'ねつ', 'demam', 'nomina', '熱があります。', 'ねつが あります。', 'Saya demam.'),
  ('n3', 3, 12, '風邪', 'かぜ', 'masuk angin', 'nomina', '風邪をひきました。', 'かぜを ひきました。', 'Saya masuk angin.'),
  ('n3', 3, 13, '病気', 'びょうき', 'penyakit', 'nomina', '病気で休みました。', 'びょうきで やすみました。', 'Saya libur karena sakit.'),
  ('n3', 3, 14, '怪我', 'けが', 'cedera', 'nomina', '怪我をしました。', 'けがを しました。', 'Saya cedera.'),
  ('n3', 3, 15, '痛み', 'いたみ', 'rasa sakit', 'nomina', '痛みが続きます。', 'いたみが つづきます。', 'Rasa sakitnya berlanjut.'),
  ('n3', 3, 16, '薬', 'くすり', 'obat', 'nomina', '薬を飲みました。', 'くすりを のみました。', 'Saya sudah minum obat.'),
  ('n3', 3, 17, '医者', 'いしゃ', 'dokter', 'nomina', '医者に行きます。', 'いしゃに いきます。', 'Saya pergi ke dokter.'),
  ('n3', 3, 18, '病院', 'びょういん', 'rumah sakit', 'nomina', '病院は駅の前です。', 'びょういんは えきの まえです。', 'Rumah sakit di depan stasiun.'),
  ('n3', 3, 19, '治る', 'なおる', 'sembuh', 'verba', '風邪が治りました。', 'かぜが なおりました。', 'Masuk anginnya sudah sembuh.'),
  ('n3', 3, 20, '眠い', 'ねむい', 'mengantuk', 'adjektiva-i', 'とても眠いです。', 'とても ねむいです。', 'Sangat mengantuk.'),
  ('n3', 3, 21, '疲れる', 'つかれる', 'lelah', 'verba', '仕事で疲れました。', 'しごとで つかれました。', 'Lelah karena kerja.'),
  ('n3', 3, 22, '元気', 'げんき', 'sehat / bersemangat', 'adjektiva-na', '元気になりました。', 'げんきに なりました。', 'Saya sudah sehat.'),
  ('n3', 3, 23, '健康', 'けんこう', 'kesehatan', 'nomina', '健康が一番です。', 'けんこうが いちばんです。', 'Kesehatan itu nomor satu.'),
  ('n3', 3, 24, '運動', 'うんどう', 'olahraga', 'nomina', '毎日運動しています。', 'まいにち うんどうしています。', 'Saya berolahraga tiap hari.'),
  ('n3', 3, 25, '睡眠', 'すいみん', 'tidur', 'nomina', '睡眠が足りません。', 'すいみんが たりません。', 'Tidur saya kurang.'),
  ('n3', 3, 26, '肩', 'かた', 'bahu', 'nomina', '肩が凝ります。', 'かたが こります。', 'Bahu saya pegal.'),
  ('n3', 3, 27, '腰', 'こし', 'pinggang', 'nomina', '腰が痛いです。', 'こしが いたいです。', 'Pinggang saya sakit.'),
  ('n3', 3, 28, '歯', 'は', 'gigi', 'nomina', '歯が痛いです。', 'はが いたいです。', 'Gigi saya sakit.'),
  ('n3', 3, 29, '血', 'ち', 'darah', 'nomina', '血が出ました。', 'ちが でました。', 'Darahnya keluar.'),
  ('n3', 3, 30, '呼吸', 'こきゅう', 'pernapasan', 'nomina', '呼吸が苦しいです。', 'こきゅうが くるしいです。', 'Napas saya sesak.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 4 · 食べ物・味 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 4, 1, '味', 'あじ', 'rasa', 'nomina', '味が濃いです。', 'あじが こいです。', 'Rasanya kuat.'),
  ('n3', 4, 2, '料理', 'りょうり', 'masakan', 'nomina', '料理を作ります。', 'りょうりを つくります。', 'Saya memasak.'),
  ('n3', 4, 3, '食材', 'しょくざい', 'bahan makanan', 'nomina', '食材を買いました。', 'しょくざいを かいました。', 'Saya sudah beli bahan makanan.'),
  ('n3', 4, 4, '肉', 'にく', 'daging', 'nomina', '肉が好きです。', 'にくが すきです。', 'Saya suka daging.'),
  ('n3', 4, 5, '魚', 'さかな', 'ikan', 'nomina', '魚を焼きます。', 'さかなを やきます。', 'Saya membakar ikan.'),
  ('n3', 4, 6, '野菜', 'やさい', 'sayur', 'nomina', '野菜を食べます。', 'やさいを たべます。', 'Saya makan sayur.'),
  ('n3', 4, 7, '果物', 'くだもの', 'buah', 'nomina', '果物は甘いです。', 'くだものは あまいです。', 'Buahnya manis.'),
  ('n3', 4, 8, '米', 'こめ', 'beras', 'nomina', '米を研ぎます。', 'こめを とぎます。', 'Saya mencuci beras.'),
  ('n3', 4, 9, '卵', 'たまご', 'telur', 'nomina', '卵を二つ使います。', 'たまごを ふたつ つかいます。', 'Saya pakai dua telur.'),
  ('n3', 4, 10, '塩', 'しお', 'garam', 'nomina', '塩を少し入れます。', 'しおを すこし いれます。', 'Saya masukkan sedikit garam.'),
  ('n3', 4, 11, '砂糖', 'さとう', 'gula', 'nomina', '砂糖は入れません。', 'さとうは いれません。', 'Gulanya tidak saya masukkan.'),
  ('n3', 4, 12, '油', 'あぶら', 'minyak', 'nomina', '油を熱します。', 'あぶらを ねっします。', 'Saya memanaskan minyak.'),
  ('n3', 4, 13, '味噌', 'みそ', 'miso', 'nomina', '味噌で味付けします。', 'みそで あじつけします。', 'Saya membumbui dengan miso.'),
  ('n3', 4, 14, '醤油', 'しょうゆ', 'kecap asin', 'nomina', '醤油をかけます。', 'しょうゆを かけます。', 'Saya menuang kecap asin.'),
  ('n3', 4, 15, '甘い', 'あまい', 'manis', 'adjektiva-i', 'このケーキは甘いです。', 'この ケーキは あまいです。', 'Kue ini manis.'),
  ('n3', 4, 16, '辛い', 'からい', 'pedas', 'adjektiva-i', 'カレーが辛いです。', 'カレーが からいです。', 'Karinya pedas.'),
  ('n3', 4, 17, '苦い', 'にがい', 'pahit', 'adjektiva-i', 'この薬は苦いです。', 'この くすりは にがいです。', 'Obat ini pahit.'),
  ('n3', 4, 18, '酸っぱい', 'すっぱい', 'asam', 'adjektiva-i', 'レモンは酸っぱいです。', 'レモンは すっぱいです。', 'Lemon itu asam.'),
  ('n3', 4, 19, '焼く', 'やく', 'membakar / memanggang', 'verba', 'パンを焼きます。', 'パンを やきます。', 'Saya memanggang roti.'),
  ('n3', 4, 20, '煮る', 'にる', 'merebus', 'verba', '野菜を煮ます。', 'やさいを にます。', 'Saya merebus sayur.'),
  ('n3', 4, 21, '揚げる', 'あげる', 'menggoreng', 'verba', '天ぷらを揚げます。', 'てんぷらを あげます。', 'Saya menggoreng tempura.'),
  ('n3', 4, 22, '混ぜる', 'まぜる', 'mengaduk', 'verba', 'よく混ぜてください。', 'よく まぜてください。', 'Tolong aduk rata.'),
  ('n3', 4, 23, '食べ過ぎ', 'たべすぎ', 'makan berlebihan', 'nomina', '食べ過ぎました。', 'たべすぎました。', 'Saya makan berlebihan.'),
  ('n3', 4, 24, '空腹', 'くうふく', 'lapar', 'nomina', '空腹で倒れそうです。', 'くうふくで たおれそうです。', 'Karena lapar hampir pingsan.'),
  ('n3', 4, 25, '美味しい', 'おいしい', 'enak', 'adjektiva-i', 'とても美味しいです。', 'とても おいしいです。', 'Sangat enak.'),
  ('n3', 4, 26, '蒸す', 'むす', 'mengukus', 'verba', '野菜を蒸します。', 'やさいを むします。', 'Saya mengukus sayur.'),
  ('n3', 4, 27, 'こしょう', 'こしょう', 'merica', 'nomina', 'こしょうをかけます。', 'こしょうを かけます。', 'Saya menabur merica.'),
  ('n3', 4, 28, 'バター', 'バター', 'mentega', 'nomina', 'バターを塗ります。', 'バターを ぬります。', 'Saya mengoles mentega.'),
  ('n3', 4, 29, 'パン', 'パン', 'roti', 'nomina', 'パンを食べます。', 'パンを たべます。', 'Saya makan roti.'),
  ('n3', 4, 30, '飲み物', 'のみもの', 'minuman', 'nomina', '飲み物は何にしますか。', 'のみものは なんに しますか。', 'Mau minum apa?')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 5 · 買い物・お金 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 5, 1, '値段', 'ねだん', 'harga', 'nomina', '値段が高いです。', 'ねだんが たかいです。', 'Harganya mahal.'),
  ('n3', 5, 2, '料金', 'りょうきん', 'tarif / biaya', 'nomina', '料金を払います。', 'りょうきんを はらいます。', 'Saya membayar biaya.'),
  ('n3', 5, 3, '支払う', 'しはらう', 'membayar', 'verba', 'カードで支払います。', 'カードで しはらいます。', 'Saya membayar dengan kartu.'),
  ('n3', 5, 4, '現金', 'げんきん', 'uang tunai', 'nomina', '現金しか使えません。', 'げんきんしか つかえません。', 'Hanya bisa pakai uang tunai.'),
  ('n3', 5, 5, '割引', 'わりびき', 'diskon', 'nomina', '割引があります。', 'わりびきが あります。', 'Ada diskon.'),
  ('n3', 5, 6, '無料', 'むりょう', 'gratis', 'nomina', '入場は無料です。', 'にゅうじょうは むりょうです。', 'Masuknya gratis.'),
  ('n3', 5, 7, '高い', 'たかい', 'mahal / tinggi', 'adjektiva-i', '少し高いですね。', 'すこし たかいですね。', 'Agak mahal ya.'),
  ('n3', 5, 8, '安い', 'やすい', 'murah', 'adjektiva-i', 'この店は安いです。', 'この みせは やすいです。', 'Toko ini murah.'),
  ('n3', 5, 9, '店', 'みせ', 'toko', 'nomina', '店は十時に開きます。', 'みせは じゅうじに あきます。', 'Tokonya buka jam sepuluh.'),
  ('n3', 5, 10, '商品', 'しょうひん', 'barang dagangan', 'nomina', '商品を選びます。', 'しょうひんを えらびます。', 'Saya memilih barang.'),
  ('n3', 5, 11, '売る', 'うる', 'menjual', 'verba', 'ここで野菜を売ります。', 'ここで やさいを うります。', 'Di sini menjual sayur.'),
  ('n3', 5, 12, '買う', 'かう', 'membeli', 'verba', '牛乳を買います。', 'ぎゅうにゅうを かいます。', 'Saya membeli susu.'),
  ('n3', 5, 13, '返す', 'かえす', 'mengembalikan', 'verba', '本を返しました。', 'ほんを かえしました。', 'Saya sudah mengembalikan buku.'),
  ('n3', 5, 14, '交換', 'こうかん', 'menukar', 'nomina', 'サイズを交換します。', 'サイズを こうかんします。', 'Saya menukar ukurannya.'),
  ('n3', 5, 15, '袋', 'ふくろ', 'kantong', 'nomina', '袋を一枚ください。', 'ふくろを いちまい ください。', 'Minta satu kantong.'),
  ('n3', 5, 16, 'レシート', 'レシート', 'struk', 'nomina', 'レシートをもらいます。', 'レシートを もらいます。', 'Saya menerima struk.'),
  ('n3', 5, 17, '財布', 'さいふ', 'dompet', 'nomina', '財布をなくしました。', 'さいふを なくしました。', 'Dompet saya hilang.'),
  ('n3', 5, 18, '貯金', 'ちょきん', 'tabungan', 'nomina', '少しずつ貯金します。', 'すこしずつ ちょきんします。', 'Saya menabung sedikit-sedikit.'),
  ('n3', 5, 19, '給料', 'きゅうりょう', 'gaji', 'nomina', '給料が入りました。', 'きゅうりょうが はいりました。', 'Gajinya sudah masuk.'),
  ('n3', 5, 20, '借りる', 'かりる', 'meminjam', 'verba', 'お金を借りました。', 'おかねを かりました。', 'Saya meminjam uang.'),
  ('n3', 5, 21, '貸す', 'かす', 'meminjamkan', 'verba', '友達にお金を貸します。', 'ともだちに おかねを かします。', 'Saya meminjamkan uang ke teman.'),
  ('n3', 5, 22, '払う', 'はらう', 'membayar', 'verba', '家賃を払います。', 'やちんを はらいます。', 'Saya membayar sewa.'),
  ('n3', 5, 23, '節約', 'せつやく', 'berhemat', 'nomina', '電気を節約します。', 'でんきを せつやくします。', 'Saya menghemat listrik.'),
  ('n3', 5, 24, 'お釣り', 'おつり', 'uang kembalian', 'nomina', 'お釣りは三百円です。', 'おつりは さんびゃくえんです。', 'Kembaliannya tiga ratus yen.'),
  ('n3', 5, 25, '売り場', 'うりば', 'bagian penjualan', 'nomina', '売り場は三階です。', 'うりばは さんがいです。', 'Bagian penjualannya di lantai tiga.'),
  ('n3', 5, 26, '特売', 'とくばい', 'obral', 'nomina', '今日は特売です。', 'きょうは とくばいです。', 'Hari ini obral.'),
  ('n3', 5, 27, '定価', 'ていか', 'harga resmi', 'nomina', '定価で買います。', 'ていかで かいます。', 'Saya beli dengan harga resmi.'),
  ('n3', 5, 28, '小銭', 'こぜに', 'uang receh', 'nomina', '小銭がありますか。', 'こぜにが ありますか。', 'Ada uang receh?'),
  ('n3', 5, 29, '領収書', 'りょうしゅうしょ', 'kuitansi', 'nomina', '領収書をください。', 'りょうしゅうしょを ください。', 'Minta kuitansinya.'),
  ('n3', 5, 30, '返品', 'へんぴん', 'pengembalian barang', 'nomina', '返品できますか。', 'へんぴん できますか。', 'Bisa dikembalikan?')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 6 · 交通・道 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 6, 1, '電車', 'でんしゃ', 'kereta listrik', 'nomina', '電車で行きます。', 'でんしゃで いきます。', 'Saya pergi naik kereta.'),
  ('n3', 6, 2, '駅', 'えき', 'stasiun', 'nomina', '駅まで歩きます。', 'えきまで あるきます。', 'Saya berjalan sampai stasiun.'),
  ('n3', 6, 3, '切符', 'きっぷ', 'tiket', 'nomina', '切符を買います。', 'きっぷを かいます。', 'Saya membeli tiket.'),
  ('n3', 6, 4, '乗る', 'のる', 'naik (kendaraan)', 'verba', 'バスに乗ります。', 'バスに のります。', 'Saya naik bus.'),
  ('n3', 6, 5, '降りる', 'おりる', 'turun (kendaraan)', 'verba', '次の駅で降ります。', 'つぎの えきで おります。', 'Saya turun di stasiun berikutnya.'),
  ('n3', 6, 6, '乗り換え', 'のりかえ', 'transit / ganti kendaraan', 'nomina', '乗り換えが必要です。', 'のりかえが ひつようです。', 'Perlu transit.'),
  ('n3', 6, 7, '空港', 'くうこう', 'bandara', 'nomina', '空港まで二十分です。', 'くうこうまで にじゅっぷんです。', 'Ke bandara dua puluh menit.'),
  ('n3', 6, 8, '飛行機', 'ひこうき', 'pesawat', 'nomina', '飛行機は飛びました。', 'ひこうきは とびました。', 'Pesawatnya sudah terbang.'),
  ('n3', 6, 9, '車', 'くるま', 'mobil', 'nomina', '車を運転します。', 'くるまを うんてんします。', 'Saya menyetir mobil.'),
  ('n3', 6, 10, '道', 'みち', 'jalan', 'nomina', 'この道は狭いです。', 'この みちは せまいです。', 'Jalan ini sempit.'),
  ('n3', 6, 11, '交差点', 'こうさてん', 'persimpangan', 'nomina', '交差点を右へ曲がります。', 'こうさてんを みぎへ まがります。', 'Belok kanan di persimpangan.'),
  ('n3', 6, 12, '信号', 'しんごう', 'lampu lalu lintas', 'nomina', '信号が赤です。', 'しんごうが あかです。', 'Lampu lalulintasnya merah.'),
  ('n3', 6, 13, '駐車場', 'ちゅうしゃじょう', 'tempat parkir', 'nomina', '駐車場はありません。', 'ちゅうしゃじょうは ありません。', 'Tidak ada tempat parkir.'),
  ('n3', 6, 14, '渋滞', 'じゅうたい', 'macet', 'nomina', '道が渋滞しています。', 'みちが じゅうたいしています。', 'Jalannya macet.'),
  ('n3', 6, 15, '歩道', 'ほどう', 'trotoar', 'nomina', '歩道を歩きます。', 'ほどうを あるきます。', 'Saya berjalan di trotoar.'),
  ('n3', 6, 16, '自転車', 'じてんしゃ', 'sepeda', 'nomina', '自転車で通勤します。', 'じてんしゃで つうきんします。', 'Saya berangkat kerja naik sepeda.'),
  ('n3', 6, 17, '時刻表', 'じこくひょう', 'jadwal keberangkatan', 'nomina', '時刻表を見ます。', 'じこくひょうを みます。', 'Saya melihat jadwal.'),
  ('n3', 6, 18, '遅れる', 'おくれる', 'terlambat', 'verba', '電車が遅れています。', 'でんしゃが おくれています。', 'Keretanya terlambat.'),
  ('n3', 6, 19, '急ぐ', 'いそぐ', 'bergegas', 'verba', '少し急ぎましょう。', 'すこし いそぎましょう。', 'Ayo sedikit bergegas.'),
  ('n3', 6, 20, '向かう', 'むかう', 'menuju', 'verba', '会社へ向かいます。', 'かいしゃへ むかいます。', 'Saya menuju kantor.'),
  ('n3', 6, 21, '曲がる', 'まがる', 'berbelok', 'verba', '角を左に曲がります。', 'かどを ひだりに まがります。', 'Belok kiri di tikungan.'),
  ('n3', 6, 22, '渡る', 'わたる', 'menyeberang', 'verba', '橋を渡ります。', 'はしを わたります。', 'Saya menyeberangi jembatan.'),
  ('n3', 6, 23, '距離', 'きょり', 'jarak', 'nomina', '距離は五キロです。', 'きょりは ごキロです。', 'Jaraknya lima kilometer.'),
  ('n3', 6, 24, '往復', 'おうふく', 'pulang-pergi', 'nomina', '往復で千円です。', 'おうふくで せんえんです。', 'Pulang-pergi seribu yen.'),
  ('n3', 6, 25, '運転', 'うんてん', 'menyetir', 'nomina', '夜は運転しません。', 'よるは うんてんしません。', 'Malam saya tidak menyetir.'),
  ('n3', 6, 26, '新幹線', 'しんかんせん', 'shinkansen', 'nomina', '新幹線で行きます。', 'しんかんせんで いきます。', 'Saya pergi naik shinkansen.'),
  ('n3', 6, 27, '地下鉄', 'ちかてつ', 'kereta bawah tanah', 'nomina', '地下鉄に乗ります。', 'ちかてつに のります。', 'Saya naik subway.'),
  ('n3', 6, 28, '定期券', 'ていきけん', 'tiket langganan', 'nomina', '定期券を買います。', 'ていきけんを かいます。', 'Saya membeli tiket langganan.'),
  ('n3', 6, 29, '座席', 'ざせき', 'kursi', 'nomina', '座席を予約します。', 'ざせきを よやくします。', 'Saya memesan kursi.'),
  ('n3', 6, 30, '満員', 'まんいん', 'penuh (orang)', 'nomina', '電車が満員です。', 'でんしゃが まんいんです。', 'Keretanya penuh.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 7 · 住まい・部屋 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 7, 1, '家', 'いえ', 'rumah', 'nomina', '家に帰ります。', 'いえに かえります。', 'Saya pulang ke rumah.'),
  ('n3', 7, 2, '部屋', 'へや', 'kamar', 'nomina', '部屋が広いです。', 'へやが ひろいです。', 'Kamarnya luas.'),
  ('n3', 7, 3, '台所', 'だいどころ', 'dapur', 'nomina', '台所は狭いです。', 'だいどころは せまいです。', 'Dapurnya sempit.'),
  ('n3', 7, 4, '風呂', 'ふろ', 'bak mandi', 'nomina', '風呂に入ります。', 'ふろに はいります。', 'Saya berendam.'),
  ('n3', 7, 5, '玄関', 'げんかん', 'pintu masuk', 'nomina', '玄関に靴があります。', 'げんかんに くつが あります。', 'Ada sepatu di pintu masuk.'),
  ('n3', 7, 6, '窓', 'まど', 'jendela', 'nomina', '窓を開けます。', 'まどを あけます。', 'Saya membuka jendela.'),
  ('n3', 7, 7, '壁', 'かべ', 'dinding', 'nomina', '壁が白いです。', 'かべが しろいです。', 'Dindingnya putih.'),
  ('n3', 7, 8, '床', 'ゆか', 'lantai', 'nomina', '床を掃除します。', 'ゆかを そうじします。', 'Saya menyapu lantai.'),
  ('n3', 7, 9, '天井', 'てんじょう', 'langit-langit', 'nomina', '天井が高いです。', 'てんじょうが たかいです。', 'Langit-langitnya tinggi.'),
  ('n3', 7, 10, '階段', 'かいだん', 'tangga', 'nomina', '階段を上ります。', 'かいだんを のぼります。', 'Saya menaiki tangga.'),
  ('n3', 7, 11, '鍵', 'かぎ', 'kunci', 'nomina', '鍵をかけてください。', 'かぎを かけてください。', 'Tolong kuncinya dipasang.'),
  ('n3', 7, 12, '電気', 'でんき', 'listrik / lampu', 'nomina', '電気を消します。', 'でんきを けします。', 'Saya mematikan lampu.'),
  ('n3', 7, 13, '水道', 'すいどう', 'air ledeng', 'nomina', '水道の水は冷たいです。', 'すいどうの みずは つめたいです。', 'Air keran dingin.'),
  ('n3', 7, 14, '家具', 'かぐ', 'perabot', 'nomina', '家具を買いました。', 'かぐを かいました。', 'Saya sudah beli perabot.'),
  ('n3', 7, 15, '押し入れ', 'おしいれ', 'lemari dinding', 'nomina', '押し入れに布団があります。', 'おしいれに ふとんが あります。', 'Ada futon di lemari dinding.'),
  ('n3', 7, 16, '洗濯', 'せんたく', 'mencuci (pakaian)', 'nomina', '洗濯をします。', 'せんたくを します。', 'Saya mencuci pakaian.'),
  ('n3', 7, 17, '掃除', 'そうじ', 'membersihkan', 'nomina', '部屋を掃除します。', 'へやを そうじします。', 'Saya membersihkan kamar.'),
  ('n3', 7, 18, '引っ越す', 'ひっこす', 'pindah rumah', 'verba', '来月引っ越します。', 'らいげつ ひっこします。', 'Bulan depan saya pindah.'),
  ('n3', 7, 19, '家賃', 'やちん', 'uang sewa', 'nomina', '家賃が高いです。', 'やちんが たかいです。', 'Sewa rumahnya mahal.'),
  ('n3', 7, 20, '近所', 'きんじょ', 'lingkungan sekitar', 'nomina', '近所に店があります。', 'きんじょに みせが あります。', 'Ada toko di sekitar sini.'),
  ('n3', 7, 21, '住む', 'すむ', 'tinggal', 'verba', '紋別に住んでいます。', 'もんべつに すんでいます。', 'Saya tinggal di Mombetsu.'),
  ('n3', 7, 22, '広い', 'ひろい', 'luas', 'adjektiva-i', 'この家は広いです。', 'この いえは ひろいです。', 'Rumah ini luas.'),
  ('n3', 7, 23, '狭い', 'せまい', 'sempit', 'adjektiva-i', '部屋が狭いです。', 'へやが せまいです。', 'Kamarnya sempit.'),
  ('n3', 7, 24, '綺麗', 'きれい', 'bersih / indah', 'adjektiva-na', '部屋が綺麗です。', 'へやが きれいです。', 'Kamarnya bersih.'),
  ('n3', 7, 25, '静か', 'しずか', 'tenang', 'adjektiva-na', '夜は静かです。', 'よるは しずかです。', 'Malamnya tenang.'),
  ('n3', 7, 26, '庭', 'にわ', 'halaman', 'nomina', '庭があります。', 'にわが あります。', 'Ada halaman.'),
  ('n3', 7, 27, '屋根', 'やね', 'atap', 'nomina', '屋根が赤いです。', 'やねが あかいです。', 'Atapnya merah.'),
  ('n3', 7, 28, '冷蔵庫', 'れいぞうこ', 'kulkas', 'nomina', '冷蔵庫に入れます。', 'れいぞうこに いれます。', 'Saya taruh di kulkas.'),
  ('n3', 7, 29, '洗面所', 'せんめんじょ', 'wastafel', 'nomina', '洗面所はどこですか。', 'せんめんじょは どこですか。', 'Wastafelnya di mana?'),
  ('n3', 7, 30, '照明', 'しょうめい', 'lampu penerangan', 'nomina', '照明を変えます。', 'しょうめいを かえます。', 'Saya mengganti lampunya.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 8 · 仕事・会社 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 8, 1, '仕事', 'しごと', 'pekerjaan', 'nomina', '仕事が忙しいです。', 'しごとが いそがしいです。', 'Pekerjaannya sibuk.'),
  ('n3', 8, 2, '会社', 'かいしゃ', 'perusahaan', 'nomina', '会社は駅の近くです。', 'かいしゃは えきの ちかくです。', 'Kantornya dekat stasiun.'),
  ('n3', 8, 3, '社員', 'しゃいん', 'karyawan', 'nomina', '社員が百人います。', 'しゃいんが ひゃくにん います。', 'Karyawannya seratus orang.'),
  ('n3', 8, 4, '上司', 'じょうし', 'atasan', 'nomina', '上司に相談します。', 'じょうしに そうだんします。', 'Saya konsultasi ke atasan.'),
  ('n3', 8, 5, '同僚', 'どうりょう', 'rekan kerja', 'nomina', '同僚と昼ご飯を食べます。', 'どうりょうと ひるごはんを たべます。', 'Saya makan siang dengan rekan kerja.'),
  ('n3', 8, 6, '会議', 'かいぎ', 'rapat', 'nomina', '会議は三時からです。', 'かいぎは さんじからです。', 'Rapat mulai jam tiga.'),
  ('n3', 8, 7, '出張', 'しゅっちょう', 'perjalanan dinas', 'nomina', '来週出張します。', 'らいしゅう しゅっちょうします。', 'Minggu depan saya dinas luar.'),
  ('n3', 8, 8, '残業', 'ざんぎょう', 'lembur', 'nomina', '今日は残業します。', 'きょうは ざんぎょうします。', 'Hari ini saya lembur.'),
  ('n3', 8, 9, '休み', 'やすみ', 'libur', 'nomina', '明日は休みです。', 'あしたは やすみです。', 'Besok libur.'),
  ('n3', 8, 10, '勤める', 'つとめる', 'bekerja di', 'verba', '銀行に勤めています。', 'ぎんこうに つとめています。', 'Saya bekerja di bank.'),
  ('n3', 8, 11, '営業', 'えいぎょう', 'pemasaran', 'nomina', '営業の仕事をしています。', 'えいぎょうの しごとを しています。', 'Saya kerja di bagian pemasaran.'),
  ('n3', 8, 12, '面接', 'めんせつ', 'wawancara kerja', 'nomina', '面接に行きます。', 'めんせつに いきます。', 'Saya pergi wawancara.'),
  ('n3', 8, 13, '契約', 'けいやく', 'kontrak', 'nomina', '契約を結びます。', 'けいやくを むすびます。', 'Saya membuat kontrak.'),
  ('n3', 8, 14, '報告', 'ほうこく', 'laporan', 'nomina', '結果を報告します。', 'けっかを ほうこくします。', 'Saya melaporkan hasilnya.'),
  ('n3', 8, 15, '依頼', 'いらい', 'permintaan', 'nomina', '仕事を依頼しました。', 'しごとを いらいしました。', 'Saya meminta pekerjaan.'),
  ('n3', 8, 16, '締め切り', 'しめきり', 'tenggat', 'nomina', '締め切りは金曜日です。', 'しめきりは きんようびです。', 'Tenggatnya hari Jumat.'),
  ('n3', 8, 17, '時給', 'じきゅう', 'upah per jam', 'nomina', '時給は千円です。', 'じきゅうは せんえんです。', 'Upah per jamnya seribu yen.'),
  ('n3', 8, 18, '部署', 'ぶしょ', 'divisi', 'nomina', '部署が変わりました。', 'ぶしょが かわりました。', 'Divisi saya berubah.'),
  ('n3', 8, 19, '名刺', 'めいし', 'kartu nama', 'nomina', '名刺を渡します。', 'めいしを わたします。', 'Saya menyerahkan kartu nama.'),
  ('n3', 8, 20, '電話', 'でんわ', 'telepon', 'nomina', '電話をかけます。', 'でんわを かけます。', 'Saya menelepon.'),
  ('n3', 8, 21, '資料', 'しりょう', 'dokumen / bahan', 'nomina', '資料を準備します。', 'しりょうを じゅんびします。', 'Saya menyiapkan dokumen.'),
  ('n3', 8, 22, '遅刻', 'ちこく', 'terlambat masuk', 'nomina', '遅刻しません。', 'ちこくしません。', 'Saya tidak terlambat.'),
  ('n3', 8, 23, '真面目', 'まじめ', 'rajin / serius', 'adjektiva-na', '彼は真面目です。', 'かれは まじめです。', 'Dia orangnya serius.'),
  ('n3', 8, 24, '忙しい', 'いそがしい', 'sibuk', 'adjektiva-i', '今週は忙しいです。', 'こんしゅうは いそがしいです。', 'Minggu ini sibuk.'),
  ('n3', 8, 25, '辞める', 'やめる', 'berhenti (kerja)', 'verba', '来月辞めます。', 'らいげつ やめます。', 'Bulan depan saya berhenti.'),
  ('n3', 8, 26, '就職', 'しゅうしょく', 'mendapat pekerjaan', 'nomina', '就職しました。', 'しゅうしょくしました。', 'Saya sudah dapat kerja.'),
  ('n3', 8, 27, '転職', 'てんしょく', 'pindah kerja', 'nomina', '転職を考えています。', 'てんしょくを かんがえています。', 'Saya mempertimbangkan pindah kerja.'),
  ('n3', 8, 28, '昇給', 'しょうきゅう', 'kenaikan gaji', 'nomina', '昇給しました。', 'しょうきゅうしました。', 'Gaji saya naik.'),
  ('n3', 8, 29, '研修', 'けんしゅう', 'pelatihan kerja', 'nomina', '研修を受けます。', 'けんしゅうを うけます。', 'Saya ikut pelatihan.'),
  ('n3', 8, 30, '職場', 'しょくば', 'tempat kerja', 'nomina', '職場が遠いです。', 'しょくばが とおいです。', 'Tempat kerjanya jauh.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 9 · 学校・勉強 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 9, 1, '学校', 'がっこう', 'sekolah', 'nomina', '学校は八時に始まります。', 'がっこうは はちじに はじまります。', 'Sekolah mulai jam delapan.'),
  ('n3', 9, 2, '授業', 'じゅぎょう', 'pelajaran', 'nomina', '授業が長いです。', 'じゅぎょうが ながいです。', 'Pelajaranannya lama.'),
  ('n3', 9, 3, '宿題', 'しゅくだい', 'pekerjaan rumah', 'nomina', '宿題をします。', 'しゅくだいを します。', 'Saya mengerjakan PR.'),
  ('n3', 9, 4, '試験', 'しけん', 'ujian', 'nomina', '試験は来週です。', 'しけんは らいしゅうです。', 'Ujiannya minggu depan.'),
  ('n3', 9, 5, '合格', 'ごうかく', 'lulus (ujian)', 'nomina', '試験に合格しました。', 'しけんに ごうかくしました。', 'Saya lulus ujian.'),
  ('n3', 9, 6, '先生', 'せんせい', 'guru', 'nomina', '先生に質問します。', 'せんせいに しつもんします。', 'Saya bertanya ke guru.'),
  ('n3', 9, 7, '生徒', 'せいと', 'murid', 'nomina', '生徒が三十人います。', 'せいとが さんじゅうにん います。', 'Muridnya tiga puluh orang.'),
  ('n3', 9, 8, '教室', 'きょうしつ', 'ruang kelas', 'nomina', '教室は二階です。', 'きょうしつは にかいです。', 'Ruang kelasnya di lantai dua.'),
  ('n3', 9, 9, '図書館', 'としょかん', 'perpustakaan', 'nomina', '図書館で勉強します。', 'としょかんで べんきょうします。', 'Saya belajar di perpustakaan.'),
  ('n3', 9, 10, '教科書', 'きょうかしょ', 'buku pelajaran', 'nomina', '教科書を忘れました。', 'きょうかしょを わすれました。', 'Saya lupa buku pelajaran.'),
  ('n3', 9, 11, '練習', 'れんしゅう', 'latihan', 'nomina', '毎日練習します。', 'まいにち れんしゅうします。', 'Saya latihan tiap hari.'),
  ('n3', 9, 12, '質問', 'しつもん', 'pertanyaan', 'nomina', '質問があります。', 'しつもんが あります。', 'Saya ada pertanyaan.'),
  ('n3', 9, 13, '覚える', 'おぼえる', 'mengingat / menghafal', 'verba', '漢字を覚えます。', 'かんじを おぼえます。', 'Saya menghafal kanji.'),
  ('n3', 9, 14, '忘れる', 'わすれる', 'lupa', 'verba', '名前を忘れました。', 'なまえを わすれました。', 'Saya lupa namanya.'),
  ('n3', 9, 15, '教える', 'おしえる', 'mengajar', 'verba', '日本語を教えます。', 'にほんごを おしえます。', 'Saya mengajar bahasa Jepang.'),
  ('n3', 9, 16, '習う', 'ならう', 'belajar (dari guru)', 'verba', 'ピアノを習っています。', 'ピアノを ならっています。', 'Saya belajar piano.'),
  ('n3', 9, 17, '復習', 'ふくしゅう', 'mengulang pelajaran', 'nomina', '復習が大切です。', 'ふくしゅうが たいせつです。', 'Mengulang pelajaran itu penting.'),
  ('n3', 9, 18, '予習', 'よしゅう', 'belajar sebelum kelas', 'nomina', '予習をします。', 'よしゅうを します。', 'Saya belajar sebelum kelas.'),
  ('n3', 9, 19, '成績', 'せいせき', 'nilai (sekolah)', 'nomina', '成績が上がりました。', 'せいせきが あがりました。', 'Nilai saya naik.'),
  ('n3', 9, 20, '卒業', 'そつぎょう', 'lulus sekolah', 'nomina', '来年卒業します。', 'らいねん そつぎょうします。', 'Tahun depan saya lulus.'),
  ('n3', 9, 21, '入学', 'にゅうがく', 'masuk sekolah', 'nomina', '四月に入学します。', 'しがつに にゅうがくします。', 'Saya masuk sekolah bulan April.'),
  ('n3', 9, 22, '作文', 'さくぶん', 'karangan', 'nomina', '作文を書きます。', 'さくぶんを かきます。', 'Saya menulis karangan.'),
  ('n3', 9, 23, '発音', 'はつおん', 'pelafalan', 'nomina', '発音が難しいです。', 'はつおんが むずかしいです。', 'Pelafalannya sulit.'),
  ('n3', 9, 24, '辞書', 'じしょ', 'kamus', 'nomina', '辞書で調べます。', 'じしょで しらべます。', 'Saya mencari di kamus.'),
  ('n3', 9, 25, '間違える', 'まちがえる', 'salah / keliru', 'verba', '漢字を間違えました。', 'かんじを まちがえました。', 'Saya salah menulis kanji.'),
  ('n3', 9, 26, '出席', 'しゅっせき', 'kehadiran', 'nomina', '出席を取ります。', 'しゅっせきを とります。', 'Saya mengambil absen.'),
  ('n3', 9, 27, '欠席', 'けっせき', 'tidak hadir', 'nomina', '欠席しました。', 'けっせきしました。', 'Saya tidak masuk.'),
  ('n3', 9, 28, '黒板', 'こくばん', 'papan tulis', 'nomina', '黒板を見ます。', 'こくばんを みます。', 'Saya melihat papan tulis.'),
  ('n3', 9, 29, '鉛筆', 'えんぴつ', 'pensil', 'nomina', '鉛筆で書きます。', 'えんぴつで かきます。', 'Saya menulis dengan pensil.'),
  ('n3', 9, 30, '進学', 'しんがく', 'melanjutkan sekolah', 'nomina', '進学します。', 'しんがくします。', 'Saya melanjutkan sekolah.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 10 · 天気・自然 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 10, 1, '天気', 'てんき', 'cuaca', 'nomina', '天気がいいです。', 'てんきが いいです。', 'Cuacanya bagus.'),
  ('n3', 10, 2, '晴れ', 'はれ', 'cerah', 'nomina', '明日は晴れです。', 'あしたは はれです。', 'Besok cerah.'),
  ('n3', 10, 3, '曇り', 'くもり', 'berawan', 'nomina', '今日は曇りです。', 'きょうは くもりです。', 'Hari ini berawan.'),
  ('n3', 10, 4, '雨', 'あめ', 'hujan', 'nomina', '雨が降っています。', 'あめが ふっています。', 'Sedang hujan.'),
  ('n3', 10, 5, '雪', 'ゆき', 'salju', 'nomina', '雪が降りました。', 'ゆきが ふりました。', 'Salju turun.'),
  ('n3', 10, 6, '風', 'かぜ', 'angin', 'nomina', '風が強いです。', 'かぜが つよいです。', 'Anginnya kencang.'),
  ('n3', 10, 7, '台風', 'たいふう', 'topan', 'nomina', '台風が来ます。', 'たいふうが きます。', 'Topan akan datang.'),
  ('n3', 10, 8, '気温', 'きおん', 'suhu udara', 'nomina', '気温が下がりました。', 'きおんが さがりました。', 'Suhunya turun.'),
  ('n3', 10, 9, '暑い', 'あつい', 'panas', 'adjektiva-i', '今日は暑いです。', 'きょうは あついです。', 'Hari ini panas.'),
  ('n3', 10, 10, '寒い', 'さむい', 'dingin', 'adjektiva-i', '北海道は寒いです。', 'ほっかいどうは さむいです。', 'Hokkaido dingin.'),
  ('n3', 10, 11, '涼しい', 'すずしい', 'sejuk', 'adjektiva-i', '朝は涼しいです。', 'あさは すずしいです。', 'Paginya sejuk.'),
  ('n3', 10, 12, '暖かい', 'あたたかい', 'hangat', 'adjektiva-i', '春は暖かいです。', 'はるは あたたかいです。', 'Musim semi hangat.'),
  ('n3', 10, 13, '空', 'そら', 'langit', 'nomina', '空が青いです。', 'そらが あおいです。', 'Langitnya biru.'),
  ('n3', 10, 14, '海', 'うみ', 'laut', 'nomina', '海が見えます。', 'うみが みえます。', 'Lautnya terlihat.'),
  ('n3', 10, 15, '山', 'やま', 'gunung', 'nomina', '山に登ります。', 'やまに のぼります。', 'Saya mendaki gunung.'),
  ('n3', 10, 16, '川', 'かわ', 'sungai', 'nomina', '川で遊びます。', 'かわで あそびます。', 'Saya bermain di sungai.'),
  ('n3', 10, 17, '森', 'もり', 'hutan', 'nomina', '森は静かです。', 'もりは しずかです。', 'Hutannya tenang.'),
  ('n3', 10, 18, '花', 'はな', 'bunga', 'nomina', '花が咲きました。', 'はなが さきました。', 'Bunganya bermekaran.'),
  ('n3', 10, 19, '木', 'き', 'pohon', 'nomina', '木が高いです。', 'きが たかいです。', 'Pohonnya tinggi.'),
  ('n3', 10, 20, '石', 'いし', 'batu', 'nomina', '石が落ちています。', 'いしが おちています。', 'Ada batu jatuh.'),
  ('n3', 10, 21, '星', 'ほし', 'bintang', 'nomina', '星がきれいです。', 'ほしが きれいです。', 'Bintangnya indah.'),
  ('n3', 10, 22, '月', 'つき', 'bulan', 'nomina', '月が明るいです。', 'つきが あかるいです。', 'Bulannya terang.'),
  ('n3', 10, 23, '地震', 'じしん', 'gempa bumi', 'nomina', '地震がありました。', 'じしんが ありました。', 'Ada gempa.'),
  ('n3', 10, 24, '自然', 'しぜん', 'alam', 'nomina', '自然が豊かです。', 'しぜんが ゆたかです。', 'Alamnya kaya.'),
  ('n3', 10, 25, '季節', 'きせつ', 'musim', 'nomina', '好きな季節は春です。', 'すきな きせつは はるです。', 'Musim favorit saya semi.'),
  ('n3', 10, 26, '雷', 'かみなり', 'petir', 'nomina', '雷が鳴っています。', 'かみなりが なっています。', 'Petirnya berbunyi.'),
  ('n3', 10, 27, '虹', 'にじ', 'pelangi', 'nomina', '虹が出ました。', 'にじが でました。', 'Pelangi muncul.'),
  ('n3', 10, 28, '霧', 'きり', 'kabut', 'nomina', '霧が濃いです。', 'きりが こいです。', 'Kabutnya tebal.'),
  ('n3', 10, 29, '洪水', 'こうずい', 'banjir', 'nomina', '洪水がありました。', 'こうずいが ありました。', 'Terjadi banjir.'),
  ('n3', 10, 30, '火山', 'かざん', 'gunung berapi', 'nomina', '火山が見えます。', 'かざんが みえます。', 'Gunung berapi terlihat.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 11 · 感情・性格 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 11, 1, '感情', 'かんじょう', 'emosi', 'nomina', '感情を表します。', 'かんじょうを あらわします。', 'Saya mengungkapkan emosi.'),
  ('n3', 11, 2, '嬉しい', 'うれしい', 'senang', 'adjektiva-i', 'とても嬉しいです。', 'とても うれしいです。', 'Saya sangat senang.'),
  ('n3', 11, 3, '悲しい', 'かなしい', 'sedih', 'adjektiva-i', '少し悲しいです。', 'すこし かなしいです。', 'Sedikit sedih.'),
  ('n3', 11, 4, '寂しい', 'さびしい', 'kesepian', 'adjektiva-i', '一人で寂しいです。', 'ひとりで さびしいです。', 'Sendirian itu sepi.'),
  ('n3', 11, 5, '怖い', 'こわい', 'takut', 'adjektiva-i', '暗いのは怖いです。', 'くらいのは こわいです。', 'Gelap itu menakutkan.'),
  ('n3', 11, 6, '心配', 'しんぱい', 'khawatir', 'nomina', '心配しないでください。', 'しんぱいしないでください。', 'Jangan khawatir.'),
  ('n3', 11, 7, '驚く', 'おどろく', 'terkejut', 'verba', '値段に驚きました。', 'ねだんに おどろきました。', 'Saya terkejut harganya.'),
  ('n3', 11, 8, '怒る', 'おこる', 'marah', 'verba', '上司が怒りました。', 'じょうしが おこりました。', 'Atasan saya marah.'),
  ('n3', 11, 9, '笑う', 'わらう', 'tertawa', 'verba', 'みんな笑いました。', 'みんな わらいました。', 'Semua tertawa.'),
  ('n3', 11, 10, '泣く', 'なく', 'menangis', 'verba', '子供が泣いています。', 'こどもが ないています。', 'Anaknya menangis.'),
  ('n3', 11, 11, '好き', 'すき', 'suka', 'adjektiva-na', '猫が好きです。', 'ねこが すきです。', 'Saya suka kucing.'),
  ('n3', 11, 12, '嫌い', 'きらい', 'tidak suka', 'adjektiva-na', '雨が嫌いです。', 'あめが きらいです。', 'Saya tidak suka hujan.'),
  ('n3', 11, 13, '恥ずかしい', 'はずかしい', 'malu', 'adjektiva-i', '少し恥ずかしいです。', 'すこし はずかしいです。', 'Sedikit malu.'),
  ('n3', 11, 14, '優しい', 'やさしい', 'baik hati', 'adjektiva-i', '優しい人です。', 'やさしい ひとです。', 'Dia orang yang baik.'),
  ('n3', 11, 15, '厳しい', 'きびしい', 'keras / tegas', 'adjektiva-i', '先生は厳しいです。', 'せんせいは きびしいです。', 'Gurunya tegas.'),
  ('n3', 11, 16, '面白い', 'おもしろい', 'menarik / lucu', 'adjektiva-i', 'この本は面白いです。', 'この ほんは おもしろいです。', 'Buku ini menarik.'),
  ('n3', 11, 17, 'つまらない', 'つまらない', 'membosankan', 'adjektiva-i', '映画はつまらないです。', 'えいがは つまらないです。', 'Filmnya membosankan.'),
  ('n3', 11, 18, '緊張', 'きんちょう', 'tegang', 'nomina', '面接で緊張しました。', 'めんせつで きんちょうしました。', 'Saya tegang saat wawancara.'),
  ('n3', 11, 19, '満足', 'まんぞく', 'puas', 'nomina', '結果に満足です。', 'けっかに まんぞくです。', 'Saya puas dengan hasilnya.'),
  ('n3', 11, 20, '後悔', 'こうかい', 'penyesalan', 'nomina', '後悔しました。', 'こうかいしました。', 'Saya menyesal.'),
  ('n3', 11, 21, '熱心', 'ねっしん', 'rajin / bersemangat', 'adjektiva-na', '熱心に勉強します。', 'ねっしんに べんきょうします。', 'Saya belajar dengan rajin.'),
  ('n3', 11, 22, '大人しい', 'おとなしい', 'pendiam', 'adjektiva-i', '彼は大人しいです。', 'かれは おとなしいです。', 'Dia pendiam.'),
  ('n3', 11, 23, '明るい', 'あかるい', 'ceria', 'adjektiva-i', '明るい性格です。', 'あかるい せいかくです。', 'Sifatnya ceria.'),
  ('n3', 11, 24, '親切', 'しんせつ', 'ramah', 'adjektiva-na', '親切な人です。', 'しんせつな ひとです。', 'Dia orang yang ramah.'),
  ('n3', 11, 25, '落ち着く', 'おちつく', 'tenang / rileks', 'verba', '少し落ち着きました。', 'すこし おちつきました。', 'Saya sedikit tenang.'),
  ('n3', 11, 26, '不安', 'ふあん', 'gelisah', 'adjektiva-na', '不安になります。', 'ふあんに なります。', 'Saya jadi gelisah.'),
  ('n3', 11, 27, '興奮', 'こうふん', 'terangsang / bersemangat', 'nomina', '少し興奮しています。', 'すこし こうふんしています。', 'Dia agak bersemangat.'),
  ('n3', 11, 28, '感動', 'かんどう', 'terharu', 'nomina', 'とても感動しました。', 'とても かんどうしました。', 'Saya sangat terharu.'),
  ('n3', 11, 29, '羨ましい', 'うらやましい', 'iri', 'adjektiva-i', '少し羨ましいです。', 'すこし うらやましいです。', 'Sedikit iri.'),
  ('n3', 11, 30, '悔しい', 'くやしい', 'kesal / menyesal', 'adjektiva-i', 'とても悔しいです。', 'とても くやしいです。', 'Sangat kesal.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 12 · 時間・予定 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 12, 1, '時間', 'じかん', 'waktu', 'nomina', '時間がありません。', 'じかんが ありません。', 'Saya tidak punya waktu.'),
  ('n3', 12, 2, '予定', 'よてい', 'rencana', 'nomina', '週末の予定はありますか。', 'しゅうまつの よていは ありますか。', 'Akhir pekan ada rencana?'),
  ('n3', 12, 3, '予約', 'よやく', 'reservasi', 'nomina', '席を予約します。', 'せきを よやくします。', 'Saya memesan tempat.'),
  ('n3', 12, 4, '今日', 'きょう', 'hari ini', 'nomina', '今日は休みです。', 'きょうは やすみです。', 'Hari ini libur.'),
  ('n3', 12, 5, '明日', 'あした', 'besok', 'nomina', '明日会いましょう。', 'あした あいましょう。', 'Ayo bertemu besok.'),
  ('n3', 12, 6, '昨日', 'きのう', 'kemarin', 'nomina', '昨日は雨でした。', 'きのうは あめでした。', 'Kemarin hujan.'),
  ('n3', 12, 7, '今週', 'こんしゅう', 'minggu ini', 'nomina', '今週は忙しいです。', 'こんしゅうは いそがしいです。', 'Minggu ini sibuk.'),
  ('n3', 12, 8, '来月', 'らいげつ', 'bulan depan', 'nomina', '来月旅行します。', 'らいげつ りょこうします。', 'Bulan depan saya pergi.'),
  ('n3', 12, 9, '去年', 'きょねん', 'tahun lalu', 'nomina', '去年日本へ来ました。', 'きょねん にほんへ きました。', 'Tahun lalu saya datang ke Jepang.'),
  ('n3', 12, 10, '最近', 'さいきん', 'akhir-akhir ini', 'nomina', '最近寒いです。', 'さいきん さむいです。', 'Akhir-akhir ini dingin.'),
  ('n3', 12, 11, '将来', 'しょうらい', 'masa depan', 'nomina', '将来は日本で働きたいです。', 'しょうらいは にほんで はたらきたいです。', 'Nanti saya ingin kerja di Jepang.'),
  ('n3', 12, 12, '途中', 'とちゅう', 'di tengah jalan', 'nomina', '途中で休みます。', 'とちゅうで やすみます。', 'Saya istirahat di tengah jalan.'),
  ('n3', 12, 13, '期間', 'きかん', 'periode', 'nomina', '期間は二週間です。', 'きかんは にしゅうかんです。', 'Periodenya dua minggu.'),
  ('n3', 12, 14, '期限', 'きげん', 'batas waktu', 'nomina', '期限は明日です。', 'きげんは あしたです。', 'Batas waktunya besok.'),
  ('n3', 12, 15, '早い', 'はやい', 'cepat / awal', 'adjektiva-i', '今日は早いですね。', 'きょうは はやいですね。', 'Hari ini cepat ya.'),
  ('n3', 12, 16, '遅い', 'おそい', 'lambat', 'adjektiva-i', 'バスが遅いです。', 'バスが おそいです。', 'Busnya lambat.'),
  ('n3', 12, 17, '急に', 'きゅうに', 'tiba-tiba', 'adverbia', '急に雨が降りました。', 'きゅうに あめが ふりました。', 'Tiba-tiba hujan turun.'),
  ('n3', 12, 18, 'ずっと', 'ずっと', 'terus-menerus', 'adverbia', 'ずっと待っています。', 'ずっと まっています。', 'Saya menunggu terus.'),
  ('n3', 12, 19, 'もうすぐ', 'もうすぐ', 'sebentar lagi', 'adverbia', 'もうすぐ春です。', 'もうすぐ はるです。', 'Sebentar lagi musim semi.'),
  ('n3', 12, 20, 'しばらく', 'しばらく', 'sementara', 'adverbia', 'しばらく休みます。', 'しばらく やすみます。', 'Saya istirahat sebentar.'),
  ('n3', 12, 21, 'まず', 'まず', 'pertama-tama', 'adverbia', 'まず手を洗います。', 'まず てを あらいます。', 'Pertama, cuci tangan.'),
  ('n3', 12, 22, 'つぎに', 'つぎに', 'selanjutnya', 'adverbia', 'つぎに野菜を切ります。', 'つぎに やさいを きります。', 'Selanjutnya memotong sayur.'),
  ('n3', 12, 23, '最後に', 'さいごに', 'terakhir', 'adverbia', '最後に塩を入れます。', 'さいごに しおを いれます。', 'Terakhir, masukkan garam.'),
  ('n3', 12, 24, '毎週', 'まいしゅう', 'tiap minggu', 'nomina', '毎週映画を見ます。', 'まいしゅう えいがを みます。', 'Tiap minggu saya menonton film.'),
  ('n3', 12, 25, '一日中', 'いちにちじゅう', 'sepanjang hari', 'nomina', '一日中働きました。', 'いちにちじゅう はたらきました。', 'Saya bekerja sepanjang hari.'),
  ('n3', 12, 26, '明後日', 'あさって', 'lusa', 'nomina', '明後日会います。', 'あさって あいます。', 'Kita bertemu lusa.'),
  ('n3', 12, 27, '一昨日', 'おととい', 'kemarin lusa', 'nomina', '一昨日来ました。', 'おととい きました。', 'Dia datang kemarin lusa.'),
  ('n3', 12, 28, '毎月', 'まいつき', 'tiap bulan', 'nomina', '毎月払います。', 'まいつき はらいます。', 'Saya bayar tiap bulan.'),
  ('n3', 12, 29, '毎年', 'まいとし', 'tiap tahun', 'nomina', '毎年旅行します。', 'まいとし りょこうします。', 'Tiap tahun saya pergi.'),
  ('n3', 12, 30, '年末', 'ねんまつ', 'akhir tahun', 'nomina', '年末は忙しいです。', 'ねんまつは いそがしいです。', 'Akhir tahun sibuk.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 13 · 機械・通信 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 13, 1, '携帯', 'けいたい', 'ponsel', 'nomina', '携帯を忘れました。', 'けいたいを わすれました。', 'Saya lupa ponsel.'),
  ('n3', 13, 2, 'メール', 'メール', 'surel', 'nomina', 'メールを送ります。', 'メールを おくります。', 'Saya mengirim surel.'),
  ('n3', 13, 3, '機械', 'きかい', 'mesin', 'nomina', '機械が壊れました。', 'きかいが こわれました。', 'Mesinnya rusak.'),
  ('n3', 13, 4, '道具', 'どうぐ', 'alat', 'nomina', '道具を借ります。', 'どうぐを かります。', 'Saya meminjam alat.'),
  ('n3', 13, 5, '部品', 'ぶひん', 'suku cadang', 'nomina', '部品が足りません。', 'ぶひんが たりません。', 'Suku cadangnya kurang.'),
  ('n3', 13, 6, '画面', 'がめん', 'layar', 'nomina', '画面が小さいです。', 'がめんが ちいさいです。', 'Layarnya kecil.'),
  ('n3', 13, 7, '電源', 'でんげん', 'sumber listrik', 'nomina', '電源を入れます。', 'でんげんを いれます。', 'Saya menyalakan listrik.'),
  ('n3', 13, 8, '充電', 'じゅうでん', 'mengisi daya', 'nomina', '充電がありません。', 'じゅうでんが ありません。', 'Baterainya habis.'),
  ('n3', 13, 9, '壊れる', 'こわれる', 'rusak', 'verba', '時計が壊れました。', 'とけいが こわれました。', 'Jamnya rusak.'),
  ('n3', 13, 10, '直す', 'なおす', 'memperbaiki', 'verba', '自転車を直します。', 'じてんしゃを なおします。', 'Saya memperbaiki sepeda.'),
  ('n3', 13, 11, '使う', 'つかう', 'menggunakan', 'verba', 'この道具を使います。', 'この どうぐを つかいます。', 'Saya memakai alat ini.'),
  ('n3', 13, 12, '動く', 'うごく', 'bergerak / berfungsi', 'verba', 'エアコンが動きません。', 'エアコンが うごきません。', 'AC-nya tidak menyala.'),
  ('n3', 13, 13, '音', 'おと', 'bunyi', 'nomina', '音が大きいです。', 'おとが おおきいです。', 'Bunyinya besar.'),
  ('n3', 13, 14, '写真', 'しゃしん', 'foto', 'nomina', '写真を撮ります。', 'しゃしんを とります。', 'Saya mengambil foto.'),
  ('n3', 13, 15, '映像', 'えいぞう', 'gambar bergerak', 'nomina', '映像がきれいです。', 'えいぞうが きれいです。', 'Gambarnya bagus.'),
  ('n3', 13, 16, '情報', 'じょうほう', 'informasi', 'nomina', '情報を集めます。', 'じょうほうを あつめます。', 'Saya mengumpulkan informasi.'),
  ('n3', 13, 17, '返事', 'へんじ', 'balasan', 'nomina', '返事がありません。', 'へんじが ありません。', 'Tidak ada balasan.'),
  ('n3', 13, 18, '送る', 'おくる', 'mengirim', 'verba', '荷物を送ります。', 'にもつを おくります。', 'Saya mengirim paket.'),
  ('n3', 13, 19, '届く', 'とどく', 'tiba / terkirim', 'verba', '荷物が届きました。', 'にもつが とどきました。', 'Paketnya sudah sampai.'),
  ('n3', 13, 20, '受ける', 'うける', 'menerima / mengikuti', 'verba', '試験を受けます。', 'しけんを うけます。', 'Saya ikut ujian.'),
  ('n3', 13, 21, '検索', 'けんさく', 'pencarian', 'nomina', 'ネットで検索します。', 'ネットで けんさくします。', 'Saya mencari di internet.'),
  ('n3', 13, 22, '登録', 'とうろく', 'pendaftaran', 'nomina', '登録が必要です。', 'とうろくが ひつようです。', 'Perlu mendaftar.'),
  ('n3', 13, 23, '設定', 'せってい', 'pengaturan', 'nomina', '設定を変えます。', 'せっていを かえます。', 'Saya mengubah pengaturan.'),
  ('n3', 13, 24, '便利', 'べんり', 'praktis', 'adjektiva-na', 'とても便利です。', 'とても べんりです。', 'Sangat praktis.'),
  ('n3', 13, 25, '苦手', 'にがて', 'kurang bisa', 'adjektiva-na', '機械は苦手です。', 'きかいは にがてです。', 'Saya kurang bisa soal mesin.'),
  ('n3', 13, 26, '機能', 'きのう', 'fungsi', 'nomina', '機能が多いです。', 'きのうが おおいです。', 'Fungsinya banyak.'),
  ('n3', 13, 27, '容量', 'ようりょう', 'kapasitas', 'nomina', '容量が足りません。', 'ようりょうが たりません。', 'Kapasitasnya kurang.'),
  ('n3', 13, 28, '接続', 'せつぞく', 'koneksi', 'nomina', '接続してください。', 'せつぞくしてください。', 'Tolong sambungkan.'),
  ('n3', 13, 29, '更新', 'こうしん', 'pembaruan', 'nomina', '更新が必要です。', 'こうしんが ひつようです。', 'Perlu pembaruan.'),
  ('n3', 13, 30, '故障', 'こしょう', 'kerusakan', 'nomina', '故障しました。', 'こしょうしました。', 'Rusak.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 14 · 趣味・スポーツ =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 14, 1, '趣味', 'しゅみ', 'hobi', 'nomina', '趣味は読書です。', 'しゅみは どくしょです。', 'Hobi saya membaca.'),
  ('n3', 14, 2, '音楽', 'おんがく', 'musik', 'nomina', '音楽を聞きます。', 'おんがくを ききます。', 'Saya mendengarkan musik.'),
  ('n3', 14, 3, '映画', 'えいが', 'film', 'nomina', '映画を見ます。', 'えいがを みます。', 'Saya menonton film.'),
  ('n3', 14, 4, '読書', 'どくしょ', 'membaca buku', 'nomina', '読書が好きです。', 'どくしょが すきです。', 'Saya suka membaca.'),
  ('n3', 14, 5, '絵', 'え', 'gambar', 'nomina', '絵を描きます。', 'えを かきます。', 'Saya menggambar.'),
  ('n3', 14, 6, '歌', 'うた', 'lagu', 'nomina', '歌を歌います。', 'うたを うたいます。', 'Saya menyanyikan lagu.'),
  ('n3', 14, 7, '楽器', 'がっき', 'alat musik', 'nomina', '楽器ができます。', 'がっきが できます。', 'Saya bisa main alat musik.'),
  ('n3', 14, 8, '試合', 'しあい', 'pertandingan', 'nomina', '試合を見ます。', 'しあいを みます。', 'Saya menonton pertandingan.'),
  ('n3', 14, 9, '選手', 'せんしゅ', 'pemain', 'nomina', '選手が走ります。', 'せんしゅが はしります。', 'Pemainnya berlari.'),
  ('n3', 14, 10, '勝つ', 'かつ', 'menang', 'verba', '試合に勝ちました。', 'しあいに かちました。', 'Kami menang.'),
  ('n3', 14, 11, '負ける', 'まける', 'kalah', 'verba', '試合に負けました。', 'しあいに まけました。', 'Kami kalah.'),
  ('n3', 14, 12, '泳ぐ', 'およぐ', 'berenang', 'verba', '海で泳ぎます。', 'うみで およぎます。', 'Saya berenang di laut.'),
  ('n3', 14, 13, '走る', 'はしる', 'berlari', 'verba', '毎朝走ります。', 'まいあさ はしります。', 'Saya lari tiap pagi.'),
  ('n3', 14, 14, '歩く', 'あるく', 'berjalan', 'verba', '駅まで歩きます。', 'えきまで あるきます。', 'Saya berjalan ke stasiun.'),
  ('n3', 14, 15, '投げる', 'なげる', 'melempar', 'verba', 'ボールを投げます。', 'ボールを なげます。', 'Saya melempar bola.'),
  ('n3', 14, 16, '蹴る', 'ける', 'menendang', 'verba', 'ボールを蹴ります。', 'ボールを けります。', 'Saya menendang bola.'),
  ('n3', 14, 17, '遊ぶ', 'あそぶ', 'bermain', 'verba', '公園で遊びます。', 'こうえんで あそびます。', 'Saya bermain di taman.'),
  ('n3', 14, 18, '集める', 'あつめる', 'mengumpulkan', 'verba', '切手を集めます。', 'きってを あつめます。', 'Saya mengumpulkan perangko.'),
  ('n3', 14, 19, '続ける', 'つづける', 'melanjutkan', 'verba', '勉強を続けます。', 'べんきょうを つづけます。', 'Saya melanjutkan belajar.'),
  ('n3', 14, 20, '夢', 'ゆめ', 'mimpi', 'nomina', '夢があります。', 'ゆめが あります。', 'Saya punya mimpi.'),
  ('n3', 14, 21, '目標', 'もくひょう', 'target', 'nomina', '目標を決めます。', 'もくひょうを きめます。', 'Saya menetapkan target.'),
  ('n3', 14, 22, '大会', 'たいかい', 'turnamen', 'nomina', '大会に出ます。', 'たいかいに でます。', 'Saya ikut turnamen.'),
  ('n3', 14, 23, '観戦', 'かんせん', 'menonton pertandingan', 'nomina', '試合を観戦します。', 'しあいを かんせんします。', 'Saya menonton pertandingan.'),
  ('n3', 14, 24, '上手', 'じょうず', 'pandai', 'adjektiva-na', '歌が上手です。', 'うたが じょうずです。', 'Dia pandai bernyanyi.'),
  ('n3', 14, 25, '下手', 'へた', 'tidak pandai', 'adjektiva-na', '絵が下手です。', 'えが へたです。', 'Saya tidak pandai menggambar.'),
  ('n3', 14, 26, '将棋', 'しょうぎ', 'shogi', 'nomina', '将棋をします。', 'しょうぎを します。', 'Saya main shogi.'),
  ('n3', 14, 27, '漫画', 'まんが', 'komik', 'nomina', '漫画を読みます。', 'まんがを よみます。', 'Saya membaca komik.'),
  ('n3', 14, 28, 'ゲーム', 'ゲーム', 'gim', 'nomina', 'ゲームをします。', 'ゲームを します。', 'Saya main gim.'),
  ('n3', 14, 29, '登山', 'とざん', 'mendaki gunung', 'nomina', '登山が好きです。', 'とざんが すきです。', 'Saya suka mendaki.'),
  ('n3', 14, 30, '釣り', 'つり', 'memancing', 'nomina', '釣りに行きます。', 'つりに いきます。', 'Saya pergi memancing.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 15 · 旅行・宿 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 15, 1, '旅行', 'りょこう', 'perjalanan', 'nomina', '旅行が好きです。', 'りょこうが すきです。', 'Saya suka bepergian.'),
  ('n3', 15, 2, '観光', 'かんこう', 'wisata', 'nomina', '京都を観光します。', 'きょうとを かんこうします。', 'Saya berwisata di Kyoto.'),
  ('n3', 15, 3, '案内', 'あんない', 'memandu', 'nomina', '町を案内します。', 'まちを あんないします。', 'Saya memandu keliling kota.'),
  ('n3', 15, 4, '地図', 'ちず', 'peta', 'nomina', '地図を見ます。', 'ちずを みます。', 'Saya melihat peta.'),
  ('n3', 15, 5, '荷物', 'にもつ', 'barang bawaan', 'nomina', '荷物が重いです。', 'にもつが おもいです。', 'Barangnya berat.'),
  ('n3', 15, 6, 'スーツケース', 'スーツケース', 'koper', 'nomina', 'スーツケースを持ちます。', 'スーツケースを もちます。', 'Saya membawa koper.'),
  ('n3', 15, 7, 'パスポート', 'パスポート', 'paspor', 'nomina', 'パスポートを見せてください。', 'パスポートを みせてください。', 'Tolong tunjukkan paspor.'),
  ('n3', 15, 8, 'ホテル', 'ホテル', 'hotel', 'nomina', 'ホテルに泊まります。', 'ホテルに とまります。', 'Saya menginap di hotel.'),
  ('n3', 15, 9, '泊まる', 'とまる', 'menginap', 'verba', '温泉に泊まります。', 'おんせんに とまります。', 'Saya menginap di onsen.'),
  ('n3', 15, 10, 'チェックイン', 'チェックイン', 'check-in', 'nomina', '三時にチェックインします。', 'さんじに チェックインします。', 'Saya check-in jam tiga.'),
  ('n3', 15, 11, '土産', 'みやげ', 'oleh-oleh', 'nomina', '土産を買います。', 'みやげを かいます。', 'Saya membeli oleh-oleh.'),
  ('n3', 15, 12, '景色', 'けしき', 'pemandangan', 'nomina', '景色がきれいです。', 'けしきが きれいです。', 'Pemandangannya indah.'),
  ('n3', 15, 13, '名所', 'めいしょ', 'tempat terkenal', 'nomina', '名所を回ります。', 'めいしょを まわります。', 'Saya mengelilingi tempat terkenal.'),
  ('n3', 15, 14, '温泉', 'おんせん', 'sumber air panas', 'nomina', '温泉が好きです。', 'おんせんが すきです。', 'Saya suka onsen.'),
  ('n3', 15, 15, '神社', 'じんじゃ', 'kuil Shinto', 'nomina', '神社に行きます。', 'じんじゃに いきます。', 'Saya pergi ke kuil.'),
  ('n3', 15, 16, '寺', 'てら', 'kuil Buddha', 'nomina', '寺を見ます。', 'てらを みます。', 'Saya melihat kuil.'),
  ('n3', 15, 17, '城', 'しろ', 'kastel', 'nomina', '城が古いです。', 'しろが ふるいです。', 'Kastelnya tua.'),
  ('n3', 15, 18, '出発', 'しゅっぱつ', 'keberangkatan', 'nomina', '朝八時に出発します。', 'あさ はちじに しゅっぱつします。', 'Berangkat jam delapan pagi.'),
  ('n3', 15, 19, '到着', 'とうちゃく', 'kedatangan', 'nomina', '夜に到着します。', 'よるに とうちゃくします。', 'Tiba malam hari.'),
  ('n3', 15, 20, '帰る', 'かえる', 'pulang', 'verba', '国へ帰ります。', 'くにへ かえります。', 'Saya pulang ke negara saya.'),
  ('n3', 15, 21, '案内所', 'あんないじょ', 'kantor informasi', 'nomina', '案内所で聞きます。', 'あんないじょで ききます。', 'Saya bertanya di kantor informasi.'),
  ('n3', 15, 22, '海外', 'かいがい', 'luar negeri', 'nomina', '海外に行きたいです。', 'かいがいに いきたいです。', 'Saya ingin ke luar negeri.'),
  ('n3', 15, 23, '国内', 'こくない', 'dalam negeri', 'nomina', '国内旅行をします。', 'こくない りょこうを します。', 'Saya bepergian dalam negeri.'),
  ('n3', 15, 24, '思い出', 'おもいで', 'kenangan', 'nomina', 'いい思い出です。', 'いい おもいでです。', 'Kenangan yang bagus.'),
  ('n3', 15, 25, '楽しい', 'たのしい', 'menyenangkan', 'adjektiva-i', '旅行は楽しいです。', 'りょこうは たのしいです。', 'Bepergian itu menyenangkan.'),
  ('n3', 15, 26, '観光客', 'かんこうきゃく', 'turis', 'nomina', '観光客が多いです。', 'かんこうきゃくが おおいです。', 'Turisnya banyak.'),
  ('n3', 15, 27, '出国', 'しゅっこく', 'keluar negeri', 'nomina', '出国します。', 'しゅっこくします。', 'Saya berangkat ke luar negeri.'),
  ('n3', 15, 28, '入国', 'にゅうこく', 'masuk negara', 'nomina', '入国しました。', 'にゅうこくしました。', 'Saya masuk negara.'),
  ('n3', 15, 29, '現地', 'げんち', 'lokasi setempat', 'nomina', '現地で買います。', 'げんちで かいます。', 'Saya beli di lokasi.'),
  ('n3', 15, 30, '滞在', 'たいざい', 'masa tinggal', 'nomina', '三日間滞在します。', 'みっかかん たいざいします。', 'Saya tinggal tiga hari.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 16 · 街・場所 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 16, 1, '町', 'まち', 'kota', 'nomina', '町が静かです。', 'まちが しずかです。', 'Kotanya tenang.'),
  ('n3', 16, 2, '村', 'むら', 'desa', 'nomina', '村に住んでいます。', 'むらに すんでいます。', 'Saya tinggal di desa.'),
  ('n3', 16, 3, '場所', 'ばしょ', 'tempat', 'nomina', '場所を教えてください。', 'ばしょを おしえてください。', 'Tolong beri tahu tempatnya.'),
  ('n3', 16, 4, '公園', 'こうえん', 'taman', 'nomina', '公園を散歩します。', 'こうえんを さんぽします。', 'Saya berjalan di taman.'),
  ('n3', 16, 5, '銀行', 'ぎんこう', 'bank', 'nomina', '銀行でお金を出します。', 'ぎんこうで おかねを だします。', 'Saya tarik uang di bank.'),
  ('n3', 16, 6, '郵便局', 'ゆうびんきょく', 'kantor pos', 'nomina', '郵便局はどこですか。', 'ゆうびんきょくは どこですか。', 'Kantor pos di mana?'),
  ('n3', 16, 7, '市役所', 'しやくしょ', 'balai kota', 'nomina', '市役所へ行きます。', 'しやくしょへ いきます。', 'Saya pergi ke balai kota.'),
  ('n3', 16, 8, '交番', 'こうばん', 'pos polisi', 'nomina', '交番で聞きます。', 'こうばんで ききます。', 'Saya bertanya di pos polisi.'),
  ('n3', 16, 9, '美術館', 'びじゅつかん', 'museum seni', 'nomina', '美術館を見ます。', 'びじゅつかんを みます。', 'Saya mengunjungi museum seni.'),
  ('n3', 16, 10, '建物', 'たてもの', 'bangunan', 'nomina', '建物が高いです。', 'たてものが たかいです。', 'Bangunannya tinggi.'),
  ('n3', 16, 11, '入口', 'いりぐち', 'pintu masuk', 'nomina', '入口は右です。', 'いりぐちは みぎです。', 'Pintu masuknya di kanan.'),
  ('n3', 16, 12, '出口', 'でぐち', 'pintu keluar', 'nomina', '出口を探します。', 'でぐちを さがします。', 'Saya mencari pintu keluar.'),
  ('n3', 16, 13, '角', 'かど', 'sudut / tikungan', 'nomina', '角の店です。', 'かどの みせです。', 'Tokonya di tikungan.'),
  ('n3', 16, 14, '前', 'まえ', 'depan', 'nomina', '駅の前で待ちます。', 'えきの まえで まちます。', 'Saya menunggu di depan stasiun.'),
  ('n3', 16, 15, '後ろ', 'うしろ', 'belakang', 'nomina', '後ろに座ります。', 'うしろに すわります。', 'Saya duduk di belakang.'),
  ('n3', 16, 16, '近く', 'ちかく', 'dekat', 'nomina', '家の近くです。', 'いえの ちかくです。', 'Dekat rumah.'),
  ('n3', 16, 17, '遠い', 'とおい', 'jauh', 'adjektiva-i', '駅は遠いです。', 'えきは とおいです。', 'Stasiunnya jauh.'),
  ('n3', 16, 18, '近い', 'ちかい', 'dekat', 'adjektiva-i', '店は近いです。', 'みせは ちかいです。', 'Tokonya dekat.'),
  ('n3', 16, 19, '中心', 'ちゅうしん', 'pusat', 'nomina', '町の中心です。', 'まちの ちゅうしんです。', 'Pusat kota.'),
  ('n3', 16, 20, '通る', 'とおる', 'melewati', 'verba', 'この道を通ります。', 'この みちを とおります。', 'Saya melewati jalan ini.'),
  ('n3', 16, 21, '曲がり角', 'まがりかど', 'tikungan', 'nomina', '曲がり角で止まります。', 'まがりかどで とまります。', 'Berhenti di tikungan.'),
  ('n3', 16, 22, '坂', 'さか', 'tanjakan', 'nomina', '坂が多いです。', 'さかが おおいです。', 'Tanjakan banyak.'),
  ('n3', 16, 23, '橋', 'はし', 'jembatan', 'nomina', '橋を渡ります。', 'はしを わたります。', 'Saya menyeberangi jembatan.'),
  ('n3', 16, 24, '港', 'みなと', 'pelabuhan', 'nomina', '港が見えます。', 'みなとが みえます。', 'Pelabuhan terlihat.'),
  ('n3', 16, 25, '通り', 'とおり', 'jalan (besar)', 'nomina', 'この通りは広いです。', 'この とおりは ひろいです。', 'Jalan ini lebar.'),
  ('n3', 16, 26, '商店街', 'しょうてんがい', 'kawasan pertokoan', 'nomina', '商店街を歩きます。', 'しょうてんがいを あるきます。', 'Saya berjalan di kawasan pertokoan.'),
  ('n3', 16, 27, '住宅', 'じゅうたく', 'perumahan', 'nomina', '住宅が多いです。', 'じゅうたくが おおいです。', 'Perumahannya banyak.'),
  ('n3', 16, 28, '工場', 'こうじょう', 'pabrik', 'nomina', '工場で働きます。', 'こうじょうで はたらきます。', 'Saya bekerja di pabrik.'),
  ('n3', 16, 29, '屋上', 'おくじょう', 'atap gedung', 'nomina', '屋上へ行きます。', 'おくじょうへ いきます。', 'Saya pergi ke atap.'),
  ('n3', 16, 30, '通路', 'つうろ', 'lorong', 'nomina', '通路を開けてください。', 'つうろを あけてください。', 'Tolong buka jalannya.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 17 · 動詞①・毎日の動作 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 17, 1, '起きる', 'おきる', 'bangun tidur', 'verba', '六時に起きます。', 'ろくじに おきます。', 'Saya bangun jam enam.'),
  ('n3', 17, 2, '寝る', 'ねる', 'tidur', 'verba', '十一時に寝ます。', 'じゅういちじに ねます。', 'Saya tidur jam sebelas.'),
  ('n3', 17, 3, '着る', 'きる', 'memakai (atasan)', 'verba', 'シャツを着ます。', 'シャツを きます。', 'Saya memakai kemeja.'),
  ('n3', 17, 4, '脱ぐ', 'ぬぐ', 'melepas', 'verba', '靴を脱ぎます。', 'くつを ぬぎます。', 'Saya melepas sepatu.'),
  ('n3', 17, 5, '履く', 'はく', 'memakai (bawahan/sepatu)', 'verba', '靴を履きます。', 'くつを はきます。', 'Saya memakai sepatu.'),
  ('n3', 17, 6, '座る', 'すわる', 'duduk', 'verba', '椅子に座ります。', 'いすに すわります。', 'Saya duduk di kursi.'),
  ('n3', 17, 7, '立つ', 'たつ', 'berdiri', 'verba', 'ここに立ちます。', 'ここに たちます。', 'Saya berdiri di sini.'),
  ('n3', 17, 8, '開ける', 'あける', 'membuka', 'verba', 'ドアを開けます。', 'ドアを あけます。', 'Saya membuka pintu.'),
  ('n3', 17, 9, '閉める', 'しめる', 'menutup', 'verba', '窓を閉めます。', 'まどを しめます。', 'Saya menutup jendela.'),
  ('n3', 17, 10, '入れる', 'いれる', 'memasukkan', 'verba', '牛乳を入れます。', 'ぎゅうにゅうを いれます。', 'Saya memasukkan susu.'),
  ('n3', 17, 11, '出す', 'だす', 'mengeluarkan', 'verba', '手紙を出します。', 'てがみを だします。', 'Saya mengirim surat.'),
  ('n3', 17, 12, '取る', 'とる', 'mengambil', 'verba', '塩を取ります。', 'しおを とります。', 'Saya mengambil garam.'),
  ('n3', 17, 13, '置く', 'おく', 'meletakkan', 'verba', '机に置きます。', 'つくえに おきます。', 'Saya meletakkan di meja.'),
  ('n3', 17, 14, '持つ', 'もつ', 'membawa / memegang', 'verba', '荷物を持ちます。', 'にもつを もちます。', 'Saya membawa barang.'),
  ('n3', 17, 15, '洗う', 'あらう', 'mencuci', 'verba', '手を洗います。', 'てを あらいます。', 'Saya mencuci tangan.'),
  ('n3', 17, 16, '拭く', 'ふく', 'mengelap', 'verba', '机を拭きます。', 'つくえを ふきます。', 'Saya mengelap meja.'),
  ('n3', 17, 17, '切る', 'きる', 'memotong', 'verba', '野菜を切ります。', 'やさいを きります。', 'Saya memotong sayur.'),
  ('n3', 17, 18, '待つ', 'まつ', 'menunggu', 'verba', '駅で待ちます。', 'えきで まちます。', 'Saya menunggu di stasiun.'),
  ('n3', 17, 19, '会う', 'あう', 'bertemu', 'verba', '友達に会います。', 'ともだちに あいます。', 'Saya bertemu teman.'),
  ('n3', 17, 20, '話す', 'はなす', 'berbicara', 'verba', 'ゆっくり話してください。', 'ゆっくり はなしてください。', 'Tolong bicara pelan-pelan.'),
  ('n3', 17, 21, '聞く', 'きく', 'mendengar / bertanya', 'verba', '音楽を聞きます。', 'おんがくを ききます。', 'Saya mendengarkan musik.'),
  ('n3', 17, 22, '見る', 'みる', 'melihat', 'verba', 'テレビを見ます。', 'テレビを みます。', 'Saya menonton TV.'),
  ('n3', 17, 23, '答える', 'こたえる', 'menjawab', 'verba', '質問に答えます。', 'しつもんに こたえます。', 'Saya menjawab pertanyaan.'),
  ('n3', 17, 24, '呼ぶ', 'よぶ', 'memanggil', 'verba', '名前を呼びます。', 'なまえを よびます。', 'Saya memanggil namanya.'),
  ('n3', 17, 25, '片付ける', 'かたづける', 'merapikan', 'verba', '部屋を片付けます。', 'へやを かたづけます。', 'Saya merapikan kamar.'),
  ('n3', 17, 26, '歌う', 'うたう', 'menyanyi', 'verba', 'みんなで歌います。', 'みんなで うたいます。', 'Kami menyanyi bersama.'),
  ('n3', 17, 27, '描く', 'かく', 'menggambar', 'verba', '絵を描きます。', 'えを かきます。', 'Saya menggambar.'),
  ('n3', 17, 28, '弾く', 'ひく', 'memainkan (alat musik)', 'verba', 'ピアノを弾きます。', 'ピアノを ひきます。', 'Saya bermain piano.'),
  ('n3', 17, 29, '読む', 'よむ', 'membaca', 'verba', '本を読みます。', 'ほんを よみます。', 'Saya membaca buku.'),
  ('n3', 17, 30, '書く', 'かく', 'menulis', 'verba', '名前を書きます。', 'なまえを かきます。', 'Saya menulis nama.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 18 · 動詞②・考える・伝える =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 18, 1, '考える', 'かんがえる', 'berpikir', 'verba', 'よく考えます。', 'よく かんがえます。', 'Saya berpikir baik-baik.'),
  ('n3', 18, 2, '思う', 'おもう', 'merasa / berpikir', 'verba', 'そう思います。', 'そう おもいます。', 'Saya rasa begitu.'),
  ('n3', 18, 3, '知る', 'しる', 'tahu', 'verba', 'その話は知っています。', 'その はなしは しっています。', 'Saya tahu soal itu.'),
  ('n3', 18, 4, '分かる', 'わかる', 'mengerti', 'verba', '意味が分かります。', 'いみが わかります。', 'Saya mengerti artinya.'),
  ('n3', 18, 5, '信じる', 'しんじる', 'percaya', 'verba', '彼を信じます。', 'かれを しんじます。', 'Saya percaya padanya.'),
  ('n3', 18, 6, '決める', 'きめる', 'memutuskan', 'verba', '日にちを決めます。', 'ひにちを きめます。', 'Saya menentukan tanggalnya.'),
  ('n3', 18, 7, '変える', 'かえる', 'mengubah', 'verba', '予定を変えます。', 'よていを かえます。', 'Saya mengubah rencana.'),
  ('n3', 18, 8, '選ぶ', 'えらぶ', 'memilih', 'verba', '色を選びます。', 'いろを えらびます。', 'Saya memilih warna.'),
  ('n3', 18, 9, '比べる', 'くらべる', 'membandingkan', 'verba', '値段を比べます。', 'ねだんを くらべます。', 'Saya membandingkan harga.'),
  ('n3', 18, 10, '伝える', 'つたえる', 'menyampaikan', 'verba', '気持ちを伝えます。', 'きもちを つたえます。', 'Saya menyampaikan perasaan.'),
  ('n3', 18, 11, '説明する', 'せつめいする', 'menjelaskan', 'verba', '使い方を説明します。', 'つかいかたを せつめいします。', 'Saya menjelaskan cara pakainya.'),
  ('n3', 18, 12, '頼む', 'たのむ', 'meminta', 'verba', '友達に頼みます。', 'ともだちに たのみます。', 'Saya meminta bantuan teman.'),
  ('n3', 18, 13, '誘う', 'さそう', 'mengajak', 'verba', '友達を誘います。', 'ともだちを さそいます。', 'Saya mengajak teman.'),
  ('n3', 18, 14, '断る', 'ことわる', 'menolak', 'verba', '誘いを断りました。', 'さそいを ことわりました。', 'Saya menolak ajakannya.'),
  ('n3', 18, 15, '認める', 'みとめる', 'mengakui', 'verba', '間違いを認めます。', 'まちがいを みとめます。', 'Saya mengakui kesalahan.'),
  ('n3', 18, 16, '疑う', 'うたがう', 'meragukan', 'verba', '少し疑っています。', 'すこし うたがっています。', 'Saya agak ragu.'),
  ('n3', 18, 17, '褒める', 'ほめる', 'memuji', 'verba', '上手だと褒めます。', 'じょうずだと ほめます。', 'Saya memuji karena pandai.'),
  ('n3', 18, 18, '謝る', 'あやまる', 'meminta maaf', 'verba', '遅れて謝ります。', 'おくれて あやまります。', 'Saya minta maaf karena terlambat.'),
  ('n3', 18, 19, '頼る', 'たよる', 'bergantung / minta tolong', 'verba', '家族に頼ります。', 'かぞくに たよります。', 'Saya minta tolong keluarga.'),
  ('n3', 18, 20, '決まる', 'きまる', 'ditentukan', 'verba', '日が決まりました。', 'ひが きまりました。', 'Tanggalnya sudah ditentukan.'),
  ('n3', 18, 21, '注意する', 'ちゅういする', 'berhati-hati / menegur', 'verba', '車に注意してください。', 'くるまに ちゅういしてください。', 'Hati-hati dengan mobil.'),
  ('n3', 18, 22, '思い出す', 'おもいだす', 'mengingat kembali', 'verba', '名前を思い出しました。', 'なまえを おもいだしました。', 'Saya ingat namanya.'),
  ('n3', 18, 23, '気づく', 'きづく', 'menyadari', 'verba', '間違いに気づきました。', 'まちがいに きづきました。', 'Saya menyadari kesalahannya.'),
  ('n3', 18, 24, '数える', 'かぞえる', 'menghitung', 'verba', 'お金を数えます。', 'おかねを かぞえます。', 'Saya menghitung uang.'),
  ('n3', 18, 25, '感じる', 'かんじる', 'merasakan', 'verba', '寒さを感じます。', 'さむさを かんじます。', 'Saya merasakan dingin.'),
  ('n3', 18, 26, '報告する', 'ほうこくする', 'melaporkan', 'verba', '結果を報告します。', 'けっかを ほうこくします。', 'Saya melaporkan hasilnya.'),
  ('n3', 18, 27, '相談する', 'そうだんする', 'berkonsultasi', 'verba', '先生に相談します。', 'せんせいに そうだんします。', 'Saya berkonsultasi ke guru.'),
  ('n3', 18, 28, '約束する', 'やくそくする', 'berjanji', 'verba', '友達と約束しました。', 'ともだちと やくそくしました。', 'Saya berjanji dengan teman.'),
  ('n3', 18, 29, '案内する', 'あんないする', 'memandu', 'verba', '町を案内します。', 'まちを あんないします。', 'Saya memandu keliling kota.'),
  ('n3', 18, 30, '紹介する', 'しょうかいする', 'memperkenalkan', 'verba', '友達を紹介します。', 'ともだちを しょうかいします。', 'Saya memperkenalkan teman.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 19 · 動詞③・変化と移動 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 19, 1, '始まる', 'はじまる', 'dimulai', 'verba', '授業が始まります。', 'じゅぎょうが はじまります。', 'Pelajaran dimulai.'),
  ('n3', 19, 2, '終わる', 'おわる', 'selesai', 'verba', '仕事が終わりました。', 'しごとが おわりました。', 'Kerjaannya sudah selesai.'),
  ('n3', 19, 3, '始める', 'はじめる', 'memulai', 'verba', '勉強を始めます。', 'べんきょうを はじめます。', 'Saya mulai belajar.'),
  ('n3', 19, 4, '続く', 'つづく', 'berlanjut', 'verba', '雨が続きます。', 'あめが つづきます。', 'Hujannya berlanjut.'),
  ('n3', 19, 5, '変わる', 'かわる', 'berubah', 'verba', '天気が変わりました。', 'てんきが かわりました。', 'Cuacanya berubah.'),
  ('n3', 19, 6, '増える', 'ふえる', 'bertambah', 'verba', '人が増えました。', 'ひとが ふえました。', 'Orangnya bertambah.'),
  ('n3', 19, 7, '減る', 'へる', 'berkurang', 'verba', '水が減りました。', 'みずが へりました。', 'Airnya berkurang.'),
  ('n3', 19, 8, '上がる', 'あがる', 'naik', 'verba', '値段が上がります。', 'ねだんが あがります。', 'Harganya naik.'),
  ('n3', 19, 9, '下がる', 'さがる', 'turun', 'verba', '気温が下がります。', 'きおんが さがります。', 'Suhunya turun.'),
  ('n3', 19, 10, '入る', 'はいる', 'masuk', 'verba', '部屋に入ります。', 'へやに はいります。', 'Saya masuk kamar.'),
  ('n3', 19, 11, '出る', 'でる', 'keluar', 'verba', '家を出ます。', 'いえを でます。', 'Saya keluar rumah.'),
  ('n3', 19, 12, '進む', 'すすむ', 'maju / berjalan', 'verba', '工事が進みます。', 'こうじが すすみます。', 'Pembangunannya maju.'),
  ('n3', 19, 13, '戻る', 'もどる', 'kembali', 'verba', '席に戻ります。', 'せきに もどります。', 'Saya kembali ke kursi.'),
  ('n3', 19, 14, '着く', 'つく', 'tiba', 'verba', '駅に着きました。', 'えきに つきました。', 'Saya sudah tiba di stasiun.'),
  ('n3', 19, 15, '通う', 'かよう', 'bolak-balik', 'verba', '学校に通っています。', 'がっこうに かよっています。', 'Saya bolak-balik ke sekolah.'),
  ('n3', 19, 16, '越える', 'こえる', 'melewati', 'verba', '山を越えます。', 'やまを こえます。', 'Saya melewati gunung.'),
  ('n3', 19, 17, '集まる', 'あつまる', 'berkumpul', 'verba', '人が集まりました。', 'ひとが あつまりました。', 'Orang-orang berkumpul.'),
  ('n3', 19, 18, '残る', 'のこる', 'tersisa', 'verba', 'お金が残りました。', 'おかねが のこりました。', 'Uangnya tersisa.'),
  ('n3', 19, 19, '消える', 'きえる', 'hilang / padam', 'verba', '電気が消えました。', 'でんきが きえました。', 'Lampunya padam.'),
  ('n3', 19, 20, '生まれる', 'うまれる', 'lahir', 'verba', '子供が生まれました。', 'こどもが うまれました。', 'Anaknya lahir.'),
  ('n3', 19, 21, '育つ', 'そだつ', 'tumbuh', 'verba', '野菜が育ちます。', 'やさいが そだちます。', 'Sayurnya tumbuh.'),
  ('n3', 19, 22, '枯れる', 'かれる', 'layu / mati (tanaman)', 'verba', '花が枯れました。', 'はなが かれました。', 'Bunganya layu.'),
  ('n3', 19, 23, '止まる', 'とまる', 'berhenti', 'verba', 'バスが止まりました。', 'バスが とまりました。', 'Busnya berhenti.'),
  ('n3', 19, 24, '逃げる', 'にげる', 'kabur', 'verba', '犬が逃げました。', 'いぬが にげました。', 'Anjingnya kabur.'),
  ('n3', 19, 25, '届ける', 'とどける', 'mengantarkan', 'verba', '荷物を届けます。', 'にもつを とどけます。', 'Saya mengantar barang.'),
  ('n3', 19, 26, '開く', 'あく', 'terbuka', 'verba', '店が開きました。', 'みせが あきました。', 'Tokonya sudah buka.'),
  ('n3', 19, 27, '閉まる', 'しまる', 'tertutup', 'verba', 'ドアが閉まりました。', 'ドアが しまりました。', 'Pintunya tertutup.'),
  ('n3', 19, 28, '落ちる', 'おちる', 'jatuh', 'verba', '荷物が落ちました。', 'にもつが おちました。', 'Barangnya jatuh.'),
  ('n3', 19, 29, '割れる', 'われる', 'pecah', 'verba', 'コップが割れました。', 'コップが われました。', 'Gelasnya pecah.'),
  ('n3', 19, 30, '壊す', 'こわす', 'merusak', 'verba', 'おもちゃを壊しました。', 'おもちゃを こわしました。', 'Saya merusak mainannya.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 20 · 形容詞・い =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 20, 1, '大きい', 'おおきい', 'besar', 'adjektiva-i', '家が大きいです。', 'いえが おおきいです。', 'Rumahnya besar.'),
  ('n3', 20, 2, '小さい', 'ちいさい', 'kecil', 'adjektiva-i', '部屋が小さいです。', 'へやが ちいさいです。', 'Kamarnya kecil.'),
  ('n3', 20, 3, '長い', 'ながい', 'panjang', 'adjektiva-i', '髪が長いです。', 'かみが ながいです。', 'Rambutnya panjang.'),
  ('n3', 20, 4, '短い', 'みじかい', 'pendek', 'adjektiva-i', '時間が短いです。', 'じかんが みじかいです。', 'Waktunya singkat.'),
  ('n3', 20, 5, '新しい', 'あたらしい', 'baru', 'adjektiva-i', '新しい車です。', 'あたらしい くるまです。', 'Mobil baru.'),
  ('n3', 20, 6, '古い', 'ふるい', 'tua / lama', 'adjektiva-i', '古い家です。', 'ふるい いえです。', 'Rumah tua.'),
  ('n3', 20, 7, '若い', 'わかい', 'muda', 'adjektiva-i', 'まだ若いです。', 'まだ わかいです。', 'Masih muda.'),
  ('n3', 20, 8, '強い', 'つよい', 'kuat', 'adjektiva-i', '風が強いです。', 'かぜが つよいです。', 'Anginnya kencang.'),
  ('n3', 20, 9, '弱い', 'よわい', 'lemah', 'adjektiva-i', '体が弱いです。', 'からだが よわいです。', 'Badan saya lemah.'),
  ('n3', 20, 10, '重い', 'おもい', 'berat', 'adjektiva-i', '荷物が重いです。', 'にもつが おもいです。', 'Barangnya berat.'),
  ('n3', 20, 11, '軽い', 'かるい', 'ringan', 'adjektiva-i', 'この袋は軽いです。', 'この ふくろは かるいです。', 'Kantong ini ringan.'),
  ('n3', 20, 12, '速い', 'はやい', 'cepat (kecepatan)', 'adjektiva-i', '走るのが速いです。', 'はしるのが はやいです。', 'Larinya cepat.'),
  ('n3', 20, 13, '太い', 'ふとい', 'tebal / besar', 'adjektiva-i', '木が太いです。', 'きが ふといです。', 'Pohonnya besar.'),
  ('n3', 20, 14, '細い', 'ほそい', 'tipis / kecil', 'adjektiva-i', '道が細いです。', 'みちが ほそいです。', 'Jalannya sempit.'),
  ('n3', 20, 15, '丸い', 'まるい', 'bulat', 'adjektiva-i', '月が丸いです。', 'つきが まるいです。', 'Bulannya bulat.'),
  ('n3', 20, 16, '正しい', 'ただしい', 'benar', 'adjektiva-i', '答えは正しいです。', 'こたえは ただしいです。', 'Jawabannya benar.'),
  ('n3', 20, 17, '難しい', 'むずかしい', 'sulit', 'adjektiva-i', '漢字は難しいです。', 'かんじは むずかしいです。', 'Kanji itu sulit.'),
  ('n3', 20, 18, '易しい', 'やさしい', 'mudah', 'adjektiva-i', 'この問題は易しいです。', 'この もんだいは やさしいです。', 'Soal ini mudah.'),
  ('n3', 20, 19, '珍しい', 'めずらしい', 'langka', 'adjektiva-i', '珍しい魚です。', 'めずらしい さかなです。', 'Ikan yang langka.'),
  ('n3', 20, 20, '少ない', 'すくない', 'sedikit', 'adjektiva-i', '人が少ないです。', 'ひとが すくないです。', 'Orangnya sedikit.'),
  ('n3', 20, 21, '多い', 'おおい', 'banyak', 'adjektiva-i', '車が多いです。', 'くるまが おおいです。', 'Mobilnya banyak.'),
  ('n3', 20, 22, '汚い', 'きたない', 'kotor', 'adjektiva-i', '部屋が汚いです。', 'へやが きたないです。', 'Kamarnya kotor.'),
  ('n3', 20, 23, 'うるさい', 'うるさい', 'berisik', 'adjektiva-i', '外がうるさいです。', 'そとが うるさいです。', 'Di luar berisik.'),
  ('n3', 20, 24, '痛い', 'いたい', 'sakit / nyeri', 'adjektiva-i', '頭が痛いです。', 'あたまが いたいです。', 'Kepala saya sakit.'),
  ('n3', 20, 25, '危ない', 'あぶない', 'berbahaya', 'adjektiva-i', 'ここは危ないです。', 'ここは あぶないです。', 'Di sini berbahaya.'),
  ('n3', 20, 26, '暗い', 'くらい', 'gelap', 'adjektiva-i', '外は暗いです。', 'そとは くらいです。', 'Di luar gelap.'),
  ('n3', 20, 27, '深い', 'ふかい', 'dalam', 'adjektiva-i', '川が深いです。', 'かわが ふかいです。', 'Sungainya dalam.'),
  ('n3', 20, 28, '浅い', 'あさい', 'dangkal', 'adjektiva-i', 'ここは浅いです。', 'ここは あさいです。', 'Di sini dangkal.'),
  ('n3', 20, 29, '硬い', 'かたい', 'keras', 'adjektiva-i', 'パンが硬いです。', 'パンが かたいです。', 'Rotinya keras.'),
  ('n3', 20, 30, '柔らかい', 'やわらかい', 'lembut', 'adjektiva-i', '肉が柔らかいです。', 'にくが やわらかいです。', 'Dagingnya lembut.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 21 · 形容詞・な =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 21, 1, '大切', 'たいせつ', 'penting', 'adjektiva-na', '家族が大切です。', 'かぞくが たいせつです。', 'Keluarga itu penting.'),
  ('n3', 21, 2, '大事', 'だいじ', 'penting', 'adjektiva-na', '大事な書類です。', 'だいじな しょるいです。', 'Dokumen penting.'),
  ('n3', 21, 3, '簡単', 'かんたん', 'mudah / sederhana', 'adjektiva-na', '簡単な問題です。', 'かんたんな もんだいです。', 'Soal yang mudah.'),
  ('n3', 21, 4, '複雑', 'ふくざつ', 'rumit', 'adjektiva-na', '複雑な話です。', 'ふくざつな はなしです。', 'Cerita yang rumit.'),
  ('n3', 21, 5, '特別', 'とくべつ', 'istimewa', 'adjektiva-na', '特別な日です。', 'とくべつな ひです。', 'Hari yang istimewa.'),
  ('n3', 21, 6, '普通', 'ふつう', 'biasa', 'adjektiva-na', '普通の生活です。', 'ふつうの せいかつです。', 'Kehidupan biasa.'),
  ('n3', 21, 7, '同じ', 'おなじ', 'sama', 'adjektiva-na', '同じ色です。', 'おなじ いろです。', 'Warnanya sama.'),
  ('n3', 21, 8, '違う', 'ちがう', 'berbeda', 'verba', '意見が違います。', 'いけんが ちがいます。', 'Pendapatnya berbeda.'),
  ('n3', 21, 9, '確か', 'たしか', 'pasti', 'adjektiva-na', '確かな情報です。', 'たしかな じょうほうです。', 'Informasi yang pasti.'),
  ('n3', 21, 10, '自由', 'じゆう', 'bebas', 'adjektiva-na', '自由な時間です。', 'じゆうな じかんです。', 'Waktu bebas.'),
  ('n3', 21, 11, '安全', 'あんぜん', 'aman', 'adjektiva-na', 'ここは安全です。', 'ここは あんぜんです。', 'Di sini aman.'),
  ('n3', 21, 12, '危険', 'きけん', 'bahaya', 'adjektiva-na', '危険な場所です。', 'きけんな ばしょです。', 'Tempat berbahaya.'),
  ('n3', 21, 13, '十分', 'じゅうぶん', 'cukup', 'adjektiva-na', '十分な時間です。', 'じゅうぶんな じかんです。', 'Waktunya cukup.'),
  ('n3', 21, 14, '無理', 'むり', 'mustahil / memaksakan', 'adjektiva-na', '無理な話です。', 'むりな はなしです。', 'Permintaan yang tidak masuk akal.'),
  ('n3', 21, 15, '得意', 'とくい', 'unggul / menguasai', 'adjektiva-na', '料理が得意です。', 'りょうりが とくいです。', 'Saya jago memasak.'),
  ('n3', 21, 16, '立派', 'りっぱ', 'megah / hebat', 'adjektiva-na', '立派な建物です。', 'りっぱな たてものです。', 'Bangunan megah.'),
  ('n3', 21, 17, '素敵', 'すてき', 'bagus / menawan', 'adjektiva-na', '素敵な部屋です。', 'すてきな へやです。', 'Kamar yang menawan.'),
  ('n3', 21, 18, '貧しい', 'まずしい', 'miskin', 'adjektiva-i', '貧しい村です。', 'まずしい むらです。', 'Desa yang miskin.'),
  ('n3', 21, 19, '豊か', 'ゆたか', 'makmur / kaya', 'adjektiva-na', '豊かな国です。', 'ゆたかな くにです。', 'Negara makmur.'),
  ('n3', 21, 20, '賑やか', 'にぎやか', 'ramai', 'adjektiva-na', '賑やかな町です。', 'にぎやかな まちです。', 'Kota yang ramai.'),
  ('n3', 21, 21, '変', 'へん', 'aneh', 'adjektiva-na', '変な音がします。', 'へんな おとが します。', 'Ada bunyi aneh.'),
  ('n3', 21, 22, '正直', 'しょうじき', 'jujur', 'adjektiva-na', '正直な人です。', 'しょうじきな ひとです。', 'Orang jujur.'),
  ('n3', 21, 23, '丁寧', 'ていねい', 'sopan / teliti', 'adjektiva-na', '丁寧な言葉です。', 'ていねいな ことばです。', 'Kata-kata yang sopan.'),
  ('n3', 21, 24, '熱い', 'あつい', 'panas (benda)', 'adjektiva-i', 'お茶が熱いです。', 'おちゃが あついです。', 'Tehnya panas.'),
  ('n3', 21, 25, '冷たい', 'つめたい', 'dingin (benda)', 'adjektiva-i', '水が冷たいです。', 'みずが つめたいです。', 'Airnya dingin.'),
  ('n3', 21, 26, '迷惑', 'めいわく', 'merepotkan', 'adjektiva-na', '迷惑をかけました。', 'めいわくを かけました。', 'Saya merepotkan.'),
  ('n3', 21, 27, '贅沢', 'ぜいたく', 'mewah', 'adjektiva-na', '贅沢な料理です。', 'ぜいたくな りょうりです。', 'Masakan yang mewah.'),
  ('n3', 21, 28, '新鮮', 'しんせん', 'segar', 'adjektiva-na', '魚が新鮮です。', 'さかなが しんせんです。', 'Ikannya segar.'),
  ('n3', 21, 29, '油っこい', 'あぶらっこい', 'berminyak', 'adjektiva-i', '少し油っこいです。', 'すこし あぶらっこいです。', 'Agak berminyak.'),
  ('n3', 21, 30, '地味', 'じみ', 'sederhana / kalem', 'adjektiva-na', '地味な色です。', 'じみな いろです。', 'Warnanya kalem.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 22 · 副詞① =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 22, 1, 'とても', 'とても', 'sangat', 'adverbia', 'とても綺麗です。', 'とても きれいです。', 'Sangat indah.'),
  ('n3', 22, 2, '少し', 'すこし', 'sedikit', 'adverbia', '少し待ってください。', 'すこし まってください。', 'Tolong tunggu sebentar.'),
  ('n3', 22, 3, 'ちょっと', 'ちょっと', 'sedikit / agak', 'adverbia', 'ちょっと高いです。', 'ちょっと たかいです。', 'Agak mahal.'),
  ('n3', 22, 4, 'たくさん', 'たくさん', 'banyak', 'adverbia', '本がたくさんあります。', 'ほんが たくさん あります。', 'Bukunya banyak.'),
  ('n3', 22, 5, '全部', 'ぜんぶ', 'semua', 'nomina', '全部食べました。', 'ぜんぶ たべました。', 'Saya makan semuanya.'),
  ('n3', 22, 6, 'ほとんど', 'ほとんど', 'hampir', 'adverbia', 'ほとんど終わりました。', 'ほとんど おわりました。', 'Hampir selesai.'),
  ('n3', 22, 7, 'だいたい', 'だいたい', 'kira-kira', 'adverbia', 'だいたい分かりました。', 'だいたい わかりました。', 'Saya kira-kira mengerti.'),
  ('n3', 22, 8, '必ず', 'かならず', 'pasti', 'adverbia', '必ず行きます。', 'かならず いきます。', 'Saya pasti pergi.'),
  ('n3', 22, 9, 'たぶん', 'たぶん', 'mungkin', 'adverbia', 'たぶん来ます。', 'たぶん きます。', 'Mungkin dia datang.'),
  ('n3', 22, 10, 'きっと', 'きっと', 'pasti (keyakinan)', 'adverbia', 'きっと大丈夫です。', 'きっと だいじょうぶです。', 'Pasti tidak apa-apa.'),
  ('n3', 22, 11, '特に', 'とくに', 'terutama', 'adverbia', '特に問題ありません。', 'とくに もんだい ありません。', 'Tidak ada masalah khusus.'),
  ('n3', 22, 12, '実は', 'じつは', 'sebenarnya', 'adverbia', '実は知りません。', 'じつは しりません。', 'Sebenarnya saya tidak tahu.'),
  ('n3', 22, 13, 'やはり', 'やはり', 'ternyata / memang', 'adverbia', 'やはり雨です。', 'やはり あめです。', 'Ternyata hujan.'),
  ('n3', 22, 14, 'もちろん', 'もちろん', 'tentu saja', 'adverbia', 'もちろん行きます。', 'もちろん いきます。', 'Tentu saja saya pergi.'),
  ('n3', 22, 15, '例えば', 'たとえば', 'misalnya', 'adverbia', '例えばこれです。', 'たとえば これです。', 'Misalnya ini.'),
  ('n3', 22, 16, 'つまり', 'つまり', 'artinya / jadi', 'adverbia', 'つまり同じです。', 'つまり おなじです。', 'Jadi sama saja.'),
  ('n3', 22, 17, 'しかも', 'しかも', 'selain itu', 'adverbia', 'しかも安いです。', 'しかも やすいです。', 'Selain itu murah.'),
  ('n3', 22, 18, 'それに', 'それに', 'ditambah lagi', 'adverbia', 'それに近いです。', 'それに ちかいです。', 'Ditambah lagi dekat.'),
  ('n3', 22, 19, 'でも', 'でも', 'tapi', 'adverbia', 'でも行きます。', 'でも いきます。', 'Tapi saya pergi.'),
  ('n3', 22, 20, 'ただし', 'ただし', 'dengan syarat', 'adverbia', 'ただし予約が必要です。', 'ただし よやくが ひつようです。', 'Dengan syarat harus reservasi.'),
  ('n3', 22, 21, '先に', 'さきに', 'lebih dulu', 'adverbia', '先に帰ります。', 'さきに かえります。', 'Saya pulang lebih dulu.'),
  ('n3', 22, 22, 'ゆっくり', 'ゆっくり', 'pelan-pelan', 'adverbia', 'ゆっくり歩きます。', 'ゆっくり あるきます。', 'Saya berjalan pelan.'),
  ('n3', 22, 23, 'はっきり', 'はっきり', 'jelas', 'adverbia', 'はっきり言ってください。', 'はっきり いってください。', 'Tolong bicara jelas.'),
  ('n3', 22, 24, 'すぐ', 'すぐ', 'langsung', 'adverbia', 'すぐ行きます。', 'すぐ いきます。', 'Saya langsung pergi.'),
  ('n3', 22, 25, 'もう', 'もう', 'sudah', 'adverbia', 'もう食べました。', 'もう たべました。', 'Saya sudah makan.'),
  ('n3', 22, 26, 'すっかり', 'すっかり', 'sama sekali (sudah)', 'adverbia', 'すっかり忘れました。', 'すっかり わすれました。', 'Saya lupa sama sekali.'),
  ('n3', 22, 27, 'せっかく', 'せっかく', 'dengan susah payah', 'adverbia', 'せっかく来ました。', 'せっかく きました。', 'Saya datang susah payah.'),
  ('n3', 22, 28, 'わざわざ', 'わざわざ', 'sengaja repot-repot', 'adverbia', 'わざわざ来ました。', 'わざわざ きました。', 'Dia repot-repot datang.'),
  ('n3', 22, 29, 'たしかに', 'たしかに', 'memang benar', 'adverbia', 'たしかにそうです。', 'たしかに そうです。', 'Memang begitu.'),
  ('n3', 22, 30, 'むしろ', 'むしろ', 'justru', 'adverbia', 'むしろ嬉しいです。', 'むしろ うれしいです。', 'Justru saya senang.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 23 · 副詞②・つなぎ言葉 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 23, 1, 'ずいぶん', 'ずいぶん', 'cukup / lumayan', 'adverbia', 'ずいぶん大きいですね。', 'ずいぶん おおきいですね。', 'Lumayan besar ya.'),
  ('n3', 23, 2, 'なかなか', 'なかなか', 'cukup (baik)', 'adverbia', 'なかなかいいです。', 'なかなか いいです。', 'Cukup bagus.'),
  ('n3', 23, 3, 'かなり', 'かなり', 'cukup', 'adverbia', 'かなり寒いです。', 'かなり さむいです。', 'Cukup dingin.'),
  ('n3', 23, 4, '全然', 'ぜんぜん', 'sama sekali (negatif)', 'adverbia', '全然分かりません。', 'ぜんぜん わかりません。', 'Sama sekali tidak mengerti.'),
  ('n3', 23, 5, 'あまり', 'あまり', 'tidak begitu', 'adverbia', 'あまり高くないです。', 'あまり たかくないです。', 'Tidak begitu mahal.'),
  ('n3', 23, 6, '何も', 'なにも', 'tidak ada apa-apa', 'adverbia', '何もありません。', 'なにも ありません。', 'Tidak ada apa-apa.'),
  ('n3', 23, 7, '誰も', 'だれも', 'tidak ada siapa-siapa', 'adverbia', '誰もいません。', 'だれも いません。', 'Tidak ada siapa-siapa.'),
  ('n3', 23, 8, 'いつも', 'いつも', 'selalu', 'adverbia', 'いつも早いです。', 'いつも はやいです。', 'Selalu cepat.'),
  ('n3', 23, 9, 'よく', 'よく', 'sering', 'adverbia', 'よく映画を見ます。', 'よく えいがを みます。', 'Saya sering menonton film.'),
  ('n3', 23, 10, 'たまに', 'たまに', 'kadang-kadang', 'adverbia', 'たまに走ります。', 'たまに はしります。', 'Kadang saya lari.'),
  ('n3', 23, 11, 'まだ', 'まだ', 'masih', 'adverbia', 'まだ終わっていません。', 'まだ おわっていません。', 'Belum selesai.'),
  ('n3', 23, 12, 'そして', 'そして', 'dan', 'adverbia', 'そして家へ帰ります。', 'そして いえへ かえります。', 'Lalu saya pulang.'),
  ('n3', 23, 13, 'しかし', 'しかし', 'tetapi', 'adverbia', 'しかし時間がありません。', 'しかし じかんが ありません。', 'Tetapi saya tidak punya waktu.'),
  ('n3', 23, 14, 'だから', 'だから', 'karena itu', 'adverbia', 'だから行きません。', 'だから いきません。', 'Karena itu saya tidak pergi.'),
  ('n3', 23, 15, 'それで', 'それで', 'oleh sebab itu', 'adverbia', 'それで遅れました。', 'それで おくれました。', 'Karena itu saya terlambat.'),
  ('n3', 23, 16, 'けれども', 'けれども', 'tetapi', 'adverbia', 'けれども大丈夫です。', 'けれども だいじょうぶです。', 'Tetapi tidak apa-apa.'),
  ('n3', 23, 17, 'また', 'また', 'lagi', 'adverbia', 'また来ます。', 'また きます。', 'Saya datang lagi.'),
  ('n3', 23, 18, 'そろそろ', 'そろそろ', 'sebentar lagi (waktunya)', 'adverbia', 'そろそろ帰りましょう。', 'そろそろ かえりましょう。', 'Ayo sebentar lagi pulang.'),
  ('n3', 23, 19, '一度', 'いちど', 'sekali', 'nomina', '一度行きました。', 'いちど いきました。', 'Saya pernah pergi sekali.'),
  ('n3', 23, 20, '二度', 'にど', 'dua kali', 'nomina', '二度見ました。', 'にど みました。', 'Saya menonton dua kali.'),
  ('n3', 23, 21, 'ぜひ', 'ぜひ', 'sangat ingin / mohon', 'adverbia', 'ぜひ来てください。', 'ぜひ きてください。', 'Tolong datang ya.'),
  ('n3', 23, 22, 'さっき', 'さっき', 'barusan', 'adverbia', 'さっき来ました。', 'さっき きました。', 'Barusan dia datang.'),
  ('n3', 23, 23, '後で', 'あとで', 'nanti', 'adverbia', '後で電話します。', 'あとで でんわします。', 'Nanti saya telepon.'),
  ('n3', 23, 24, '今すぐ', 'いますぐ', 'sekarang juga', 'adverbia', '今すぐ行きます。', 'いますぐ いきます。', 'Saya pergi sekarang juga.'),
  ('n3', 23, 25, 'だんだん', 'だんだん', 'perlahan-lahan', 'adverbia', 'だんだん暖かくなります。', 'だんだん あたたかくなります。', 'Perlahan jadi hangat.'),
  ('n3', 23, 26, '決して', 'けっして', 'tidak akan (dengan negatif)', 'adverbia', '決して忘れません。', 'けっして わすれません。', 'Saya tidak akan lupa.'),
  ('n3', 23, 27, '別に', 'べつに', 'tidak begitu', 'adverbia', '別に大丈夫です。', 'べつに だいじょうぶです。', 'Biasa saja, tidak apa-apa.'),
  ('n3', 23, 28, '逆に', 'ぎゃくに', 'sebaliknya', 'adverbia', '逆に安いです。', 'ぎゃくに やすいです。', 'Sebaliknya jadi murah.'),
  ('n3', 23, 29, '一方', 'いっぽう', 'di sisi lain', 'nomina', '一方で難しいです。', 'いっぽうで むずかしいです。', 'Di sisi lain sulit.'),
  ('n3', 23, 30, 'さらに', 'さらに', 'lebih lagi', 'adverbia', 'さらに増えました。', 'さらに ふえました。', 'Bertambah lagi.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 24 · 擬音語・擬態語 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 24, 1, 'ぴったり', 'ぴったり', 'pas', 'adverbia', 'ぴったりのサイズです。', 'ぴったりの サイズです。', 'Ukurannya pas.'),
  ('n3', 24, 2, 'しっかり', 'しっかり', 'dengan sungguh-sungguh', 'adverbia', 'しっかり勉強します。', 'しっかり べんきょうします。', 'Saya belajar dengan sungguh-sungguh.'),
  ('n3', 24, 3, 'のんびり', 'のんびり', 'santai', 'adverbia', 'のんびり休みます。', 'のんびり やすみます。', 'Saya istirahat santai.'),
  ('n3', 24, 4, 'いっぱい', 'いっぱい', 'penuh / banyak', 'adverbia', 'お腹がいっぱいです。', 'おなかが いっぱいです。', 'Perut saya kenyang.'),
  ('n3', 24, 5, 'ぐっすり', 'ぐっすり', 'tidur nyenyak', 'adverbia', 'ぐっすり寝ました。', 'ぐっすり ねました。', 'Saya tidur nyenyak.'),
  ('n3', 24, 6, 'ぺこぺこ', 'ぺこぺこ', 'sangat lapar', 'adverbia', 'お腹がぺこぺこです。', 'おなかが ぺこぺこです。', 'Perut saya sangat lapar.'),
  ('n3', 24, 7, 'ぐるぐる', 'ぐるぐる', 'berputar-putar', 'adverbia', '目がぐるぐるします。', 'めが ぐるぐるします。', 'Kepala saya pusing.'),
  ('n3', 24, 8, 'きらきら', 'きらきら', 'berkilau', 'adverbia', '星がきらきらしています。', 'ほしが きらきらしています。', 'Bintangnya berkilau.'),
  ('n3', 24, 9, 'ざあざあ', 'ざあざあ', 'hujan deras', 'adverbia', '雨がざあざあ降っています。', 'あめが ざあざあ ふっています。', 'Hujannya deras sekali.'),
  ('n3', 24, 10, 'そっと', 'そっと', 'dengan hati-hati', 'adverbia', 'そっと閉めます。', 'そっと しめます。', 'Saya menutupnya pelan-pelan.'),
  ('n3', 24, 11, 'ふらふら', 'ふらふら', 'sempoyongan', 'adverbia', '頭がふらふらします。', 'あたまが ふらふらします。', 'Kepala saya pusing berat.'),
  ('n3', 24, 12, 'どきどき', 'どきどき', 'deg-degan', 'adverbia', '胸がどきどきします。', 'むねが どきどきします。', 'Jantung saya berdebar.'),
  ('n3', 24, 13, 'わくわく', 'わくわく', 'bersemangat menanti', 'adverbia', '旅行がわくわくします。', 'りょこうが わくわくします。', 'Perjalanannya bikin semangat.'),
  ('n3', 24, 14, 'ぺらぺら', 'ぺらぺら', 'fasih', 'adverbia', '日本語がぺらぺらです。', 'にほんごが ぺらぺらです。', 'Bahasa Jepangnya fasih.'),
  ('n3', 24, 15, 'ぼんやり', 'ぼんやり', 'melamun', 'adverbia', 'ぼんやりしています。', 'ぼんやりしています。', 'Saya sedang melamun.'),
  ('n3', 24, 16, 'こっそり', 'こっそり', 'diam-diam', 'adverbia', 'こっそり出ました。', 'こっそり でました。', 'Dia keluar diam-diam.'),
  ('n3', 24, 17, 'ぐちゃぐちゃ', 'ぐちゃぐちゃ', 'berantakan', 'adverbia', '机がぐちゃぐちゃです。', 'つくえが ぐちゃぐちゃです。', 'Mejanya berantakan.'),
  ('n3', 24, 18, 'ぴかぴか', 'ぴかぴか', 'mengkilap', 'adverbia', '靴がぴかぴかです。', 'くつが ぴかぴかです。', 'Sepatunya mengkilap.'),
  ('n3', 24, 19, 'がっかり', 'がっかり', 'kecewa', 'adverbia', 'とてもがっかりしました。', 'とても がっかりしました。', 'Saya sangat kecewa.'),
  ('n3', 24, 20, 'うっかり', 'うっかり', 'tanpa sengaja', 'adverbia', 'うっかり忘れました。', 'うっかり わすれました。', 'Tidak sengaja saya lupa.'),
  ('n3', 24, 21, 'ゆったり', 'ゆったり', 'lega / santai', 'adverbia', 'ゆったり過ごします。', 'ゆったり すごします。', 'Saya menghabiskan waktu santai.'),
  ('n3', 24, 22, 'どんどん', 'どんどん', 'semakin / terus', 'adverbia', 'どんどん上手になります。', 'どんどん じょうずに なります。', 'Semakin hari makin pandai.'),
  ('n3', 24, 23, 'ばらばら', 'ばらばら', 'terpisah-pisah', 'adverbia', '紙がばらばらです。', 'かみが ばらばらです。', 'Kertasnya berserakan.'),
  ('n3', 24, 24, 'ぐったり', 'ぐったり', 'lemas', 'adverbia', '疲れてぐったりです。', 'つかれて ぐったりです。', 'Lemas karena lelah.'),
  ('n3', 24, 25, 'ひらひら', 'ひらひら', 'berkibar', 'adverbia', '花びらがひらひら落ちます。', 'はなびらが ひらひら おちます。', 'Kelopak bunga berjatuhan.'),
  ('n3', 24, 26, 'ごろごろ', 'ごろごろ', 'mager / berguling', 'adverbia', '休みはごろごろします。', 'やすみは ごろごろします。', 'Hari libur saya mager.'),
  ('n3', 24, 27, 'にこにこ', 'にこにこ', 'tersenyum', 'adverbia', '彼女はにこにこしています。', 'かのじょは にこにこしています。', 'Dia tersenyum.'),
  ('n3', 24, 28, 'ぷんぷん', 'ぷんぷん', 'marah (kelihatan)', 'adverbia', '少しぷんぷんしています。', 'すこし ぷんぷんしています。', 'Dia agak marah.'),
  ('n3', 24, 29, 'しーん', 'しーん', 'hening', 'adverbia', '部屋がしーんとしています。', 'へやが しーんと しています。', 'Kamarnya hening.'),
  ('n3', 24, 30, 'ぐーぐー', 'ぐーぐー', 'tidur mendengkur', 'adverbia', 'ぐーぐー寝ています。', 'ぐーぐー ねています。', 'Dia tidur mendengkur.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 25 · 複合語・よく使う名詞 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 25, 1, '天気予報', 'てんきよほう', 'prakiraan cuaca', 'nomina', '天気予報を見ます。', 'てんきよほうを みます。', 'Saya melihat prakiraan cuaca.'),
  ('n3', 25, 2, '待ち合わせ', 'まちあわせ', 'janji temu', 'nomina', '待ち合わせは駅です。', 'まちあわせは えきです。', 'Janji temunya di stasiun.'),
  ('n3', 25, 3, '食料品', 'しょくりょうひん', 'bahan makanan', 'nomina', '食料品を買います。', 'しょくりょうひんを かいます。', 'Saya membeli bahan makanan.'),
  ('n3', 25, 4, '日記', 'にっき', 'buku harian', 'nomina', '日記を書きます。', 'にっきを かきます。', 'Saya menulis buku harian.'),
  ('n3', 25, 5, '手紙', 'てがみ', 'surat', 'nomina', '手紙を送ります。', 'てがみを おくります。', 'Saya mengirim surat.'),
  ('n3', 25, 6, '切手', 'きって', 'perangko', 'nomina', '切手を貼ります。', 'きってを はります。', 'Saya menempel perangko.'),
  ('n3', 25, 7, '葉書', 'はがき', 'kartu pos', 'nomina', '葉書を出します。', 'はがきを だします。', 'Saya mengirim kartu pos.'),
  ('n3', 25, 8, '小包', 'こづつみ', 'paket', 'nomina', '小包が届きました。', 'こづつみが とどきました。', 'Paketnya sudah sampai.'),
  ('n3', 25, 9, '住所', 'じゅうしょ', 'alamat', 'nomina', '住所を書きます。', 'じゅうしょを かきます。', 'Saya menulis alamat.'),
  ('n3', 25, 10, '名前', 'なまえ', 'nama', 'nomina', '名前を教えてください。', 'なまえを おしえてください。', 'Tolong beri tahu namanya.'),
  ('n3', 25, 11, '誕生日', 'たんじょうび', 'ulang tahun', 'nomina', '明日は誕生日です。', 'あしたは たんじょうびです。', 'Besok ulang tahun.'),
  ('n3', 25, 12, '休憩', 'きゅうけい', 'istirahat sejenak', 'nomina', '少し休憩しましょう。', 'すこし きゅうけいしましょう。', 'Ayo istirahat sebentar.'),
  ('n3', 25, 13, '行事', 'ぎょうじ', 'acara (sekolah/kantor)', 'nomina', '学校の行事です。', 'がっこうの ぎょうじです。', 'Acara sekolah.'),
  ('n3', 25, 14, '会場', 'かいじょう', 'tempat acara', 'nomina', '会場はどこですか。', 'かいじょうは どこですか。', 'Tempat acaranya di mana?'),
  ('n3', 25, 15, '参加', 'さんか', 'partisipasi', 'nomina', '会議に参加します。', 'かいぎに さんかします。', 'Saya ikut rapat.'),
  ('n3', 25, 16, '用意', 'ようい', 'persiapan', 'nomina', '用意ができました。', 'よういが できました。', 'Persiapannya sudah siap.'),
  ('n3', 25, 17, '片付け', 'かたづけ', 'merapikan', 'nomina', '片付けをします。', 'かたづけを します。', 'Saya merapikan.'),
  ('n3', 25, 18, '洗濯物', 'せんたくもの', 'cucian', 'nomina', '洗濯物を干します。', 'せんたくものを ほします。', 'Saya menjemur cucian.'),
  ('n3', 25, 19, '味付け', 'あじつけ', 'bumbu', 'nomina', '味付けが薄いです。', 'あじつけが うすいです。', 'Bumbunya kurang.'),
  ('n3', 25, 20, '料理人', 'りょうりにん', 'juru masak', 'nomina', '料理人になりたいです。', 'りょうりにんに なりたいです。', 'Saya ingin jadi juru masak.'),
  ('n3', 25, 21, '時間割', 'じかんわり', 'jadwal pelajaran', 'nomina', '時間割を見ます。', 'じかんわりを みます。', 'Saya melihat jadwal.'),
  ('n3', 25, 22, '忘れ物', 'わすれもの', 'barang tertinggal', 'nomina', '忘れ物をしました。', 'わすれものを しました。', 'Saya meninggalkan barang.'),
  ('n3', 25, 23, '待ち時間', 'まちじかん', 'waktu tunggu', 'nomina', '待ち時間が長いです。', 'まちじかんが ながいです。', 'Waktu tunggunya lama.'),
  ('n3', 25, 24, '人口', 'じんこう', 'populasi', 'nomina', '人口が少ないです。', 'じんこうが すくないです。', 'Populasinya sedikit.'),
  ('n3', 25, 25, '付き合い', 'つきあい', 'pergaulan', 'nomina', '付き合いが大切です。', 'つきあいが たいせつです。', 'Pergaulan itu penting.'),
  ('n3', 25, 26, '出入口', 'でいりぐち', 'pintu masuk-keluar', 'nomina', '出入口はこちらです。', 'でいりぐちは こちらです。', 'Pintu masuknya di sini.'),
  ('n3', 25, 27, '引っ越し', 'ひっこし', 'pindahan', 'nomina', '引っ越しをします。', 'ひっこしを します。', 'Saya akan pindahan.'),
  ('n3', 25, 28, '早口', 'はやくち', 'bicara cepat', 'nomina', '早口で話します。', 'はやくちで はなします。', 'Dia bicara cepat.'),
  ('n3', 25, 29, '物価', 'ぶっか', 'harga barang', 'nomina', '物価が高いです。', 'ぶっかが たかいです。', 'Harga barang mahal.'),
  ('n3', 25, 30, '夜空', 'よぞら', 'langit malam', 'nomina', '夜空がきれいです。', 'よぞらが きれいです。', 'Langit malamnya indah.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 26 · 社会・出来事 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 26, 1, '社会', 'しゃかい', 'masyarakat', 'nomina', '社会の問題です。', 'しゃかいの もんだいです。', 'Masalah sosial.'),
  ('n3', 26, 2, '政治', 'せいじ', 'politik', 'nomina', '政治の話です。', 'せいじの はなしです。', 'Bicara soal politik.'),
  ('n3', 26, 3, '経済', 'けいざい', 'ekonomi', 'nomina', '経済が悪いです。', 'けいざいが わるいです。', 'Ekonominya buruk.'),
  ('n3', 26, 4, '法律', 'ほうりつ', 'hukum', 'nomina', '法律を守ります。', 'ほうりつを まもります。', 'Saya menaati hukum.'),
  ('n3', 26, 5, '選挙', 'せんきょ', 'pemilu', 'nomina', '選挙があります。', 'せんきょが あります。', 'Ada pemilu.'),
  ('n3', 26, 6, '事件', 'じけん', 'insiden', 'nomina', '事件がありました。', 'じけんが ありました。', 'Ada insiden.'),
  ('n3', 26, 7, '事故', 'じこ', 'kecelakaan', 'nomina', '事故で遅れました。', 'じこで おくれました。', 'Terlambat karena kecelakaan.'),
  ('n3', 26, 8, '火事', 'かじ', 'kebakaran', 'nomina', '火事が起きました。', 'かじが おきました。', 'Terjadi kebakaran.'),
  ('n3', 26, 9, '災害', 'さいがい', 'bencana', 'nomina', '災害に備えます。', 'さいがいに そなえます。', 'Saya bersiap untuk bencana.'),
  ('n3', 26, 10, '警察', 'けいさつ', 'polisi', 'nomina', '警察に連絡します。', 'けいさつに れんらくします。', 'Saya menghubungi polisi.'),
  ('n3', 26, 11, '政府', 'せいふ', 'pemerintah', 'nomina', '政府が決めました。', 'せいふが きめました。', 'Pemerintah memutuskan.'),
  ('n3', 26, 12, '市民', 'しみん', 'warga kota', 'nomina', '市民が集まりました。', 'しみんが あつまりました。', 'Warga berkumpul.'),
  ('n3', 26, 13, '税金', 'ぜいきん', 'pajak', 'nomina', '税金を払います。', 'ぜいきんを はらいます。', 'Saya membayar pajak.'),
  ('n3', 26, 14, '保険', 'ほけん', 'asuransi', 'nomina', '保険に入ります。', 'ほけんに はいります。', 'Saya ikut asuransi.'),
  ('n3', 26, 15, '報道', 'ほうどう', 'pemberitaan', 'nomina', '報道を見ます。', 'ほうどうを みます。', 'Saya melihat pemberitaan.'),
  ('n3', 26, 16, '記事', 'きじ', 'artikel', 'nomina', '記事を読みます。', 'きじを よみます。', 'Saya membaca artikel.'),
  ('n3', 26, 17, '世の中', 'よのなか', 'kehidupan sosial', 'nomina', '世の中が変わりました。', 'よのなかが かわりました。', 'Dunia sudah berubah.'),
  ('n3', 26, 18, '制度', 'せいど', 'sistem / aturan', 'nomina', '制度が変わりました。', 'せいどが かわりました。', 'Sistemnya berubah.'),
  ('n3', 26, 19, '話し合い', 'はなしあい', 'diskusi', 'nomina', '話し合いをします。', 'はなしあいを します。', 'Kami berdiskusi.'),
  ('n3', 26, 20, '方針', 'ほうしん', 'kebijakan / arah', 'nomina', '方針を決めます。', 'ほうしんを きめます。', 'Kami menentukan arah.'),
  ('n3', 26, 21, '問題', 'もんだい', 'masalah', 'nomina', '問題があります。', 'もんだいが あります。', 'Ada masalah.'),
  ('n3', 26, 22, '対応', 'たいおう', 'penanganan', 'nomina', '対応が遅れました。', 'たいおうが おくれました。', 'Penanganannya terlambat.'),
  ('n3', 26, 23, '影響', 'えいきょう', 'pengaruh', 'nomina', '影響が大きいです。', 'えいきょうが おおきいです。', 'Pengaruhnya besar.'),
  ('n3', 26, 24, '増加', 'ぞうか', 'penambahan', 'nomina', '人口が増加しています。', 'じんこうが ぞうかしています。', 'Populasi bertambah.'),
  ('n3', 26, 25, '減少', 'げんしょう', 'pengurangan', 'nomina', '数が減少しました。', 'かずが げんしょうしました。', 'Jumlahnya berkurang.'),
  ('n3', 26, 26, '国際', 'こくさい', 'internasional', 'nomina', '国際会議があります。', 'こくさい かいぎが あります。', 'Ada konferensi internasional.'),
  ('n3', 26, 27, '教育', 'きょういく', 'pendidikan', 'nomina', '教育が大切です。', 'きょういくが たいせつです。', 'Pendidikan itu penting.'),
  ('n3', 26, 28, '産業', 'さんぎょう', 'industri', 'nomina', '産業が発達しています。', 'さんぎょうが はったつしています。', 'Industrinya maju.'),
  ('n3', 26, 29, '環境', 'かんきょう', 'lingkungan', 'nomina', '環境を守ります。', 'かんきょうを まもります。', 'Saya menjaga lingkungan.'),
  ('n3', 26, 30, '犯罪', 'はんざい', 'kejahatan', 'nomina', '犯罪が減りました。', 'はんざいが へりました。', 'Kejahatan berkurang.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 27 · 文化・行事 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 27, 1, '文化', 'ぶんか', 'budaya', 'nomina', '日本の文化が好きです。', 'にほんの ぶんかが すきです。', 'Saya suka budaya Jepang.'),
  ('n3', 27, 2, '伝統', 'でんとう', 'tradisi', 'nomina', '伝統を守ります。', 'でんとうを まもります。', 'Saya menjaga tradisi.'),
  ('n3', 27, 3, '祭り', 'まつり', 'festival', 'nomina', '祭りに行きます。', 'まつりに いきます。', 'Saya pergi ke festival.'),
  ('n3', 27, 4, '正月', 'しょうがつ', 'tahun baru Jepang', 'nomina', '正月に帰ります。', 'しょうがつに かえります。', 'Saya pulang saat tahun baru.'),
  ('n3', 27, 5, '花見', 'はなみ', 'melihat bunga', 'nomina', '花見をします。', 'はなみを します。', 'Saya melihat bunga sakura.'),
  ('n3', 27, 6, '浴衣', 'ゆかた', 'yukata', 'nomina', '浴衣を着ます。', 'ゆかたを きます。', 'Saya memakai yukata.'),
  ('n3', 27, 7, '茶道', 'さどう', 'upacara teh', 'nomina', '茶道を習います。', 'さどうを ならいます。', 'Saya belajar upacara teh.'),
  ('n3', 27, 8, '書道', 'しょどう', 'kaligrafi', 'nomina', '書道が趣味です。', 'しょどうが しゅみです。', 'Kaligrafi hobi saya.'),
  ('n3', 27, 9, '歌舞伎', 'かぶき', 'kabuki', 'nomina', '歌舞伎を見ました。', 'かぶきを みました。', 'Saya menonton kabuki.'),
  ('n3', 27, 10, '相撲', 'すもう', 'sumo', 'nomina', '相撲が好きです。', 'すもうが すきです。', 'Saya suka sumo.'),
  ('n3', 27, 11, '着物', 'きもの', 'kimono', 'nomina', '着物は高いです。', 'きものは たかいです。', 'Kimononya mahal.'),
  ('n3', 27, 12, '畳', 'たたみ', 'tikar tatami', 'nomina', '畳の部屋です。', 'たたみの へやです。', 'Kamar bertatami.'),
  ('n3', 27, 13, '布団', 'ふとん', 'futon', 'nomina', '布団を敷きます。', 'ふとんを しきます。', 'Saya menggelar futon.'),
  ('n3', 27, 14, '箸', 'はし', 'sumpit', 'nomina', '箸で食べます。', 'はしで たべます。', 'Saya makan pakai sumpit.'),
  ('n3', 27, 15, '味噌汁', 'みそしる', 'sup miso', 'nomina', '味噌汁を作ります。', 'みそしるを つくります。', 'Saya membuat sup miso.'),
  ('n3', 27, 16, '寿司', 'すし', 'sushi', 'nomina', '寿司を食べます。', 'すしを たべます。', 'Saya makan sushi.'),
  ('n3', 27, 17, '天ぷら', 'てんぷら', 'tempura', 'nomina', '天ぷらが好きです。', 'てんぷらが すきです。', 'Saya suka tempura.'),
  ('n3', 27, 18, 'お辞儀', 'おじぎ', 'membungkuk', 'nomina', 'お辞儀をします。', 'おじぎを します。', 'Saya membungkuk.'),
  ('n3', 27, 19, '敬語', 'けいご', 'bahasa sopan', 'nomina', '敬語は難しいです。', 'けいごは むずかしいです。', 'Bahasa sopan itu sulit.'),
  ('n3', 27, 20, '挨拶', 'あいさつ', 'salam', 'nomina', '挨拶をします。', 'あいさつを します。', 'Saya memberi salam.'),
  ('n3', 27, 21, '礼儀', 'れいぎ', 'tata krama', 'nomina', '礼儀が大切です。', 'れいぎが たいせつです。', 'Tata krama itu penting.'),
  ('n3', 27, 22, '慣習', 'かんしゅう', 'kebiasaan turun-temurun', 'nomina', '古い慣習です。', 'ふるい かんしゅうです。', 'Kebiasaan lama.'),
  ('n3', 27, 23, '芸術', 'げいじゅつ', 'seni', 'nomina', '芸術が好きです。', 'げいじゅつが すきです。', 'Saya suka seni.'),
  ('n3', 27, 24, '歴史', 'れきし', 'sejarah', 'nomina', '歴史を勉強します。', 'れきしを べんきょうします。', 'Saya belajar sejarah.'),
  ('n3', 27, 25, '民話', 'みんわ', 'cerita rakyat', 'nomina', '民話を読みます。', 'みんわを よみます。', 'Saya membaca cerita rakyat.'),
  ('n3', 27, 26, '盆踊り', 'ぼんおどり', 'tarian obon', 'nomina', '盆踊りをします。', 'ぼんおどりを します。', 'Kami menari obon.'),
  ('n3', 27, 27, '初詣', 'はつもうで', 'ziarah tahun baru', 'nomina', '初詣に行きます。', 'はつもうでに いきます。', 'Saya pergi ziarah tahun baru.'),
  ('n3', 27, 28, '節分', 'せつぶん', 'setsubun', 'nomina', '節分に豆をまきます。', 'せつぶんに まめを まきます。', 'Saat setsubun saya menabur kacang.'),
  ('n3', 27, 29, '紅葉', 'こうよう', 'daun musim gugur', 'nomina', '紅葉がきれいです。', 'こうようが きれいです。', 'Daun musim gugurnya indah.'),
  ('n3', 27, 30, '和食', 'わしょく', 'masakan Jepang', 'nomina', '和食が好きです。', 'わしょくが すきです。', 'Saya suka masakan Jepang.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 28 · ビジネス・連絡 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 28, 1, 'お世話', 'おせわ', 'bantuan / dukungan', 'nomina', 'お世話になりました。', 'おせわに なりました。', 'Terima kasih atas bantuannya.'),
  ('n3', 28, 2, '担当', 'たんとう', 'penanggung jawab', 'nomina', '担当は田中さんです。', 'たんとうは たなかさんです。', 'Penanggung jawabnya Pak Tanaka.'),
  ('n3', 28, 3, '承知', 'しょうち', 'mengerti (formal)', 'nomina', '承知しました。', 'しょうちしました。', 'Baik, saya mengerti.'),
  ('n3', 28, 4, '添付', 'てんぷ', 'lampiran', 'nomina', '添付を確認してください。', 'てんぷを かくにんしてください。', 'Tolong cek lampirannya.'),
  ('n3', 28, 5, '件名', 'けんめい', 'subjek', 'nomina', '件名を書きます。', 'けんめいを かきます。', 'Saya menulis subjek.'),
  ('n3', 28, 6, '宛先', 'あてさき', 'alamat tujuan', 'nomina', '宛先を入れます。', 'あてさきを いれます。', 'Saya mengisi alamat tujuan.'),
  ('n3', 28, 7, '返信', 'へんしん', 'balasan', 'nomina', '返信をお願いします。', 'へんしんを おねがいします。', 'Mohon dibalas.'),
  ('n3', 28, 8, '転送', 'てんそう', 'meneruskan', 'nomina', 'メールを転送します。', 'メールを てんそうします。', 'Saya meneruskan surel.'),
  ('n3', 28, 9, '印刷', 'いんさつ', 'mencetak', 'nomina', '資料を印刷します。', 'しりょうを いんさつします。', 'Saya mencetak dokumen.'),
  ('n3', 28, 10, '会計', 'かいけい', 'akuntansi', 'nomina', '会計を担当しています。', 'かいけいを たんとうしています。', 'Saya bertanggung jawab di akuntansi.'),
  ('n3', 28, 11, '売上', 'うりあげ', 'penjualan', 'nomina', '売上が増えました。', 'うりあげが ふえました。', 'Penjualan naik.'),
  ('n3', 28, 12, '利益', 'りえき', 'keuntungan', 'nomina', '利益が出ました。', 'りえきが でました。', 'Sudah untung.'),
  ('n3', 28, 13, '費用', 'ひよう', 'biaya', 'nomina', '費用がかかります。', 'ひようが かかります。', 'Perlu biaya.'),
  ('n3', 28, 14, '予算', 'よさん', 'anggaran', 'nomina', '予算が足りません。', 'よさんが たりません。', 'Anggarannya kurang.'),
  ('n3', 28, 15, '提案', 'ていあん', 'usulan', 'nomina', '提案をします。', 'ていあんを します。', 'Saya mengajukan usulan.'),
  ('n3', 28, 16, '承認', 'しょうにん', 'persetujuan', 'nomina', '承認をもらいます。', 'しょうにんを もらいます。', 'Saya meminta persetujuan.'),
  ('n3', 28, 17, '打ち合わせ', 'うちあわせ', 'rapat koordinasi', 'nomina', '打ち合わせがあります。', 'うちあわせが あります。', 'Ada rapat koordinasi.'),
  ('n3', 28, 18, '納期', 'のうき', 'tenggat pengiriman', 'nomina', '納期は来週です。', 'のうきは らいしゅうです。', 'Tenggat kirimnya minggu depan.'),
  ('n3', 28, 19, '処理', 'しょり', 'pemrosesan', 'nomina', '処理が終わりました。', 'しょりが おわりました。', 'Pemrosesannya selesai.'),
  ('n3', 28, 20, '指示', 'しじ', 'instruksi', 'nomina', '指示を待ちます。', 'しじを まちます。', 'Saya menunggu instruksi.'),
  ('n3', 28, 21, '連絡先', 'れんらくさき', 'kontak', 'nomina', '連絡先を教えてください。', 'れんらくさきを おしえてください。', 'Tolong beri tahu kontaknya.'),
  ('n3', 28, 22, '面談', 'めんだん', 'pertemuan / wawancara', 'nomina', '面談があります。', 'めんだんが あります。', 'Ada pertemuan.'),
  ('n3', 28, 23, '出社', 'しゅっしゃ', 'masuk kantor', 'nomina', '九時に出社します。', 'くじに しゅっしゃします。', 'Saya masuk kantor jam sembilan.'),
  ('n3', 28, 24, '退社', 'たいしゃ', 'pulang kantor', 'nomina', '六時に退社します。', 'ろくじに たいしゃします。', 'Saya pulang kantor jam enam.'),
  ('n3', 28, 25, '有給', 'ゆうきゅう', 'cuti berbayar', 'nomina', '有給を取ります。', 'ゆうきゅうを とります。', 'Saya mengambil cuti.'),
  ('n3', 28, 26, '見積もり', 'みつもり', 'estimasi biaya', 'nomina', '見積もりをお願いします。', 'みつもりを おねがいします。', 'Mohon estimasi biayanya.'),
  ('n3', 28, 27, '請求書', 'せいきゅうしょ', 'tagihan', 'nomina', '請求書を送ります。', 'せいきゅうしょを おくります。', 'Saya mengirim tagihan.'),
  ('n3', 28, 28, '在庫', 'ざいこ', 'stok', 'nomina', '在庫がありません。', 'ざいこが ありません。', 'Stoknya habis.'),
  ('n3', 28, 29, '納品', 'のうひん', 'pengiriman barang', 'nomina', '納品しました。', 'のうひんしました。', 'Barangnya sudah dikirim.'),
  ('n3', 28, 30, '取引', 'とりひき', 'transaksi', 'nomina', '取引があります。', 'とりひきが あります。', 'Ada transaksi.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 29 · 数・量・程度 =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 29, 1, '数', 'かず', 'jumlah', 'nomina', '数が足りません。', 'かずが たりません。', 'Jumlahnya kurang.'),
  ('n3', 29, 2, '半分', 'はんぶん', 'setengah', 'nomina', '半分食べました。', 'はんぶん たべました。', 'Saya makan setengahnya.'),
  ('n3', 29, 3, '倍', 'ばい', 'kali (lipat)', 'nomina', '二倍になりました。', 'にばいに なりました。', 'Menjadi dua kali lipat.'),
  ('n3', 29, 4, '平均', 'へいきん', 'rata-rata', 'nomina', '平均は八十点です。', 'へいきんは はちじゅってんです。', 'Rata-ratanya delapan puluh.'),
  ('n3', 29, 5, '合計', 'ごうけい', 'total', 'nomina', '合計は千円です。', 'ごうけいは せんえんです。', 'Totalnya seribu yen.'),
  ('n3', 29, 6, '残り', 'のこり', 'sisa', 'nomina', '残りは少しです。', 'のこりは すこしです。', 'Sisanya sedikit.'),
  ('n3', 29, 7, '以上', 'いじょう', 'lebih dari', 'nomina', '十人以上います。', 'じゅうにん いじょう います。', 'Ada sepuluh orang lebih.'),
  ('n3', 29, 8, '以下', 'いか', 'kurang dari', 'nomina', '五人以下です。', 'ごにん いかです。', 'Lima orang atau kurang.'),
  ('n3', 29, 9, '以内', 'いない', 'dalam batas', 'nomina', '一週間以内です。', 'いっしゅうかん いないです。', 'Dalam satu minggu.'),
  ('n3', 29, 10, '程度', 'ていど', 'tingkat / sekadar', 'nomina', 'この程度です。', 'この ていどです。', 'Sekitar segini.'),
  ('n3', 29, 11, '割合', 'わりあい', 'proporsi', 'nomina', '割合が高いです。', 'わりあいが たかいです。', 'Proporsinya tinggi.'),
  ('n3', 29, 12, '番目', 'ばんめ', 'ke- (urutan)', 'nomina', '三番目です。', 'さんばんめです。', 'Yang ketiga.'),
  ('n3', 29, 13, '回', 'かい', 'kali', 'nomina', '三回行きました。', 'さんかい いきました。', 'Saya pergi tiga kali.'),
  ('n3', 29, 14, '個', 'こ', 'buah (benda kecil)', 'nomina', 'りんごを三個買います。', 'りんごを さんこ かいます。', 'Saya beli tiga apel.'),
  ('n3', 29, 15, '枚', 'まい', 'lembar', 'nomina', '紙を二枚ください。', 'かみを にまい ください。', 'Minta dua lembar kertas.'),
  ('n3', 29, 16, '台', 'だい', 'unit (mesin)', 'nomina', '車が二台あります。', 'くるまが にだい あります。', 'Ada dua mobil.'),
  ('n3', 29, 17, '冊', 'さつ', 'buku (satuan)', 'nomina', '本を三冊借ります。', 'ほんを さんさつ かります。', 'Saya meminjam tiga buku.'),
  ('n3', 29, 18, '匹', 'ひき', 'ekor', 'nomina', '猫が二匹います。', 'ねこが にひき います。', 'Ada dua kucing.'),
  ('n3', 29, 19, '杯', 'はい', 'cangkir / gelas', 'nomina', 'コーヒーを一杯ください。', 'コーヒーを いっぱい ください。', 'Minta satu cangkir kopi.'),
  ('n3', 29, 20, 'セット', 'セット', 'set', 'nomina', '二つセットです。', 'ふたつ セットです。', 'Satu set dua buah.'),
  ('n3', 29, 21, '多数', 'たすう', 'banyak orang', 'nomina', '多数の人が来ました。', 'たすうの ひとが きました。', 'Banyak orang datang.'),
  ('n3', 29, 22, '少数', 'しょうすう', 'sedikit orang', 'nomina', '少数の意見です。', 'しょうすうの いけんです。', 'Pendapat minoritas.'),
  ('n3', 29, 23, '最大', 'さいだい', 'maksimum', 'nomina', '最大十人です。', 'さいだい じゅうにんです。', 'Maksimal sepuluh orang.'),
  ('n3', 29, 24, '最小', 'さいしょう', 'minimum', 'nomina', '最小の数です。', 'さいしょうの かずです。', 'Jumlah paling kecil.'),
  ('n3', 29, 25, '丁度', 'ちょうど', 'tepat', 'adverbia', '丁度十時です。', 'ちょうど じゅうじです。', 'Tepat jam sepuluh.'),
  ('n3', 29, 26, '大部分', 'だいぶぶん', 'sebagian besar', 'nomina', '大部分終わりました。', 'だいぶぶん おわりました。', 'Sebagian besar sudah selesai.'),
  ('n3', 29, 27, '数え方', 'かぞえかた', 'cara menghitung', 'nomina', '数え方が難しいです。', 'かぞえかたが むずかしいです。', 'Cara menghitungnya sulit.'),
  ('n3', 29, 28, '重さ', 'おもさ', 'berat', 'nomina', '重さを量ります。', 'おもさを はかります。', 'Saya menimbang beratnya.'),
  ('n3', 29, 29, '長さ', 'ながさ', 'panjang', 'nomina', '長さは二メートルです。', 'ながさは にメートルです。', 'Panjangnya dua meter.'),
  ('n3', 29, 30, '広さ', 'ひろさ', 'luas', 'nomina', '広さは二十畳です。', 'ひろさは にじゅうじょうです。', 'Luasnya dua puluh tatami.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 30 · 重要語レビュー① =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 30, 1, '機会', 'きかい', 'kesempatan', 'nomina', 'いい機会です。', 'いい きかいです。', 'Kesempatan bagus.'),
  ('n3', 30, 2, '状況', 'じょうきょう', 'situasi', 'nomina', '状況が変わりました。', 'じょうきょうが かわりました。', 'Situasinya berubah.'),
  ('n3', 30, 3, '理由', 'りゆう', 'alasan', 'nomina', '理由を教えてください。', 'りゆうを おしえてください。', 'Tolong beri tahu alasannya.'),
  ('n3', 30, 4, '目的', 'もくてき', 'tujuan', 'nomina', '目的は何ですか。', 'もくてきは なんですか。', 'Tujuannya apa?'),
  ('n3', 30, 5, '方法', 'ほうほう', 'metode', 'nomina', 'いい方法があります。', 'いい ほうほうが あります。', 'Ada cara yang bagus.'),
  ('n3', 30, 6, '結果', 'けっか', 'hasil', 'nomina', '結果が出ました。', 'けっかが でました。', 'Hasilnya keluar.'),
  ('n3', 30, 7, '原因', 'げんいん', 'penyebab', 'nomina', '原因が分かりません。', 'げんいんが わかりません。', 'Penyebabnya tidak tahu.'),
  ('n3', 30, 8, '内容', 'ないよう', 'isi', 'nomina', '内容を確認します。', 'ないようを かくにんします。', 'Saya memeriksa isinya.'),
  ('n3', 30, 9, '条件', 'じょうけん', 'syarat', 'nomina', '条件がいいです。', 'じょうけんが いいです。', 'Syaratnya bagus.'),
  ('n3', 30, 10, '立場', 'たちば', 'posisi / sudut pandang', 'nomina', '立場が違います。', 'たちばが ちがいます。', 'Posisinya berbeda.'),
  ('n3', 30, 11, '意味', 'いみ', 'arti', 'nomina', '意味が分かりません。', 'いみが わかりません。', 'Artinya tidak mengerti.'),
  ('n3', 30, 12, '記憶', 'きおく', 'ingatan', 'nomina', '記憶があいまいです。', 'きおくが あいまいです。', 'Ingatannya kabur.'),
  ('n3', 30, 13, '判断', 'はんだん', 'penilaian', 'nomina', '判断が難しいです。', 'はんだんが むずかしいです。', 'Sulit menilai.'),
  ('n3', 30, 14, '理解', 'りかい', 'pemahaman', 'nomina', '理解できました。', 'りかいできました。', 'Saya sudah paham.'),
  ('n3', 30, 15, '興味', 'きょうみ', 'minat', 'nomina', '興味があります。', 'きょうみが あります。', 'Saya tertarik.'),
  ('n3', 30, 16, '関心', 'かんしん', 'perhatian', 'nomina', '関心が高いです。', 'かんしんが たかいです。', 'Perhatiannya tinggi.'),
  ('n3', 30, 17, '印象', 'いんしょう', 'kesan', 'nomina', 'いい印象です。', 'いい いんしょうです。', 'Kesannya bagus.'),
  ('n3', 30, 18, '想像', 'そうぞう', 'imajinasi', 'nomina', '想像してください。', 'そうぞうしてください。', 'Tolong bayangkan.'),
  ('n3', 30, 19, '予想', 'よそう', 'perkiraan', 'nomina', '予想が当たりました。', 'よそうが あたりました。', 'Perkiraannya tepat.'),
  ('n3', 30, 20, '対策', 'たいさく', 'tindakan penanganan', 'nomina', '対策を考えます。', 'たいさくを かんがえます。', 'Saya memikirkan tindakan.'),
  ('n3', 30, 21, '手段', 'しゅだん', 'cara / sarana', 'nomina', '手段がありません。', 'しゅだんが ありません。', 'Tidak ada caranya.'),
  ('n3', 30, 22, '成果', 'せいか', 'hasil kerja', 'nomina', '成果が出ました。', 'せいかが でました。', 'Hasilnya terlihat.'),
  ('n3', 30, 23, '課題', 'かだい', 'tugas / tantangan', 'nomina', '課題が多いです。', 'かだいが おおいです。', 'Tantangannya banyak.'),
  ('n3', 30, 24, '計画', 'けいかく', 'rencana', 'nomina', '計画を立てます。', 'けいかくを たてます。', 'Saya membuat rencana.'),
  ('n3', 30, 25, '実行', 'じっこう', 'pelaksanaan', 'nomina', '計画を実行します。', 'けいかくを じっこうします。', 'Saya menjalankan rencana.'),
  ('n3', 30, 26, '可能性', 'かのうせい', 'kemungkinan', 'nomina', '可能性があります。', 'かのうせいが あります。', 'Ada kemungkinan.'),
  ('n3', 30, 27, '必要性', 'ひつようせい', 'keperluan', 'nomina', '必要性を感じます。', 'ひつようせいを かんじます。', 'Saya merasa perlu.'),
  ('n3', 30, 28, '優先', 'ゆうせん', 'prioritas', 'nomina', '仕事を優先します。', 'しごとを ゆうせんします。', 'Saya memprioritaskan kerja.'),
  ('n3', 30, 29, '具体的', 'ぐたいてき', 'konkret', 'adjektiva-na', '具体的に話します。', 'ぐたいてきに はなします。', 'Saya bicara konkret.'),
  ('n3', 30, 30, '一般的', 'いっぱんてき', 'umum', 'adjektiva-na', '一般的な考えです。', 'いっぱんてきな かんがえです。', 'Pandangan yang umum.')
on conflict (level, hari_ke, urutan) do nothing;

-- ===== Hari 31 · 重要語レビュー② =====
insert into public.kosakata
  (level, hari_ke, urutan, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id)
values
  ('n3', 31, 1, '知識', 'ちしき', 'pengetahuan', 'nomina', '知識が足りません。', 'ちしきが たりません。', 'Pengetahuannya kurang.'),
  ('n3', 31, 2, '技術', 'ぎじゅつ', 'teknologi / teknik', 'nomina', '技術が進みました。', 'ぎじゅつが すすみました。', 'Teknologinya maju.'),
  ('n3', 31, 3, '能力', 'のうりょく', 'kemampuan', 'nomina', '能力が高いです。', 'のうりょくが たかいです。', 'Kemampuannya tinggi.'),
  ('n3', 31, 4, '才能', 'さいのう', 'bakat', 'nomina', '才能があります。', 'さいのうが あります。', 'Dia punya bakat.'),
  ('n3', 31, 5, '成長', 'せいちょう', 'pertumbuhan', 'nomina', '成長が早いです。', 'せいちょうが はやいです。', 'Pertumbuhannya cepat.'),
  ('n3', 31, 6, '進歩', 'しんぽ', 'kemajuan', 'nomina', '進歩がありません。', 'しんぽが ありません。', 'Tidak ada kemajuan.'),
  ('n3', 31, 7, '変化', 'へんか', 'perubahan', 'nomina', '変化が大きいです。', 'へんかが おおきいです。', 'Perubahannya besar.'),
  ('n3', 31, 8, '特徴', 'とくちょう', 'ciri khas', 'nomina', '特徴を説明します。', 'とくちょうを せつめいします。', 'Saya menjelaskan cirinya.'),
  ('n3', 31, 9, '違い', 'ちがい', 'perbedaan', 'nomina', '違いが分かります。', 'ちがいが わかります。', 'Saya tahu bedanya.'),
  ('n3', 31, 10, '共通', 'きょうつう', 'kesamaan', 'nomina', '共通の趣味です。', 'きょうつうの しゅみです。', 'Hobi yang sama.'),
  ('n3', 31, 11, '比較', 'ひかく', 'perbandingan', 'nomina', '比較してみます。', 'ひかくしてみます。', 'Saya coba bandingkan.'),
  ('n3', 31, 12, '保証', 'ほしょう', 'jaminan', 'nomina', '保証があります。', 'ほしょうが あります。', 'Ada jaminannya.'),
  ('n3', 31, 13, '責任', 'せきにん', 'tanggung jawab', 'nomina', '責任があります。', 'せきにんが あります。', 'Ada tanggung jawabnya.'),
  ('n3', 31, 14, '義務', 'ぎむ', 'kewajiban', 'nomina', '義務を果たします。', 'ぎむを はたします。', 'Saya menunaikan kewajiban.'),
  ('n3', 31, 15, '権利', 'けんり', 'hak', 'nomina', '権利があります。', 'けんりが あります。', 'Ada haknya.'),
  ('n3', 31, 16, '平等', 'びょうどう', 'kesetaraan', 'nomina', '平等が大切です。', 'びょうどうが たいせつです。', 'Kesetaraan itu penting.'),
  ('n3', 31, 17, '態度', 'たいど', 'sikap', 'nomina', '態度がいいです。', 'たいどが いいです。', 'Sikapnya bagus.'),
  ('n3', 31, 18, '信頼', 'しんらい', 'kepercayaan', 'nomina', '信頼しています。', 'しんらいしています。', 'Saya mempercayainya.'),
  ('n3', 31, 19, '尊敬', 'そんけい', 'rasa hormat', 'nomina', '尊敬しています。', 'そんけいしています。', 'Saya menghormatinya.'),
  ('n3', 31, 20, '感謝', 'かんしゃ', 'rasa syukur', 'nomina', '感謝しています。', 'かんしゃしています。', 'Saya bersyukur.'),
  ('n3', 31, 21, '協力', 'きょうりょく', 'kerja sama', 'nomina', '協力してください。', 'きょうりょくしてください。', 'Mohon kerja samanya.'),
  ('n3', 31, 22, '交流', 'こうりゅう', 'interaksi', 'nomina', '交流があります。', 'こうりゅうが あります。', 'Ada interaksi.'),
  ('n3', 31, 23, '実力', 'じつりょく', 'kemampuan nyata', 'nomina', '実力があります。', 'じつりょくが あります。', 'Dia punya kemampuan nyata.'),
  ('n3', 31, 24, '自信', 'じしん', 'percaya diri', 'nomina', '自信がありません。', 'じしんが ありません。', 'Saya tidak percaya diri.'),
  ('n3', 31, 25, '集中', 'しゅうちゅう', 'konsentrasi', 'nomina', '集中してください。', 'しゅうちゅうしてください。', 'Tolong konsentrasi.'),
  ('n3', 31, 26, '向上', 'こうじょう', 'peningkatan', 'nomina', '能力が向上しました。', 'のうりょくが こうじょうしました。', 'Kemampuannya meningkat.'),
  ('n3', 31, 27, '評価', 'ひょうか', 'penilaian', 'nomina', '評価が高いです。', 'ひょうかが たかいです。', 'Penilaiannya tinggi.'),
  ('n3', 31, 28, '貢献', 'こうけん', 'kontribusi', 'nomina', '会社に貢献します。', 'かいしゃに こうけんします。', 'Saya berkontribusi ke perusahaan.'),
  ('n3', 31, 29, '段階', 'だんかい', 'tahap', 'nomina', '次の段階です。', 'つぎの だんかいです。', 'Tahap berikutnya.'),
  ('n3', 31, 30, '継続', 'けいぞく', 'kelanjutan', 'nomina', '継続が大事です。', 'けいぞくが だいじです。', 'Konsistensi itu penting.')
on conflict (level, hari_ke, urutan) do nothing;
