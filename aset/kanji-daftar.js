/* ============================================================================
   kanji-daftar.js — daftar hari kanji + progres
   Mirip daftar-hari.js (kosakata), tapi sumbernya tabel `kanji` + `review_kanji`.
   ============================================================================ */

const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const $ = (id) => document.getElementById(id);

async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }

  const { supabase } = window.sesiSiap;
  const kotak = $('daftar-hari');
  if (!kotak) return;

  /* 1. kanji per hari */
  const { data: bahan, error } = await supabase
    .from('kanji')
    .select('hari_ke, urutan, kanji')
    .eq('level', LEVEL)
    .order('hari_ke')
    .order('urutan');

  if (error) {
    kotak.innerHTML = `<div class="kosong">Gagal memuat: ${error.message}</div>`;
    return;
  }

  const hariAda = [...new Set((bahan || []).map(x => x.hari_ke))].sort((a, b) => a - b);

  if (!hariAda.length) {
    kotak.innerHTML = `<div class="kosong"><b>Belum ada kanji.</b><br>
      Jalankan <code>upload-kanji.sql</code> dulu.</div>`;
    return;
  }

  /* 2. progres: jumlah kanji yang sudah dinilai per hari */
  const { data: rev } = await supabase
    .from('review_kanji')
    .select('hari_ke, status');

  const dinilai = {};
  const total   = {};
  (bahan || []).forEach(k => { total[k.hari_ke] = (total[k.hari_ke] || 0) + 1; });
  (rev || []).forEach(r => {
    if (r.status !== 'belum') dinilai[r.hari_ke] = (dinilai[r.hari_ke] || 0) + 1;
  });

  const beres = (h) => (dinilai[h] || 0) >= (total[h] || 0);
  const selesai = hariAda.filter(beres).length;
  const sekarang = hariAda.find(h => !beres(h)) || hariAda[hariAda.length - 1];

  /* 3. kepala */
  $('info-hari').textContent = `${selesai} selesai · ${hariAda.length} hari kanji · ${(bahan || []).length} kanji`;

  $('angka-hari').innerHTML = 'Kanji · Hari ' + sekarang;
  const sudahHariIni = dinilai[sekarang] || 0;
  $('ket-hari').textContent = `${selesai} / ${hariAda.length} hari selesai · hari ${sekarang}: ${sudahHariIni} / ${total[sekarang]} dinilai`;
  $('batang-hari').style.width = (selesai / hariAda.length) * 100 + '%';

  const tombol = $('btn-lanjut');
  tombol.href = `kanji.html?hari=${sekarang}`;
  tombol.textContent = sudahHariIni > 0
    ? `Lanjutkan kanji hari ${sekarang}`
    : (selesai === 0 ? `Mulai kanji hari ${sekarang}` : `Mulai kanji hari ${sekarang}`);

  /* 4. daftar */
  kotak.innerHTML = hariAda.map((h) => {
    const jml = dinilai[h] || 0;
    const tot = total[h] || 0;
    const st  = jml >= tot ? 'selesai ✓' : jml > 0 ? `${jml}/${tot} dinilai` : 'belum';
    const kelas = jml >= tot ? ' class="done"' : '';
    const contoh = (bahan || []).filter(k => k.hari_ke === h).map(k => k.kanji).slice(0, 5).join('');

    return `<li>
      <a href="kanji.html?hari=${h}"${kelas}>
        <span class="no">${String(h).padStart(2, '0')}</span>
        <span class="nm">Hari ${h}
          <small>${contoh}… · ${tot} kanji</small>
        </span>
        <span class="hai">${st}</span>
      </a>
    </li>`;
  }).join('');
}

jalankan();
