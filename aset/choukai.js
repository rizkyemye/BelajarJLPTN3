/* ============================================================================
   choukai.js — soal mendengar gaya JLPT
   Suara: Web Speech (ja-JP) lewat aset/suara.js — tidak ada file audio.
   Skrip dibacakan baris demi baris (satu baris = satu pembicara).
   ============================================================================ */
import { simpanNilai, catatSalah } from './nilai.js';


import { furigana } from './furigana.js';
import { bacaBerurutan, berhenti, adaSuaraJepang } from './suara.js';

const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const $ = (id) => document.getElementById(id);

const NAMA_JENIS = {
  kd: '課題理解 · pahami tugasnya',
  pt: 'ポイント理解 · pahami poinnya',
  hw: '発話表現 · apa yang kamu katakan',
  sk: '即時応答 · jawab seketika'
};

let semua = [];
let sedang = null;
let sedangMain = false;

/* mode latihan (bebas ulang) vs jlpt (sekali putar, tempo normal, pertanyaan
   baru bisa dibuka setelah diperiksa) */
let mode = localStorage.getItem('ck-mode') === 'jlpt' ? 'jlpt' : 'latihan';
let sudahPutar = false;

const esc = (s) => String(s ?? '').replace(/[&<>"]/g, (c) =>
  ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));

/* pisahkan "女：あした…" jadi { pelaku, teks } */
function pecahBaris(teks, furi) {
  const jp = String(teks || '').split('\n').filter((x) => x.trim());
  const fu = String(furi || '').split('\n');

  return jp.map((baris, i) => {
    const i2 = baris.indexOf('：');
    const pelaku = i2 > 0 ? baris.slice(0, i2) : '';
    const isiJp = i2 > 0 ? baris.slice(i2 + 1) : baris;

    const f = fu[i] || '';
    const j2 = f.indexOf('：');
    const isiFuri = j2 > 0 ? f.slice(j2 + 1) : f;

    return { pelaku, jp: isiJp, furi: isiFuri || isiJp };
  });
}

/* ---------- daftar ---------- */
function gambar(isi) {
  const kotak = $('daftar-choukai');
  if (!isi.length) {
    kotak.innerHTML = '<div class="kosong">Belum ada soal.</div>';
    return;
  }

  kotak.innerHTML = isi.map((d) => `
    <button class="dk-item" type="button" data-hari="${d.hari_ke}">
      <span class="dk-kiri">
        <span class="dk-hari">Hari ${d.hari_ke} · ${d.jenis === 'kd' ? '課題理解' : d.jenis === 'pt' ? 'ポイント理解' : d.jenis === 'hw' ? '発話表現' : '即時応答'}</span>
        <span class="dk-judul">${esc(d.judul_jp || '')}</span>
        <span class="dk-meta">${esc(d.judul_id || '')} · ${Array.isArray(d.soal) ? d.soal.length : 0} soal</span>
      </span>
      <span class="panah" aria-hidden="true">›</span>
    </button>`).join('');

  kotak.querySelectorAll('.dk-item').forEach((b) => {
    b.addEventListener('click', () => buka(Number(b.dataset.hari)));
  });
}

