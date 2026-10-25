-- ============================================================================
-- KEIGO — 敬語 untuk kerja hotel (尊敬語・謙譲語・丁寧語)
-- level, kategori, dasar (bentuk biasa), arti, sonkei, kenjo, contoh, arti contoh
-- Aman dijalankan berulang.
-- ============================================================================

create table if not exists public.keigo (
  id       bigserial primary key,
  level    text not null default 'n3',
  urutan   int  not null,
  kategori text not null,          -- 'dasar' | 'hotel'
  dasar    text not null,          -- 行く
  arti     text not null,          -- pergi
  sonkei   text,                   -- 尊敬語 (untuk atasan/tamu)
  kenjo    text,                   -- 謙譲語 (untuk diri sendiri)
  contoh_jp text not null,         -- kalimat siap pakai
  contoh_id text not null,
  unique (level, urutan)
);

alter table public.keigo enable row level security;
drop policy if exists "baca keigo" on public.keigo;
create policy "baca keigo" on public.keigo for select to authenticated using (true);

insert into public.keigo (level, urutan, kategori, dasar, arti, sonkei, kenjo, contoh_jp, contoh_id) values
('n3',  1, 'dasar', '行く・来る',          'pergi / datang',        'いらっしゃる',        '参る・伺う',        '部長はまもなくいらっしゃいます。',            'Kepala bagian akan segera datang.'),
('n3',  2, 'dasar', 'いる',                'ada (orang)',           'いらっしゃる',        'おる',              '田中様はいらっしゃいますか。',                'Apakah Tuan Tanaka ada?'),
('n3',  3, 'dasar', '食べる・飲む',        'makan / minum',         '召し上がる',          'いただく',          'どうぞ召し上がってください。',                'Silakan makan.'),
('n3',  4, 'dasar', '言う',                'mengatakan',            'おっしゃる',          '申す・申し上げる',   '社長がおっしゃったとおりです。',              'Seperti yang dikatakan direktur.'),
('n3',  5, 'dasar', '見る',                'melihat',               'ご覧になる',          '拝見する',          '資料をご覧になりましたか。',                  'Apakah Anda sudah melihat dokumennya?'),
('n3',  6, 'dasar', 'する',                'melakukan',             'なさる',              'いたす',            '私がご案内いたします。',                      'Saya yang akan mengantar.'),
('n3',  7, 'dasar', '知る',                'tahu',                  'ご存じだ',            '存じる',            'その件は存じております。',                    'Saya tahu soal itu.'),
('n3',  8, 'dasar', '会う',                'bertemu',               'お会いになる',        'お目にかかる',      '先日お目にかかりました。',                    'Kami bertemu tempo hari.'),
('n3',  9, 'dasar', '聞く',                'mendengar / bertanya',  'お聞きになる',        '伺う・拝聴する',     '1つ伺ってもよろしいですか。',                 'Boleh saya bertanya satu hal?'),
('n3', 10, 'dasar', '待つ',                'menunggu',              'お待ちになる',        'お待ちする',        'ロビーでお待ちしております。',                'Kami menunggu di lobi.'),
('n3', 11, 'dasar', '思う',                'berpikir / merasa',     'お思いになる',        '存じる',            'いかがお思いですか。',                        'Bagaimana pendapat Anda?'),
('n3', 12, 'dasar', 'あげる',              'memberi',               'くださる',            '差し上げる',        'お土産を差し上げました。',                    'Saya memberi oleh-oleh.'),
('n3', 13, 'dasar', 'もらう',              'menerima',              'お受け取りになる',    'いただく',          'お菓子をいただきました。',                    'Saya menerima kue.'),
('n3', 14, 'dasar', '持つ',                'membawa / memegang',    'お持ちになる',        'お持ちする',        'お荷物をお持ちします。',                      'Saya bawakan barangnya.'),
('n3', 15, 'dasar', '伝える',              'menyampaikan',          'お伝えになる',        'お伝えする',        'お伝えしておきます。',                        'Akan saya sampaikan.'),
('n3', 16, 'dasar', '読む',                'membaca',               'お読みになる',        '拝読する',          'レポートを拝読しました。',                    'Saya sudah membaca laporannya.'),
('n3', 17, 'dasar', '書く',                'menulis',               'お書きになる',        'お書きする',        'こちらにお書きいただけますか。',              'Bisa ditulis di sini?'),
('n3', 18, 'dasar', '分かる',              'mengerti',              'ご理解いただく',      '承知する',          '事情は承知しております。',                    'Saya paham keadaannya.'),
('n3', 19, 'dasar', '着る',                'memakai (baju)',        'お召しになる',        '着させていただく',   '制服はお召しになりますか。',                  'Apakah Anda akan memakai seragam?'),
('n3', 20, 'dasar', '寝る',                'tidur',                 'お休みになる',        '休ませていただく',   'ゆっくりお休みください。',                    'Silakan beristirahat tenang.'),
('n3', 21, 'dasar', '使う',                'memakai',               'お使いになる',        '使わせていただく',   'この券をお使いください。',                    'Silakan pakai kupon ini.'),
('n3', 22, 'dasar', '買う',                'membeli',               'お求めになる',        '買わせていただく',   'どこでお求めになりましたか。',                'Anda beli di mana?'),
('n3', 23, 'dasar', '見せる',              'menunjukkan',           'お見せになる',        'お目にかける',      'お部屋をご案内してご覧に入れます。',          'Saya antar dan tunjukkan kamarnya.'),

