/* ============================================================================
   bunpou.js — daftar pola tata bahasa N3 + dialog penjelasan
   Klik satu pola → dialog: arti, rumus, penjelasan, contoh + furigana.
   ============================================================================ */
import { simpanNilai } from './nilai.js';


import { furigana } from './furigana.js';

const $ = (id) => document.getElementById(id);
let daftar = [];
let urutTampil = [];   // indeks pola sesuai urutan yang sedang tampil (untuk ← →)

async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }

  const { supabase } = window.sesiSiap;
  const kotak = $('daftar-bunpou');

  const { data, error } = await supabase
    .from('bunpou')
    .select('urutan, tema_jp, tema_id, pola, arti, rumus, penjelasan, contoh_jp, contoh_furi, contoh_id')
    .eq('level', 'n3')
    .order('urutan');

  if (error) {
    kotak.innerHTML = `<div class="kosong"><b>Tabel <code>bunpou</code> belum siap.</b><br>
      Jalankan <code>db/bunpou.sql</code> dulu.</div>`;
    return;
  }

  daftar = data || [];
  $('info-bunpou').textContent = `${daftar.length} pola`;

  if (!daftar.length) {
    kotak.innerHTML = '<div class="kosong">Belum ada pola. Jalankan db/bunpou.sql.</div>';
    return;
  }

  gambar(daftar);
  pasangDialog();
  pasangCari();
}

/* ---------- daftar ---------- */
function gambar(isi) {
  const grup = new Map();
  isi.forEach((p, i) => {
    const kunci = p.tema_jp + '|' + p.tema_id;
    if (!grup.has(kunci)) grup.set(kunci, { jp: p.tema_jp, id: p.tema_id, isi: [] });
    grup.get(kunci).isi.push({ ...p, _i: daftar.indexOf(p) });
  });

  urutTampil = [...grup.values()].flatMap((g) => g.isi.map((p) => p._i));

  $('daftar-bunpou').innerHTML = [...grup.values()].map((g) => `
    <section class="bp-grup">
      <h2 class="bp-tema">${esc(g.jp)} <small>${esc(g.id)}</small>
        <button class="bp-kuis" type="button" data-tema="${esc(g.jp)}|${esc(g.id)}">Kuis</button>
      </h2>
      ${g.isi.map((p) => `
        <button class="bp-item" type="button" data-i="${p._i}">
          <span class="bp-pola">${esc(p.pola)}</span>
          <span class="bp-arti">${esc(p.arti)}</span>
          <span class="panah" aria-hidden="true">›</span>
        </button>`).join('')}
    </section>`).join('');

  $('daftar-bunpou').querySelectorAll('.bp-item').forEach((b) => {
    b.addEventListener('click', () => buka(Number(b.dataset.i)));
  });

  // kuis per kategori
  $('daftar-bunpou').querySelectorAll('.bp-kuis').forEach((b) => {
    b.addEventListener('click', (e) => { e.stopPropagation(); mulaiKuis(b.dataset.tema); });
  });
}

/* ---------- dialog ---------- */
function pasangDialog() {
  const dlg = $('dialog-bunpou');

  $('bp-tutup').addEventListener('click', () => dlg.close());
  dlg.addEventListener('click', (e) => { if (e.target === dlg) dlg.close(); });

  $('bp-mundur').addEventListener('click', () => geser(-1));
  $('bp-maju').addEventListener('click', () => geser(1));

  dlg.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowLeft') geser(-1);
    if (e.key === 'ArrowRight') geser(1);
  });
}

let sedang = -1;

function buka(i) {
  const p = daftar[i];
  if (!p) return;
  sedang = i;

  $('bp-pola').textContent = p.pola;
  $('bp-arti').textContent = p.arti;
  $('bp-tema').textContent = `${p.tema_jp} · ${p.tema_id}`;
  $('bp-rumus').textContent = p.rumus || '—';
  $('bp-penjelasan').textContent = p.penjelasan || '';

  const contoh = $('bp-contoh');
  contoh.innerHTML = p.contoh_furi
    ? furigana(p.contoh_jp, p.contoh_furi)
    : esc(p.contoh_jp);
  $('bp-contoh-id').textContent = p.contoh_id || '';

  const pos = urutTampil.indexOf(i);
  $('bp-mundur').disabled = pos <= 0;
  $('bp-maju').disabled = pos < 0 || pos >= urutTampil.length - 1;

  const dlg = $('dialog-bunpou');
  if (!dlg.open) dlg.showModal();
  contoh.blur();
}

