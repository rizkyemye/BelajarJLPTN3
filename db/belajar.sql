-- ============================================================================
-- Belajar N3 · isi & progres belajar
-- Jalankan di Supabase → SQL Editor → paste → Run
-- Aman dijalankan ulang.
--
-- ATURAN (dari Emye):
--   1. 30 kosakata per hari, semua level
--   2. flashcard: kanji · yomikata · arti · contoh kalimat
--   3. WAJIB review dulu sebelum boleh mulai hari berikutnya
--   4. kuis 3 tipe:  kanji→arti · suara→(kanji+arti) · kanji→(hiragana+arti)
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. BAHAN — kosakata (diisi admin, semua user baca)
-- ---------------------------------------------------------------------------
create table if not exists public.kosakata (
  id         bigint generated always as identity primary key,
  level      text not null check (level in ('n5','n4','n3')),
  hari_ke    int  not null check (hari_ke >= 1),
  urutan     int  not null check (urutan between 1 and 30),   -- posisi dalam hari

  kanji      text not null,                     -- 生活
  yomi       text not null,                     -- せいかつ
  arti       text not null,                     -- kehidupan sehari-hari
  kelas      text,                              -- nomina / verba / adjektiva

  contoh_jp  text,                              -- 生活が忙しい。
  contoh_id  text,                              -- Kehidupan sehari-hari sibuk.
  audio      text,                              -- nama file audio (boleh null)

  created_at timestamptz not null default now(),

  unique (level, hari_ke, urutan)
);

create index if not exists kosakata_hari_idx on public.kosakata (level, hari_ke, urutan);

-- ---------------------------------------------------------------------------
-- 2. PROGRES HARI per user
--    status: 'belajar' → 'review' → 'selesai'
-- ---------------------------------------------------------------------------
create table if not exists public.hari (
  user_id    uuid not null references public.profiles(id) on delete cascade,
  level      text not null check (level in ('n5','n4','n3')),
  hari_ke    int  not null check (hari_ke >= 1),
  status     text not null default 'belajar'
             check (status in ('belajar','review','selesai')),
  mulai_at   timestamptz not null default now(),
  selesai_at timestamptz,
  primary key (user_id, level, hari_ke)
);

-- ---------------------------------------------------------------------------
-- 3. TABEL REVIEW — WAJIB sebelum hari berikutnya
--    satu baris = satu kata yang harus diingat
-- ---------------------------------------------------------------------------
create table if not exists public.review (
  user_id     uuid   not null references public.profiles(id) on delete cascade,
  kosakata_id bigint not null references public.kosakata(id) on delete cascade,
  hari_ke     int    not null,
  status      text   not null default 'belum'
              check (status in ('belum','hafal','ulang')),
  dinilai_at  timestamptz,
  primary key (user_id, kosakata_id)
);

create index if not exists review_user_hari_idx on public.review (user_id, hari_ke, status);

-- ---------------------------------------------------------------------------
-- 4. PENJAGA: boleh mulai hari N hanya kalau hari N-1 sudah 'selesai'
--    (dan artinya review hari N-1 sudah dikerjakan)
-- ---------------------------------------------------------------------------
create or replace function public.boleh_mulai(p_level text, p_hari int)
returns boolean
language sql
security definer
stable
set search_path = public
as $$
  select case
    when p_hari <= 1 then true
    else exists (
      select 1 from public.hari
      where user_id = auth.uid()
        and level   = p_level
        and hari_ke = p_hari - 1
        and status  = 'selesai'
    )
  end;
$$;

grant execute on function public.boleh_mulai(text, int) to authenticated;

-- ---------------------------------------------------------------------------
-- 5. MULAI HARI — tolak kalau hari sebelumnya belum beres
-- ---------------------------------------------------------------------------
create or replace function public.mulai_hari(p_level text, p_hari int)
returns text
language plpgsql
security definer
set search_path = public
as $$
declare
  sisa int;
