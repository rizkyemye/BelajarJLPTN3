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

import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

const DOMAIN = 'n3master.local';

/* AKAR = folder situs ini (../ dari ../aset/sesi.js) — aman juga kalau
   situs tidak di akar domain (mis. USER.github.io/REPO/) */
const AKAR = new URL('../', import.meta.url).href;

async function jalankan() {
  if (!window.konfigSiap || !window.konfigSiap()) {
    document.body.insertAdjacentHTML('afterbegin',
      `<div style="padding:14px 18px;background:#c0392b;color:#fff;font:14px/1.5 system-ui">
         Konfigurasi Supabase belum diisi di <code>aset/konfig.js</code>.
       </div>`);
    return;
  }

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
  const level = (profil.level || 'n5').toLowerCase();

  if (['n5', 'n4', 'n3'].includes(folder) && folder !== level) {
    location.replace('../' + level + '/index.html');
    return;
  }

  /* ---------- 4. admin-only ---------- */
  if (folder === 'admin' && profil.role !== 'admin') {
    location.replace(AKAR + level + '/index.html');
    return;
  }

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
}

jalankan();
