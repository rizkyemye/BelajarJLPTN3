-- ============================================================================
-- NAIK KE 30 KATA / HARI
--
-- Sebelumnya batas urutan 1–25. Sekarang 1–30.
-- Jalankan SEKALI di SQL Editor. Aman diulang.
-- ============================================================================

-- 1. longgarkan batas urutan
alter table public.kosakata drop constraint if exists kosakata_urutan_check;
alter table public.kosakata
  add constraint kosakata_urutan_check check (urutan between 1 and 30);

-- 2. mulai_hari: jangan patok jumlah 25
create or replace function public.mulai_hari(p_level text, p_hari int)
returns text
language plpgsql
security definer
set search_path = public
as $$
declare
  sisa int;
  ulang int;
begin
  if not public.boleh_mulai(p_level, p_hari) then
    return 'terkunci';
  end if;

  insert into public.hari (user_id, level, hari_ke, status)
  values (auth.uid(), p_level, p_hari, 'belajar')
  on conflict (user_id, level, hari_ke) do nothing;

  -- semua kata baru hari itu
  insert into public.review (user_id, kosakata_id, hari_ke, status)
  select auth.uid(), k.id, p_hari, 'belum'
  from public.kosakata k
  where k.level = p_level and k.hari_ke = p_hari
  on conflict (user_id, kosakata_id) do nothing;

  -- tarik maksimal 10 kata 'ulang' dari hari lampau
  with lampau as (
    select r.kosakata_id
    from public.review r
    join public.kosakata k on k.id = r.kosakata_id
    where r.user_id = auth.uid()
      and k.level   = p_level
      and r.status  = 'ulang'
      and r.hari_ke < p_hari
    order by r.hari_ke
    limit 10
  )
  update public.review r
     set status = 'belum',
         hari_ke = p_hari,
         dinilai_at = null
    from lampau
   where r.user_id = auth.uid()
     and r.kosakata_id = lampau.kosakata_id;

  get diagnostics ulang = row_count;

  select count(*) into sisa
  from public.review
  where user_id = auth.uid() and hari_ke = p_hari and status = 'belum';

  return case when ulang > 0 then 'mulai+' || ulang else 'mulai' end;
end;
$$;

grant execute on function public.mulai_hari(text, int) to authenticated;

-- 3. cek
select level, hari_ke, count(*) as jumlah
from public.kosakata
where level = 'n3'
group by level, hari_ke
order by hari_ke
limit 5;
