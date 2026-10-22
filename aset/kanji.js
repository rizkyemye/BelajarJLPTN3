/* ============================================================================
   kanji.js — kartu kanji + review wajib + kuis 3 tipe
   Alur sengaja disamakan dengan belajar.js (kosakata):
   kartu → 3 tombol → kuis. Beda isi: onyomi/kunyomi/bushu/3 kosakata.
   ============================================================================ */
import { simpanNilai } from './nilai.js';


import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';
import { ucapkan, suaraSiap } from './suara.js';
import { pasangUrutan } from './strokes.js';

const $ = (id) => document.getElementById(id);

const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const HARI  = Number(new URLSearchParams(location.search).get('hari') || 1);

let supabase = null;
let daftar = [];
let posisi = 0;
let nilai = {};

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
  $('label-hari').textContent  = 'Kanji · Hari ' + HARI;
  document.title = `Kanji Hari ${HARI} · N3 · 日本語 Belajar`;

  if (!window.konfigSiap || !window.konfigSiap()) {
    $('memuat').textContent = 'Konfigurasi Supabase belum diisi di aset/konfig.js';
    return;
  }

  supabase = createClient(window.KONFIG.url, window.KONFIG.kunci, {
    auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: false }
  });

  const { data: { user } } = await supabase.auth.getUser();
  if (!user) { location.replace('../login.html'); return; }

  const { data: hasil, error: errBuka } = await supabase
    .rpc('mulai_hari_kanji', { p_level: LEVEL, p_hari: HARI });

  if (errBuka) {
    $('memuat').textContent = 'Gagal membuka hari: ' + errBuka.message;
    return;
  }

  if (hasil === 'terkunci') {
    $('hari-sebelum').textContent = 'hari ' + (HARI - 1);
    tampil('terkunci');
    return;
  }

  const { data: kanji, error: errK } = await supabase
    .from('kanji')
    .select('id, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata')
    .eq('level', LEVEL)
    .eq('hari_ke', HARI)
    .order('urutan');

  if (errK || !kanji || !kanji.length) {
    $('memuat').innerHTML =
      'Belum ada kanji untuk hari ini.<br><small>Jalankan upload-kanji.sql dulu.</small>';
    return;
  }

  daftar = kanji;

  const { data: sudah } = await supabase
    .from('review_kanji')
    .select('kanji_id, status')
    .eq('hari_ke', HARI);

  (sudah || []).forEach(r => {
    if (r.status !== 'belum') nilai[r.kanji_id] = r.status;
  });

  await suaraSiap();

  if (Object.keys(nilai).length >= daftar.length) {
    await tahapSelesai();
    return;
  }

  posisi = daftar.findIndex(k => !nilai[k.id]);
  if (posisi < 0) posisi = 0;

  tampil('tahap-kartu');
  gambarKartu();
}

