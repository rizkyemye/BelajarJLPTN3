/* ============================================================================
   moshii.js — 模試 JLPT N3 (versi ketat)

   第1部 文字・語彙 25  · 第2部 文法 10 · 第3部 読解 12  → 110 menit
   第4部 聴解 10                                        → 40 menit
   Soal dibuat dari data yang sudah ada (kosakata / bunpou / dokkai / choukai).
   Pengecoh sengaja diambil dari hari & kelas yang sama, jadi mirip semua.
   ============================================================================ */

import { ucapkan, suaraSiap } from './suara.js';
import { furigana } from './furigana.js';
import { simpanNilai, catatSalah } from './nilai.js';
import { esc } from './aman.js';

const $ = (id) => document.getElementById(id);
const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const MENIT1 = 110, MENIT2 = 40;

let supabase = null;
let soal = [];          // { bagian, petunjuk, tampil, pilihan[], kunci, teksJp?, teksFuri?, bunyi? }
let jawab = [];
let posisi = 0;         // index di dalam bagian aktif
let mulaiIdx = 0;       // index awal bagian aktif
let fase = 1;
let sisa = MENIT1 * 60;
let jam = null;
let sudahPutar = false;

const BAGIAN = ['', '第1部', '第2部', '第3部', '第4部'];
const NAMA_BAGIAN = { 1: '文字・語彙', 2: '文法', 3: '読解', 4: '聴解' };