('n3', 24, 'hotel', 'いらっしゃいませ',     'selamat datang',       null, null, 'いらっしゃいませ。ご予約を承っております。',  'Selamat datang. Kami menangani reservasi Anda.'),
('n3', 25, 'hotel', '少々お待ちください',   'mohon tunggu sebentar', null, null, '少々お待ちください。すぐにお調べいたします。', 'Mohon tunggu sebentar. Segera saya cek.'),
('n3', 26, 'hotel', 'かしこまりました',     'baik, siap',           null, null, 'かしこまりました。お部屋までご案内いたします。','Baik. Saya antar ke kamar.'),
('n3', 27, 'hotel', '恐れ入りますが',       'maaf, permisi',        null, null, '恐れ入りますが、こちらにお名前をお願いいたします。', 'Maaf, mohon isi nama Anda di sini.'),
('n3', 28, 'hotel', 'ご案内いたします',     'saya antarkan',        null, null, 'お荷物をお持ちして、お部屋へご案内いたします。','Saya bawakan barangnya dan antar ke kamar.'),
('n3', 29, 'hotel', 'ごゆっくりどうぞ',     'silakan menikmati',    null, null, 'ごゆっくりどうぞ。何かございましたらお申し付けください。', 'Silakan menikmati. Beri tahu kami jika perlu apa-apa.'),
('n3', 30, 'hotel', 'お会計はこちらです',   'pembayaran di sini',   null, null, 'お会計はこちらのカウンターでございます。',    'Pembayaran di loket ini.'),
('n3', 31, 'hotel', '承知いたしました',     'baik, mengerti',       null, null, '承知いたしました。そのように手配いたします。','Baik, mengerti. Saya atur seperti itu.'),
('n3', 32, 'hotel', 'お手数をおかけします','mohon maaf merepotkan', null, null, 'お手数をおかけしますが、ご記入をお願いいたします。','Maaf merepotkan, mohon diisi.'),
('n3', 33, 'hotel', 'ご不明な点がありましたら', 'kalau ada yang belum jelas', null, null, 'ご不明な点がありましたら、いつでもお申し付けください。', 'Kalau ada yang belum jelas, kapan saja beri tahu kami.'),
('n3', 34, 'hotel', 'お申し付けください',   'silakan minta',        null, null, '何なりとお申し付けください。',                'Silakan minta apa saja.'),
('n3', 35, 'hotel', 'ただいま確認いたします', 'sekarang saya cek',  null, null, 'ただいま確認いたします。少々お待ちください。','Sekarang saya cek. Mohon tunggu.'),
('n3', 36, 'hotel', 'お部屋の準備が整いました', 'kamar sudah siap', null, null, 'お部屋の準備が整いました。お荷物はこちらです。','Kamar sudah siap. Bagasi Anda di sini.'),
('n3', 37, 'hotel', '申し訳ございません',   'saya minta maaf',      null, null, '申し訳ございません。すぐに新しいものをお持ちします。', 'Minta maaf. Segera saya bawakan yang baru.'),
('n3', 38, 'hotel', 'よろしければ',         'kalau berkenan',       null, null, 'よろしければ、こちらをご利用ください。',      'Kalau berkenan, silakan gunakan ini.'),
('n3', 39, 'hotel', 'お待たせいたしました', 'terima kasih menunggu', null, null, 'お待たせいたしました。こちらがお食事でございます。', 'Maaf membuat menunggu. Ini makanannya.'),
('n3', 40, 'hotel', 'こちらが〜でございます', 'ini adalah',        null, null, 'こちらが朝食会場でございます。',              'Ini adalah tempat sarapan.')
on conflict (level, urutan) do update set
  kategori = excluded.kategori, dasar = excluded.dasar, arti = excluded.arti,
  sonkei = excluded.sonkei, kenjo = excluded.kenjo,
  contoh_jp = excluded.contoh_jp, contoh_id = excluded.contoh_id;

select kategori, count(*) from public.keigo where level = 'n3' group by kategori;