/* ---------- flashcard ---------- */
function gambarKartu() {
  const k = daftar[posisi];
  if (!k) return tahapSelesai();

  $('kartu').classList.remove('terbalik');

  // depan: bushu kecil di atas (seperti kelas kata di kosakata)
  $('bushu-depan').textContent =
    k.bushu ? `${k.bushu}${k.arti_bushu ? ' ' + k.arti_bushu : ''}` : '';

  $('kanji').textContent = k.kanji;

  const yomi = [k.onyomi, k.kunyomi].filter(Boolean).join(' ／ ');
  $('yomi').textContent = yomi || '—';
  $('arti').textContent = k.arti;

  const kata = Array.isArray(k.kata) ? k.kata : [];
  if (kata.length) {
    $('contoh-wrap').hidden = false;
    // tiap kata dibungkus span nowrap supaya bacaan tidak terpotong di HP
    ['contoh-jp', 'contoh-id'].forEach(id => { $(id).innerHTML = ''; });
    kata.forEach((x, i) => {
      if (i) [$('contoh-jp'), $('contoh-id')].forEach(el => el.append(' · '));
      [['contoh-jp', `${x.k} ${x.y}`], ['contoh-id', x.a]].forEach(([id, teks]) => {
        const s = document.createElement('span');
        s.style.whiteSpace = 'nowrap';
        s.textContent = teks;
        $(id).append(s);
      });
    });
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

  supabase.rpc('nilai_kanji', { p_id: k.id, p_nilai: hasil }).then(() => {});

  const sisa = daftar.findIndex((x, i) => i > posisi && !nilai[x.id]);
  const sisaAwal = daftar.findIndex(x => !nilai[x.id]);

  if (sisa >= 0)          { posisi = sisa; gambarKartu(); }
  else if (sisaAwal >= 0) { posisi = sisaAwal; gambarKartu(); }
  else                    { tahapSelesai(); }
}

/* ---------- selesai ---------- */
async function tahapSelesai() {
  tampil('tahap-selesai');

  const hafal = Object.values(nilai).filter(v => v === 'hafal').length;
  const ragu  = Object.values(nilai).filter(v => v === 'ragu').length;
  const lupa  = Object.values(nilai).filter(v => v === 'lupa').length;

  $('judul-selesai').textContent = 'Semua kanji sudah dinilai';
  $('ket-selesai').innerHTML =
    `<b>${hafal}</b> hafal · <b>${ragu}</b> ragu · <b>${lupa}</b> lupa.` +
    ((ragu + lupa) > 0
      ? `<br><small>${ragu + lupa} kanji masuk antrian review.</small>` : '');

  const besok = $('btn-besok');
  besok.hidden = false;
  besok.href = `kanji.html?hari=${HARI + 1}`;
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

/* 3 tipe · 4 soal per tipe = 12 */
function buatSoal() {
  const hasil = [];
  const tipe = [
    { nama: 'Tip 1 · kanji → arti',        jenis: 'arti' },
    { nama: 'Tip 2 · suara → kanji + arti', jenis: 'dengar' },
    { nama: 'Tip 3 · kanji → bacaan + arti', jenis: 'baca' }
  ];

  tipe.forEach((t) => {
    acak(daftar).slice(0, 4).forEach((k) => {
      const lain = acak(daftar.filter(x => x.id !== k.id)).slice(0, 3);

      if (t.jenis === 'arti') {
        hasil.push({
          topik: t.nama, tampil: k.kanji, kecil: false,
          petunjuk: 'Pilih artinya',
          benarTeks: k.arti,
          pilihan: acak([k.arti, ...lain.map(x => x.arti)]),
          bunyi: k.kunyomi || k.onyomi
        });
      }

      if (t.jenis === 'dengar') {
        hasil.push({
          topik: t.nama, tampil: '🔊', kecil: true,
          petunjuk: 'Dengarkan, lalu pilih kanji dan artinya',
          benarTeks: `${k.kanji} — ${k.arti}`,
          pilihan: acak([`${k.kanji} — ${k.arti}`,
                         ...lain.map(x => `${x.kanji} — ${x.arti}`)]),
          bunyi: k.kunyomi || k.onyomi,
          putarDulu: true
        });
      }

      if (t.jenis === 'baca') {
        const baca = (k.onyomi || k.kunyomi || '').split('・')[0];
        hasil.push({
          topik: t.nama, tampil: k.kanji, kecil: false,
          petunjuk: 'Pilih cara baca dan artinya',
          benarTeks: `${baca} — ${k.arti}`,
          pilihan: acak([`${baca} — ${k.arti}`,
                         ...lain.map(x => `${(x.onyomi || x.kunyomi || '').split('・')[0]} — ${x.arti}`)])
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
  el.className = 'kuis-soal' + (s.kecil ? ' kecil' : '') + (s.putarDulu ? ' putar-ulang' : '');
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
  simpanNilai('kanji', HARI, benar, soal.length);
  $('nilai').textContent = `${benar} / ${soal.length} benar (${persen}%)`;
  $('pesan-nilai').textContent =
    persen >= 80 ? 'Bagus. Lanjut hari berikutnya besok.'
    : persen >= 60 ? 'Lumayan. Ulangi kanji yang tadi salah.'
    : 'Masih goyah. Baca ulang kartunya sebelum lanjut.';
}

/* ---------- urutan goresan ---------- */
const dlg = $('dialog-urut');
let urutan = null;

async function bukaUrutan() {
  const k = daftar[posisi];
  if (!k) return;

  $('urut-kanji').textContent = k.kanji;
  $('svg-wadah').textContent = 'memuat…';
  dlg.showModal();

  urutan = await pasangUrutan(k.kanji, $('svg-wadah'));
  $('urut-sub').textContent = urutan ? `${urutan.jumlah} goresan` : 'data goresan tidak ditemukan';
  if (urutan) urutan.main();
}

$('btn-urut').addEventListener('click', (e) => {
  e.stopPropagation();
  bukaUrutan();
});

$('ulang-urut').addEventListener('click', () => { if (urutan) urutan.main(); });
$('tutup-urut').addEventListener('click', () => dlg.close());
dlg.addEventListener('click', (e) => { if (e.target === dlg) dlg.close(); });

/* ---------- pasang ---------- */
$('putar').addEventListener('click', (e) => {
  e.stopPropagation();
  const k = daftar[posisi];
  if (k) ucapkan(k.kunyomi || k.onyomi, { rate: 0.85 });
});

const kartu = $('kartu');
kartu.addEventListener('click', () => kartu.classList.toggle('terbalik'));
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
mulai().catch((e) => {
  console.error('[kanji]', e);
  gagalMemuat('Gagal memuat: ' + (e && e.message ? e.message : e));
});
