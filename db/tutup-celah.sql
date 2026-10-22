-- ============================================================================
-- TUTUP CELAH — 3 lubang yang ketemu saat periksa kode
-- Jalankan di Supabase → SQL Editor → Run. Aman diulang.
--
-- 1. User bisa memalsukan progres (selesai hari tanpa belajar)
-- 2. View `statistik` bocor ke pengunjung tanpa login
-- 3. (manual, di dashboard) sandi minimal 6 → 8
-- ============================================================================


-- ---------------------------------------------------------------------------
-- 1. CABUT TULIS LANGSUNG DARI KLIEN
--
-- Sebelumnya user (login) boleh insert/update baris review & hari MILIKNYA
-- langsung lewat REST. Artinya siapa pun bisa:
--   PATCH /rest/v1/review?user_id=eq.<dirinya>  {"status":"hafal","tahap":5}
--   POST  /rest/v1/hari  {"hari_ke":42,"status":"selesai"}
-- → semua hari terbuka tanpa belajar.
--
-- Pemilik asli baris ini tidak dipakai aplikasi: semua penulisan sudah lewat
-- RPC SECURITY DEFINER (mulai_hari, nilai_review, selesaikan_review,
-- mulai_hari_kanji, nilai_kanji). Jadi policy tulisnya aman dicabut.
-- ---------------------------------------------------------------------------

drop policy if exists "tulis review sendiri"        on public.review;
drop policy if exists "ubah review sendiri"         on public.review;
drop policy if exists "tulis hari sendiri"          on public.hari;
drop policy if exists "tulis review kanji sendiri"  on public.review_kanji;
drop policy if exists "ubah review kanji sendiri"   on public.review_kanji;

-- baca sendiri tetap ada (dipakai halaman-halaman)


-- ---------------------------------------------------------------------------
-- 2. VIEW STATISTIK: jangan bisa dibaca tanpa login
-- View tidak ikut RLS. Tanpa ini, siapa pun yang punya publishable key bisa
-- `select * from statistik` dan melihat jumlah akun, aktif 7 hari, dll.
-- Panel admin tidak memakai view ini, jadi aman dicabut.
-- ---------------------------------------------------------------------------

revoke all on public.statistik from anon;
revoke all on public.statistik from authenticated;


-- ---------------------------------------------------------------------------
-- 3. BUKTI — policy yang masih aktif setelah dijalankan
-- ---------------------------------------------------------------------------

select tablename, policyname, cmd
from pg_policies
where schemaname = 'public'
  and tablename in ('review', 'hari', 'review_kanji')
order by tablename, cmd;


-- ============================================================================
-- MASIH HARUS MANUAL DI DASHBOARD (tidak bisa lewat SQL):
--
-- a) Authentication → Providers → Email
--    · Minimum password length : 8   (sekarang 6, cek klien bisa di-bypass)
--
-- b) Authentication → Rate limits
--    · kurangi "token refresh" & "sign in/sign up" kalau tersedia
--
-- c) Kalau mau daftar TIDAK bisa pilih level N3 langsung:
--      buat_profil() → ganti `coalesce(...->>'level','n5')` jadi `'n5'`
--    (sekarang user bebas daftar langsung ke N3)
-- ============================================================================
