/* ============================================================================
   nilai-halaman.js — halaman Penilaian: baca tabel nilai_kuis
   Tampilan: angka utama · akurasi per modul · tren 7 hari · riwayat 20
   ============================================================================ */

import { esc } from './aman.js';

const $ = (id) => document.getElementById(id);
const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];

const NAMA = {
  kosakata: 'Kosakata', kanji: 'Kanji', bunpou: 'Bunpou',
  dokkai: 'Dokkai', choukai: 'Choukai', campur: 'Try Out / campur'
};

let supabase = null;
let semua = [];

function tampil(id) {
  ['memuat', 'isi', 'kosong', 'gagal'].forEach((x) => {
    const el = $(x);
    if (el) el.hidden = (x !== id);
  });
}

function persen(benar, total) {
  return total ? Math.round((benar / total) * 100) : 0;
}

function barisBar(nama, benar, total, akurasi) {
  const p = akurasi == null ? persen(benar, total) : akurasi;
  return `
    <div class="rk-baris">
      <span class="rk-nama">${esc(nama)}</span>
      <span class="batang"><i style="width:${p}%"></i></span>
      <span class="rk-nilai">${p}%</span>
    </div>`;
}

function tanggalPendek(iso) {
  const d = new Date(iso);
  return d.toLocaleDateString('id-ID', { day: 'numeric', month: 'short' });
}

function gambar() {
  const totalSoal = semua.reduce((a, r) => a + r.total, 0);
  const totalBenar = semua.reduce((a, r) => a + r.benar, 0);
  const rata = persen(totalBenar, totalSoal);

  /* hari berturut ada nilai */
  const hariAda = new Set(semua.map((r) => new Date(r.dibuat_at).toDateString()));
  let runtun = 0;
  const d = new Date();
  while (hariAda.has(d.toDateString())) { runtun++; d.setDate(d.getDate() - 1); }

  $('angka-utama').innerHTML = `
    <div class="angka-kotak"><b>${semua.length}</b><span>kuis dikerjakan</span></div>
    <div class="angka-kotak"><b>${rata}%</b><span>rata-rata benar</span></div>
    <div class="angka-kotak"><b>${runtun}</b><span>hari berturut</span></div>`;

  /* per modul */
  const per = {};
  semua.forEach((r) => {
    const j = r.jenis || 'lain';
    per[j] = per[j] || { benar: 0, total: 0, n: 0 };
    per[j].benar += r.benar;
    per[j].total += r.total;
    per[j].n++;
  });

  const urut = Object.entries(per)
    .map(([j, v]) => ({ j, ...v, akurasi: persen(v.benar, v.total) }))
    .sort((a, b) => a.akurasi - b.akurasi);

  $('per-jenis').innerHTML = urut.length
    ? urut.map((x) => barisBar(`${NAMA[x.j] || x.j} · ${x.n}×`, x.benar, x.total)).join('')
    : '<div class="kosong">Belum ada nilai.</div>';

  /* tren 7 hari vs 7 hari sebelumnya */
  const kini = Date.now();
  const HARI = 864e5;
  const ambil = (dari, sampai) => semua.filter((r) => {
    const t = new Date(r.dibuat_at).getTime();
    return t >= kini - dari * HARI && t < kini - sampai * HARI;
  });
  const ringkas = (arr) => {
    const total = arr.reduce((a, r) => a + r.total, 0);
    const benar = arr.reduce((a, r) => a + r.benar, 0);
    return { total, benar, akurasi: persen(benar, total), n: arr.length };
  };

  const ini = ringkas(ambil(7, 0));
  const lalu = ringkas(ambil(14, 7));

  let trenTeks = 'belum bisa dibandingkan';
  if (ini.n && lalu.n) {
    const delta = ini.akurasi - lalu.akurasi;
    trenTeks = delta > 0 ? `naik ${delta} poin ✓` : delta < 0 ? `turun ${Math.abs(delta)} poin` : 'sama';
  }

  $('tren').innerHTML = `
    <div class="rk-baris">
      <span class="rk-nama">7 hari ini</span>
      <span class="batang"><i style="width:${ini.akurasi}%"></i></span>
      <span class="rk-nilai">${ini.n ? ini.akurasi + '%' : '—'}</span>
    </div>
    <div class="rk-baris">
      <span class="rk-nama">7 hari sebelum</span>
      <span class="batang"><i style="width:${lalu.akurasi}%"></i></span>
      <span class="rk-nilai">${lalu.n ? lalu.akurasi + '%' : '—'}</span>
    </div>
    <p class="jadwal-info">${esc(trenTeks)}</p>`;

  /* riwayat 20 */
  const riwayat = semua.slice(0, 20);
  $('riwayat').innerHTML = riwayat.length
    ? riwayat.map((r) => {
        const p = persen(r.benar, r.total);
        const hari = r.hari_ke ? ` · hari ${r.hari_ke}` : '';
        return `
          <div class="rk-baris">
            <span class="rk-nama">${tanggalPendek(r.dibuat_at)}</span>
            <span class="batang"><i style="width:${p}%"></i></span>
            <span class="rk-nilai">${r.benar}/${r.total}</span>
          </div>
          <p class="jadwal-info" style="margin:-6px 0 10px">${esc(NAMA[r.jenis] || r.jenis)}${esc(hari)} · ${p}%</p>`;
      }).join('')
    : '<div class="kosong">Belum ada riwayat.</div>';

  tampil('isi');
}

async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }
  supabase = window.sesiSiap.supabase;

  const { data, error } = await supabase
    .from('nilai_kuis')
    .select('jenis, hari_ke, benar, total, dibuat_at')
    .order('dibuat_at', { ascending: false })
    .limit(300);

  if (error) {
    tampil('gagal');
    $('pesan-gagal').innerHTML =
      `${esc(error.message)}<br><br>Jalankan <code>db/nilai-kuis.sql</code> di Supabase SQL Editor.`;
    return;
  }

  semua = data || [];
  if (!semua.length) { tampil('kosong'); return; }
  gambar();
}

tampil('memuat');
jalankan().catch((e) => {
  console.error('[nilai]', e);
  tampil('gagal');
  $('pesan-gagal').textContent = 'Gagal memuat: ' + (e && e.message ? e.message : e);
});
