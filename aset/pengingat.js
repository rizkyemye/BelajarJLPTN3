import { rekapNilai } from './nilai.js';
/* ============================================================================
   pengingat.js — halaman depan level (n3/index.html)
   Isi: hari + tema yang sedang berjalan, sisa antrian review, antrian kanji,
   dan hitung mundur ujian JLPT.

   Data diambil dari tabel yang sudah ada (tidak ada tabel baru):
     rekap_kosakata(level) · hari · tema_hari · jumlah_antrian(level) · review_kanji
   ============================================================================ */

const LEVEL = (location.pathname.match(/\/(n[345])\//) || [, 'n3'])[1];
const UJIAN = new Date(2026, 11, 6);          // 6 Desember 2026 (JLPT)
const $ = (id) => document.getElementById(id);

/* hari berturut-turut (berdasarkan tanggal selesai) */
function hitungStreak(rows) {
  const tgl = new Set();
  rows.forEach((r) => {
    if (r.status === 'selesai' && r.selesai_at) {
      const d = new Date(r.selesai_at);
      tgl.add(`${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`);
    }
  });
  if (!tgl.size) return 0;

  const kunci = (d) => `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`;
  const hari = new Date();
  if (!tgl.has(kunci(hari))) hari.setDate(hari.getDate() - 1);

  let n = 0;
  while (tgl.has(kunci(hari))) { n++; hari.setDate(hari.getDate() - 1); }
  return n;
}

function sisaHariUjian() {
  const kini = new Date();
  kini.setHours(0, 0, 0, 0);
  return Math.round((UJIAN - kini) / 86400000);
}

function sekarangBerikut(progres, bahan) {
  const peta = {};
  progres.forEach((p) => { peta[p.hari_ke] = p; });
  const hariAda = [...new Set(bahan.map((x) => x.hari_ke))].sort((a, b) => a - b);
  if (!hariAda.length) return 1;
  return hariAda.find((h) => peta[h]?.status !== 'selesai') || hariAda[hariAda.length - 1];
}

async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }

  const { supabase, profil } = window.sesiSiap;

  /* ---------- waktu & salam ---------- */
  const kini = new Date();
  const tglId = kini.toLocaleDateString('id-ID', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' });
  const tglJp = `${kini.getFullYear()}年${kini.getMonth() + 1}月${kini.getDate()}日`;

  $('salam').textContent = `Halo, ${profil.username}`;
  $('info-waktu').textContent = tglJp;
  const sisa = sisaHariUjian();
  $('kalimat').textContent = `${tglId} · ujian JLPT ${sisa > 0 ? sisa + ' hari lagi' : 'sudah dekat'}`;

  /* ---------- bahan + progres ---------- */
  const { data: bahan, error } = await supabase.rpc('rekap_kosakata', { p_level: LEVEL });
  if (error) {
    $('ket-hari').textContent = 'Gagal memuat: ' + error.message;
    return;
  }

  const hariAda = [...new Set((bahan || []).map((x) => x.hari_ke))].sort((a, b) => a - b);
  if (!hariAda.length) {
    $('ket-hari').textContent = 'Belum ada bahan.';
    $('daftar-ingat').innerHTML = '<li><div class="kosong">Isi tabel <code>kosakata</code> dulu.</div></li>';
    return;
  }

  const { data: progres } = await supabase
    .from('hari').select('hari_ke, status, selesai_at').eq('level', LEVEL);

  const peta = {};
  (progres || []).forEach((p) => { peta[p.hari_ke] = p; });

  const { data: temaRows } = await supabase
    .from('tema_hari').select('hari_ke, tema, arti').eq('level', LEVEL);

  const tema = {};
  (temaRows || []).forEach((t) => { tema[t.hari_ke] = t; });

  let nAntrian = 0;
  try {
    const { data: n } = await supabase.rpc('jumlah_antrian', { p_level: LEVEL });
    nAntrian = n || 0;
  } catch (_) { nAntrian = 0; }

  let nKanji = 0;
  try {
    const hariIni = kini.toISOString().slice(0, 10);
    const { count } = await supabase
      .from('review_kanji')
      .select('*', { count: 'exact', head: true })
      .lte('jatuh_tempo', hariIni);
    nKanji = count || 0;
  } catch (_) { nKanji = 0; }

  let dokkaiIni = null;
  try {
    const { data: dk } = await supabase
      .from('dokkai')
      .select('hari_ke, judul_jp, judul_id, soal')
      .eq('level', LEVEL)
      .eq('hari_ke', sekarangBerikut(progres || [], bahan || []))
      .maybeSingle();
    dokkaiIni = dk || null;
  } catch (_) { dokkaiIni = null; }

  const selesai = Object.values(peta).filter((p) => p.status === 'selesai').length;
  const sekarang = hariAda.find((h) => peta[h]?.status !== 'selesai') || hariAda[hariAda.length - 1];
  const tKini = tema[sekarang];

  /* ---------- kartu utama ---------- */
  $('angka-hari').innerHTML = 'Hari ' + sekarang +
    (tKini ? ` <span class="tema-jp">${tKini.tema}</span>` : '');
  $('ket-hari').textContent = `${selesai} / ${hariAda.length} hari selesai` +
    (tKini && tKini.arti ? ` · ${tKini.arti}` : '');

  const sambung = hitungStreak(progres || []);
  const elStreak = $('streak');
  elStreak.hidden = sambung < 1;
  elStreak.textContent = `🔥 ${sambung} hari berturut-turut`;

  $('batang-hari').style.width = (selesai / hariAda.length) * 100 + '%';

  const tombol = $('btn-lanjut');
  if (nAntrian > 0) {
    tombol.href = `review.html?hari=${sekarang}`;
    tombol.textContent = `Review ${nAntrian} kata dulu`;
  } else {
    tombol.href = `kartu.html?hari=${sekarang}`;
    tombol.textContent = selesai === 0 ? 'Mulai hari 1' : 'Lanjutkan hari ' + sekarang;
  }

  /* ---------- rekap nilai kuis 14 hari ---------- */
  const NAMA_KUIS = {
    kosakata: 'Kosakata', kanji: 'Kanji', bunpou: 'Bunpou', dokkai: 'Dokkai', choukai: 'Choukai'
  };
  const rk = await rekapNilai();
  const kotakRk = $('rekap');
  if (kotakRk) {
    kotakRk.innerHTML = rk.length
      ? rk.map((r) => `
        <div class="rk-baris">
          <span class="rk-nama">${NAMA_KUIS[r.jenis] || r.jenis}</span>
          <span class="batang"><i style="width:${r.akurasi || 0}%"></i></span>
          <span class="rk-nilai">${r.akurasi || 0}%</span>
        </div>`).join('')
      : '<div class="kosong">Belum ada nilai kuis. Kerjakan satu kuis dulu.</div>';
  }

  /* ---------- daftar pengingat ---------- */
  const item = (no, href, judul, ket, label) => `
    <li>
      <a href="${href}">
        <span class="no">${no}</span>
        <span class="nm">${judul}<small>${ket}</small></span>
        <span class="hai">${label}</span>
      </a>
    </li>`;

  $('daftar-ingat').innerHTML = [
    item('01', `kartu.html?hari=${sekarang}`, `Kosakata · Hari ${sekarang}`,
      `${tKini ? tKini.tema + ' · ' : ''}${bahan.find((b) => b.hari_ke === sekarang)?.jumlah || 0} kata`,
      peta[sekarang]?.status === 'selesai' ? 'selesai ✓' : 'belum'),
    item('02', 'review.html', 'Review kosakata',
      nAntrian > 0 ? `${nAntrian} kata jatuh tempo` : 'tidak ada yang jatuh tempo',
      nAntrian > 0 ? 'kerjakan' : 'kosong'),
    item('03', 'kanji-review.html', 'Review kanji',
      nKanji > 0 ? `${nKanji} kanji jatuh tempo` : 'tidak ada yang jatuh tempo',
      nKanji > 0 ? 'kerjakan' : 'kosong'),
    item('04', 'dokkai.html',
      dokkaiIni ? `Dokkai · Hari ${dokkaiIni.hari_ke}` : 'Dokkai',
      dokkaiIni
        ? `${dokkaiIni.judul_jp} · ${(dokkaiIni.soal || []).length} soal`
        : 'belum ada bacaan untuk hari ini',
      dokkaiIni ? 'baca' : 'buka')
  ].join('');
}

jalankan().catch((e) => {
  const kotak = $('daftar-ingat');
  if (kotak) kotak.innerHTML = `<li><div class="kosong">Gagal memuat: ${e && e.message ? e.message : e}</div></li>`;
});
