-- ============================================================================
-- SALAH — catatan jawaban yang salah (誤答ノート)
-- Disimpan otomatis setiap kali menjawab salah di kuis.
-- Aman dijalankan berulang.
-- ============================================================================

create table if not exists public.salah (
  id        bigserial primary key,
  user_id   uuid not null default auth.uid() references public.profiles(id) on delete cascade,
  jenis     text not null check (jenis in ('kosakata','kanji','bunpou','dokkai','choukai','campur')),
  hari_ke   int,
  tampil    text not null,
  benar     text not null,
  dipilih   text,
  dibuat_at timestamptz not null default now()
);

create index if not exists salah_user_idx on public.salah (user_id, dibuat_at desc);

alter table public.salah enable row level security;

drop policy if exists "tulis salah sendiri" on public.salah;
create policy "tulis salah sendiri"
  on public.salah for insert to authenticated
  with check (user_id = auth.uid());

drop policy if exists "baca salah sendiri" on public.salah;
create policy "baca salah sendiri"
  on public.salah for select to authenticated
  using (user_id = auth.uid());

drop policy if exists "hapus salah sendiri" on public.salah;
create policy "hapus salah sendiri"
  on public.salah for delete to authenticated
  using (user_id = auth.uid());

select 'tabel salah siap' as cek;
