/* ============================================================================
   dokkai.js — daftar bacaan + pembaca + soal
   Data dari tabel `dokkai` (lihat db/dokkai.sql). Soal disimpan sebagai JSONB:
     [{ "tanya": "...", "pilihan": ["a","b","c","d"], "benar": 0 }, ...]
   ============================================================================ */
import { simpanNilai, catatSalah } from './nilai.js';


import { furigana } from './furigana.js';

const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const $ = (id) => document.getElementById(id);

let semua = [];
let urutTampil = [];
let sedang = -1;

function esc(s) {
  return String(s ?? '').replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));
}

/* ---------- daftar ---------- */
function gambar(isi) {
  const kotak = $('daftar-dokkai');
  if (!isi.length) {
    kotak.innerHTML = '<div class="kosong">Belum ada bacaan yang cocok.</div>';
    urutTampil = [];
    return;
  }

  urutTampil = isi.map((d) => d.hari_ke);

  kotak.innerHTML = isi.map((d) => {
    const jml = Array.isArray(d.soal) ? d.soal.length : 0;
    return `<button class="dk-item" type="button" data-hari="${d.hari_ke}">
      <span class="dk-kiri">
        <span class="dk-hari">Hari ${d.hari_ke}</span>
        <span class="dk-judul">${esc(d.judul_jp)}</span>
        <span class="dk-meta">${esc(d.judul_id || '')}${d.tema ? ' · ' + esc(d.tema) : ''} · ${jml} soal${d.jenis && d.jenis !== 'setsumei' ? ' · ' + (d.jenis === 'email' ? 'メール' : 'お知らせ') : ''}</span>
      </span>
      <span class="panah" aria-hidden="true">›</span>
    </button>`;
  }).join('');

  kotak.querySelectorAll('.dk-item').forEach((b) => {
    b.addEventListener('click', () => buka(Number(b.dataset.hari)));
  });
}

/* ---------- pembaca ---------- */
function buka(hari) {
  const d = semua.find((x) => x.hari_ke === hari);
  if (!d) return;
  sedang = hari;

  $('dk-tema').textContent = `Hari ${d.hari_ke}${d.tema ? ' · ' + d.tema : ''}`;
  $('dk-judul').textContent = d.judul_jp;
  $('dk-judul-id').textContent = d.judul_id || '';

  // baris per baris (penting untuk e-mail & pengumuman yang berparagraf)
  const jp = String(d.teks_jp || '').split('\n');
  const fu = String(d.teks_furi || '').split('\n');
  const jenis = d.jenis || 'setsumei';
  const kelasBaris = jenis === 'email' ? 'dk-email' : jenis === 'oshirase' ? 'dk-notice' : 'dk-teks';

  $('dk-teks').className = kelasBaris;
  $('dk-teks').innerHTML = jp.map((baris, i) => {
    if (!baris.trim()) return '';
    const isi = (fu[i] && fu[i].trim()) ? furigana(baris, fu[i]) : esc(baris);
    const kepala = (jenis === 'email' && i === 0) ? ' class="dk-subjek"' : '';
    return `<span${kepala}>${isi}</span><br>`;
  }).join('');

  $('dk-teks-id').textContent = d.teks_id || '';
  $('dk-hasil').textContent = '';
  $('dk-periksa').disabled = false;

  const soal = Array.isArray(d.soal) ? d.soal : [];
  $('dk-soal').innerHTML = soal.map((s, i) => `
    <div class="dk-soal" data-i="${i}">
      <p class="dk-tanya">${i + 1}. ${esc(s.tanya)}</p>
      <div class="pilihan" data-i="${i}">
        ${s.pilihan.map((p, k) => `<button type="button" data-k="${k}">${esc(p)}</button>`).join('')}
      </div>
    </div>`).join('');

  $('dk-soal').querySelectorAll('.pilihan').forEach((kotak) => {
    kotak.querySelectorAll('button').forEach((b) => {
      b.addEventListener('click', () => {
        if (kotak.dataset.selesai === '1') return;
        kotak.querySelectorAll('button').forEach((x) => x.classList.remove('pilih'));
        b.classList.add('pilih');
        kotak.dataset.pilih = b.dataset.k;
      });
    });
  });

  const dlg = $('dialog-dokkai');
  if (!dlg.open) dlg.showModal();
  dlg.scrollTop = 0;
}

