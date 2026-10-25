/* ============================================================================
   salah-halaman.js — 誤答ノート: daftar jawaban salah (tabel `salah`)
   ============================================================================ */

import { esc } from './aman.js';

const $ = (id) => document.getElementById(id);

const NAMA = {
  kosakata: 'Kosakata', kanji: 'Kanji', bunpou: 'Bunpou',
  dokkai: 'Dokkai', choukai: 'Choukai', campur: 'Try Out / 模試'
};

let supabase = null;
let semua = [];

function tampil(id) {
  ['memuat', 'isi', 'kosong', 'gagal'].forEach((x) => {
    const el = $(x);
    if (el) el.hidden = (x !== id);
  });
}

function tanggal(iso) {
  return new Date(iso).toLocaleDateString('id-ID', { day: 'numeric', month: 'short' });
}

function gambar() {
  const cari = ($('cari').value || '').trim().toLowerCase();
  const isi = cari
    ? semua.filter((r) => (r.tampil + r.benar + (r.dipilih || '')).toLowerCase().includes(cari))
    : semua;

  const per = {};
  semua.forEach((r) => { per[r.jenis] = (per[r.jenis] || 0) + 1; });
  const tersering = Object.entries(per).sort((a, b) => b[1] - a[1])[0];

  $('angka').innerHTML = `
    <div class="angka-kotak"><b>${semua.length}</b><span>catatan salah</span></div>
    <div class="angka-kotak"><b>${Object.keys(per).length}</b><span>modul</span></div>
    <div class="angka-kotak"><b class="teks">${tersering ? esc(NAMA[tersering[0]] || tersering[0]) : '—'}</b><span>paling sering</span></div>`;

  $('daftar-salah').innerHTML = isi.length
    ? isi.map((r) => `
        <article class="salah-kartu">
          <div class="salah-kepala">
            <span class="salah-jenis">${esc(NAMA[r.jenis] || r.jenis)}</span>
            <span class="salah-waktu">${tanggal(r.dibuat_at)}${r.hari_ke ? ' · hari ' + r.hari_ke : ''}</span>
          </div>
          <p class="salah-soal">${esc(r.tampil)}</p>
          <p class="salah-baris"><span class="salah-label">kamu</span> <span class="salah-salah">${esc(r.dipilih || '—')}</span></p>
          <p class="salah-baris"><span class="salah-label">benar</span> <span class="salah-benar">${esc(r.benar)}</span></p>
        </article>`).join('')
    : '<div class="kosong">Tidak ada yang cocok dengan pencarian.</div>';
}

async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }
  supabase = window.sesiSiap.supabase;

  const { data, error } = await supabase
    .from('salah')
    .select('jenis, hari_ke, tampil, benar, dipilih, dibuat_at')
    .order('dibuat_at', { ascending: false })
    .limit(400);

  if (error) {
    tampil('gagal');
    $('pesan-gagal').innerHTML =
      `${esc(error.message)}<br><br>Jalankan <code>db/salah.sql</code> di Supabase SQL Editor.`;
    return;
  }

  semua = data || [];
  if (!semua.length) { tampil('kosong'); return; }

  tampil('isi');
  gambar();
  $('cari').addEventListener('input', gambar);
}

tampil('memuat');
jalankan().catch((e) => {
  console.error('[salah]', e);
  tampil('gagal');
  $('pesan-gagal').textContent = 'Gagal memuat: ' + (e && e.message ? e.message : e);
});
