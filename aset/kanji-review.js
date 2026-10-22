/* ============================================================================
   kanji-review.js — ulangi kanji yang jatuh tempo (SRS yang sudah ada)
   Sumber: tabel review_kanji (jadwal dihitung fungsi nilai_kanji di Supabase).
   ============================================================================ */

const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const $ = (id) => document.getElementById(id);

let daftar = [];
let posisi = 0;
let sudah = 0;
let supabase = null;

const hariIni = () => new Date().toISOString().slice(0, 10);
const esc = (s) => String(s ?? '');
const setBatang = (el, persen) => { if (el) el.style.width = `${Math.max(0, Math.min(100, persen))}%`; };

function tampil(id) {
  ['memuat', 'tahap-kartu', 'tahap-selesai'].forEach((x) => {
    const el = $(x);
    if (el) el.hidden = x !== id;
  });
}

async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }
  supabase = window.sesiSiap.supabase;

  /* 1. kanji yang jatuh tempo */
  const { data: tempo, error } = await supabase
    .from('review_kanji')
    .select('kanji_id, tahap, jatuh_tempo')
    .lte('jatuh_tempo', hariIni());

  if (error) {
    $('memuat').innerHTML = `<div class="kosong">Gagal memuat: ${esc(error.message)}</div>`;
    return;
  }

  const idTempo = (tempo || []).filter((r) => !r.jatuh_tempo || r.jatuh_tempo <= hariIni()).map((r) => r.kanji_id);

  if (!idTempo.length) {
    $('info-ulang').textContent = '0 kanji';
    $('memuat').innerHTML =
      '<div class="kosong">Tidak ada kanji yang jatuh tempo hari ini.<br>' +
      'Kembali besok, atau buka <a href="kanji-daftar.html">daftar kanji</a>.</div>';
    return;
  }

  /* 2. detail kanji */
  const { data: kanji } = await supabase
    .from('kanji')
    .select('id, kanji, onyomi, kunyomi, arti, bushu, arti_bushu, kata')
    .eq('level', LEVEL)
    .in('id', idTempo.slice(0, 200))
    .order('hari_ke');

  daftar = kanji || [];
  if (!daftar.length) {
    $('memuat').innerHTML = '<div class="kosong">Tidak ada kanji untuk level ini.</div>';
    return;
  }

  $('info-ulang').textContent = `${daftar.length} kanji jatuh tempo`;
  posisi = 0;
  sudah = 0;

  tampil('tahap-kartu');
  gambarKartu();
}

function gambarKartu() {
  const k = daftar[posisi];
  if (!k) return selesai();

  $('kartu').classList.remove('terbalik');
  $('kendali').hidden = true;
  $('btn-balik').hidden = false;

  const bushu = k.bushu ? `${k.bushu}${k.arti_bushu ? ' ' + k.arti_bushu : ''}` : '';
  const yomi = [k.onyomi, k.kunyomi].filter(Boolean).join(' ／ ') || '—';

  $('bushu-depan').textContent = bushu;
  $('kanji').textContent = k.kanji;
  $('yomi').textContent = '';

  $('bushu-belakang').textContent = bushu;
  $('kanji-belakang').textContent = k.kanji;
  $('yomi-belakang').textContent = yomi;
  $('arti').textContent = k.arti;

  const kata = Array.isArray(k.kata) ? k.kata : [];
  if (kata.length) {
    $('contoh-wrap').hidden = false;
    $('contoh-jp').textContent = kata.map((x) => `${x.k} ${x.y}`).join(' · ');
    $('contoh-id').textContent = kata.map((x) => x.a).join(' · ');
  } else {
    $('contoh-wrap').hidden = true;
  }

  $('hitung').textContent = `${posisi + 1} / ${daftar.length}`;
  setBatang($('batang-kartu'), (posisi / daftar.length) * 100);
}

function balik() {
  $('kartu').classList.add('terbalik');
  $('kendali').hidden = false;
  $('btn-balik').hidden = true;
}

async function nilai(hasil) {
  const k = daftar[posisi];
  if (!k) return;

  $('kendali').hidden = true;
  await supabase.rpc('nilai_kanji', { p_id: k.id, p_nilai: hasil });

  if (hasil === 'hafal') sudah++;
  posisi++;
  gambarKartu();
}

function selesai() {
  tampil('tahap-selesai');
  const persen = daftar.length ? Math.round((sudah / daftar.length) * 100) : 0;
  $('nilai-akhir').textContent = `${sudah} / ${daftar.length} hafal (${persen}%)`;
  $('pesan-akhir').textContent = persen >= 80
    ? 'Bagus. Kanji ini mundur ke jadwal berikutnya.'
    : 'Yang masih ragu akan muncul lagi besok.';
  setBatang($('batang-kartu'), 100);
}

$('btn-balik').addEventListener('click', balik);
$('kartu').addEventListener('click', balik);
document.querySelectorAll('#kendali button').forEach((b) => {
  b.addEventListener('click', (e) => { e.stopPropagation(); nilai(b.dataset.nilai); });
});

jalankan().catch((e) => {
  const kotak = $('memuat');
  if (kotak) kotak.innerHTML = `<div class="kosong">Gagal memuat: ${esc(e && e.message ? e.message : e)}</div>`;
});
