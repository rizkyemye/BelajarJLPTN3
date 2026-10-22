-- ============================================================================
-- KANJI — kartu kanji + jadwal review sendiri
--
-- Kartu: depan kanji · belakang onyomi, kunyomi, arti, bushu, 3 kosakata
-- Jalankan SEKALI di SQL Editor. Aman diulang.
-- ============================================================================

-- ---------- 1. tabel kanji ----------
create table if not exists public.kanji (
  id         bigint generated always as identity primary key,
  level      text not null check (level in ('n5','n4','n3')),
  hari_ke    int  not null check (hari_ke >= 1),
  urutan     int  not null check (urutan between 1 and 20),

  kanji      text not null,
  onyomi     text,             -- ケイ・キョウ
  kunyomi    text,             -- へ.る
  arti       text not null,

  bushu      text,             -- 糸
  arti_bushu text,             -- benang

  kata       jsonb not null default '[]'::jsonb,  -- 3 kosakata: [{"k","y","a"}]

  created_at timestamptz not null default now(),
  unique (level, hari_ke, urutan),
  unique (level, kanji)
);

create index if not exists kanji_hari_idx on public.kanji (level, hari_ke, urutan);

-- ---------- 2. jadwal (fungsi murni, dipakai kanji & kosakata) ----------
create or replace function public.jadwal_berikut(p_tahap smallint, p_nilai text)
returns table (tahap smallint, jeda int)
language sql
immutable
as $$
  select
    t.tahap,
    (array[1, 3, 7, 14, 30])[greatest(1, least(5, t.tahap))] as jeda
  from (
    select case
      when p_nilai = 'lupa'  then 1
      when p_nilai = 'hafal' then least(5, greatest(1, coalesce(p_tahap, 0) + 1))
      else greatest(1, coalesce(p_tahap, 0))
    end::smallint as tahap
  ) t;
$$;

grant execute on function public.jadwal_berikut(smallint, text) to authenticated;

-- ---------- 3. review kanji ----------
create table if not exists public.review_kanji (
  user_id     uuid   not null references public.profiles(id) on delete cascade,
  kanji_id    bigint not null references public.kanji(id) on delete cascade,
  hari_ke     int    not null,
  status      text   not null default 'belum'
              check (status in ('belum','hafal','ulang')),
  tahap       smallint not null default 0,
  jatuh_tempo date,
  terakhir    date,
  dinilai_at  timestamptz,
  primary key (user_id, kanji_id)
);

create index if not exists review_kanji_tempo_idx on public.review_kanji (user_id, jatuh_tempo);

-- ---------- 4. nilai satu kanji ----------
create or replace function public.nilai_kanji(p_id bigint, p_nilai text)
returns table (tahap smallint, jatuh_tempo date)
language plpgsql
security definer
set search_path = public
as $$
declare
  t smallint;
  j int;
  lama smallint;
begin
  select r.tahap into lama
  from public.review_kanji r
  where r.user_id = auth.uid() and r.kanji_id = p_id;

  if lama is null then
    return;
  end if;

  select s.tahap, s.jeda into t, j from public.jadwal_berikut(lama, p_nilai) s;

  update public.review_kanji r
     set tahap       = t,
         jatuh_tempo = current_date + j,
         terakhir    = current_date,
         dinilai_at  = now(),
         status      = case when p_nilai = 'lupa' then 'ulang' else 'hafal' end
   where r.user_id = auth.uid() and r.kanji_id = p_id;

  return query select t, current_date + j;
end;
$$;

grant execute on function public.nilai_kanji(bigint, text) to authenticated;

-- ---------- 5. buka hari kanji (siapkan antrian) ----------
create or replace function public.mulai_hari_kanji(p_level text, p_hari int)
returns text
language plpgsql
security definer
set search_path = public
as $$
begin
  -- kanji berdiri sendiri: hari N terbuka kalau semua kanji hari N-1 sudah dinilai
  if p_hari > 1 and exists (
    select 1
    from public.review_kanji r
    join public.kanji k on k.id = r.kanji_id
    where r.user_id = auth.uid()
      and k.level   = p_level
      and k.hari_ke = p_hari - 1
      and r.status  = 'belum'
  ) then
    return 'terkunci';
  end if;

  insert into public.review_kanji (user_id, kanji_id, hari_ke, status)
  select auth.uid(), k.id, p_hari, 'belum'
  from public.kanji k
  where k.level = p_level and k.hari_ke = p_hari
  on conflict (user_id, kanji_id) do nothing;

  return 'mulai';
end;
$$;

grant execute on function public.mulai_hari_kanji(text, int) to authenticated;

-- ---------- 6. antrian review kanji ----------
create or replace function public.antrian_kanji(p_level text)
returns table (
  id bigint, kanji text, onyomi text, kunyomi text, arti text,
  bushu text, arti_bushu text, kata jsonb, tahap smallint
)
language sql
security definer
stable
set search_path = public
as $$
  select k.id, k.kanji, k.onyomi, k.kunyomi, k.arti,
         k.bushu, k.arti_bushu, k.kata, r.tahap
  from public.review_kanji r
  join public.kanji k on k.id = r.kanji_id
  where r.user_id = auth.uid()
    and k.level   = p_level
    and r.jatuh_tempo <= current_date
  order by r.jatuh_tempo, r.tahap, k.urutan
  limit 40;
$$;

grant execute on function public.antrian_kanji(text) to authenticated;

create or replace function public.jumlah_antrian_kanji(p_level text)
returns int
language sql
security definer
stable
set search_path = public
as $$
  select count(*)::int
  from public.review_kanji r
  join public.kanji k on k.id = r.kanji_id
  where r.user_id = auth.uid()
    and k.level = p_level
    and r.jatuh_tempo <= current_date;
$$;

grant execute on function public.jumlah_antrian_kanji(text) to authenticated;

-- ---------- 7. RLS ----------
alter table public.kanji        enable row level security;
alter table public.review_kanji enable row level security;

drop policy if exists "baca kanji" on public.kanji;
create policy "baca kanji"
  on public.kanji for select to authenticated using (true);

drop policy if exists "admin kelola kanji" on public.kanji;
create policy "admin kelola kanji"
  on public.kanji for all to authenticated
  using (public.apakah_admin()) with check (public.apakah_admin());

drop policy if exists "baca review kanji sendiri" on public.review_kanji;
create policy "baca review kanji sendiri"
  on public.review_kanji for select using (user_id = auth.uid());

drop policy if exists "tulis review kanji sendiri" on public.review_kanji;
create policy "tulis review kanji sendiri"
  on public.review_kanji for insert with check (user_id = auth.uid());

drop policy if exists "ubah review kanji sendiri" on public.review_kanji;
create policy "ubah review kanji sendiri"
  on public.review_kanji for update
  using (user_id = auth.uid()) with check (user_id = auth.uid());

-- ---------- 8. cek ----------
select count(*) as jumlah_kanji from public.kanji;
