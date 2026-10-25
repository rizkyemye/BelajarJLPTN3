/* ============================================================================
   review.js — sesi review harian
   1) kartu flip  2) 3 tombol (Lupa / Ragu / Hafal) → jadwal +1/+3/+7/+14/+30
   3) kuis 12 soal dari kata yang sama
   ============================================================================ */

import { ucapkan, suaraSiap } from './suara.js';
import { furigana } from './furigana.js';
import { simpanNilai, catatSalah } from './nilai.js';

const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const $ = (id) => document.getElementById(id);

let supabase = null;
let antrian = [];
let posisi = 0;
let dinilai = 0;
let ringkas = { lupa: 0, ragu: 0, hafal: 0 };
let lemah = [];
let mode = 'srs';          // 'srs' | 'campur'
let jam = null;            // timer kuis campur

function tampil(id) {
  ['memuat', 'tahap-pilih', 'tahap-kosong', 'tahap-kartu', 'tahap-kuis', 'tahap-selesai']
    .forEach(x => { const el = $(x); if (el) el.hidden = (x !== id); });
  // kalau halaman versi lama (tanpa menu), tetap ke bagian yang bisa dipakai
  if (!$('tahap-pilih') && id === 'tahap-pilih') {
    if (antrian.length) { tampil('tahap-kartu'); gambarKartu(); }
    else tampil('tahap-kosong');
  }
}
function info(id, teks) {
  const el = $(id);
  if (el) el.textContent = teks;
}
function setBatang(el, p) { el.style.width = Math.max(0, Math.min(100, p)) + '%'; }

/* ---------- kartu ---------- */
function gambarKartu() {
  const k = antrian[posisi];
  if (!k) return mulaiKuis();

  $('kartu').classList.remove('terbalik');
  $('kelas').textContent = k.kelas || '';
  $('kanji').textContent = k.kanji;
  $('yomi').textContent  = k.yomi;
  $('arti').textContent  = k.arti;

  if (k.contoh_jp) {
    $('contoh-wrap').hidden = false;
    $('contoh-jp').innerHTML = k.contoh_furi
      ? furigana(k.contoh_jp, k.contoh_furi)
      : k.contoh_jp;
    $('contoh-id').textContent = k.contoh_id || '';
  } else {
    $('contoh-wrap').hidden = true;
  }

  $('hitung').textContent = `${posisi + 1} / ${antrian.length}`;
  setBatang($('batang-kartu'), (posisi / antrian.length) * 100);
  $('jadwal-info').textContent = `tahap ${k.tahap || 0}`;
}

async function nilai(hasil) {
  const k = antrian[posisi];
  if (!k) return;

  const btn = { lupa: $('btn-lupa'), ragu: $('btn-ragu'), hafal: $('btn-hafal') };
  Object.values(btn).forEach(b => b.disabled = true);

  const { data, error } = await supabase.rpc('nilai_review', { p_id: k.id, p_nilai: hasil });

  Object.values(btn).forEach(b => b.disabled = false);

  if (error) { $('jadwal-info').textContent = 'Gagal: ' + error.message; return; }

  ringkas[hasil]++;
  if (data && data[0]) {
    const tgl = new Date(data[0].jatuh_tempo);
    $('jadwal-info').textContent =
      `→ tahap ${data[0].tahap}, muncul lagi ${tgl.toLocaleDateString('id-ID', { day: 'numeric', month: 'short' })}`;
  }

  dinilai++;
  posisi++;
  setTimeout(() => { if (posisi < antrian.length) gambarKartu(); else mulaiKuis(); }, 220);
}

/* ---------- mulai sesi kartu dari daftar ---------- */
async function mulaiSesi(daftar, iniMode = 'srs') {
  if (!daftar || !daftar.length) return;
  mode = iniMode;
  antrian = daftar;
  dinilai = 0;
  ringkas = { lupa: 0, ragu: 0, hafal: 0 };
  posisi = 0;
  // suara dimuat di latar belakang — jangan tahan tampilan kartu
  suaraSiap().catch(() => {});
  tampil('tahap-kartu');
  gambarKartu();
}

/* ---------- kuis 12 soal ---------- */
let soal = [];
let soalKe = 0;
let benar = 0;

function acak(a) {
  const x = a.slice();
  for (let i = x.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [x[i], x[j]] = [x[j], x[i]];
  }
  return x;
}

