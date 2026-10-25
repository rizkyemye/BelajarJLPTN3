/* ============================================================================
   belajar.js — flashcard 30 kata + review wajib + kuis 3 tipe
   Dipakai n5/ n4/ n3/ — level dibaca dari nama folder.
   ============================================================================ */
import { simpanNilai, catatSalah } from './nilai.js';


import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';
import { ucapkan, suaraSiap } from './suara.js';
import { furigana } from './furigana.js';

const DOMAIN = 'n3master.local';
const $ = (id) => document.getElementById(id);

/* level dari URL: .../n3/kartu.html */
const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const HARI  = Number(new URLSearchParams(location.search).get('hari') || 1);

let supabase = null;
let daftar = [];        // 30 kosakata
let posisi = 0;         // kartu ke-
let nilai = {};         // kosakata_id → 'hafal' | 'ulang'

/* ---------- tampil ---------- */
function tampil(id) {
  ['memuat', 'terkunci', 'tahap-kartu', 'tahap-selesai', 'tahap-kuis', 'tahap-kuis-selesai']
    .forEach(x => $(x).hidden = (x !== id));
}

function setBatang(el, persen) {
  el.style.width = Math.max(0, Math.min(100, persen)) + '%';
}

/* ---------- mulai ---------- */
async function mulai() {
  $('label-level').textContent = LEVEL.toUpperCase();
  $('label-hari').textContent  = 'Hari ' + HARI;

  if (!window.konfigSiap || !window.konfigSiap()) {
    $('memuat').textContent = 'Konfigurasi Supabase belum diisi di aset/konfig.js';
    return;
  }

  supabase = createClient(window.KONFIG.url, window.KONFIG.kunci, {
    auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: false }
  });

  // tema hari ini (kalau ada) — setelah client dibuat
  supabase.from('tema_hari')
    .select('tema, arti')
    .eq('level', LEVEL).eq('hari_ke', HARI)
    .maybeSingle()
    .then(({ data: t }) => {
      if (!t) return;
      $('label-hari').innerHTML =
        `Hari ${HARI} <span class="tema-jp">${t.tema}</span>`;
      if (t.arti) document.title = `Hari ${HARI} · ${t.tema} · 日本語 Belajar`;
    });


  // 1. sesi (server, bukan cache)
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) { location.replace('../login.html'); return; }

  // 2. buka / periksa hari
  const { data: hasil, error: errBuka } = await supabase
    .rpc('mulai_hari', { p_level: LEVEL, p_hari: HARI });

  if (errBuka) {
    $('memuat').textContent = 'Gagal membuka hari: ' + errBuka.message;
    return;
  }

  if (hasil === 'terkunci') {
    $('hari-sebelum').textContent = 'Hari ' + (HARI - 1);
    tampil('terkunci');
    return;
  }

  // 3. ambil semua kata hari itu
  const { data: kata, error: errKata } = await supabase
    .from('kosakata')
    .select('id, kanji, yomi, arti, kelas, contoh_jp, contoh_furi, contoh_id')
    .eq('level', LEVEL)
    .eq('hari_ke', HARI)
    .order('urutan');

  if (errKata || !kata || !kata.length) {
    $('memuat').innerHTML =
      'Belum ada bahan untuk hari ini.<br><small>Isi tabel kosakata dulu lewat SQL.</small>';
    return;
  }

  daftar = kata;

  // 4. baca status review yang sudah ada
  const { data: sudah } = await supabase
    .from('review')
    .select('kosakata_id, status')
    .eq('hari_ke', HARI);

  (sudah || []).forEach(r => {
    if (r.status !== 'belum') nilai[r.kosakata_id] = r.status;
  });

  await suaraSiap();

  // semua sudah dinilai? langsung ke tahap selesai
  if (Object.keys(nilai).length >= daftar.length) {
    await tahapSelesai();
    return;
  }

  // lanjut dari kartu pertama yang belum dinilai
  posisi = daftar.findIndex(k => !nilai[k.id]);
  if (posisi < 0) posisi = 0;

  tampil('tahap-kartu');
  gambarKartu();
}