/* ---------- buka satu soal ---------- */
function buka(hari) {
  const d = semua.find((x) => x.hari_ke === hari);
  if (!d) return;
  sedang = d;
  sedangMain = false;
  sudahPutar = false;

  $('ck-jenis').textContent = `Hari ${d.hari_ke} · ${NAMA_JENIS[d.jenis] || d.jenis}`;
  $('ck-judul').textContent = d.judul_jp || '';
  $('ck-judul-id').textContent = d.judul_id || '';
  $('ck-hasil').textContent = '';
  $('ck-periksa').disabled = false;
  $('ck-soal').dataset.selesai = '';
  $('ck-putar-teks').textContent = adaSuaraJepang() ? 'Putar suara' : 'Putar (suara Jepang tidak ada)';

  const baris = pecahBaris(d.skrip_jp, d.skrip_furi);

  $('ck-skrip').innerHTML = baris.map((b) =>
    `<span class="ck-baris">${b.pelaku ? `<b>${esc(b.pelaku)}</b> ` : ''}${b.furi ? furigana(b.jp, b.furi) : esc(b.jp)}</span>`).join('');

  $('ck-teks-id').textContent = (d.teks_id || '').replace(/\n/g, ' ');

  const soal = Array.isArray(d.soal) ? d.soal : [];
  // seperti JLPT: pertanyaan DIDENGAR, tidak ditampilkan (bisa dibuka kalau perlu)
  $('ck-soal').innerHTML = soal.map((s, i) => `
    <div class="dk-soal" data-i="${i}">
      <details class="ck-tanya">
        <summary>聞いてください · pertanyaan ${i + 1}</summary>
        <p class="dk-tanya">${esc(s.tanya)}</p>
      </details>
      <div class="pilihan" data-i="${i}">
        ${s.pilihan.map((p, k) => `<button type="button" data-k="${k}">${esc(p)}</button>`).join('')}
      </div>
    </div>`).join('');

  $('ck-soal').querySelectorAll('.pilihan').forEach((kotak) => {
    kotak.querySelectorAll('button').forEach((b) => {
      b.addEventListener('click', () => {
        if (kotak.dataset.selesai === '1') return;
        kotak.querySelectorAll('button').forEach((x) => x.classList.remove('pilih'));
        b.classList.add('pilih');
        kotak.dataset.pilih = b.dataset.k;
      });
    });
  });

  terapkanMode();

  const dlg = $('dialog-choukai');
  if (!dlg.open) dlg.showModal();
  dlg.scrollTop = 0;
}

/* suara tiap pembicara: beda nada (pitch) & tempo — tanpa perlu 2 voice */
function gaya(pelaku) {
  const p = String(pelaku || '');
  if (p.includes('女') || p.includes('母') || p.includes('姉') || p.includes('妹')) return { pitch: 1.22, rate: 0.95 };
  if (p.includes('男') || p.includes('父') || p.includes('兄') || p.includes('弟')) return { pitch: 0.72, rate: 0.9 };
  if (p.includes('ナレーション') || p.includes('先生') || p.includes('医者') || p.includes('店')) return { pitch: 1.0, rate: 0.88 };
  return { pitch: 1.0, rate: 0.93 };
}

/* ---------- mode ---------- */
function terapkanMode() {
  document.querySelectorAll('.ck-mode-btn').forEach((b) => {
    const on = b.dataset.mode === mode;
    b.classList.toggle('aktif', on);
    b.setAttribute('aria-pressed', on ? 'true' : 'false');
  });

  const kunci = mode === 'jlpt' && sudahPutar;
  const tombol = $('ck-putar');
  if (tombol) tombol.disabled = Boolean(kunci && sedangMain === false);

  const catatan = $('ck-catatan');
  if (catatan) {
    catatan.textContent = mode === 'jlpt'
      ? 'Mode JLPT: suara diputar sekali, tempo normal. Pertanyaan baru bisa dibuka setelah diperiksa.'
      : '';
  }

  // di mode JLPT pertanyaan tidak boleh dibuka sebelum diperiksa
  const selesai = $('ck-soal') && $('ck-soal').dataset.selesai === '1';

  document.querySelectorAll('.ck-tanya').forEach((d) => {
    if (selesai) { d.classList.remove('terkunci'); d.open = true; return; }
    const kunci = mode === 'jlpt';
    d.classList.toggle('terkunci', kunci);
    if (kunci) d.open = false;
    if (!d.dataset.pasang) {
      d.dataset.pasang = '1';
      d.addEventListener('toggle', () => {
        if (d.classList.contains('terkunci') && d.open) d.open = false;
      });
    }
  });
}

function gantiMode(m) {
  mode = m === 'jlpt' ? 'jlpt' : 'latihan';
  localStorage.setItem('ck-mode', mode);
  terapkanMode();
}

