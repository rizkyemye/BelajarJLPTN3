/* ============================================================================
   ondoku.js — 音読 & shadowing dari teks dokkai yang sudah ada (0 data baru)
   · kalimat dipecah per 。！？
   · dibacakan berurutan, kalimat aktif disorot
   · tempo 0.7 / 0.85 / 1.0
   · mode shadowing: jeda panjang supaya kamu bisa mengulang sendiri
   ============================================================================ */

import { furigana } from './furigana.js';
import { bacaBerurutan, berhenti, suaraSiap } from './suara.js';
import { esc } from './aman.js';

const $ = (id) => document.getElementById(id);
const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];

let supabase = null;
let semua = [];
let sedang = null;
let kalimat = [];        // { jp, furi, kana }
let aktif = -1;

function tampil(id) {
  ['memuat', 'isi', 'gagal'].forEach((x) => {
    const el = $(x);
    if (el) el.hidden = (x !== id);
  });
}

/* pecah per kalimat, pertahankan tanda baca */
function pecah(teks) {
  return String(teks || '')
    .split(/(?<=[。！？])/u)
    .map((x) => x.trim())
    .filter(Boolean);
}

function siapkanKalimat(d) {
  const jp = pecah(d.teks_jp);
  const fu = pecah(d.teks_furi || '');

  kalimat = jp.map((k, i) => ({
    jp: k,
    furi: fu[i] || '',
    kana: (fu[i] || k).replace(/[、。！？「」]/g, '')
  }));
}

function gambar() {
  $('judul').textContent = sedang
    ? `Hari ${sedang.hari_ke} · ${sedang.judul_jp}`
    : '';

  $('kalimat').innerHTML = kalimat.map((k, i) => `
    <button type="button" class="od-kalimat" data-i="${i}">
      <span class="od-no">${i + 1}</span>
      <span class="od-teks">${k.furi ? furigana(k.jp, k.furi) : esc(k.jp)}</span>
    </button>`).join('');

  $('kalimat').querySelectorAll('.od-kalimat').forEach((b) => {
    b.addEventListener('click', () => putarSatu(Number(b.dataset.i)));
  });
}

function sorot(i) {
  aktif = i;
  $('kalimat').querySelectorAll('.od-kalimat').forEach((b, n) => {
    b.classList.toggle('aktif', n === i);
  });
  const el = $('kalimat').querySelectorAll('.od-kalimat')[i];
  if (el && el.scrollIntoView) el.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
}

function tombolJalan(ya) {
  $('btn-putar').disabled = ya;
  $('btn-stop').disabled = !ya;
}

async function putarSemua(dari = 0) {
  await suaraSiap().catch(() => {});
  tombolJalan(true);

  const tempo = Number($('pilih-tempo').value);
  const shadow = $('shadow').checked;
  const daftar = kalimat.slice(dari).map((k) => ({ teks: k.kana, rate: tempo }));

  await bacaBerurutan(daftar, {
    rate: tempo,
    jeda: shadow ? 1400 : 380,
    onItem: (i) => sorot(dari + i)
  });

  tombolJalan(false);
  sorot(-1);
}

async function putarSatu(i) {
  berhenti();
  await suaraSiap().catch(() => {});
  const tempo = Number($('pilih-tempo').value);
  const k = kalimat[i];
  if (!k) return;
  sorot(i);
  tombolJalan(true);
  await bacaBerurutan([{ teks: k.kana, rate: tempo }], { rate: tempo, jeda: 0 });
  tombolJalan(false);
}

function pilihBacaan() {
  const hari = Number($('pilih-hari').value);
  sedang = semua.find((d) => d.hari_ke === hari) || semua[0];
  siapkanKalimat(sedang);
  gambar();
  tampil('isi');
}

async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }
  supabase = window.sesiSiap.supabase;

  const { data, error } = await supabase
    .from('dokkai')
    .select('hari_ke, judul_jp, teks_jp, teks_furi')
    .eq('level', LEVEL)
    .order('hari_ke');

  if (error || !data || !data.length) {
    tampil('gagal');
    $('pesan-gagal').textContent = error
      ? 'Gagal memuat: ' + error.message
      : 'Jalankan db/dokkai.sql dulu.';
    return;
  }

  semua = data.filter((d) => d.teks_jp);
  $('pilih-hari').innerHTML = semua
    .map((d) => `<option value="${d.hari_ke}">Hari ${d.hari_ke} · ${esc(d.judul_jp || '')}</option>`)
    .join('');

  pilihBacaan();
}

$('pilih-hari').addEventListener('change', () => { berhenti(); pilihBacaan(); });
$('btn-putar').addEventListener('click', () => putarSemua(0));
$('btn-stop').addEventListener('click', () => { berhenti(); tombolJalan(false); sorot(-1); });

tampil('memuat');
jalankan().catch((e) => {
  console.error('[ondoku]', e);
  tampil('gagal');
  $('pesan-gagal').textContent = 'Gagal memuat: ' + (e && e.message ? e.message : e);
});
