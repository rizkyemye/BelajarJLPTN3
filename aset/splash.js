/* ============================================================================
   splash.js — layar pembuka: 日本語 digambar goresan demi goresan
   Sumber goresan: KanjiVG (Ulrich Apel) · CC BY-SA 3.0
   Muncul sekali per sesi (sessionStorage).

   Sisipkan sebagai elemen PERTAMA di <body>:
     <script src="../aset/splash.js"></script>
   ============================================================================ */
(function () {
  /* ---------- PWA: pasang service worker (sekali, diam-diam) ---------- */
  try {
    if ('serviceWorker' in navigator && location.protocol.startsWith('http')) {
      const dalam = /\/(n[345]|admin)\//.test(location.pathname);
      const sw = (dalam ? '../sw.js' : './sw.js');
      window.addEventListener('load', () => {
        navigator.serviceWorker.register(sw).catch(() => {});
      });
    }
  } catch (_) {}

  try {
    if (sessionStorage.getItem('splash-n3')) return;
    sessionStorage.setItem('splash-n3', '1');
  } catch (_) { /* mode privat: tetap tampil */ }

  /* ---------- dasar path: .../aset/splash.js → .../aset/kanji-svg/ ---------- */
  const skrip = document.currentScript && document.currentScript.src;
  const DASAR = skrip
    ? skrip.replace(/splash\.js(?:\?.*)?$/, 'kanji-svg/')
    : 'kanji-svg/';

  const KANJI   = ['日', '本', '語'];
  const JEDA    = 40;    // ms antar goresan
  const DURASI  = 220;   // ms per goresan
  const AKHIR   = 300;   // jeda setelah goresan terakhir
  const halus   = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  /* ---------- gaya ---------- */
  const gaya = document.createElement('style');
  gaya.textContent = `
  .splash-n3{
    position:fixed;inset:0;z-index:9999;
    display:grid;place-content:center;justify-items:center;gap:18px;
    background:var(--kertas,#f6f3ea);color:var(--tinta,#12141a);
    transition:opacity .35s ease, visibility .35s ease;
  }
  .splash-n3 .goresan{display:flex;gap:.08em;align-items:center}
  .splash-n3 .goresan svg{
    width:clamp(64px,17vw,110px);height:clamp(64px,17vw,110px);overflow:visible;
  }
  .splash-n3 .goresan path{
    fill:none;stroke:var(--tinta,#12141a);
    stroke-width:4;stroke-linecap:round;stroke-linejoin:round;
    stroke-dasharray:100;stroke-dashoffset:100;
    animation:splash-n3-garis ${DURASI}ms ease-out forwards;
  }
  .splash-n3 .s{
    font-size:12px;letter-spacing:.22em;text-transform:uppercase;
    color:var(--tinta-3,#6b6f7a);
  }
  .splash-n3.hilang{opacity:0;visibility:hidden}
  @keyframes splash-n3-garis{to{stroke-dashoffset:0}}
  `;
  document.head.appendChild(gaya);

  /* ---------- wadah ---------- */
  const el = document.createElement('div');
  el.className = 'splash-n3';
  el.setAttribute('role', 'status');
  el.setAttribute('aria-label', 'Memuat');
  el.innerHTML =
    '<div class="goresan"></div>' +
    (halus ? '' : '<div class="s">N3 · memuat</div>');
  document.documentElement.appendChild(el);

  const tutup = () => {
    el.classList.add('hilang');
    setTimeout(() => el.remove(), 400);
  };

  /* ---------- gambar goresan ---------- */
  const wadah = el.querySelector('.goresan');
  let total = 0;

  Promise.all(KANJI.map(ch =>
    fetch(DASAR + ch.codePointAt(0).toString(16).padStart(5, '0') + '.svg')
      .then(r => (r.ok ? r.text() : Promise.reject()))
      .then(t => t.slice(Math.max(0, t.indexOf('<svg'))))
      .catch(() => null)
  )).then(daftar => {
    if (daftar.some(s => !s)) {                       // data tidak ada → teks biasa
      wadah.innerHTML = `<span style="font-family:'Noto Serif JP',serif;font-size:clamp(44px,13vw,76px);letter-spacing:.06em">${KANJI.join('')}</span>`;
      setTimeout(tutup, 900);
      return;
    }

    daftar.forEach(svgTeks => {
      const bungkus = document.createElement('div');
      bungkus.innerHTML = svgTeks;
      const svg = bungkus.querySelector('svg');
      if (!svg) return;

      svg.removeAttribute('width');
      svg.removeAttribute('height');
      svg.setAttribute('viewBox', '0 0 109 109');
      svg.querySelectorAll('text').forEach(t => t.remove());

      svg.querySelectorAll('path').forEach((p, i) => {
        p.setAttribute('pathLength', '100');            // panjang dinormalkan → CSS cukup
        p.style.animationDelay = (halus ? 0 : (total + i) * JEDA) + 'ms';
      });
      total += svg.querySelectorAll('path').length;

      wadah.appendChild(svg);
    });

    const lama = halus ? 700 : total * JEDA + DURASI + AKHIR;
    setTimeout(tutup, lama);
  });

  // jaring aman: jangan pernah menggantung lebih dari 3 detik
  setTimeout(() => { if (document.body && el.isConnected) tutup(); }, 3000);
})();