/* ---------- flashcard ---------- */
function gambarKartu() {
  const k = daftar[posisi];
  if (!k) return tahapSelesai();

  $('kartu').classList.remove('terbalik');   // selalu mulai dari muka kanji
  $('kelas').textContent = k.kelas || '';
  $('kanji').textContent = k.kanji;
  $('yomi').textContent  = k.yomi;
  $('arti').textContent  = k.arti;

  if (k.contoh_jp) {
    $('contoh-wrap').hidden = false;
    $('contoh-jp').innerHTML = k.contoh_furi
      ? furigana(k.contoh_jp, k.contoh_furi)
      : k.contoh_jp.replace(/[&<>]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;'}[c]));
    $('contoh-id').textContent = k.contoh_id || '';
  } else {
    $('contoh-wrap').hidden = true;
  }

  $('hitung').textContent = `${Object.keys(nilai).length + 1} / ${daftar.length}`;
  setBatang($('batang-kartu'), (Object.keys(nilai).length / daftar.length) * 100);
}

function hentikan() {
  try { speechSynthesis.cancel(); } catch (_) {}
}

function kartuBerikut(hasil) {
  const k = daftar[posisi];
  nilai[k.id] = hasil;

  // jadwalkan ulang lewat SRS (lupa → besok, ragu → tetap, hafal → naik tahap)
  supabase.rpc('nilai_review', { p_id: k.id, p_nilai: hasil }).then(() => {});

  // cari berikutnya yang belum dinilai
  const sisa = daftar.findIndex((x, i) => i > posisi && !nilai[x.id]);
  const sisaAwal = daftar.findIndex(x => !nilai[x.id]);

  if (sisa >= 0)      { posisi = sisa; gambarKartu(); }
  else if (sisaAwal >= 0) { posisi = sisaAwal; gambarKartu(); }
  else                { tahapSelesai(); }
}

/* ---------- selesai review ---------- */
async function tahapSelesai() {
  const { data: hasil } = await supabase
    .rpc('selesaikan_review', { p_level: LEVEL, p_hari: HARI });

  tampil('tahap-selesai');

  const hafal = Object.values(nilai).filter(v => v === 'hafal').length;
  const ragu  = Object.values(nilai).filter(v => v === 'ragu').length;
  const lupa  = Object.values(nilai).filter(v => v === 'lupa').length;

  const besok = $('btn-besok');

  if (hasil === 'selesai') {
    $('judul-selesai').textContent = 'Review selesai';
    $('ket-selesai').innerHTML =
      `<b>${hafal}</b> hafal · <b>${ragu}</b> ragu · <b>${lupa}</b> lupa. ` +
      `Hari ${HARI + 1} sudah terbuka.` +
      ((ragu + lupa) > 0
        ? `<br><small>${ragu + lupa} kata masuk antrian review besok.</small>` : '');

    besok.hidden = false;
    besok.href = `kartu.html?hari=${HARI + 1}`;
  } else {
    $('judul-selesai').textContent = 'Masih ada yang belum dinilai';
    $('ket-selesai').textContent = 'Kembali dan nilai semua kartu dulu.';
    besok.hidden = true;
  }
}

/* ---------- kuis ---------- */
let soal = [];
let soalKe = 0;
let benar = 0;

function acak(arr) {
  const a = arr.slice();
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

/* tiga tipe soal, 5 soal per tipe = 15 */
function buatSoal() {
  const hasil = [];
  const tipe = [
    { nama: 'Tip 1 · kanji → arti',          jenis: 'arti' },
    { nama: 'Tip 2 · suara → kanji + arti',  jenis: 'dengar' },
    { nama: 'Tip 3 · kanji → hiragana + arti', jenis: 'baca' },
    { nama: 'Tip 4 · isi kalimat',           jenis: 'rumpang' },
    { nama: 'Tip 5 · 聴解 · dengar kalimat',  jenis: 'dengarKalimat' }
  ];

  tipe.forEach((t) => {
    const lima = acak(daftar).slice(0, 3);
    lima.forEach((k) => {
      const lain = acak(daftar.filter(x => x.id !== k.id)).slice(0, 3);

      if (t.jenis === 'arti') {
        hasil.push({
          topik: t.nama, tampil: k.kanji, kecil: false,
          petunjuk: 'Pilih artinya',
          benarTeks: k.arti,
          pilihan: acak([k.arti, ...lain.map(x => x.arti)]),
          bunyi: k.yomi
        });
      }

      if (t.jenis === 'dengar') {
        hasil.push({
          topik: t.nama, tampil: '🔊', kecil: true,
          petunjuk: 'Dengarkan, lalu pilih kanji dan artinya',
          benarTeks: `${k.kanji} — ${k.arti}`,
          pilihan: acak([`${k.kanji} — ${k.arti}`,
                         ...lain.map(x => `${x.kanji} — ${x.arti}`)]),
          bunyi: k.yomi,
          putarDulu: true
        });
      }

      if (t.jenis === 'baca') {
        hasil.push({
          topik: t.nama, tampil: k.kanji, kecil: false,
          petunjuk: 'Pilih cara baca (hiragana) dan artinya',
          benarTeks: `${k.yomi} — ${k.arti}`,
          pilihan: acak([`${k.yomi} — ${k.arti}`,
                         ...lain.map(x => `${x.yomi} — ${x.arti}`)])
        });
      }

      // kalimat contoh dengan kata itu diganti ＿＿
      if (t.jenis === 'rumpang') {
        const kalimat = (k.contoh_jp || '').includes(k.kanji)
          ? k.contoh_jp.replace(k.kanji, '＿＿')
          : null;
        if (!kalimat) return;
        hasil.push({
          topik: t.nama, tampil: kalimat, kecil: false, kalimat: true,
          petunjuk: 'Kata apa yang tepat untuk kalimat ini?',
          benarTeks: k.kanji,
          pilihan: acak([k.kanji, ...lain.map(x => x.kanji)]),
          bunyi: k.yomi
        });
      }

      // 聴解: kalimat dibacakan, pilih kata + artinya
      if (t.jenis === 'dengarKalimat') {
        hasil.push({
          topik: t.nama, tampil: '🔊', kecil: true,
          petunjuk: 'Dengarkan kalimatnya, lalu pilih kata dan artinya',
          benarTeks: `${k.kanji} — ${k.arti}`,
          pilihan: acak([`${k.kanji} — ${k.arti}`,
                         ...lain.map(x => `${x.kanji} — ${x.arti}`)]),
          bunyi: k.contoh_furi || k.yomi,
          putarDulu: true
        });
      }
    });
  });

  return acak(hasil);
}

function gambarSoal() {
  const s = soal[soalKe];
  if (!s) return selesaiKuis();

  $('kuis-topik').textContent = s.topik;
  const el = $('kuis-soal');
  el.textContent = s.tampil;
  el.className = 'kuis-soal' + (s.kecil ? ' kecil' : '') +
                 (s.putarDulu ? ' putar-ulang' : '') + (s.kalimat ? ' kalimat' : '');
  $('kuis-petunjuk').textContent = s.putarDulu
    ? 'Tap untuk mengulang suara'
    : s.petunjuk;

  /* 🔊 bisa ditekan untuk memutar ulang */
  if (s.putarDulu) {
    el.setAttribute('role', 'button');
    el.setAttribute('tabindex', '0');
    el.setAttribute('aria-label', 'Putar ulang suara');
    el.onclick = () => ucapkan(s.bunyi, { rate: 0.85 });
    el.onkeydown = (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        ucapkan(s.bunyi, { rate: 0.85 });
      }
    };
  } else {
    el.removeAttribute('role');
    el.removeAttribute('tabindex');
    el.removeAttribute('aria-label');
    el.onclick = null;
    el.onkeydown = null;
  }

  $('kuis-hitung').textContent = `${soalKe + 1} / ${soal.length}`;
  setBatang($('batang-kuis'), (soalKe / soal.length) * 100);

  const kotak = $('pilihan');
  kotak.innerHTML = '';
  $('selisih').textContent = '';
  $('btn-lanjut-kuis').hidden = true;

  s.pilihan.forEach((teks) => {
    const b = document.createElement('button');
    b.textContent = teks;
    b.addEventListener('click', () => jawab(b, teks, s));
    kotak.appendChild(b);
  });

  if (s.putarDulu) ucapkan(s.bunyi, { rate: 0.85 });
}

function jawab(tombol, teks, s) {
  const semua = [...$('pilihan').children];
  semua.forEach(b => { b.disabled = true; });

  const tepat = teks === s.benarTeks;
  if (tepat) { benar++; tombol.classList.add('benar'); }
  else {
    catatSalah('kosakata', HARI, s.tampil, s.benarTeks, teks);
    tombol.classList.add('salah');
    semua.find(b => b.textContent === s.benarTeks)?.classList.add('benar');
  }

  $('selisih').innerHTML = tepat
    ? 'Benar ✓'
    : `Yang benar: <b>${s.benarTeks}</b>`;

  const lanjut = $('btn-lanjut-kuis');
  lanjut.hidden = false;
  lanjut.onclick = () => { soalKe++; gambarSoal(); };
}

function selesaiKuis() {
  tampil('tahap-kuis-selesai');
  const persen = Math.round((benar / soal.length) * 100);
  simpanNilai('kosakata', HARI, benar, soal.length);
  $('nilai').textContent = `${benar} / ${soal.length} benar (${persen}%)`;
  $('pesan-nilai').textContent =
    persen >= 80 ? 'Bagus. Lanjut hari berikutnya besok.'
    : persen >= 60 ? 'Lumayan. Ulangi kata yang tadi salah.'
    : 'Masih goyah. Baca ulang kartunya sebelum lanjut.';
}

/* ---------- pasang ---------- */
$('putar').addEventListener('click', (e) => {
  e.stopPropagation();                 // jangan balik kartunya
  const k = daftar[posisi];
  if (k) ucapkan(k.yomi, { rate: 0.85 });
});

/* ---------- balik kartu ---------- */
const kartu = $('kartu');
kartu.addEventListener('click', () => {
  kartu.classList.toggle('terbalik');
});
kartu.addEventListener('keydown', (e) => {
  if (e.key === 'Enter' || e.key === ' ') {
    e.preventDefault();
    kartu.classList.toggle('terbalik');
  }
});

$('btn-hafal').addEventListener('click', () => { hentikan(); kartuBerikut('hafal'); });
$('btn-ragu').addEventListener('click',  () => { hentikan(); kartuBerikut('ragu'); });
$('btn-lupa').addEventListener('click',  () => { hentikan(); kartuBerikut('lupa'); });

$('btn-kuis').addEventListener('click', () => {
  soal = buatSoal();
  soalKe = 0;
  benar = 0;
  tampil('tahap-kuis');
  gambarSoal();
});

/* ---------- penjaga: jangan menggantung di "Memuat…" ---------- */
let jamPasir = null;

function gagal(pesan) {
  clearTimeout(jamPasir);
  tampil('memuat');
  $('memuat').innerHTML =
    `<b>${pesan}</b><br><br>
     <button class="tbl-teks" type="button" onclick="location.reload()">Muat ulang</button>`;
}

jamPasir = setTimeout(() => {
  const m = $('memuat');
  if (m && !m.hidden) {
    gagal('Server tidak menjawab (12 detik). Periksa internet, lalu muat ulang.');
  }
}, 12000);

tampil('memuat');
mulai().catch((e) => {
  console.error('[belajar]', e);
  gagal('Gagal memuat: ' + (e && e.message ? e.message : e));
});
