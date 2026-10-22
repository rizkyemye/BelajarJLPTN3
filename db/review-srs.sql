-- ============================================================================
-- REVIEW v2 — jadwal tetap (+1/+3/+7/+14/+30) + 3 tombol + antrian
--
-- Jalankan SEKALI di SQL Editor. Aman diulang.
--
-- Perubahan:
--   · review.tahap       : tingkat ingatan (1..5)
--   · review.jatuh_tempo : kapan harus muncul lagi
--   · review.terakhir    : terakhir dinilai
--   · nilai_review()     : Lupa / Ragu / Hafal → atur jadwal
--   · antrian_review()   : kata yang jatuh tempo hari ini
--   · mulai_hari()       : tidak lagi menarik kata 'ulang' (diganti jadwal)
-- ============================================================================

-- ---------- 1. kolom baru ----------
alter table public.review add column if not exists tahap       smallint not null default 0;
alter table public.review add column if not exists jatuh_tempo date;
alter table public.review add column if not exists terakhir    date;

create index if not exists review_tempo_idx
  on public.review (user_id, jatuh_tempo);

-- kata lama: anggap jatuh tempo besok supaya masuk antrian
update public.review
   set jatuh_tempo = coalesce(jatuh_tempo, current_date)
 where jatuh_tempo is null and status in ('hafal', 'ulang');

-- ---------- 2. nilai satu kata ----------
-- lupa → tahap 1, besok lagi
-- ragu → tahap tetap (minimal 1), jadwal sesuai tahap
-- hafal → tahap + 1 (maks 5)
create or replace function public.nilai_review(p_id bigint, p_nilai text)
returns table (tahap smallint, jatuh_tempo date)
language plpgsql
security definer
set search_path = public
as $$
declare
  t smallint;
  jeda int;
  jadwal int[] := array[1, 3, 7, 14, 30];
begin
  select r.tahap into t
  from public.review r
  where r.user_id = auth.uid() and r.kosakata_id = p_id;

  if t is null then
    return;
  end if;

  if p_nilai = 'lupa' then
    t := 1;
  elsif p_nilai = 'hafal' then
    t := least(5, greatest(1, t + 1))::smallint;
  else
    t := greatest(1, t)::smallint;   -- ragu: tahap tidak naik
  end if;

  jeda := jadwal[greatest(1, least(5, t))];

  update public.review r
     set tahap       = t,
         jatuh_tempo = current_date + jeda,
         terakhir    = current_date,
         dinilai_at  = now(),
         status      = case p_nilai when 'hafal' then 'hafal'
                                    when 'ragu'  then 'hafal'
                                    else 'ulang' end
   where r.user_id = auth.uid() and r.kosakata_id = p_id;

  return query select t, current_date + jeda;
end;
$$;

grant execute on function public.nilai_review(bigint, text) to authenticated;

-- ---------- 3. antrian review hari ini ----------
create or replace function public.antrian_review(p_level text)
returns table (
  id bigint, kanji text, yomi text, arti text, kelas text,
  contoh_jp text, contoh_furi text, contoh_id text, tahap smallint
)
language sql
security definer
stable
set search_path = public
as $$
  select k.id, k.kanji, k.yomi, k.arti, k.kelas,
         k.contoh_jp, k.contoh_furi, k.contoh_id, r.tahap
  from public.review r
  join public.kosakata k on k.id = r.kosakata_id
  where r.user_id = auth.uid()
    and k.level   = p_level
    and r.jatuh_tempo <= current_date
  order by r.jatuh_tempo, r.tahap, k.urutan
  limit 60;
$$;

grant execute on function public.antrian_review(text) to authenticated;

-- ---------- 4. jumlah antrian (buat badge di halaman level) ----------
create or replace function public.jumlah_antrian(p_level text)
returns int
language sql
security definer
stable
set search_path = public
as $$
  select count(*)::int
  from public.review r
  join public.kosakata k on k.id = r.kosakata_id
  where r.user_id = auth.uid()
    and k.level   = p_level
    and r.jatuh_tempo <= current_date;
$$;

grant execute on function public.jumlah_antrian(text) to authenticated;

-- ---------- 5. mulai_hari: tanpa tarikan 'ulang' ----------
create or replace function public.mulai_hari(p_level text, p_hari int)
returns text
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.boleh_mulai(p_level, p_hari) then
    return 'terkunci';
  end if;

  insert into public.hari (user_id, level, hari_ke, status)
  values (auth.uid(), p_level, p_hari, 'belajar')
  on conflict (user_id, level, hari_ke) do nothing;

  insert into public.review (user_id, kosakata_id, hari_ke, status, tahap, jatuh_tempo)
  select auth.uid(), k.id, p_hari, 'belum', 0, null
  from public.kosakata k
  where k.level = p_level and k.hari_ke = p_hari
  on conflict (user_id, kosakata_id) do nothing;

  return 'mulai';
end;
$$;

grant execute on function public.mulai_hari(text, int) to authenticated;

-- ---------- 6. selesaikan review harian: kata yang sudah dinilai masuk jadwal +1 ----------
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
  from public.review r
  join public.kosakata k on k.id = r.kosakata_id
  where r.user_id = auth.uid() and k.level = p_level
    and r.hari_ke = p_hari and r.status = 'belum';

  if belum > 0 then
    return 'belum-lengkap';
  end if;

  -- kata baru hari itu otomatis dijadwalkan besok
  update public.review r
     set jatuh_tempo = coalesce(r.jatuh_tempo, current_date + 1),
         terakhir    = coalesce(r.terakhir, current_date)
  from public.kosakata k
  where k.id = r.kosakata_id
    and r.user_id = auth.uid()
    and k.level = p_level
    and r.hari_ke = p_hari;

  update public.hari
     set status = 'selesai', selesai_at = now()
   where user_id = auth.uid() and level = p_level and hari_ke = p_hari;

  return 'selesai';
end;
$$;

grant execute on function public.selesaikan_review(text, int) to authenticated;

-- ---------- 7. cek ----------
select
  count(*) filter (where jatuh_tempo is null) as tanpa_jadwal,
  count(*) filter (where jatuh_tempo <= current_date) as jatuh_tempo_hari_ini,
  count(*) as total
from public.review;
