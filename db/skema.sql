-- ============================================================================
-- Belajar N3 · skema database (Supabase)
-- Jalankan di: Supabase → SQL Editor → New query → paste → Run
--
-- PERUBAHAN: login pakai Supabase Auth (bukan tabel password sendiri).
--   Username dipetakan jadi email internal:  nama → nama@n3master.local
--   Password disimpan Supabase di auth.users (bcrypt, tidak bisa dibaca).
-- Tabel kita cuma menyimpan DATA PROFIL (level, role, status).
-- ============================================================================

-- ---------- 1. profil (1 baris = 1 akun) ----------
create table if not exists public.profiles (
  id            uuid primary key references auth.users(id) on delete cascade,
  username      text unique not null,
  level         text not null default 'n5'
                check (level in ('n5','n4','n3')),
  role          text not null default 'user'
                check (role in ('user','admin')),
  status        text not null default 'aktif'
                check (status in ('aktif','ditangguhkan')),
  created_at    timestamptz not null default now(),
  last_login_at timestamptz,

  constraint username_format check (username ~ '^[a-zA-Z0-9._]{3,24}$')
);

create index if not exists profiles_status_idx on public.profiles (status);
create index if not exists profiles_level_idx  on public.profiles (level);

-- ---------- 2. progress ----------
create table if not exists public.progress (
  id         bigint generated always as identity primary key,
  user_id    uuid not null references public.profiles(id) on delete cascade,
  topik      text not null,
  hari_ke    int  not null,
  selesai_at timestamptz not null default now(),
  unique (user_id, hari_ke)
);

create index if not exists progress_user_idx on public.progress (user_id, selesai_at desc);

-- ---------- 3. profil otomatis saat daftar ----------
-- metadata.username dikirim dari form pendaftaran
create or replace function public.buat_profil()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, username, level)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'username', split_part(new.email,'@',1)),
    coalesce(new.raw_user_meta_data->>'level', 'n5')
  );
  return new;
end;
$$;

drop trigger if exists on_daftar on auth.users;
create trigger on_daftar
  after insert on auth.users
  for each row execute function public.buat_profil();

-- ---------- 4. RLS ----------
alter table public.profiles  enable row level security;
alter table public.progress  enable row level security;

drop policy if exists "baca profil sendiri" on public.profiles;
create policy "baca profil sendiri"
  on public.profiles for select
  using (id = auth.uid());

drop policy if exists "admin baca semua profil" on public.profiles;
create policy "admin baca semua profil"
  on public.profiles for select
  using (exists (select 1 from public.profiles p where p.id = auth.uid() and p.role = 'admin'));

drop policy if exists "admin ubah profil" on public.profiles;
create policy "admin ubah profil"
  on public.profiles for update
  using (exists (select 1 from public.profiles p where p.id = auth.uid() and p.role = 'admin'));

drop policy if exists "baca progress sendiri" on public.progress;
create policy "baca progress sendiri"
  on public.progress for select
  using (user_id = auth.uid());

drop policy if exists "tulis progress sendiri" on public.progress;
create policy "tulis progress sendiri"
  on public.progress for insert
  with check (user_id = auth.uid());

-- ---------- 5. bantuan ----------
create or replace function public.tandai_login()
returns void language sql security definer as $$
  update public.profiles set last_login_at = now() where id = auth.uid();
$$;

create or replace view public.statistik as
select
  count(*)                                                          as total_user,
  count(*) filter (where last_login_at > now() - interval '7 days') as aktif_7hari,
  count(*) filter (where status = 'ditangguhkan')                   as ditangguhkan,
  count(*) filter (where level = 'n3')                              as n3,
  count(*) filter (where level = 'n4')                              as n4,
  count(*) filter (where level = 'n5')                              as n5
from public.profiles;

-- ============================================================================
-- SETELAH RUN — 2 setelan manual di dashboard (sekali saja):
--
-- 1. Authentication → Sign In / Providers → Email
--    · "Confirm email"  → MATIKAN  (biar daftar langsung bisa login)
--
-- 2. Bikin admin pertama:
--    Authentication → Users → Add user
--       Email    : namaadmin@n3master.local
--       Password : (isi kuat)
--       Auto Confirm User : ✓
--    Lalu jalankan:
--       update public.profiles set role = 'admin', level = 'n3'
--       where username = 'namaadmin';
--
-- CATATAN: email asli tidak dipakai. Pola: <username>@n3master.local
-- ============================================================================


-- ---------- 6. cek username (dipanggil halaman daftar) ----------
-- Mengembalikan TRUE kalau username sudah dipakai.
-- security definer: boleh dipakai anon, tapi hanya mengembalikan ya/tidak.
create or replace function public.cek_username(p_username text)
returns boolean
language sql
security definer
stable
set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where lower(username) = lower(trim(p_username))
  );
$$;

grant execute on function public.cek_username(text) to anon, authenticated;
