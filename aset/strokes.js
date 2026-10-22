/* ============================================================================
   strokes.js — animasi urutan goresan dari KanjiVG
   Data: KanjiVG (Ulrich Apel) · CC BY-SA 3.0 · https://kanjivg.tagaini.net

   Cara pakai:
     const urut = await pasangUrutan('経験', wadahEl);
     urut.main();     // gambar goresan satu per satu
   ============================================================================ */

const DASAR = new URL('../aset/kanji-svg/', import.meta.url);

function kode(ch) {
  return ch.codePointAt(0).toString(16).padStart(5, '0');
}

/* ambil satu karakter dari teks yang mungkin berisi beberapa kanji */
export async function pasangUrutan(teks, wadah) {
  const ch = [...teks].find(c => c.codePointAt(0) > 0x3000) || [...teks][0];
  if (!ch) return null;

  let svg;
  try {
    const r = await fetch(new URL(kode(ch) + '.svg', DASAR));
    if (!r.ok) throw new Error('SVG tidak ada');
    svg = await r.text();
  } catch (_) {
    return null;    // belum punya datanya, bukan error
  }

  // buang deklarasi XML + DOCTYPE (kalau tidak, sisa teksnya ikut tampil)
  const mulai = svg.indexOf('<svg');
  if (mulai > 0) svg = svg.slice(mulai);

  wadah.innerHTML = svg;

  const el = wadah.querySelector('svg');
  if (!el) return null;

  el.removeAttribute('width');
  el.removeAttribute('height');
  el.setAttribute('viewBox', '0 0 109 109');
  el.classList.add('svg-kanji');

  const jalur = [...el.querySelectorAll('path')];
  // buang elemen teks/nomor bawaan kalau ada
  el.querySelectorAll('text').forEach(t => t.remove());

  const panjang = jalur.map(p => {
    try { return p.getTotalLength(); } catch (_) { return 0; }
  });

  jalur.forEach((p, i) => {
    p.style.fill = 'none';
    p.style.stroke = 'var(--tinta)';
    p.style.strokeWidth = '3.2';
    p.style.strokeLinecap = 'round';
    p.style.strokeLinejoin = 'round';
    p.style.strokeDasharray = panjang[i] + ' ' + panjang[i];
    p.style.strokeDashoffset = panjang[i];
    p.style.transition = 'none';
  });

  let sedangJalan = false;

  function reset() {
    jalur.forEach((p, i) => {
      p.style.transition = 'none';
      p.style.strokeDashoffset = panjang[i];
    });
  }

  function utuh() {
    jalur.forEach((p, i) => {
      p.style.transition = 'none';
      p.style.strokeDashoffset = 0;
    });
  }

  function main(jeda = 340) {
    if (sedangJalan) return;
    sedangJalan = true;
    reset();

    jalur.forEach((p, i) => {
      setTimeout(() => {
        p.style.transition = `stroke-dashoffset ${jeda}ms ease-out`;
        p.style.strokeDashoffset = 0;
        if (i === jalur.length - 1) setTimeout(() => { sedangJalan = false; }, jeda + 80);
      }, i * jeda);
    });

    setTimeout(() => { sedangJalan = false; }, jalur.length * jeda + 200);
  }

  utuh();   // awalnya langsung tampil utuh

  return { main, utuh, reset, jumlah: jalur.length };
}
