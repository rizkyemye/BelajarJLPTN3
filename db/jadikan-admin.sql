-- ============================================================================
-- SATU-SATUNYA yang perlu dijalankan untuk panel admin
-- (form kosakata + panel admin tidak butuh tabel baru)
--
-- Isi: jadikan akunmu admin, lalu buktikan policy-nya siap.
-- Jalankan SEKALI di SQL Editor. Aman diulang.
-- ============================================================================

-- ---------- 1. jadikan admin ----------
update public.profiles
   set role = 'admin'
 where username = 'rizkyemye';

-- kalau mau lebih aman, sebut lewat email-nya:
-- update public.profiles p set role = 'admin'
-- from auth.users u
-- where u.id = p.id and u.email = 'rizkyemye@n3master.local';

-- ---------- 2. pastikan fungsi penembus RLS ada ----------
create or replace function public.apakah_admin()
returns boolean
language sql security definer stable
set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;
grant execute on function public.apakah_admin() to authenticated, anon;

-- ---------- 3. pastikan policy kosakata (insert/update/delete) ada ----------
drop policy if exists "admin kelola kosakata" on public.kosakata;
create policy "admin kelola kosakata"
  on public.kosakata for all
  to authenticated
  using (public.apakah_admin())
  with check (public.apakah_admin());

-- ---------- 4. pastikan policy profil admin ada ----------
drop policy if exists "admin baca semua profil" on public.profiles;
create policy "admin baca semua profil"
  on public.profiles for select
  to authenticated
  using (public.apakah_admin());

drop policy if exists "admin ubah profil" on public.profiles;
create policy "admin ubah profil"
  on public.profiles for update
  to authenticated
  using (public.apakah_admin())
  with check (public.apakah_admin());

-- ---------- 5. BUKTI: harus muncul role = admin ----------
select username, level, role, status
from public.profiles
order by created_at;

-- ---------- 6. BUKTI: policy yang aktif ----------
select tablename, policyname, cmd
from pg_policies
where tablename in ('profiles','kosakata')
order by tablename, policyname;
