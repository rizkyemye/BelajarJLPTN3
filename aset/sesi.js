/* ============================================================================
   sesi.js — penjaga halaman + info akun
   Dipakai semua halaman level: n5/, n4/, n3/, admin/.

   Cara pakai di halaman:
     <script src="../aset/konfig.js"></script>
     <script type="module" src="../aset/sesi.js"></script>
   Lalu pasang elemen:
     <span data-akun="username"></span>
     <span data-akun="level"></span>
     <button data-akun="keluar">Keluar</button>
   ============================================================================ */


/* ---------- konfigurasi: kalau file lama nyangkut di cache, ambil ulang paksa ---------- */
async function pastikanKonfig() {
  if (window.konfigSiap && window.konfigSiap()) return true;

  try {
    const src = new URL('konfig.js', import.meta.url).href + '?t=' + Date.now();
    await new Promise((selesai) => {
      const s = document.createElement('script');
      s.src = src;
      s.onload = selesai;
      s.onerror = selesai;
      document.head.appendChild(s);
    });
  } catch (_) {}

  return !!(window.konfigSiap && window.konfigSiap());
}

import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

const DOMAIN = 'n3master.local';

/* AKAR = folder situs ini (../ dari ../aset/sesi.js) — aman juga kalau
   situs tidak di akar domain (mis. USER.github.io/REPO/) */
const AKAR = new URL('../', import.meta.url).href;

/* tampilkan alasan kalau proses tidak selesai — biar tidak "memuat" selamanya */
function tampilMasalah(teks) {
  let bar = document.getElementById('sesi-masalah');
  if (!bar) {
    bar = document.createElement('div');
    bar.id = 'sesi-masalah';
    bar.style.cssText = 'padding:10px 14px;background:#c0392b;color:#fff;font:13px/1.5 system-ui';
    document.body.insertAdjacentHTML('afterbegin', '');
    document.body.prepend(bar);
  }
  bar.innerHTML = `${teks} <button type="button" style="margin-left:8px;padding:4px 10px;background:#fff;color:#c0392b;border:0;font:inherit;cursor:pointer">Muat ulang</button>`;
  bar.querySelector('button').addEventListener('click', () => location.reload());
}

async function jalankan() {
  const siapKonfig = await pastikanKonfig();
  if (!siapKonfig) {
    document.body.insertAdjacentHTML('afterbegin',
      `<div style="padding:14px 18px;background:#c0392b;color:#fff;font:14px/1.5 system-ui">
         Konfigurasi Supabase belum diisi di <code>aset/konfig.js</code>.
       </div>`);
    return;
  }

  const jamSesi = setTimeout(() => {
    tampilMasalah('Sesi belum menjawab (10 dtk). Cek internet, lalu muat ulang.');
  }, 10000);

  try {

  const supabase = createClient(window.KONFIG.url, window.KONFIG.kunci, {
    auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: false }
  });

  /* ---------- 1. tanya server, jangan percaya cache ---------- */
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    location.replace(AKAR + 'login.html');
    return;
  }

  /* ---------- 2. profil dari database ---------- */
  const { data: baris } = await supabase.rpc('profil_saya');
  const profil = Array.isArray(baris) ? baris[0] : baris;

  if (!profil) {
    await supabase.auth.signOut();
    location.replace(AKAR + 'login.html?err=profil');
    return;
  }

  if (profil.status === 'ditangguhkan') {
    await supabase.auth.signOut();
    location.replace(AKAR + 'login.html?err=ditangguhkan');
    return;
  }

  /* ---------- 3. halaman sesuai level? ---------- */
  const folder = location.pathname.split('/').filter(Boolean).slice(-2, -1)[0];
  const level = (profil.level || 'n3').toLowerCase();
  const ADA = 'n3';                        // satu-satunya level yang punya halaman

  // level lain (n5/n4) → halaman gerbang, bukan dilempar ke n3 diam-diam
  let lihatN3 = false;
  try { lihatN3 = sessionStorage.getItem('lihat-n3') === '1'; } catch (_) {}

  if (['n5', 'n4', 'n3'].includes(folder)) {
    if (level !== ADA && !lihatN3) {
      location.replace(AKAR + 'login.html?err=level&lv=' + level.toUpperCase());
      return;
    }
    if (folder !== ADA) {              // halaman level lain yang file-nya tak ada
      location.replace(AKAR + ADA + '/index.html');
      return;
    }
  }

  /* ---------- 4. admin-only ---------- */
  if (folder === 'admin' && profil.role !== 'admin') {
    location.replace(AKAR + ADA + '/index.html');
    return;
  }

  clearTimeout(jamSesi);

  /* ---------- 5. isi ke halaman ---------- */
  document.documentElement.dataset.siap = '1';

  document.querySelectorAll('[data-akun]').forEach((el) => {
    const kunci = el.dataset.akun;
    if (kunci === 'username') el.textContent = profil.username;
    if (kunci === 'level')    el.textContent = level.toUpperCase();
    if (kunci === 'keluar') {
      el.addEventListener('click', async (e) => {
        e.preventDefault();
        await supabase.auth.signOut();
        location.replace(AKAR + 'login.html');
      });
    }
  });

  /* ---------- 6. konfirmasi keluar ---------- */
  const dlg = document.getElementById('dialog-keluar');
  if (dlg) {
    if (typeof dlg.showModal !== 'function') dlg.remove();   // browser tua: langsung keluar saja
    dlg.addEventListener('click', (e) => { if (e.target === dlg) dlg.close(); });
  }
  document.querySelectorAll('[data-buka-keluar]').forEach((b) => {
    b.addEventListener('click', (e) => {
      e.preventDefault();
      if (dlg && typeof dlg.showModal === 'function') dlg.showModal();
      else {
        const t = document.querySelector('[data-akun="keluar"]');
        if (t) t.click();
      }
    });
  });
  document.querySelectorAll('[data-tutup-keluar]').forEach((b) => {
    b.addEventListener('click', () => { if (dlg) dlg.close(); });
  });

  /* kabari halaman lain bahwa sesi siap */
  window.sesiSiap = { profil, supabase, AKAR };
  document.dispatchEvent(new CustomEvent('sesi-siap', { detail: window.sesiSiap }));

  } catch (e) {
    clearTimeout(jamSesi);
    console.error('[sesi]', e);
    tampilMasalah('Sesi gagal: ' + ((e && e.message) || e));
  }
}

jalankan();