function buatSoal() {
  const pakai = acak(antrian).slice(0, 12);
  return pakai.map(k => {
    const lain = acak(antrian.filter(x => x.id !== k.id)).slice(0, 3);
    const opsi = [k.arti, ...lain.map(x => x.arti)];
    while (opsi.length < 4) opsi.push(k.arti);
    return {
      tampil: k.kanji, benar: k.arti, pilihan: acak([...new Set(opsi)]).slice(0, 4)
    };
  });
}

function gambarSoal() {
  const s = soal[soalKe];
  if (!s) return selesai();

  if (s.topik) $('kuis-topik').textContent = s.topik;
  $('kuis-soal').textContent = s.tampil;
  $('kuis-hitung').textContent = `${soalKe + 1} / ${soal.length}`;
  setBatang($('batang-kuis'), (soalKe / soal.length) * 100);

  const kotak = $('pilihan');
  kotak.innerHTML = '';
  $('selisih').textContent = '';
  $('btn-lanjut-kuis').hidden = true;

  s.pilihan.forEach(teks => {
    const b = document.createElement('button');
    b.type = 'button';
    b.textContent = teks;
    b.addEventListener('click', () => jawab(b, teks, s));
    kotak.appendChild(b);
  });
}

function jawab(tombol, teks, s) {
  const semua = [...$('pilihan').children];
  semua.forEach(b => b.disabled = true);

  const tepat = teks === s.benar;
  if (tepat) { benar++; tombol.classList.add('benar'); }
  else {
    catatSalah('kosakata', null, s.tampil, s.benar, teks);
    tombol.classList.add('salah');
    semua.find(b => b.textContent === s.benar)?.classList.add('benar');
  }

  $('selisih').innerHTML = tepat ? 'Benar ✓' : `Yang benar: <b>${s.benar}</b>`;
  const lanjut = $('btn-lanjut-kuis');
  lanjut.hidden = false;
  lanjut.onclick = () => { soalKe++; gambarSoal(); };
}

function mulaiKuis() {
  if (!antrian.length) return selesai();

  mode = 'srs';
  soal = buatSoal();
  $('kuis-topik').textContent = 'Kuis review · kanji → arti';
  soalKe = 0;
  benar = 0;

  if (!soal.length) return selesai();

  tampil('tahap-kuis');
  gambarSoal();
}

/* ---------- kuis campur: kosakata + kanji + bunpou ---------- */
function acakN(a, n) {
  return acak(a).slice(0, n);
}

async function mulaiCampur() {
  tampil('memuat');
  $('memuat').textContent = 'Menyiapkan kuis campur…';

  let kos = [], kan = [], bun = [];
  try {
    ({ data: kos } = await supabase.from('kosakata').select('kanji,arti').eq('level', LEVEL).limit(600));
    ({ data: kan } = await supabase.from('kanji').select('kanji,arti').eq('level', LEVEL).limit(300));
    ({ data: bun } = await supabase.from('bunpou').select('pola,arti').eq('level', LEVEL).limit(300));
  } catch (_) { /* pakai yang ada */ }

  kos = (kos || []).filter((x) => x.arti && x.kanji);
  kan = (kan || []).filter((x) => x.arti && x.kanji);
  bun = (bun || []).filter((x) => x.pola && x.arti);

  const soalBaru = [];

  const buatTipe = (pool, n, label, ambil) => {
    if (pool.length < 4) return;
    acakN(pool, n).forEach((item) => {
      const benar = ambil(item);
      const lain = acakN(pool.filter((x) => ambil(x) !== benar), 3).map(ambil);
      const pilihan = acak([...new Set([benar, ...lain])]).slice(0, 4);
      if (pilihan.length < 4) return;
      soalBaru.push({ tampil: item.kanji || item.pola, benar, pilihan, topik: label });
    });
  };

  buatTipe(kos, 4, 'Kosakata · kanji → arti', (x) => x.arti);
  buatTipe(kan, 3, 'Kanji · arti', (x) => x.arti);
  buatTipe(bun, 3, 'Bunpou · pola → arti', (x) => x.arti);

  if (soalBaru.length < 4) {
    tampil('tahap-pilih');
    info('p4-info', 'data belum cukup untuk kuis campur');
    return;
  }

  mode = 'campur';
  soal = acak(soalBaru).slice(0, 10);
  soalKe = 0;
  benar = 0;

  tampil('tahap-kuis');
  $('sisa-waktu').hidden = false;
  mulaiHitungan(300);
  gambarSoal();
}

function mulaiHitungan(detik) {
  clearInterval(jam);
  const el = $('sisa-waktu');
  const tulis = () => {
    const m = Math.floor(detik / 60);
    const d = String(detik % 60).padStart(2, '0');
    el.textContent = `${m}:${d}`;
    el.classList.toggle('habis', detik <= 30);
  };
  tulis();
  jam = setInterval(() => {
    detik--;
    tulis();
    if (detik <= 0) { clearInterval(jam); selesai(); }
  }, 1000);
}

