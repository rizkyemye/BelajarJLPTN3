-- ============================================================================
-- DIAGNOSA + PERBAIKAN — "Profil akun tidak ditemukan"
-- Tempel SEMUA ke SQL Editor → Run → lihat hasilnya
-- ============================================================================

-- ---------- 1. LIHAT: user ada di auth.users? ----------
select 'auth.users' as tabel, id, email, email_confirmed_at, created_at
from auth.users
order by created_at;

-- ---------- 2. LIHAT: ada baris di profiles? ----------
select 'profiles' as tabel, id, username, level, role, status
from public.profiles
order by created_at;

-- ---------- 3. PAKSA bikin profil untuk SEMUA user ----------
insert into public.profiles (id, username, level)
select
  u.id,
  coalesce(nullif(u.raw_user_meta_data->>'username',''), split_part(u.email,'@',1)),
  coalesce(nullif(u.raw_user_meta_data->>'level',''), 'n3')
from auth.users u
where not exists (select 1 from public.profiles p where p.id = u.id);

-- ---------- 4. Kalau username dobel, beri akhiran ----------
update public.profiles p
   set username = p.username || '_' || substr(p.id::text, 1, 4)
 where p.id in (
   select id from (
     select id, row_number() over (partition by lower(username) order by created_at) as rn
     from public.profiles
   ) x where rn > 1
 );

-- ---------- 5. CEK HASIL ----------
select
  u.email,
  p.username,
  p.level,
  p.status,
  u.email_confirmed_at is not null as email_terkonfirmasi
from auth.users u
left join public.profiles p on p.id = u.id
order by u.created_at;