/* ---------- periksa ---------- */
function periksa() {
  const d = semua.find((x) => x.hari_ke === sedang);
  if (!d) return;

  const soal = Array.isArray(d.soal) ? d.soal : [];
  let benar = 0;
  let belum = 0;

  $('dk-soal').querySelectorAll('.pilihan').forEach((kotak) => {
    const i = Number(kotak.dataset.i);
    const s = soal[i];
    const pilih = kotak.dataset.pilih;

    if (pilih === undefined) { belum++; return; }
    kotak.dataset.selesai = '1';

    kotak.querySelectorAll('button').forEach((b) => {
      const k = Number(b.dataset.k);
      b.disabled = true;
      b.classList.remove('pilih');
      if (k === s.benar) b.classList.add('benar');
      else if (k === Number(pilih)) b.classList.add('salah');
    });

    if (Number(pilih) === s.benar) benar++;
    else catatSalah('dokkai', sedang, s.tanya, s.pilihan[s.benar], s.pilihan[Number(pilih)]);
  });

  if (belum === soal.length) {
    $('dk-hasil').textContent = 'Pilih jawaban dulu.';
    return;
  }

  const persen = Math.round((benar / soal.length) * 100);
  simpanNilai('dokkai', sedang, benar, soal.length);
  $('dk-hasil').textContent = `${benar} / ${soal.length} benar (${persen}%)`
    + (belum ? ` · ${belum} soal belum dijawab` : '');
  $('dk-periksa').disabled = true;
}

/* ---------- cari ---------- */
function pasangCari() {
  const cari = $('cari');
  const hasil = $('cari-hasil');
  let jam = null;

  cari.addEventListener('input', () => {
    clearTimeout(jam);
    jam = setTimeout(() => {
      const q = cari.value.trim().toLowerCase();
      if (!q) { gambar(semua); hasil.textContent = ''; return; }

      const cocok = semua.filter((d) =>
        [d.judul_jp, d.judul_id, d.tema, d.teks_id].join(' ').toLowerCase().includes(q));

      gambar(cocok);
      hasil.textContent = `${cocok.length} cocok`;
    }, 120);
  });
}

/* ---------- mulai ---------- */
async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }

  const { supabase } = window.sesiSiap;

  const KOLOM = 'hari_ke, tema, judul_jp, judul_id, teks_jp, teks_furi, teks_id, soal';

  // `jenis` boleh belum ada (kalau ALTER belum dijalankan) → coba lagi tanpa itu
  let { data, error } = await supabase
    .from('dokkai')
    .select(`${KOLOM}, jenis`)
    .eq('level', LEVEL)
    .order('hari_ke', { ascending: true });

  if (error) {
    ({ data, error } = await supabase
      .from('dokkai')
      .select(KOLOM)
      .eq('level', LEVEL)
      .order('hari_ke', { ascending: true }));
  }

  if (error) {
    $('daftar-dokkai').innerHTML = `<div class="kosong">Gagal memuat: ${esc(error.message)}</div>`;
    return;
  }

  semua = data || [];
  $('info-dokkai').textContent = `${semua.length} bacaan`;

  if (!semua.length) {
    $('daftar-dokkai').innerHTML = '<div class="kosong">Belum ada bacaan. Jalankan <code>db/dokkai.sql</code>.</div>';
    return;
  }

  gambar(semua);
  pasangCari();

  $('dk-periksa').addEventListener('click', periksa);
  const dlg = $('dialog-dokkai');
  $('dk-tutup').addEventListener('click', () => dlg.close());
  dlg.addEventListener('click', (e) => { if (e.target === dlg) dlg.close(); });
}

jalankan().catch((e) => {
  const kotak = $('daftar-dokkai');
  if (kotak) kotak.innerHTML = `<div class="kosong">Gagal memuat: ${esc(e && e.message ? e.message : e)}</div>`;
});
