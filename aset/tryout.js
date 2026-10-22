/* ============================================================================
   tryout.js — Try Out N3: 文法 10 · 読解 6 · 聴解 3 = 19 soal, 25 menit

   Alur: semua soal dibuat sekali di awal → dikerjakan berurutan (boleh mundur,
   boleh ubah jawaban) → "Selesai" → skor per bagian + daftar salah.
   Tidak ada pembahasan di tengah ujian (mirip JLPT).
   ============================================================================ */

import { ucapkan, suaraSiap } from './suara.js';
import { furigana } from './furigana.js';
import { simpanNilai } from './nilai.js';

const $ = (id) => document.getElementById(id);
const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const DURASI = 25 * 60;

let supabase = null;
let soal = [];
let jawab = [];      // jawab[i] = index pilihan yang dipilih
let posisi = 0;
let sisa = DURASI;
let jam = null;
let mulai = false;

function tampil(id) {
  ['memuat', 'tahap-awal', 'tahap-ujian', 'tahap-hasil']
    .forEach((x) => { const el = $(x); if (el) el.hidden = (x !== id); });
}

function acak(a) {
  const x = a.slice();
  for (let i = x.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [x[i], x[j]] = [x[j], x[i]];
  }
  return x;
}

/* ---------- bikin soal ---------- */
async function siapkan() {
  const [bun, dok, ck] = await Promise.all([
    supabase.from('bunpou').select('pola, arti').eq('level', LEVEL).limit(300),
    supabase.from('dokkai').select('hari_ke, judul_jp, teks_jp, teks_furi, soal').eq('level', LEVEL).order('hari_ke').limit(42),
    supabase.from('choukai').select('hari_ke, judul_jp, skrip_jp, soal').eq('level', LEVEL).order('hari_ke').limit(42)
  ]);

  const daftarBun = (bun.data || []).filter((x) => x.pola && x.arti);
  const daftarDok = (dok.data || []).filter((x) => (x.soal || []).length);
  const daftarCk = (ck.data || []).filter((x) => (x.soal || []).length);

  const hasil = [];

  /* 文法: pola → arti */
  acak(daftarBun).slice(0, 10).forEach((b) => {
    const lain = acak(daftarBun.filter((x) => x.arti !== b.arti)).slice(0, 3).map((x) => x.arti);
    const pilihan = acak([b.arti, ...lain]);
    hasil.push({
      bagian: '文法', petunjuk: 'Pilih arti pola di bawah ini',
      tampil: b.pola, pilihan, kunci: pilihan.indexOf(b.arti), bunyi: null
    });
  });

  /* 読解: 2 bacaan × 3 soal */
  acak(daftarDok).slice(0, 2).forEach((d) => {
    (d.soal || []).slice(0, 3).forEach((s) => {
      hasil.push({
        bagian: '読解', petunjuk: 'Baca teks di atas, lalu pilih jawaban',
        tampil: s.tanya,
        pilihan: s.pilihan,
        kunci: s.kunci,
        teksJp: d.teks_jp,
        teksFuri: d.teks_furi,
        bunyi: null
      });
    });
  });

  /* 聴解: 3 soal */
  acak(daftarCk).slice(0, 3).forEach((c) => {
    const s = (c.soal || [])[0];
    if (!s) return;
    hasil.push({
      bagian: '聴解', petunjuk: 'Dengarkan sekali, lalu pilih jawaban',
      tampil: s.tanya,
      pilihan: s.pilihan,
      kunci: s.kunci,
      bunyi: c.skrip_jp,
      teksJp: null
    });
  });

  return hasil;
}

/* ---------- tampilan soal ---------- */
function gambar() {
  const s = soal[posisi];
  if (!s) return selesai();

  $('topik').textContent = `${s.bagian} · ${s.petunjuk}`;
  $('hitung').textContent = `${posisi + 1} / ${soal.length}`;
  $('batang').style.width = ((posisi) / soal.length * 100) + '%';

  const teks = $('teks-dokkai');
  if (s.teksJp) {
    teks.hidden = false;
    teks.innerHTML = s.teksFuri ? furigana(s.teksJp, s.teksFuri) : s.teksJp;
  } else {
    teks.hidden = true;
    teks.innerHTML = '';
  }

  const kotak = $('pilihan');
  kotak.innerHTML = '';
  $('soal').textContent = s.tampil;

  s.pilihan.forEach((te, i) => {
    const b = document.createElement('button');
    b.type = 'button';
    b.innerHTML = `${String.fromCharCode(65 + i)}. ${te}`;
    if (jawab[posisi] === i) b.classList.add('dipilih');
    b.addEventListener('click', () => {
      jawab[posisi] = i;
      gambar();
    });
    kotak.appendChild(b);
  });

  const dengar = $('kotak-dengar');
  dengar.hidden = !s.bunyi;
  if (s.bunyi) {
    const b = $('btn-putar');
    b.disabled = false;
    b.textContent = '🔊 Putar suara (1×)';
    b.onclick = () => putar(b);
  }

  $('btn-mundur').disabled = posisi === 0;
  $('btn-maju').textContent = posisi === soal.length - 1 ? 'Selesai ✓' : 'Berikutnya →';
}

