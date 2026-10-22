-- ============================================================================
-- PERBAIKAN · isi profil untuk akun yang sudah ada
--
-- Gejala: login berhasil, tapi pesan "Profil akun tidak ditemukan."
-- Sebab : akun dibuat SEBELUM trigger buat_profil terpasang,
--         jadi barisnya tidak ada di tabel profiles.
-- Solusi: salin semua user di auth.users yang belum punya profil.
--
-- Aman dijalankan berulang.
-- ============================================================================

-- 1. pastikan kolom level/username ada isinya
insert into public.profiles (id, username, level)
select
  u.id,
  coalesce(nullif(u.raw_user_meta_data->>'username', ''), split_part(u.email, '@', 1)),
  coalesce(nullif(u.raw_user_meta_data->>'level', ''), 'n5')
from auth.users u
left join public.profiles p on p.id = u.id
where p.id is null
on conflict (id) do nothing;

-- 2. kalau username bentrok (dobel), beri akhiran angka
do $$
declare
  r record;
  dasar text;
  akhir int := 0;
begin
  for r in
    select id, username from public.profiles p
    where exists (
      select 1 from public.profiles q
      where lower(q.username) = lower(p.username) and q.id <> p.id
    )
  loop
    dasar := r.username; akhir := akhir + 1;
    update public.profiles
       set username = dasar || '_' || akhir
     where id = r.id
       and not exists (select 1 from public.profiles z where lower(z.username) = lower(dasar || '_' || akhir));
  end loop;
end $$;

-- 3. pastikan trigger terpasang (untuk pendaftaran berikutnya)
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
    coalesce(nullif(new.raw_user_meta_data->>'username',''), split_part(new.email,'@',1)),
    coalesce(nullif(new.raw_user_meta_data->>'level',''), 'n5')
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_daftar on auth.users;
create trigger on_daftar
  after insert on auth.users
  for each row execute function public.buat_profil();

-- 4. hasil
select p.username, p.level, p.role, p.status, u.email, u.email_confirmed_at
from public.profiles p
join auth.users u on u.id = p.id
order by p.created_at;
