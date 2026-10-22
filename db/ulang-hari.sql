-- ============================================================================
-- ① PENGULANGAN — kata berstatus 'ulang' ikut masuk hari berikutnya
--
-- Sebelumnya: kata yang ditandai "Ulangi nanti" cuma disimpan, tidak pernah
-- muncul lagi. Sekarang: maksimal 10 kata 'ulang' dari hari-hari lampau
-- ditarik ke hari yang sedang dibuka.
--
-- Jalankan SEKALI di SQL Editor. Aman diulang.
-- ============================================================================

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

  -- 1. buka hari
  insert into public.hari (user_id, level, hari_ke, status)
  values (auth.uid(), p_level, p_hari, 'belajar')
  on conflict (user_id, level, hari_ke) do nothing;

  -- 2. 25 kata baru
  insert into public.review (user_id, kosakata_id, hari_ke, status)
  select auth.uid(), k.id, p_hari, 'belum'
  from public.kosakata k
  where k.level = p_level and k.hari_ke = p_hari
  on conflict (user_id, kosakata_id) do nothing;

  -- 3. PENGULANGAN: tarik maksimal 10 kata 'ulang' dari hari lampau
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

-- ---------- cek ----------
select count(*) as kata_ulang_tercatat
from public.review
where status = 'ulang';
