import { esc } from './aman.js';
/* ============================================================================
   daftar-hari.js — isi halaman level dengan daftar hari yang tersedia
   Otomatis membaca tabel `kosakata` + progres `hari`.
   ============================================================================ */

const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const $ = (id) => document.getElementById(id);

/* hari berturut-turut (berdasarkan tanggal selesai, bukan nomor hari) */
function hitungStreak(rows) {
  const tgl = new Set();
  rows.forEach(r => {
    if (r.status === 'selesai' && r.selesai_at) {
      const d = new Date(r.selesai_at);
      tgl.add(`${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`);
    }
  });
  if (!tgl.size) return 0;

  const kunci = (d) => `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`;
  const hari = new Date();

  // kalau hari ini belum selesai, mulai hitung dari kemarin
  if (!tgl.has(kunci(hari))) hari.setDate(hari.getDate() - 1);

  let n = 0;
  while (tgl.has(kunci(hari))) { n++; hari.setDate(hari.getDate() - 1); }
  return n;
}

async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }

  const { supabase } = window.sesiSiap;
  const kotak = $('daftar-hari');
  const info = $('info-hari');
  if (!kotak) return;

  /* ---------- 1. hari apa saja yang punya bahan ----------
     Pakai RPC, bukan select semua baris: PostgREST memotong hasil di 1000
     baris, jadi dengan 1.200+ kata daftar hari berhenti di tengah. */
  const { data: bahan, error } = await supabase
    .rpc('rekap_kosakata', { p_level: LEVEL });

  if (error) {
    kotak.innerHTML = `<div class="kosong">Gagal memuat: ${esc(error.message)}</div>`;
    return;
  }

  const hariAda = [...new Set((bahan || []).map(x => x.hari_ke))].sort((a, b) => a - b);

  if (!hariAda.length) {
    kotak.innerHTML = `<div class="kosong"><b>Belum ada bahan.</b><br>
      Isi tabel <code>kosakata</code> dulu untuk level ${LEVEL.toUpperCase()}.</div>`;
    return;
  }

  /* ---------- 2. progres user ---------- */
  const { data: progres } = await supabase
    .from('hari')
    .select('hari_ke, status, selesai_at')
    .eq('level', LEVEL);

  const peta = {};
  (progres || []).forEach(p => { peta[p.hari_ke] = p; });

  // tema per hari
  const { data: temaRows } = await supabase
    .from('tema_hari')
    .select('hari_ke, tema, arti')
    .eq('level', LEVEL);

  const tema = {};
  (temaRows || []).forEach(t => { tema[t.hari_ke] = t; });

  // antrian review hari ini
  let nAntrian = 0;
  try {
    const { data: n } = await supabase.rpc('jumlah_antrian', { p_level: LEVEL });
    nAntrian = n || 0;
  } catch (_) { nAntrian = 0; }

  const selesai = Object.values(peta).filter(p => p.status === 'selesai').length;
  const sekarang = hariAda.find(h => peta[h]?.status !== 'selesai') || hariAda.length;

  /* ---------- 3. kepala ---------- */
  if (info) {
    info.textContent = `${selesai} selesai · ${hariAda.length} hari tersedia`;
  }

  const kartuHari = $('hari-sekarang');
  if (kartuHari) {
    const tKini = tema[sekarang];
    $('angka-hari').innerHTML = 'Hari ' + sekarang +
      (tKini ? ` <span class="tema-jp">${tKini.tema}</span>` : '');
    if (tKini && tKini.arti) $('ket-hari').textContent = tKini.arti;
    $('ket-hari').textContent = `${selesai} / ${hariAda.length} hari selesai`;

    const sambung = hitungStreak(progres || []);
    const elStreak = $('streak');
    if (elStreak) {
      elStreak.hidden = sambung < 1;
      elStreak.textContent = `🔥 ${sambung} hari berturut-turut`;
    }
    const isi = $('batang-hari');
    if (isi) isi.style.width = (selesai / hariAda.length) * 100 + '%';

    const tombol = $('btn-lanjut');
    if (tombol) {
      if (nAntrian > 0) {
        tombol.href = `review.html?hari=${sekarang}`;
        tombol.textContent = `Review ${nAntrian} kata dulu`;
      } else {
        tombol.href = `kartu.html?hari=${sekarang}`;
        tombol.textContent = selesai === 0 ? 'Mulai hari 1'
          : (peta[sekarang]?.status === 'belum' ? 'Lanjutkan hari ' + sekarang
          : 'Mulai hari ' + sekarang);
      }
    }

    const elAntrian = $('antrian');
    if (elAntrian) {
      elAntrian.hidden = nAntrian < 1;
      elAntrian.textContent = `${nAntrian} kata jatuh tempo`;
    }
  }

  /* ---------- 4. daftar ---------- */
  const jumlah = {};
  (bahan || []).forEach(k => { jumlah[k.hari_ke] = k.jumlah; });

  kotak.innerHTML = hariAda.map((h) => {
    const st = peta[h]?.status || 'baru';
    const label = st === 'selesai' ? 'selesai ✓'
                : st === 'review'  ? 'sedang review'
                : st === 'belajar' ? 'dikerjakan'
                : 'belum';
    const kelas = st === 'selesai' ? ' class="done"' : '';

    const t = tema[h];
    return `<li>
      <a href="kartu.html?hari=${h}"${kelas}>
        <span class="no">${String(h).padStart(2, '0')}</span>
        <span class="nm">Hari ${h}${t ? ' · ' + esc(t.tema) : ''}
          <small>${t && t.arti ? esc(t.arti) + ' · ' : ''}${jumlah[h]} kata</small>
        </span>
        <span class="hai">${label}</span>
      </a>
    </li>`;
  }).join('');
}

jalankan();