let sudahPutar = false;

async function putar(tombol) {
  const s = soal[posisi];
  if (!s || !s.bunyi || sudahPutar) return;
  sudahPutar = true;
  tombol.disabled = true;
  tombol.textContent = 'Memutar…';

  const baris = s.bunyi.split('\n').filter((x) => x.trim());
  await suaraSiap();
  for (const b of baris) {
    await new Promise((r) => { ucapkan(b, { rate: 0.9 }); setTimeout(r, 900); });
    await new Promise((r) => setTimeout(r, 320));
  }
  tombol.textContent = 'Selesai diputar';
}

/* ---------- timer ---------- */
function tulisSisa() {
  const m = Math.floor(sisa / 60);
  const d = String(sisa % 60).padStart(2, '0');
  const el = $('sisa-waktu');
  el.textContent = `${m}:${d}`;
  el.classList.toggle('habis', sisa <= 60);
}

function mulaiJam() {
  clearInterval(jam);
  tulisSisa();
  jam = setInterval(() => {
    sisa--;
    tulisSisa();
    if (sisa <= 0) { clearInterval(jam); selesai(); }
  }, 1000);
}

/* ---------- hasil ---------- */
function selesai() {
  clearInterval(jam);
  tampil('tahap-hasil');

  const perBagian = {};
  soal.forEach((s, i) => {
    perBagian[s.bagian] = perBagian[s.bagian] || { benar: 0, total: 0 };
    perBagian[s.bagian].total++;
    if (jawab[i] === s.kunci) perBagian[s.bagian].benar++;
  });

  const benar = soal.filter((s, i) => jawab[i] === s.kunci).length;
  const persen = soal.length ? Math.round(benar / soal.length * 100) : 0;
  $('ringkas-hasil').innerHTML =
    `<b>${benar} / ${soal.length}</b> benar (${persen}%) · ` +
    (persen >= 60 ? 'lulus batas kasar ✓' : 'belum lulus batas kasar ✗');

  $('rincian-hasil').innerHTML = Object.entries(perBagian).map(([nama, v]) => `
    <div class="rk-baris">
      <span class="rk-nama">${nama}</span>
      <span class="batang"><i style="width:${Math.round(v.benar / v.total * 100)}%"></i></span>
      <span class="rk-nilai">${v.benar}/${v.total}</span>
    </div>`).join('');

  simpanNilai('campur', null, benar, soal.length);
}

/* ---------- alur ---------- */
function mulaiUjian() {
  mulai = true;
  jawab = new Array(soal.length).fill(-1);
  posisi = 0;
  sisa = DURASI;
  sudahPutar = false;
  $('kepala').hidden = true;
  tampil('tahap-ujian');
  mulaiJam();
  gambar();
}

async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }
  supabase = window.sesiSiap.supabase;

  soal = await siapkan();
  if (soal.length < 5) {
    $('memuat').textContent = 'Data soal belum cukup. Jalankan bunpou.sql, dokkai.sql, choukai.sql dulu.';
    return;
  }

  const jumlah = soal.reduce((a, s) => { a[s.bagian] = (a[s.bagian] || 0) + 1; return a; }, {});
  $('info-awal').textContent =
    `${soal.length} soal · ${DURASI / 60} menit · ` +
    Object.entries(jumlah).map(([k, v]) => `${k} ${v} soal`).join(' · ');

  tampil('tahap-awal');
}

/* ---------- tombol ---------- */
$('btn-mulai').addEventListener('click', mulaiUjian);
$('btn-ulang').addEventListener('click', () => location.reload());

$('btn-maju').addEventListener('click', () => {
  if (posisi >= soal.length - 1) return selesai();
  posisi++;
  sudahPutar = false;
  gambar();
});

$('btn-mundur').addEventListener('click', () => {
  if (posisi === 0) return;
  posisi--;
  gambar();
});

tampil('memuat');
jalankan().catch((e) => {
  console.error('[tryout]', e);
  $('memuat').innerHTML = `<b>Gagal memuat: ${e.message || e}</b><br><br>
    <button class="tbl-teks" type="button" onclick="location.reload()">Muat ulang</button>`;
});
