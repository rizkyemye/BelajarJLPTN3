-- ============================================================================
-- DOKKAI gaya JLPT — contoh Hari 1–3
--
-- 3 bentuk soal seperti JLPT N3:
--   ① setsumei  : 短文 + pilihan jawaban panjang (内容把握)
--   ② email     : メール (件名 + isi) + pertanyaan
--   ③ oshirase  : お知らせ / 掲示 (info检索)
--
-- Kolom `jenis` menentukan tampilan. Baris lama otomatis 'setsumei'.
-- Aman dijalankan berulang.
-- ============================================================================

alter table public.dokkai
  add column if not exists jenis text not null default 'setsumei';

-- ============================================================================
-- HARI 1 · setsumei — 生活 / kebiasaan kecil
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
  'n3', 1, '生活', '小さな習慣', 'Kebiasaan kecil',

'毎日の生活の中で、少しの時間でできることを続ける人がいる。五分だけ運動する、寝る前に日記を書く、といった小さな習慣だ。始めたばかりのころは効果が分からないが、三か月も続けると、体も気持ちも変わるという。大切なのは、一度にたくさんやろうとしないことだ。',

'まいにちの せいかつの なかで、すこしの じかんで できることを つづける ひとが いる。ごふんだけ うんどうする、ねる まえに にっきを かく、と いった ちいさな しゅうかんだ。はじめた ばかりの ころは こうかが わからないが、さんかげつも つづけると、からだも きもちも かわる という。たいせつなのは、いちどに たくさん やろうと しない ことだ。',

'Di dalam kehidupan sehari-hari, ada orang yang melanjutkan hal-hal yang bisa dikerjakan dalam waktu sedikit. Kebiasaan kecil, seperti olahraga lima menit saja atau menulis buku harian sebelum tidur. Saat baru mulai, efeknya belum terasa, tetapi kalau diteruskan sampai tiga bulan, katanya badan dan perasaan ikut berubah. Yang penting adalah tidak mencoba melakukan banyak hal sekaligus.',

'[
 {"tanya":"この文章で筆者が一番言いたいことは何か。",
  "pilihan":[
    "小さなことを毎日続けることが大切だ。",
    "一度にたくさん運動したほうが効果がある。",
    "三か月続けても、生活は変わらない。",
    "日記を書く人はとても少ない。"
  ],"benar":0},

 {"tanya":"文章によると、始めたばかりのころはどうか。",
  "pilihan":[
    "すぐに体も気持ちも変わる。",
    "効果がまだ分からない。",
    "やめたくなる人が多い。",
    "時間が足りなくて続けられない。"
  ],"benar":1},

 {"tanya":"筆者が「大切なのは、一度にたくさんやろうとしないことだ」と言っているのはなぜか。",
  "pilihan":[
    "たくさんやると、お金がかかるから。",
    "毎日少しずつ続けたほうが長く続けられるから。",
    "一度にやると、体を壊すことが決まっているから。",
    "運動は、しないほうがいいと思っているから。"
  ],"benar":1}
]'::jsonb,
  'setsumei'
)
on conflict (level, hari_ke) do update set
  tema = excluded.tema, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  teks_jp = excluded.teks_jp, teks_furi = excluded.teks_furi, teks_id = excluded.teks_id,
  soal = excluded.soal, jenis = excluded.jenis;


-- ============================================================================
-- HARI 2 · email — 家族・人 / undangan
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
  'n3', 2, '家族・人', '親戚の集まり', 'Acara kumpul keluarga',

'件名：親戚の集まりのお知らせ
みなさん
お元気ですか。鈴木です。来月、久しぶりに親戚が集まることになりました。
日時：12月7日（日）12時から
場所：祖母の家
料理はこちらで準備します。飲み物を持ってきてください。
参加できない人は、今週中に連絡してください。',

'けんめい：しんせきの あつまりの おしらせ
みなさん
おげんきですか。すずきです。らいげつ、ひさしぶりに しんせきが あつまる ことに なりました。
にちじ：じゅうにがつ なのか（にち）じゅうにじから
ばしょ：そぼの いえ
りょうりは こちらで じゅんびします。のみものを もってきて ください。
さんかできない ひとは、こんしゅうちゅうに れんらくして ください。',

