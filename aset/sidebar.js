/* ============================================================================
   sidebar.js — menu kiri semua halaman level (n3/ n4/ n5/)
   Satu tempat untuk mengubah menu: array MENU di bawah.

   Pakai di halaman:
     <aside class="sisi-kiri" data-sidebar></aside>
     <script src="../aset/sidebar.js"></script>

   Isi `.akun` tetap diisi oleh sesi.js (data-akun="username|level|keluar").
   ============================================================================ */
(function () {
  const el = document.querySelector('[data-sidebar]');
  if (!el) return;

  // file → menu mana yang menyala
  const MENU = [
    { kanji: '単', nama: 'Kosakata', ke: 'index.html',
      file: ['index.html', 'belajar.html'] },
    { kanji: '漢', nama: 'Kanji', ke: 'kanji-daftar.html',
      file: ['kanji-daftar.html', 'kanji.html'] },
    { kanji: '文', nama: 'Bunpou', ke: 'bunpou.html',
      file: ['bunpou.html'] },
    { kanji: '復', nama: 'Review', ke: 'review.html',
      file: ['review.html'] }
  ];

  const sekarang = (location.pathname.split('/').pop() || 'index.html').split('?')[0];

  el.innerHTML = `
    <a href="index.html" class="merek-kecil">日本語<small>N3</small></a>
    <nav>
      <ul class="menu">
        ${MENU.map((m) => `
        <li><a href="${m.ke}"${m.file.includes(sekarang) ? ' class="aktif"' : ''}>
          <span class="kanji-menu">${m.kanji}</span>${m.nama}
        </a></li>`).join('')}
      </ul>
    </nav>
    <div class="akun">
      <span class="nama" data-akun="username">…</span>
      <span data-akun="level">N3</span>
      <button data-akun="keluar">Keluar</button>
    </div>`;
})();
