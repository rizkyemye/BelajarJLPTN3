-- ============================================================================
-- FIX · "infinite recursion detected in policy for relation profiles"
--
-- Sebab (bug dari saya): policy di tabel profiles menanyakan tabel profiles
-- lagi → berputar terus.
-- Solusi: satu fungsi SECURITY DEFINER yang menembus RLS, lalu semua policy
-- memakai fungsi itu.
--
-- Jalankan di SQL Editor. Aman diulang.
-- ============================================================================

-- ---------- 1. fungsi penentu admin ----------
create or replace function public.apakah_admin()
returns boolean
language sql
security definer
stable
set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

grant execute on function public.apakah_admin() to authenticated, anon;

-- ---------- 2. bersihkan semua policy lama di profiles ----------
drop policy if exists "baca profil sendiri"      on public.profiles;
drop policy if exists "admin baca semua profil"  on public.profiles;
drop policy if exists "admin baca semua"         on public.profiles;
drop policy if exists "admin ubah profil"        on public.profiles;
drop policy if exists "admin ubah semua"         on public.profiles;

-- ---------- 3. policy baru — TIDAK menanyakan tabel profiles ----------
create policy "baca profil sendiri"
  on public.profiles for select
  to authenticated
  using (id = auth.uid());

create policy "admin baca semua profil"
  on public.profiles for select
  to authenticated
  using (public.apakah_admin());

create policy "admin ubah profil"
  on public.profiles for update
  to authenticated
  using (public.apakah_admin())
  with check (public.apakah_admin());

-- ---------- 4. policy kosakata juga pakai fungsi (biar tidak memicu RLS profiles) ----------
drop policy if exists "admin kelola kosakata" on public.kosakata;
create policy "admin kelola kosakata"
  on public.kosakata for all
  to authenticated
  using (public.apakah_admin())
  with check (public.apakah_admin());

drop policy if exists "baca kosakata" on public.kosakata;
create policy "baca kosakata"
  on public.kosakata for select
  to authenticated
  using (true);

-- ---------- 5. cek ----------
select policyname, cmd, roles
from pg_policies
where tablename in ('profiles','kosakata')
order by tablename, policyname;