'Subjek: Pemberitahuan kumpul keluarga
Semua,
Apa kabar? Saya Suzuki. Bulan depan, untuk pertama kalinya sejak lama, keluarga besar akan berkumpul.
Tanggal: 7 Desember (Minggu) mulai jam 12
Tempat: rumah nenek
Makanan disiapkan di sini. Mohon bawa minuman.
Yang tidak bisa ikut, mohon menghubungi dalam pekan ini.',

'[
 {"tanya":"このメールを読んだ人は、何を持って行かなければならないか。",
  "pilihan":[
    "飲み物を持って行かなければならない。",
    "料理を全部作って持って行かなければならない。",
    "椅子とテーブルを持って行かなければならない。",
    "何も持って行かなくてもいい。"
  ],"benar":0},

 {"tanya":"集まりに参加できない人は、どうしなければならないか。",
  "pilihan":[
    "12月7日の12時までに、祖母の家へ行く。",
    "今週中に鈴木さんに連絡する。",
    "来月までに、もう一度メールを送る。",
    "料理を作ってから、家に帰る。"
  ],"benar":1},

 {"tanya":"集まりはいつ、どこで行われるか。",
  "pilihan":[
    "12月7日の12時から、祖母の家で行われる。",
    "12月7日の朝9時から、鈴木さんの家で行われる。",
    "今週の日曜日の夜、ホテルで行われる。",
    "1月7日の12時から、祖母の家で行われる。"
  ],"benar":0}
]'::jsonb,
  'email'
)
on conflict (level, hari_ke) do update set
  tema = excluded.tema, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  teks_jp = excluded.teks_jp, teks_furi = excluded.teks_furi, teks_id = excluded.teks_id,
  soal = excluded.soal, jenis = excluded.jenis;


-- ============================================================================
-- HARI 3 · oshirase — 体・健康 / pengumuman pemeriksaan kesehatan
-- ============================================================================
insert into public.dokkai (level, hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal, jenis)
values (
  'n3', 3, '体・健康', '健康診断のお知らせ', 'Pemberitahuan pemeriksaan kesehatan',

'健康診断のお知らせ
・受付時間：午前8時30分から11時まで
・場所：市民病院 2階
・前の日の夜9時から、何も食べないでください。水は飲んでもかまいません。
・保険証と問診票を持ってきてください。
・予約は必要ありません。',

'けんこうしんだんの おしらせ
・うけつけじかん：ごぜん はちじ さんじゅっぷんから じゅういちじまで
・ばしょ：しみんびょういん にかい
・まえのひの よる くじから、なにも たべないで ください。みずは のんでも かまいません。
・ほけんしょうと もんしんひょうを もってきて ください。
・よやくは ひつよう ありません。',

'Pemberitahuan pemeriksaan kesehatan
・Jam penerimaan: 08.30 sampai 11.00 pagi
・Tempat: Rumah Sakit Kota, lantai 2
・Mulai jam 9 malam hari sebelumnya, jangan makan apa pun. Air boleh diminum.
・Mohon bawa kartu asuransi dan lembar kuesioner.
・Tidak perlu reservasi.',

'[
 {"tanya":"前の日の夜9時から、何をしてはいけないか。",
  "pilihan":[
    "何も食べてはいけない。",
    "水を飲んではいけない。",
    "早く寝てはいけない。",
    "病院に行ってはいけない。"
  ],"benar":0},

 {"tanya":"当日、持って行かなければならないものはどれか。",
  "pilihan":[
    "保険証と問診票",
    "予約票とお金",
    "水と食べ物",
    "病院の地図と筆記用具"
  ],"benar":0},

 {"tanya":"このお知らせによると、予約についてどうなっているか。",
  "pilihan":[
    "必ず電話で予約しなければならない。",
    "予約は必要ない。",
    "前の日までに予約しなければならない。",
    "予約は午後からしかできない。"
  ],"benar":1}
]'::jsonb,
  'oshirase'
)
on conflict (level, hari_ke) do update set
  tema = excluded.tema, judul_jp = excluded.judul_jp, judul_id = excluded.judul_id,
  teks_jp = excluded.teks_jp, teks_furi = excluded.teks_furi, teks_id = excluded.teks_id,
  soal = excluded.soal, jenis = excluded.jenis;

-- cek: select hari_ke, jenis, judul_jp, jsonb_array_length(soal) from public.dokkai order by hari_ke limit 5;