function geser(arah) {
  const pos = urutTampil.indexOf(sedang);
  if (pos < 0) return;
  const berikut = urutTampil[pos + arah];
  if (berikut === undefined) return;
  buka(berikut);
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

      if (!q) {
        gambar(daftar);
        hasil.textContent = '';
        return;
      }

      const cocok = daftar.filter((p) =>
        (p.pola + ' ' + p.arti + ' ' + p.rumus + ' ' + p.penjelasan + ' ' + p.contoh_id)
          .toLowerCase().includes(q));

      gambar(cocok);
      hasil.textContent = cocok.length ? `${cocok.length} cocok` : 'tidak ada';
      if (!cocok.length) {
        $('daftar-bunpou').innerHTML = '<div class="kosong">Tidak ada pola yang cocok.</div>';
      }
    }, 120);
  });
}

function esc(s) {
  return String(s ?? '').replace(/[&<>"]/g, (c) =>
    ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));
}


/* ============================================================================
   KUIS BUNPOU — 15 soal, 5 tipe (3 soal per tipe)
   ① pola → arti        ② arti → pola          ③ arti kalimat → pola
   ④ kalimat ID → kalimat JP                   ⑤ kalimat JP (furigana) → arti
   ============================================================================ */
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

const JENIS = ['arti', 'pola', 'kalimat', 'idKeJp', 'jpKeId'];
const NAMA = {
  arti: 'pola → arti',
  pola: 'arti → pola',
  kalimat: 'kalimat → pola',
  idKeJp: 'Indonesia → Jepang',
  jpKeId: 'Jepang → Indonesia'
};

/** satu soal; null kalau pola tidak punya contoh kalimat */
function bikinSoal(jenis, p, pool) {
  // 3 pengecoh: utamakan dari kategori yang sama, kurangnya ambil dari daftar lain
  let lain = acak(pool.filter((x) => x.pola !== p.pola && x.arti !== p.arti)).slice(0, 3);
  if (lain.length < 3) {
    const ada = new Set(lain.map((x) => x.pola));
    const sisa = acak(daftar.filter((x) => x.pola !== p.pola && x.arti !== p.arti && !ada.has(x.pola)));
    lain = lain.concat(sisa.slice(0, 3 - lain.length));
  }
  if (lain.length < 3) return null;

  if (jenis === 'arti') {
    return { jenis, tampil: p.pola, petunjuk: 'Pilih artinya',
      benarTeks: p.arti, pilihan: acak([p.arti, ...lain.map((x) => x.arti)]) };
  }

  if (jenis === 'pola') {
    return { jenis, tampil: p.arti, kalimat: true, petunjuk: 'Pola mana yang cocok?',
      benarTeks: p.pola, pilihan: acak([p.pola, ...lain.map((x) => x.pola)]) };
  }

  if (jenis === 'kalimat') {
    if (!p.contoh_id) return null;
    return { jenis, tampil: p.contoh_id, kalimat: true, petunjuk: 'Kalimat ini memakai pola apa?',
      benarTeks: p.pola, pilihan: acak([p.pola, ...lain.map((x) => x.pola)]) };
  }

  if (jenis === 'idKeJp') {
    if (!p.contoh_id || !p.contoh_jp) return null;
    return { jenis, tampil: p.contoh_id, kalimat: true, petunjuk: 'Pilih kalimat Jepang yang tepat',
      benarTeks: p.contoh_jp, pilihan: acak([p.contoh_jp, ...lain.map((x) => x.contoh_jp)]) };
  }

  // jpKeId
  if (!p.contoh_id || !p.contoh_jp) return null;
  const adaFuri = Boolean(p.contoh_furi);
  return { jenis, html: adaFuri,
    tampil: adaFuri ? furigana(p.contoh_jp, p.contoh_furi) : p.contoh_jp,
    kalimat: true, petunjuk: 'Pilih arti kalimat ini',
    benarTeks: p.contoh_id, pilihan: acak([p.contoh_id, ...lain.map((x) => x.contoh_id)]) };
}

