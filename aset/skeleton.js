/* ============================================================================
   skeleton.js — rangka halaman selama data dimuat
   Sisipkan sebagai elemen pertama di <body>:
     <script src="../aset/skeleton.js"></script>

   Cara kerja: TIDAK menebak layout. Rangka memakai elemen asli halaman —
   teksnya disembunyikan, kotaknya diberi shimmer. Jadi bentuknya selalu pas
   dengan halaman yang sedang dibuka, apa pun lebar layarnya.

   Hilang otomatis saat isi asli muncul; dipaksa hilang setelah 4 detik.
   ============================================================================ */
(function () {
  const AKAR = document.documentElement;
  AKAR.classList.add('skeleton-n3');   // dipasang sebelum <body> digambar

  const gaya = document.createElement('style');
  gaya.textContent = `
  /* --- shimmer --- */
  @keyframes skn3{
    0%{background-position:100% 50%}
    100%{background-position:0 50%}
  }
  html.skeleton-n3 .hari-kartu,
  html.skeleton-n3 .topik li a,
  html.skeleton-n3 .kartu-kata,
  html.skeleton-n3 .kepala-isi h1,
  html.skeleton-n3 .kepala-isi p,
  html.skeleton-n3 .sisi-kiri .nama,
  html.skeleton-n3 .topik .kosong{
    background-image:linear-gradient(90deg,
      var(--garis,#e3ded1) 25%, var(--garis-2,#efebdf) 37%, var(--garis,#e3ded1) 63%);
    background-size:400% 100%;
    background-repeat:no-repeat;
    animation:skn3 1.4s ease-in-out infinite;
    color:transparent !important;
    text-shadow:none !important;
    border-color:transparent !important;
    box-shadow:none !important;
    border-radius:6px;
  }

  /* isi kartu/tombol disembunyikan, kotaknya tetap jadi blok shimmer */
  html.skeleton-n3 .hari-kartu > *,
  html.skeleton-n3 .topik li a > *,
  html.skeleton-n3 .kartu-kata > *,
  html.skeleton-n3 .kendali > *,
  html.skeleton-n3 .kemajuan > *,
  html.skeleton-n3 .kepala-isi .atas-kecil span,
  html.skeleton-n3 #memuat{
    visibility:hidden !important;
  }

  /* kartu hari & flashcard: jangan bikin tinggi berubah */
  html.skeleton-n3 .hari-kartu,
  html.skeleton-n3 .topik li a{min-height:1em}
  html.skeleton-n3 .topik .kosong{
    min-height:52px;border:0 !important;padding:0 !important;margin-bottom:12px;
  }

  @media (prefers-reduced-motion:reduce){
    html.skeleton-n3 .hari-kartu,
    html.skeleton-n3 .topik li a,
    html.skeleton-n3 .kartu-kata,
    html.skeleton-n3 .kepala-isi h1,
    html.skeleton-n3 .kepala-isi p{animation:none}
  }
  `;
  document.head.appendChild(gaya);

  /* halaman kartu: tampilkan wadahnya sementara supaya rangkanya kelihatan */
  let tiruan = null;
  const pasangTiruan = () => {
    const kartu = document.getElementById('tahap-kartu');
    if (kartu && kartu.hidden) { kartu.hidden = false; tiruan = kartu; }
  };

  let tutup = false;
  const buang = () => {
    if (tutup) return;
    tutup = true;
    AKAR.classList.remove('skeleton-n3');
    gaya.remove();
    // wadah tiruan hanya disembunyikan kalau JS memang belum menampilkan apa pun
    const m = document.getElementById('memuat');
    if (tiruan && m && !m.hidden && m.textContent.trim().startsWith('Memuat')) {
      tiruan.hidden = true;
    }
  };

  /* ---------- kapan dianggap selesai ---------- */
  const adaIsi = () => {
    const memuat = document.getElementById('memuat');
    // masih "Memuat…" → belum; sudah ada pesan lain (mis. error) → anggap selesai
    if (memuat && !memuat.hidden) {
      return !memuat.textContent.trim().startsWith('Memuat');
    }

    const kartu = document.getElementById('tahap-kartu');
    if (kartu) {
      return ['tahap-kartu', 'terkunci', 'tahap-selesai']
        .some(id => { const x = document.getElementById(id); return x && !x.hidden; });
    }

    const daftar = document.getElementById('daftar-hari');
    if (daftar) return !daftar.querySelector('.kosong');

    // landing / login: cukup tunggu halaman selesai
    return document.readyState === 'complete';
  };

  const cek = () => { if (adaIsi()) buang(); };

  const mulai = () => { pasangTiruan(); cek(); };

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', mulai, { once: true });
    window.addEventListener('load', cek, { once: true });
  } else {
    mulai();
  }

  new MutationObserver(cek).observe(document.documentElement, {
    subtree: true, childList: true, attributes: true, attributeFilter: ['hidden', 'class']
  });

  setTimeout(buang, 15000);  // jaring aman terakhir
})();
