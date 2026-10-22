/* ============================================================================
   furigana.js — pasang <ruby> di atas kanji pada kalimat Jepang

   Masukan : teks asli (kanji) + bacaan hiragana penuh
   Keluaran: HTML dengan <ruby> di atas setiap kelompok kanji

   Contoh:
     furigana('二人の関係は深い。', 'ふたりの かんけいは ふかい。')
     → 二<ruby>人<rt>ふたり</rt></ruby>の<ruby>関係<rt>かんけい</rt></ruby>は
       <ruby>深<rt>ふか</rt></ruby>い。

   Catatan: penyelarasan sederhana (cukup untuk kalimat pendek).
   ponytail: tanpa kamus; kalau kalimat panjang & banyak kanji, hasil bisa
   meleset — tambahkan kamus kata kalau itu terjadi.
   ============================================================================ */

const KANJI = /[\u4e00-\u9fff\u3005々〆ヵヶ]/;
const KANA  = /[\u3040-\u309f\u30a0-\u30ff]/;

const adalahKanji = (c) => KANJI.test(c);
const adalahKana  = (c) => KANA.test(c);

/* pecah jadi potongan: kelompok kanji atau kana tunggal */
function potong(teks) {
  const hasil = [];
  let i = 0;
  while (i < teks.length) {
    if (adalahKanji(teks[i])) {
      let j = i;
      while (j < teks.length && adalahKanji(teks[j])) j++;
      hasil.push({ tipe: 'kanji', isi: teks.slice(i, j) });
      i = j;
    } else if (adalahKana(teks[i])) {
      let j = i;
      while (j < teks.length && adalahKana(teks[j])) j++;
      hasil.push({ tipe: 'kana', isi: teks.slice(i, j) });
      i = j;
    } else {
      hasil.push({ tipe: 'lain', isi: teks[i] });
      i++;
    }
  }
  return hasil;
}

function spasiBersih(s) {
  return String(s || '').replace(/\s+/g, '');
}

export function furigana(teks, bacaan) {
  const asli = String(teks || '');
  // hanya kana yang dipakai menyelaraskan; tanda baca di teks asli tidak
  // memajukan posisi, jadi tanda baca di bacaan juga harus dibuang.
  let furi  = spasiBersih(bacaan).replace(/[^\u3040-\u309f\u30a0-\u30ff\u30fc]/g, '');

  // tidak ada bacaan → tampilkan apa adanya
  if (!furi) return escapeHtml(asli);

  const bagian = potong(asli);

  // kalau tidak ada kanji sama sekali, cukup kembalikan teks
  if (!bagian.some(b => b.tipe === 'kanji')) return escapeHtml(asli);

  // kursor ke bacaan
  let pos = 0;
  const keluar = [];

  // bantu: cari urutan kana berikutnya di bacaan (untuk okurigana)
  function cocokKana(kana) {
    const idx = furi.indexOf(kana, pos);
    return idx;
  }

  for (let i = 0; i < bagian.length; i++) {
    const b = bagian[i];

    if (b.tipe !== 'kanji') {
      // kana/lain di teks asli: lewati jumlah sama di bacaan
      if (b.tipe === 'kana') {
        const idx = furi.indexOf(b.isi, pos);
        if (idx >= 0) {
          pos = idx + b.isi.length;
        } else {
          // katakana (ケーキ) sementara bacaan hiragana (けーき) → maju sama panjang
          pos = Math.min(furi.length, pos + b.isi.length);
        }
      }
      keluar.push(escapeHtml(b.isi));
      continue;
    }

    // kelompok kanji: cari batas bacaan
    const berikut = bagian[i + 1];
    let akhir;

    if (berikut && berikut.tipe === 'kana') {
      // baca sampai kana penutup (okurigana) ditemukan.
      // Kalau kana itu tepat di posisi bacaan sekarang, itu artinya bacaan
      // kanji dimulai dengan kana yang sama (暖かい → あたた＋かい),
      // jadi cari kemunculan berikutnya.
      let idx = furi.indexOf(berikut.isi, pos);
      if (idx === pos) idx = furi.indexOf(berikut.isi, pos + 1);

      if (idx > pos) {
        akhir = idx;                 // kana penutup milik teks asli
      } else {
        akhir = nextKanjiBoundary(bagian, i, furi, pos);
      }
    } else {
      akhir = nextKanjiBoundary(bagian, i, furi, pos);
    }

    let rt = furi.slice(pos, akhir);
    if (!rt) rt = '';
    pos = Math.max(pos, akhir);

    keluar.push(
      rt
        ? `<ruby>${escapeHtml(b.isi)}<rt>${escapeHtml(rt)}</rt></ruby>`
        : escapeHtml(b.isi)
    );
  }

  return keluar.join('');
}

/* cari akhir bacaan untuk kelompok kanji tanpa okurigana:
   ambil sisa bacaan sampai sepanjang rata-rata, sisihkan untuk bagian lain */
function nextKanjiBoundary(bagian, i, furi, pos) {
  // hitung kanji tersisa setelah ini
  let sisaKanji = 0;
  for (let j = i + 1; j < bagian.length; j++) {
    if (bagian[j].tipe === 'kanji') sisaKanji += bagian[j].isi.length;
  }
  const sisaKana = bagian.slice(i + 1).filter(b => b.tipe === 'kana').reduce((n, b) => n + b.isi.length, 0);

  const sisaBacaan = furi.length - pos;
  if (sisaKanji === 0) return furi.length;
  if (sisaKana >= sisaBacaan) return pos;         // tidak ada sisa untuk dibagi

  // bagi rata: sisa bacaan dikurangi kana yang masih tersisa
  const untukKana = sisaKana;
  const tersedia  = sisaBacaan - untukKana;
  if (tersedia <= 0) return pos;

  const perKanji = Math.max(1, Math.round(tersedia / (sisaKanji + bagian[i].isi.length)));
  return Math.min(furi.length, pos + Math.max(1, perKanji * bagian[i].isi.length));
}

function escapeHtml(s) {
  return String(s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}