/**
 * tema = "tema_jp|tema_id" → soal khusus kategori itu (1 soal tiap pola, tipe bergiliran)
 * tema kosong             → campur semua kategori (5 tipe × 3 pola)
 */
function buatSoal(tema) {
  const pool = tema ? daftar.filter((p) => p.tema_jp + '|' + p.tema_id === tema) : daftar;
  const hasil = [];

  if (tema) {
    pool.forEach((p, i) => {
      const s = bikinSoal(JENIS[i % JENIS.length], p, pool)
             || bikinSoal(JENIS[(i + 1) % JENIS.length], p, pool);
      if (s) hasil.push({ ...s, topik: pool[0].tema_jp + ' · ' + NAMA[s.jenis] });
    });
  } else {
    JENIS.forEach((j, n) => {
      acak(daftar).slice(0, 3).forEach((p) => {
        const s = bikinSoal(j, p, daftar);
        if (s) hasil.push({ ...s, topik: 'Tip ' + (n + 1) + ' · ' + NAMA[j] });
      });
    });
  }

  return acak(hasil);
}

function tampilKuis(tampil) {
  $('tahap-kuis').hidden = !tampil;
  $('tahap-kuis-selesai').hidden = true;
  document.querySelector('.cari-wrap').hidden = tampil;
  $('daftar-bunpou').hidden = tampil;
  document.querySelector('.kepala-isi p').hidden = tampil;
}

let temaAktif = null;

function mulaiKuis(tema) {
  if (!daftar.length) return;
  temaAktif = typeof tema === 'string' ? tema : null;
  soal = buatSoal(temaAktif);
  soalKe = 0;
  benar = 0;
  tampilKuis(true);
  gambarSoal();
}

function gambarSoal() {
  const s = soal[soalKe];
  if (!s) return selesaiKuis();

  $('kuis-topik').textContent = s.topik;
  const el = $('kuis-soal');
  if (s.html) el.innerHTML = s.tampil; else el.textContent = s.tampil;
  el.className = 'kuis-soal' + (s.kalimat ? ' kalimat' : '');
  $('kuis-petunjuk').textContent = s.petunjuk;

  $('kuis-hitung').textContent = `${soalKe + 1} / ${soal.length}`;
  $('batang-kuis').style.width = (soalKe / soal.length) * 100 + '%';

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
}

function jawab(tombol, teks, s) {
  const semua = [...$('pilihan').children];
  semua.forEach((b) => { b.disabled = true; });

  const tepat = teks === s.benarTeks;
  if (tepat) { benar++; tombol.classList.add('benar'); }
  else {
    tombol.classList.add('salah');
    semua.find((b) => b.textContent === s.benarTeks)?.classList.add('benar');
  }

  $('selisih').innerHTML = tepat ? 'Benar ✓' : `Yang benar: <b>${esc(s.benarTeks)}</b>`;
  const lanjut = $('btn-lanjut-kuis');
  lanjut.hidden = false;
  lanjut.onclick = () => { soalKe++; gambarSoal(); };
}

function selesaiKuis() {
  $('tahap-kuis').hidden = true;
  $('tahap-kuis-selesai').hidden = false;
  const persen = Math.round((benar / soal.length) * 100);
  simpanNilai('bunpou', null, benar, soal.length);
  $('nilai').textContent = `${benar} / ${soal.length} benar (${persen}%)`;
  $('pesan-nilai').textContent =
    persen >= 80 ? 'Bagus. Polanya sudah nempel.'
    : persen >= 60 ? 'Lumayan. Baca ulang pola yang tadi salah.'
    : 'Masih goyah. Buka daftarnya, baca rumus + contohnya.';
}

$('btn-mulai-kuis').addEventListener('click', () => mulaiKuis(null));
$('btn-ulang-kuis').addEventListener('click', () => mulaiKuis(temaAktif));

jalankan().catch((e) => {
  const kotak = $('daftar-bunpou');
  if (kotak) kotak.innerHTML = `<div class="kosong">Gagal memuat: ${esc(e && e.message ? e.message : e)}</div>`;
});
