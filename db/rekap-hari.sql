-- ============================================================================
-- FIX — daftar hari berhenti di hari 34
--
-- Sebab: halaman level membaca SEMUA baris kosakata lalu menghitung hari.
-- PostgREST memotong hasil di 1000 baris, jadi dengan 1.260 kata daftarnya
-- putus di tengah hari 34.
--
-- Solusi: satu RPC yang hanya mengembalikan 42 baris (hari + jumlah kata).
-- ============================================================================

create or replace function public.rekap_kosakata(p_level text)
returns table (hari_ke int, jumlah int)
language sql
security definer
stable
set search_path = public
as $$
  select k.hari_ke, count(*)::int as jumlah
  from public.kosakata k
  where k.level = p_level
  group by k.hari_ke
  order by k.hari_ke;
$$;

grant execute on function public.rekap_kosakata(text) to authenticated;

-- ---------- bukti ----------
select * from public.rekap_kosakata('n3');
