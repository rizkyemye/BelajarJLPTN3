-- ============================================================================
-- FIX · "Profil akun tidak ditemukan" padahal barisnya ADA
--
-- Sebab: baris di tabel profiles tidak terbaca oleh user yang login (RLS).
-- Solusi: ambil profil lewat RPC SECURITY DEFINER — selalu mengembalikan
--         baris MILIK user yang sedang login, tidak terpengaruh RLS.
--
-- Aman dijalankan berulang. Jalankan di SQL Editor.
-- ============================================================================

-- ---------- 1. fungsi ambil profil sendiri ----------
create or replace function public.profil_saya()
returns table (
  username text,
  level    text,
  status   text,
  role     text
)
language sql
security definer
stable
set search_path = public
as $$
  select p.username, p.level, p.status, p.role
  from public.profiles p
  where p.id = auth.uid();
$$;

grant execute on function public.profil_saya() to authenticated;

-- ---------- 2. rapikan policy baca profil ----------
alter table public.profiles enable row level security;

drop policy if exists "baca profil sendiri" on public.profiles;
create policy "baca profil sendiri"
  on public.profiles for select
  to authenticated
  using (id = auth.uid());

-- ---------- 3. pastikan grant tabel ----------
grant select on public.profiles to authenticated;
grant update on public.profiles to authenticated;

-- ---------- 4. bukti: policy yang aktif ----------
select schemaname, tablename, policyname, cmd, roles
from pg_policies
where tablename = 'profiles';

-- ---------- 5. uji fungsi (dijalankan sebagai service role, hasil = 0 baris) ----------
select proname, prosecdef
from pg_proc
where proname in ('profil_saya');
