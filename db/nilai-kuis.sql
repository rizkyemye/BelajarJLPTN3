-- ============================================================================
-- NILAI KUIS — simpan skor tiap kuis, lalu bisa dilihat rekapnya
-- Amit dijalankan berulang.
-- ============================================================================

create table if not exists public.nilai_kuis (
  id         bigserial primary key,
  user_id    uuid not null default auth.uid() references public.profiles(id) on delete cascade,
  jenis      text not null check (jenis in ('kosakata','kanji','bunpou','dokkai','choukai')),
  hari_ke    int,
  benar      int not null check (benar >= 0),
  total      int not null check (total > 0),
  dibuat_at  timestamptz not null default now()
);

create index if not exists nilai_kuis_user_idx on public.nilai_kuis (user_id, dibuat_at desc);

alter table public.nilai_kuis enable row level security;

-- tulis: hanya baris milik sendiri
drop policy if exists "tulis nilai sendiri" on public.nilai_kuis;
create policy "tulis nilai sendiri"
  on public.nilai_kuis for insert
  to authenticated
  with check (user_id = auth.uid());

-- baca: hanya baris sendiri
drop policy if exists "baca nilai sendiri" on public.nilai_kuis;
create policy "baca nilai sendiri"
  on public.nilai_kuis for select
  to authenticated
  using (user_id = auth.uid());

-- hapus: sendiri
drop policy if exists "hapus nilai sendiri" on public.nilai_kuis;
create policy "hapus nilai sendiri"
  on public.nilai_kuis for delete
  to authenticated
  using (user_id = auth.uid());

-- ---------- rekap 14 hari terakhir ----------
create or replace function public.rekap_kuis()
returns table (jenis text, total int, benar int, akurasi int)
language sql
security definer
stable
set search_path = public
as $$
  select
    n.jenis,
    sum(n.total)::int                        as total,
    sum(n.benar)::int                        as benar,
    round(100.0 * sum(n.benar) / nullif(sum(n.total), 0))::int as akurasi
  from public.nilai_kuis n
  where n.user_id = auth.uid()
    and n.dibuat_at > now() - interval '14 days'
  group by n.jenis
  order by 4 asc;
$$;

grant execute on function public.rekap_kuis() to authenticated;

-- cek: select * from public.rekap_kuis();