function selesai() {
  clearInterval(jam);
  $('sisa-waktu').hidden = true;
  tampil('tahap-selesai');

  const persen = soal.length ? Math.round((benar / soal.length) * 100) : 0;
  if (soal.length) simpanNilai(mode === 'campur' ? 'campur' : 'kosakata', null, benar, soal.length);
  $('judul-selesai').textContent = 'Review selesai';
  $('ket-selesai').innerHTML =
    `<b>${dinilai}</b> kata dinilai — ${ringkas.hafal} hafal · ${ringkas.ragu} ragu · ${ringkas.lupa} lupa` +
    (soal.length ? `<br><small>Kuis: ${benar}/${soal.length} benar (${persen}%)</small>` : '');
}

/* ---------- mulai ---------- */
async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }

  supabase = window.sesiSiap.supabase;
  $('label-level').textContent = LEVEL.toUpperCase();

  const { data, error } = await supabase.rpc('antrian_review', { p_level: LEVEL });

  if (error) {
    $('memuat').textContent = 'Gagal memuat antrian: ' + error.message;
    return;
  }

  antrian = data || [];
  clearTimeout(jamPasir);

  /* angka-angka di menu */
  info('p1-info', antrian.length
    ? `${antrian.length} kata jatuh tempo`
    : 'tidak ada yang jatuh tempo');

  let nKanji = 0;
  try {
    const hariIni = new Date().toISOString().slice(0, 10);
    const { count } = await supabase
      .from('review_kanji')
      .select('*', { count: 'exact', head: true })
      .lte('jatuh_tempo', hariIni);
    nKanji = count || 0;
  } catch (_) { nKanji = 0; }
  info('p2-info', nKanji ? `${nKanji} kanji jatuh tempo` : 'tidak ada yang jatuh tempo');

  try {
    const { data: l } = await supabase.rpc('antrian_lemah', { p_level: LEVEL });
    lemah = l || [];
  } catch (_) { lemah = []; }
  info('p3-info', lemah.length ? `${lemah.length} kata belum kuat` : 'belum ada data lupa');

  tampil('tahap-pilih');
}

/* ---------- tombol menu ---------- */
const p1 = $('p1'), p3 = $('p3'), p4 = $('p4');

if (p1) p1.addEventListener('click', (e) => {
  e.preventDefault();
  if (!antrian.length) { info('p1-info', 'tidak ada yang jatuh tempo'); return; }
  mulaiSesi(antrian, 'srs');
});
if (p3) p3.addEventListener('click', (e) => {
  e.preventDefault();
  if (!lemah.length) { info('p3-info', 'belum ada data lupa'); return; }
  mulaiSesi(lemah, 'lemah');
});
if (p4) p4.addEventListener('click', (e) => {
  e.preventDefault();
  mulaiCampur();
});

/* ---------- pasang ---------- */
const kartu = $('kartu');
kartu.addEventListener('click', () => kartu.classList.toggle('terbalik'));
kartu.addEventListener('keydown', (e) => {
  if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); kartu.classList.toggle('terbalik'); }
});

$('putar').addEventListener('click', (e) => {
  e.stopPropagation();
  const k = antrian[posisi];
  if (k) ucapkan(k.yomi, { rate: 0.85 });
});

$('btn-lupa').addEventListener('click', () => nilai('lupa'));
$('btn-ragu').addEventListener('click', () => nilai('ragu'));
$('btn-hafal').addEventListener('click', () => nilai('hafal'));

$('btn-belajar').addEventListener('click', (ev) => {
  const hari = new URLSearchParams(location.search).get('hari');
  if (hari) $('btn-belajar').href = `kartu.html?hari=${hari}`;
});

/* ---------- penjaga: jangan menggantung di "Memuat…" ---------- */
function gagalMemuat(pesan) {
  tampil('memuat');
  $('memuat').innerHTML =
    `<b>${pesan}</b><br><br>
     <button class="tbl-teks" type="button" onclick="location.reload()">Muat ulang</button>`;
}

const jamPasir = setTimeout(() => {
  const m = $('memuat');
  if (m && !m.hidden) gagalMemuat('Server tidak menjawab (12 detik). Periksa internet, lalu muat ulang.');
}, 12000);

tampil('memuat');
jalankan().catch((e) => {
  console.error('[review]', e);
  gagalMemuat('Gagal memuat: ' + (e && e.message ? e.message : e));
});
