-- ============================================================================
-- REVIEW — kata yang paling sering lupa (tahap 0–1) + izin jenis 'campur'
-- Aman dijalankan berulang.
-- ============================================================================

create or replace function public.antrian_lemah(p_level text)
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
    and r.tahap  <= 1
  order by r.tahap, r.jatuh_tempo, k.urutan
  limit 20;
$$;

grant execute on function public.antrian_lemah(text) to authenticated;

-- jenis 'campur' (kuis gabungan) supaya skornya ikut tercatat
do $$
begin
  alter table public.nilai_kuis drop constraint if exists nilai_kuis_jenis_check;
  alter table public.nilai_kuis
    add constraint nilai_kuis_jenis_check
    check (jenis in ('kosakata','kanji','bunpou','dokkai','choukai','campur'));
exception when others then null;
end $$;

select 'antrian_lemah siap' as cek;