/* ---------- putar ---------- */
async function putar() {
  if (!sedang || sedangMain) return;
  if (mode === 'jlpt' && sudahPutar) return;

  const baris = pecahBaris(sedang.skrip_jp, sedang.skrip_furi);
  const soal = Array.isArray(sedang.soal) ? sedang.soal : [];

  // urutan seperti JLPT: ① pertanyaan dulu → ② percakapan → ③ pertanyaan lagi
  const dasar = mode === 'jlpt' ? 1 : 0.93;
  const naskah = baris.map((b) => {
    const g = gaya(b.pelaku);
    return { teks: b.furi, pitch: g.pitch, rate: mode === 'jlpt' ? Math.min(1, g.rate + 0.07) : g.rate };
  });
  const semuaTanya = soal.map((s) => s.tanya).join('。');

  sedangMain = true;
  $('ck-putar').disabled = true;

  sudahPutar = true;
  let ok = true;

  if (semuaTanya) {
    $('ck-putar-teks').textContent = 'Pertanyaan…';
    ok = await bacaBerurutan(
      [{ teks: `もんだい。まず、しつもんを きいて ください。${semuaTanya}`, pitch: 1.0, rate: 0.86 }],
      { jeda: 700 }
    );
  }

  if (ok) {
    $('ck-putar-teks').textContent = 'Percakapan…';
    ok = await bacaBerurutan(naskah, { rate: dasar, jeda: mode === 'jlpt' ? 260 : 380 });
  }

  if (ok && semuaTanya) {
    $('ck-putar-teks').textContent = 'Pertanyaan ulang…';
    ok = await bacaBerurutan(
      [{ teks: `もう いちど、しつもんを きいて ください。${semuaTanya}`, pitch: 1.0, rate: 0.86 }],
      { jeda: 500 }
    );
  }

  sedangMain = false;
  $('ck-putar').disabled = false;
  $('ck-putar-teks').textContent = ok ? 'Putar ulang' : 'Putar (gagal — cek suara perangkat)';
}

/* ---------- periksa ---------- */
function periksa() {
  if (!sedang) return;

  const soal = sedang.soal || [];
  let benar = 0;
  let belum = 0;

  $('ck-soal').querySelectorAll('.pilihan').forEach((kotak) => {
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
    else catatSalah('choukai', sedang ? sedang.hari_ke : null, s.tanya, s.pilihan[s.benar], s.pilihan[Number(pilih)]);
  });

  if (belum === soal.length) {
    $('ck-hasil').textContent = 'Pilih jawaban dulu.';
    return;
  }

  $('ck-soal').dataset.selesai = '1';
  $('ck-soal').querySelectorAll('.ck-tanya').forEach((d) => {
    d.classList.remove('terkunci');
    d.open = true;
  });
  if (mode === 'jlpt') { sudahPutar = false; terapkanMode(); }

  const persen = Math.round((benar / soal.length) * 100);
  simpanNilai('choukai', sedang ? sedang.hari_ke : null, benar, soal.length);
  $('ck-hasil').textContent = `${benar} / ${soal.length} benar (${persen}%)`
    + (belum ? ` · ${belum} soal belum dijawab` : '');
  $('ck-periksa').disabled = true;
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
        [d.judul_jp, d.judul_id, d.skrip_jp].join(' ').toLowerCase().includes(q));

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

  const { data, error } = await supabase
    .from('choukai')
    .select('hari_ke, jenis, judul_jp, judul_id, skrip_jp, skrip_furi, teks_id, soal')
    .eq('level', LEVEL)
    .order('hari_ke', { ascending: true });

  if (error) {
    $('daftar-choukai').innerHTML = `<div class="kosong">Gagal memuat: ${esc(error.message)}</div>`;
    return;
  }

  semua = data || [];
  $('info-choukai').textContent = `${semua.length} soal dengar`;

  if (!semua.length) {
    $('daftar-choukai').innerHTML = '<div class="kosong">Belum ada soal. Jalankan <code>db/choukai.sql</code>.</div>';
    return;
  }

  gambar(semua);
  pasangCari();

  document.querySelectorAll('.ck-mode-btn').forEach((b) => {
    b.addEventListener('click', () => { gantiMode(b.dataset.mode); terapkanMode(); });
  });

  $('ck-putar').addEventListener('click', putar);
  $('ck-periksa').addEventListener('click', periksa);

  const dlg = $('dialog-choukai');
  $('ck-tutup').addEventListener('click', () => { berhenti(); dlg.close(); });
  dlg.addEventListener('click', (e) => { if (e.target === dlg) { berhenti(); dlg.close(); } });
  dlg.addEventListener('close', () => berhenti());
}

jalankan().catch((e) => {
  const kotak = $('daftar-choukai');
  if (kotak) kotak.innerHTML = `<div class="kosong">Gagal memuat: ${esc(e && e.message ? e.message : e)}</div>`;
});
