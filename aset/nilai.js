/* ============================================================================
   nilai.js — simpan skor kuis + baca rekap (untuk halaman pengingat)

   Tabel: nilai_kuis (user_id default auth.uid(), RLS: hanya baris sendiri)
   ============================================================================ */

/** simpan satu hasil kuis; gagal = diam saja (jangan ganggu latihan) */
export async function simpanNilai(jenis, hariKe, benar, total) {
  try {
    const s = window.sesiSiap && window.sesiSiap.supabase;
    if (!s || !total) return;
    await s.from('nilai_kuis').insert({
      jenis,
      hari_ke: hariKe ?? null,
      benar: Math.max(0, Number(benar) || 0),
      total: Math.max(1, Number(total) || 1)
    });
  } catch (_) { /* diam */ }
}

/** rekap 14 hari terakhir: [{jenis, total, benar, akurasi}] */
export async function rekapNilai() {
  try {
    const s = window.sesiSiap && window.sesiSiap.supabase;
    if (!s) return [];
    const { data } = await s.rpc('rekap_kuis');
    return Array.isArray(data) ? data : [];
  } catch (_) {
    return [];
  }
}


/* catat satu jawaban yang salah (誤答ノート) — gagal = diam saja */
export async function catatSalah(jenis, hariKe, tampil, benar, dipilih) {
  try {
    const sb = window.sesiSiap && window.sesiSiap.supabase;
    if (!sb) return;
    await sb.from('salah').insert({
      jenis,
      hari_ke: hariKe ?? null,
      tampil: String(tampil).slice(0, 300),
      benar: String(benar).slice(0, 300),
      dipilih: String(dipilih ?? '').slice(0, 300)
    });
  } catch (_) { /* offline / tabel belum ada: jangan ganggu latihan */ }
}
