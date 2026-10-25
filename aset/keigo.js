/* ============================================================================
   keigo.js — 敬語: daftar 尊敬/謙譲 + frasa hotel + kuis 10 soal
   Jenis soal (acak, bergiliran):
     ① dasar → 尊敬語
     ② dasar → 謙譲語
     ③ frasa hotel: arti → frasa Jepang
   ============================================================================ */

import { esc } from './aman.js';
import { simpanNilai, catatSalah } from './nilai.js';

const $ = (id) => document.getElementById(id);
const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];

let supabase = null;
let semua = [];
let dasar = [];
let hotel = [];
let soal = [];
let soalKe = 0;
let benar = 0;

function tampil(id) {
  ['memuat', 'isu', 'kuis', 'gagal'].forEach((x) => {
    const el = $(x);
    if (el) el.hidden = (x !== id);
  });
}

function acak(a) {
  const x = a.slice();
  for (let i = x.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [x[i], x[j]] = [x[j], x[i]];
  }
  return x;
}

/* ---------- daftar ---------- */
function gambarDaftar() {
  $('daftar-dasar').innerHTML = dasar.map((k) => `
    <div class="kg-baris">
      <div class="kg-kiri">
        <b>${esc(k.dasar)}</b>
        <span>${esc(k.arti)}</span>
      </div>
      <div class="kg-kanan">
        <span class="kg-label">尊敬</span> <span class="kg-son">${esc(k.sonkei || '—')}</span>
        <span class="kg-label">謙譲</span> <span class="kg-ken">${esc(k.kenjo || '—')}</span>
      </div>
    </div>`).join('');

  $('daftar-hotel').innerHTML = hotel.map((k) => `
    <div class="kg-baris hotel">
      <div class="kg-kiri">
        <b>${esc(k.dasar)}</b>
        <span>${esc(k.arti)}</span>
      </div>
      <p class="kg-contoh">${esc(k.contoh_jp)}</p>
      <p class="kg-arti">${esc(k.contoh_id)}</p>
    </div>`).join('');
}

/* ---------- kuis ---------- */
function buatSoal() {
  const hasil = [];

  const tipe = ['son', 'ken'];
  tipe.forEach((t) => {
    acak(dasar).slice(0, 4).forEach((k) => {
      const kunci = t === 'son' ? k.sonkei : k.kenjo;
      if (!kunci) return;
      const lain = acak(dasar)
        .map((x) => (t === 'son' ? x.sonkei : x.kenjo))
        .filter((x) => x && x !== kunci);
      const pilihan = acak([kunci, ...[...new Set(lain)].slice(0, 3)]);
      if (pilihan.length < 4) return;
      hasil.push({
        topik: t === 'son' ? '尊敬語 · untuk atasan & tamu' : '謙譲語 · untuk diri sendiri',
        tanya: k.dasar,
        ket: k.arti,
        pilihan,
        kunci: pilihan.indexOf(kunci)
      });
    });
  });

  acak(hotel).slice(0, 4).forEach((k) => {
    const lain = acak(hotel.filter((x) => x.dasar !== k.dasar)).slice(0, 3).map((x) => x.dasar);
    const pilihan = acak([k.dasar, ...lain]);
    if (pilihan.length < 4) return;
    hasil.push({
      topik: 'Frasa hotel · pilih yang tepat',
      tanya: k.arti,
      ket: k.contoh_id,
      pilihan,
      kunci: pilihan.indexOf(k.dasar)
    });
  });

  return acak(hasil).slice(0, 10);
}

function gambarSoal() {
  const s = soal[soalKe];
  if (!s) return selesai();

  $('k-topik').textContent = s.topik;
  $('k-soal').textContent = s.tanya;
  $('k-hitung').textContent = `${soalKe + 1} / ${soal.length}`;
  $('k-batang').style.width = `${(soalKe / soal.length) * 100}%`;
  $('k-hasil').textContent = s.ket || '';
  $('k-lanjut').hidden = true;

  const kotak = $('k-pilihan');
  kotak.innerHTML = '';
  s.pilihan.forEach((te) => {
    const b = document.createElement('button');
    b.type = 'button';
    b.textContent = te;
    b.addEventListener('click', () => jawab(b, te, s));
    kotak.appendChild(b);
  });
}

function jawab(tombol, teks, s) {
  const semuaBtn = [...$('k-pilihan').children];
  semuaBtn.forEach((b) => { b.disabled = true; });

  const tepat = teks === s.pilihan[s.kunci];
  if (tepat) { benar++; tombol.classList.add('benar'); }
  else {
    tombol.classList.add('salah');
    semuaBtn.find((b) => b.textContent === s.pilihan[s.kunci])?.classList.add('benar');
    catatSalah('bunpou', null, s.tanya, s.pilihan[s.kunci], teks);
  }

  $('k-hasil').textContent = tepat
    ? 'Benar ✓'
    : `Yang benar: ${s.pilihan[s.kunci]}`;

  const lanjut = $('k-lanjut');
  lanjut.hidden = false;
  lanjut.textContent = soalKe === soal.length - 1 ? 'Selesai ✓' : 'Lanjut →';
  lanjut.onclick = () => { soalKe++; gambarSoal(); };
}

function selesai() {
  const persen = Math.round((benar / soal.length) * 100);
  simpanNilai('bunpou', null, benar, soal.length);
  $('k-topik').textContent = 'Hasil kuis 敬語';
  $('k-soal').textContent = `${benar} / ${soal.length} benar (${persen}%)`;
  $('k-pilihan').innerHTML = '';
  $('k-hasil').textContent = persen >= 80 ? 'Bagus ✓' : persen >= 60 ? 'Lumayan — ulangi lagi' : 'Masih goyah ✗ baca daftar sekali lagi';
  $('k-lanjut').hidden = true;
  $('k-keluar').textContent = '← Kembali ke daftar';
}

function mulaiKuis() {
  soal = buatSoal();
  if (soal.length < 4) { alert('Data keigo belum cukup.'); return; }
  soalKe = 0;
  benar = 0;
  tampil('kuis');
  gambarSoal();
}

/* ---------- mulai ---------- */
async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }
  supabase = window.sesiSiap.supabase;

  const { data, error } = await supabase
    .from('keigo')
    .select('urutan, kategori, dasar, arti, sonkei, kenjo, contoh_jp, contoh_id')
    .eq('level', LEVEL)
    .order('urutan');

  if (error) {
    tampil('gagal');
    $('pesan-gagal').innerHTML = `${esc(error.message)}<br><br>Jalankan <code>db/keigo.sql</code>.`;
    return;
  }

  semua = data || [];
  dasar = semua.filter((k) => k.kategori === 'dasar');
  hotel = semua.filter((k) => k.kategori === 'hotel');

  gambarDaftar();
  tampil('isu');
}

$('btn-kuis').addEventListener('click', mulaiKuis);
$('k-keluar').addEventListener('click', () => {
  tampil('isu');
  $('k-keluar').textContent = '✕ Keluar kuis';
});

tampil('memuat');
jalankan().catch((e) => {
  console.error('[keigo]', e);
  tampil('gagal');
  $('pesan-gagal').textContent = 'Gagal memuat: ' + (e && e.message ? e.message : e);
});