function tampil(id) {
  ['memuat', 'tahap-awal', 'tahap-ujian', 'tahap-jeda', 'tahap-hasil']
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

/* ambil 3 pengecoh dari kumpulan yang mirip */
function pengecoh(benar, kandidat, n = 3) {
  const unik = [...new Set(kandidat.filter((x) => x && x !== benar))];
  return acak(unik).slice(0, n);
}

/* ---------- buat soal ---------- */
async function siapkan() {
  const [kos, bun, dok, ck] = await Promise.all([
    supabase.from('kosakata').select('hari_ke, kanji, yomi, arti, kelas').eq('level', LEVEL).limit(600),
    supabase.from('bunpou').select('pola, arti, tema_jp, contoh_id').eq('level', LEVEL).limit(300),
    supabase.from('dokkai').select('hari_ke, judul_jp, teks_jp, teks_furi, soal').eq('level', LEVEL).limit(42),
    supabase.from('choukai').select('hari_ke, skrip_jp, soal').eq('level', LEVEL).limit(42)
  ]);

  const kata = (kos.data || []).filter((k) => k.kanji && k.yomi && k.arti);
  const pola = (bun.data || []).filter((b) => b.pola && b.arti);
  const baca = (dok.data || []).filter((d) => (d.soal || []).length >= 3);
  const dengar = (ck.data || []).filter((c) => (c.soal || []).length);

  const hasil = [];
  const perHari = {};
  kata.forEach((k) => { (perHari[k.hari_ke] ||= []).push(k); });

  /* --- 第1部: 15 soal 読み方 --- */
  acak(kata).slice(0, 15).forEach((k) => {
    const kawan = perHari[k.hari_ke] || kata;
    const opsi = [k.yomi, ...pengecoh(k.yomi, kawan.map((x) => x.yomi))];
    if (opsi.length < 4) return;
    hasil.push({
      bagian: 1, petunjuk: 'Pilih cara baca yang benar (ひらがな)',
      tampil: k.kanji, pilihan: acak(opsi), kunci: 0, bunyi: k.yomi, tipe: 'yomi'
    });
    const s = hasil[hasil.length - 1];
    s.kunci = s.pilihan.indexOf(k.yomi);
  });

  /* --- 第1部: 10 soal 意味 (pengecoh dari kelas sama) --- */
  acak(kata).slice(0, 10).forEach((k) => {
    const sekelas = kata.filter((x) => x.kelas === k.kelas);
    const opsi = [k.arti, ...pengecoh(k.arti, (sekelas.length > 5 ? sekelas : kata).map((x) => x.arti))];
    if (opsi.length < 4) return;
    const pilihan = acak(opsi);
    hasil.push({
      bagian: 1, petunjuk: 'Pilih arti yang paling tepat',
      tampil: k.kanji, pilihan, kunci: pilihan.indexOf(k.arti), bunyi: k.yomi, tipe: 'arti'
    });
  });

  /* --- 第2部: 10 文法 --- */
  acak(pola).slice(0, 5).forEach((p) => {
    const kawan = pola.filter((x) => x.tema_jp === p.tema_jp && x.pola !== p.pola);
    const lain = pengecoh(p.arti, (kawan.length >= 3 ? kawan : pola).map((x) => x.arti));
    const pilihan = acak([p.arti, ...lain]);
    if (pilihan.length < 4) return;
    hasil.push({
      bagian: 2, petunjuk: 'Pilih arti pola yang tepat',
      tampil: p.pola, pilihan, kunci: pilihan.indexOf(p.arti), bunyi: null, tipe: 'bunpou'
    });
  });

  acak(pola).slice(0, 5).forEach((p) => {
    const kawan = pola.filter((x) => x.tema_jp === p.tema_jp && x.pola !== p.pola);
    const lain = pengecoh(p.pola, (kawan.length >= 3 ? kawan : pola).map((x) => x.pola));
    const pilihan = acak([p.pola, ...lain]);
    if (pilihan.length < 4) return;
    hasil.push({
      bagian: 2, petunjuk: 'Pilih pola yang sesuai dengan makna ini',
      tampil: p.arti, pilihan, kunci: pilihan.indexOf(p.pola), bunyi: null, tipe: 'bunpou'
    });
  });

  /* --- 第3部: 12 読解 (4 bacaan × 3) --- */
  acak(baca).slice(0, 4).forEach((d) => {
    d.soal.slice(0, 3).forEach((s) => {
      hasil.push({
        bagian: 3, petunjuk: 'Baca teks di atas, lalu pilih jawaban',
        tampil: s.tanya, pilihan: s.pilihan, kunci: s.kunci,
        teksJp: d.teks_jp, teksFuri: d.teks_furi, bunyi: null, tipe: 'dokkai'
      });
    });
  });

  /* --- 第4部: 10 聴解 --- */
  acak(dengar).slice(0, 10).forEach((c) => {
    const s = (c.soal || [])[0];
    if (!s) return;
    hasil.push({
      bagian: 4, petunjuk: 'Dengarkan sekali, lalu pilih jawaban',
      tampil: s.tanya, pilihan: s.pilihan, kunci: s.kunci,
      bunyi: c.skrip_jp, teksJp: null, tipe: 'choukai'
    });
  });

  return hasil;
}

/* ---------- tampilan ---------- */
function batasBagian(b) {
  const awal = soal.findIndex((s) => s.bagian === b);
  if (awal < 0) return [0, -1];
  let akhir = soal.length - 1;
  for (let i = awal; i < soal.length; i++) if (soal[i].bagian > b) { akhir = i - 1; break; }
  return [awal, akhir];
}

function gambar() {
  const s = soal[mulaiIdx + posisi];
  if (!s) return fase === 1 ? keJeda() : selesai();

  $('bagian').textContent = BAGIAN[s.bagian];
  $('topik').textContent = `${NAMA_BAGIAN[s.bagian]} · ${s.petunjuk}`;
  $('hitung').textContent = `${posisi + 1} / ${batasBagian(s.bagian)[1] - batasBagian(s.bagian)[0] + 1}`;
  $('batang').style.width = `${(posisi / Math.max(1, batasBagian(s.bagian)[1] - batasBagian(s.bagian)[0] + 1)) * 100}%`;

  const teks = $('teks-dokkai');
  if (s.teksJp) {
    teks.hidden = false;
    teks.innerHTML = s.teksFuri ? furigana(s.teksJp, s.teksFuri) : esc(s.teksJp);
  } else {
    teks.hidden = true;
    teks.innerHTML = '';
  }

  $('soal').textContent = s.tampil;

  const kotak = $('pilihan');
  kotak.innerHTML = '';
  s.pilihan.forEach((te, i) => {
    const b = document.createElement('button');
    b.type = 'button';
    b.innerHTML = `${String.fromCharCode(65 + i)}. ${esc(te)}`;
    if (jawab[mulaiIdx + posisi] === i) b.classList.add('dipilih');
    b.addEventListener('click', () => { jawab[mulaiIdx + posisi] = i; gambar(); });
    kotak.appendChild(b);
  });

  const dengar = $('kotak-dengar');
  dengar.hidden = !s.bunyi;
  if (s.bunyi) {
    const b = $('btn-putar');
    b.disabled = sudahPutar;
    b.textContent = sudahPutar ? 'Sudah diputar' : '🔊 Putar (1×)';
    b.onclick = () => putar(b);
  }

  $('btn-mundur').disabled = posisi === 0;
  $('btn-maju').textContent = (mulaiIdx + posisi) === soal.length - 1 ? 'Selesai ✓' : 'Berikutnya →';
}

async function putar(tombol) {
  const s = soal[mulaiIdx + posisi];
  if (!s || !s.bunyi || sudahPutar) return;
  sudahPutar = true;
  tombol.disabled = true;
  tombol.textContent = 'Memutar…';
  const baris = s.bunyi.split('\n').filter((x) => x.trim());
  await suaraSiap().catch(() => {});
  for (const b of baris) {
    ucapkan(b, { rate: 0.92 });
    await new Promise((r) => setTimeout(r, 900));
    await new Promise((r) => setTimeout(r, 300));
  }
  tombol.textContent = 'Sudah diputar';
}

/* ---------- waktu ---------- */
function tulisSisa() {
  const m = Math.floor(sisa / 60), d = String(sisa % 60).padStart(2, '0');
  const el = $('sisa-waktu');
  el.textContent = `${m}:${d}`;
  el.classList.toggle('habis', sisa <= 300);
}

function mulaiJam() {
  clearInterval(jam);
  tulisSisa();
  jam = setInterval(() => {
    sisa--;
    tulisSisa();
    if (sisa <= 0) {
      clearInterval(jam);
      if (fase === 1) keJeda(); else selesai();
    }
  }, 1000);
}

/* ---------- perpindahan ---------- */
function keJeda() {
  clearInterval(jam);
  tampil('tahap-jeda');
  $('kepala').hidden = true;
}

function mulaiDengar() {
  fase = 2;
  const [awal] = batasBagian(4);
  mulaiIdx = awal;
  posisi = 0;
  sudahPutar = false;
  sisa = MENIT2 * 60;
  tampil('tahap-ujian');
  mulaiJam();
  gambar();
}

function next() {
  const idx = mulaiIdx + posisi;
  if (idx >= soal.length - 1) return selesai();

  const nxt = soal[idx + 1];
  if (soal[idx].bagian !== nxt.bagian) {
    if (nxt.bagian === 4) return keJeda();     // jeda sebelum 聴解
    mulaiIdx = idx + 1;                        // bagian berikutnya, tanpa berhenti
    posisi = 0;
    sudahPutar = false;
    gambar();
    return;
  }

  posisi++;
  sudahPutar = false;
  gambar();
}

function prev() {
  if (posisi === 0) return;
  posisi--;
  gambar();
}

/* ---------- hasil ---------- */
function selesai() {
  clearInterval(jam);
  $('sisa-waktu').hidden = true;
  tampil('tahap-hasil');

  const per = {};
  soal.forEach((s, i) => {
    const p = per[s.bagian] ||= { benar: 0, total: 0 };
    p.total++;
    if (jawab[i] === s.kunci) p.benar++;
  });

  const benar = soal.filter((s, i) => jawab[i] === s.kunci).length;
  const persen = soal.length ? Math.round((benar / soal.length) * 100) : 0;
  const lulus = benar >= Math.ceil(soal.length * 0.6);
  $('ringkas-hasil').innerHTML =
    `<b>${benar} / ${soal.length}</b> benar (${persen}%) · ${lulus ? 'lulus batas kasar ✓' : 'belum lulus batas kasar ✗'}`;

  $('rincian-hasil').innerHTML = Object.entries(per).map(([b, v]) => `
    <div class="rk-baris">
      <span class="rk-nama">${BAGIAN[b]} ${NAMA_BAGIAN[b]}</span>
      <span class="batang"><i style="width:${Math.round(v.benar / v.total * 100)}%"></i></span>
      <span class="rk-nilai">${v.benar}/${v.total}</span>
    </div>`).join('');

  simpanNilai('campur', null, benar, soal.length);

  /* catat yang salah → 誤答ノート */
  soal.forEach((s2, i) => {
    if (jawab[i] !== s2.kunci && jawab[i] !== -1) {
      catatSalah('campur', null, s2.tampil, s2.pilihan[s2.kunci], s2.pilihan[jawab[i]]);
    }
  });
}

/* ---------- alur ---------- */
function mulaiUjian() {
  jawab = new Array(soal.length).fill(-1);
  fase = 1;
  mulaiIdx = 0;
  posisi = 0;
  sudahPutar = false;
  sisa = MENIT1 * 60;
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
  if (soal.length < 20) {
    $('memuat').textContent = 'Data soal belum cukup (butuh kosakata, bunpou, dokkai, choukai).';
    return;
  }

  const n = {};
  soal.forEach((s) => { n[s.bagian] = (n[s.bagian] || 0) + 1; });
  $('info-awal').textContent =
    Object.entries(n).map(([b, v]) => `${BAGIAN[b]} ${NAMA_BAGIAN[b]} ${v} soal`).join(' · ') +
    ` · total ${soal.length}`;

  tampil('tahap-awal');
}

$('btn-mulai').addEventListener('click', mulaiUjian);
$('btn-dengar').addEventListener('click', mulaiDengar);
$('btn-ulang').addEventListener('click', () => location.reload());
$('btn-maju').addEventListener('click', next);
$('btn-mundur').addEventListener('click', prev);

tampil('memuat');
jalankan().catch((e) => {
  console.error('[moshii]', e);
  $('memuat').innerHTML = `<b>Gagal memuat: ${esc(e.message || e)}</b><br><br>
    <button class="tbl-teks" type="button" onclick="location.reload()">Muat ulang</button>`;
});