begin
  if not public.boleh_mulai(p_level, p_hari) then
    return 'terkunci';
  end if;

  -- izin: user ini
  insert into public.hari (user_id, level, hari_ke, status)
  values (auth.uid(), p_level, p_hari, 'belajar')
  on conflict (user_id, level, hari_ke) do nothing;

  -- siapkan 25 baris review kalau belum ada
  insert into public.review (user_id, kosakata_id, hari_ke, status)
  select auth.uid(), k.id, p_hari, 'belum'
  from public.kosakata k
  where k.level = p_level and k.hari_ke = p_hari
  on conflict (user_id, kosakata_id) do nothing;

  select count(*) into sisa
  from public.review
  where user_id = auth.uid() and hari_ke = p_hari and status = 'belum';

  return case when sisa = 25 then 'mulai' else 'lanjut' end;
end;
$$;

grant execute on function public.mulai_hari(text, int) to authenticated;

-- ---------------------------------------------------------------------------
-- 6. SELESAIKAN REVIEW → buka kunci hari berikutnya
-- ---------------------------------------------------------------------------
create or replace function public.selesaikan_review(p_level text, p_hari int)
returns text
language plpgsql
security definer
set search_path = public
as $$
declare
  belum int;
begin
  select count(*) into belum
  from public.review
  where user_id = auth.uid() and hari_ke = p_hari and status = 'belum';

  if belum > 0 then
    return 'belum-lengkap';
  end if;

  update public.hari
     set status = 'selesai', selesai_at = now()
   where user_id = auth.uid() and level = p_level and hari_ke = p_hari;

  return 'selesai';
end;
$$;

grant execute on function public.selesaikan_review(text, int) to authenticated;

-- ---------------------------------------------------------------------------
-- 7. RLS
-- ---------------------------------------------------------------------------
alter table public.kosakata enable row level security;
alter table public.hari     enable row level security;
alter table public.review   enable row level security;

-- bahan: semua user login boleh baca
drop policy if exists "baca kosakata" on public.kosakata;
create policy "baca kosakata"
  on public.kosakata for select
  to authenticated
  using (true);

-- hari: hanya milik sendiri
drop policy if exists "baca hari sendiri" on public.hari;
create policy "baca hari sendiri"
  on public.hari for select
  using (user_id = auth.uid());

drop policy if exists "tulis hari sendiri" on public.hari;
create policy "tulis hari sendiri"
  on public.hari for insert
  with check (user_id = auth.uid());

-- review: hanya milik sendiri
drop policy if exists "baca review sendiri" on public.review;
create policy "baca review sendiri"
  on public.review for select
  using (user_id = auth.uid());

drop policy if exists "tulis review sendiri" on public.review;
create policy "tulis review sendiri"
  on public.review for insert
  with check (user_id = auth.uid());

drop policy if exists "ubah review sendiri" on public.review;
create policy "ubah review sendiri"
  on public.review for update
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- admin: kelola bahan
drop policy if exists "admin kelola kosakata" on public.kosakata;
create policy "admin kelola kosakata"
  on public.kosakata for all
  using (exists (select 1 from public.profiles p where p.id = auth.uid() and p.role = 'admin'))
  with check (exists (select 1 from public.profiles p where p.id = auth.uid() and p.role = 'admin'));

-- ============================================================================
-- RINGKASAN ALUR SATU HARI
--
--   mulai_hari('n3', 4)
--     → cek boleh_mulai: hari 3 harus 'selesai'
--     → buat 25 baris review status 'belum'
--
--   user buka 25 flashcard → review.status = 'hafal' / 'ulang'
--
--   selesaikan_review('n3', 4)
--     → kalau masih ada 'belum' → ditolak
--     → hari 4 = 'selesai'  → hari 5 terbuka
--
--   kuis 3 tipe (kanji→arti, suara→kanji+arti, kanji→hiragana+arti)
--   tidak menyimpan nilai ke DB; hanya latihan. Bisa ditambah nanti.
-- ============================================================================
