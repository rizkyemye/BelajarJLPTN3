/* ============================================================================
   kosakata-admin.js — tambah / impor / hapus kosakata
   Butuh profil.role = 'admin' (sesi.js + RLS apakah_admin())
   ============================================================================ */

const $ = (id) => document.getElementById(id);
let supabase = null;
let hariSekarang = 1;
let levelSekarang = 'n3';

const esc = (s) => String(s ?? '').replace(/[&<>"]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));

function kabar(teks, jenis = 'salah') {
  $('pesan').textContent = teks;
  $('pesan').className = 'pesan tampil' + (jenis === 'ok' ? ' ok' : '');
}
function bersih() {
  $('pesan').textContent = '';
  $('pesan').className = 'pesan';
}

/* ---------- pilih cara ---------- */
document.querySelectorAll('.pilih-cara-tbl').forEach(b => {
  b.addEventListener('click', () => {
    document.querySelectorAll('.pilih-cara-tbl').forEach(x => x.classList.remove('aktif'));
    b.classList.add('aktif');
    $('cara-satu').hidden = b.dataset.cara !== 'satu';
    $('cara-csv').hidden  = b.dataset.cara !== 'csv';
  });
});

/* ---------- urutan berikutnya ---------- */
async function urutanBerikut(level, hari) {
  const { data } = await supabase
    .from('kosakata')
    .select('urutan')
    .eq('level', level)
    .eq('hari_ke', hari)
    .order('urutan', { ascending: false })
    .limit(1);
  return (data && data[0] ? data[0].urutan : 0) + 1;
}

/* ---------- muat daftar hari ini ---------- */
async function muatDaftar() {
  levelSekarang = $('level').value;
  hariSekarang  = Number($('hari').value) || 1;

  $('judul-daftar').textContent = `Isi ${levelSekarang.toUpperCase()} · hari ${hariSekarang}`;
  $('isi-kata').innerHTML = `<tr><td colspan="6" class="kosong-baris">memuat…</td></tr>`;

  const { data, error } = await supabase
    .from('kosakata')
    .select('id, urutan, kanji, yomi, arti, contoh_jp')
    .eq('level', levelSekarang)
    .eq('hari_ke', hariSekarang)
    .order('urutan');

  if (error) {
    $('isi-kata').innerHTML = `<tr><td colspan="6" class="kosong-baris">Gagal: ${esc(error.message)}</td></tr>`;
    return;
  }

  $('info-hari').textContent = `${(data || []).length} kata`;

  $('isi-kata').innerHTML = (data || []).length
    ? data.map(k => `
      <tr>
        <td class="mono">${k.urutan}</td>
        <td class="isian-jp">${esc(k.kanji)}</td>
        <td class="isian-jp kecil">${esc(k.yomi)}</td>
        <td>${esc(k.arti)}</td>
        <td class="kecil">${esc(k.contoh_jp || '—')}</td>
        <td class="aksi-sel"><button class="tbl-teks" data-hapus="${k.id}">hapus</button></td>
      </tr>`).join('')
    : `<tr><td colspan="6" class="kosong-baris">Belum ada kata untuk hari ini.</td></tr>`;

  document.querySelectorAll('[data-hapus]').forEach(b => {
    b.addEventListener('click', async () => {
      if (!confirm('Hapus kata ini?')) return;
      b.disabled = true;
      const { error: e } = await supabase.from('kosakata').delete().eq('id', b.dataset.hapus);
      if (e) { alert('Gagal hapus: ' + e.message); b.disabled = false; return; }
      await muatDaftar();
    });
  });
}

/* ---------- simpan satu kata ---------- */
async function simpanSatu() {
  const level = $('level').value;
  const hari  = Number($('hari').value) || 1;
  const kanji = $('kanji').value.trim();
  const yomi  = $('yomi').value.trim();
  const arti  = $('arti').value.trim();

  if (!kanji) return kabar('Kanji wajib diisi.');
  if (!yomi)  return kabar('Yomikata (hiragana) wajib diisi.');
  if (!arti)  return kabar('Arti wajib diisi.');

  const urutan = await urutanBerikut(level, hari);
  if (urutan > 30) return kabar(`Hari ${hari} sudah penuh (30 kata). Buat hari berikutnya.`);

  $('simpan').disabled = true;
  $('simpan').textContent = 'Menyimpan…';

  const { error } = await supabase.from('kosakata').insert({
    level, hari_ke: hari, urutan,
    kanji, yomi, arti,
    kelas:     $('kelas').value || null,
    contoh_jp: $('contoh_jp').value.trim() || null,
    contoh_furi: $('contoh_furi').value.trim() || null,
    contoh_id: $('contoh_id').value.trim() || null
  });

  $('simpan').disabled = false;
  $('simpan').textContent = 'Simpan kata';

  if (error) return kabar('Gagal simpan: ' + error.message);

  kabar(`Tersimpan: ${kanji} (urutan ${urutan}).`, 'ok');
  ['kanji', 'yomi', 'arti', 'contoh_jp', 'contoh_furi', 'contoh_id'].forEach(id => $(id).value = '');
  $('kanji').focus();
  await muatDaftar();
}

/* ---------- pecah CSV ---------- */
function pecahBaris(teks) {
  // pemisah: tab (dari Excel/Sheets) atau koma
  const pemisah = teks.includes('\t') ? '\t' : ',';
  const hasil = [];
  for (const baris of teks.split(/\r?\n/)) {
    if (!baris.trim()) continue;
    // dukung tanda kutip untuk kolom berisi koma
    const kolom = [];
    let kini = '', dalamKutip = false;
    for (let i = 0; i < baris.length; i++) {
      const c = baris[i];
      if (c === '"') {
        if (dalamKutip && baris[i + 1] === '"') { kini += '"'; i++; }
        else dalamKutip = !dalamKutip;
      } else if (c === pemisah && !dalamKutip) { kolom.push(kini); kini = ''; }
      else kini += c;
    }
    kolom.push(kini);
    hasil.push(kolom.map(s => s.trim()));
  }
  return hasil;
}

function buatData(kolom, level, hari, urutanAwal) {
  return kolom.map((k, i) => ({
    level, hari_ke: hari, urutan: urutanAwal + i,
    kanji:       k[0] || '',
    yomi:        k[1] || '',
    arti:        k[2] || '',
    kelas:       k[3] || null,
    contoh_jp:   k[4] || null,
    contoh_furi: k[5] || null,
    contoh_id:   k[6] || null
  }));
}

function cekBaris(baris) {
  const salah = [];
  baris.forEach((k, i) => {
    if (!k.kanji || !k.yomi || !k.arti) salah.push(i + 1);
    if (k.urutan > 30) salah.push(i + 1);
  });
  return [...new Set(salah)];
}

/* ---------- cek dulu ---------- */
async function lihatCsv() {
  const level = $('level').value;
  const hari  = Number($('hari').value) || 1;
  const kolom = pecahBaris($('csv').value);
  if (!kolom.length) return kabar('Belum ada isi.');

  const awal = await urutanBerikut(level, hari);
  const data = buatData(kolom, level, hari, awal);
  const salah = cekBaris(data);

  $('pratinjau').hidden = false;
  $('pratinjau').textContent =
    `${data.length} baris · urutan ${awal}–${awal + data.length - 1}\n` +
    (salah.length ? `⚠ baris bermasalah: ${salah.join(', ')}\n` : '✓ semua baris lengkap\n') +
    '\n' + data.slice(0, 5).map(d =>
      `${String(d.urutan).padStart(2, '0')}  ${d.kanji}  ${d.yomi}  ${d.arti}`).join('\n') +
    (data.length > 5 ? `\n… dan ${data.length - 5} lagi` : '');
}

/* ---------- impor ---------- */
async function imporCsv() {
  const level = $('level').value;
  const hari  = Number($('hari').value) || 1;
  const kolom = pecahBaris($('csv').value);
  if (!kolom.length) return kabar('Belum ada isi.');

  const awal = await urutanBerikut(level, hari);
  const data = buatData(kolom, level, hari, awal);
  const salah = cekBaris(data);

  if (salah.length) {
    return kabar(`Baris ke-${salah.join(', ')} belum lengkap atau urutan lewat 30.`);
  }

  $('impor').disabled = true;
  $('impor').textContent = 'Mengimpor…';

  const { error } = await supabase.from('kosakata').insert(data);

  $('impor').disabled = false;
  $('impor').textContent = 'Impor';

  if (error) return kabar('Gagal impor: ' + error.message);

  kabar(`${data.length} kata masuk ke ${level.toUpperCase()} hari ${hari}.`, 'ok');
  $('csv').value = '';
  $('pratinjau').hidden = true;
  await muatDaftar();
}

/* ---------- pasang ---------- */
$('simpan').addEventListener('click', simpanSatu);
$('bersihkan').addEventListener('click', () => {
  ['kanji', 'yomi', 'arti', 'contoh_jp', 'contoh_furi', 'contoh_id'].forEach(id => $(id).value = '');
  bersih();
});
$('lihat').addEventListener('click', lihatCsv);
$('impor').addEventListener('click', imporCsv);
$('level').addEventListener('change', muatDaftar);
$('hari').addEventListener('change', muatDaftar);

/* ---------- mulai ---------- */
async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }
  supabase = window.sesiSiap.supabase;

  if (window.sesiSiap.profil.role !== 'admin') {
    location.replace('../n3/index.html');
    return;
  }

  await muatDaftar();
}

jalankan();
