/* ============================================================================
   daftar.js — halaman pendaftaran
   Username unik: dicek ke database lewat RPC cek_username, lalu dijaga
   oleh constraint UNIQUE di tabel profiles.
   ============================================================================ */

import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

const DOMAIN = 'n3master.local';
const $ = (id) => document.getElementById(id);

const form   = $('form');
const pesan  = $('pesan');
const tombol = $('tombol');

let supabase = null;

function kabar(teks, jenis = 'salah') {
  pesan.textContent = teks;
  pesan.className = 'pesan tampil' + (jenis === 'ok' ? ' ok' : '');
}
function bersihkan() {
  pesan.textContent = '';
  pesan.className = 'pesan';
}

/* ---------- error → bahasa Indonesia ---------- */
function terjemah(err) {
  const p = ((err && (err.message || err.error_description)) || '').toLowerCase();

  if (p.includes('already registered') || p.includes('already been registered') ||
      p.includes('user already exists') || p.includes('duplicate'))
    return 'Username sudah terpakai.';

  if (p.includes('rate limit'))  return 'Terlalu banyak percobaan. Tunggu sebentar.';
  if (p.includes('password'))    return 'Sandi minimal 8 karakter.';
  if (p.includes('network') || p.includes('fetch') || p.includes('failed to fetch'))
    return 'Tidak bisa menghubungi server. Periksa koneksi.';

  return 'Gagal mendaftar: ' + (err && err.message ? err.message : 'coba lagi.');
}

/* ---------- kirim ---------- */
form.addEventListener('submit', async (e) => {
  e.preventDefault();
  bersihkan();

  const username = ($('username').value || '').trim().toLowerCase();
  const sandi    = $('sandi').value || '';
  const sandi2   = $('sandi2').value || '';
  const level    = form.querySelector('input[name=level]:checked').value;

  // --- validasi dasar ---
  if (!/^[a-z0-9._]{3,24}$/.test(username)) {
    return kabar('Nama pengguna 3–24 karakter: huruf kecil, angka, titik, garis bawah.');
  }
  if (sandi.length < 8) {
    return kabar('Sandi minimal 8 karakter.');
  }
  if (sandi !== sandi2) {
    return kabar('Ulangi sandi tidak sama.');
  }

  tombol.disabled = true;
  tombol.textContent = 'Memeriksa nama…';

  try {
    // --- 1. cek username ke DATABASE ---
    const { data: terpakai, error: errCek } = await supabase
      .rpc('cek_username', { p_username: username });

    // kalau RPC belum dipasang, jangan gagalkan pendaftaran — biar UNIQUE yang jaga
    if (!errCek && terpakai === true) {
      return kabar('Username sudah terpakai.');
    }

    // --- 2. daftar ---
    tombol.textContent = 'Mendaftarkan…';

    const { error: errDaftar } = await supabase.auth.signUp({
      email: `${username}@${DOMAIN}`,
      password: sandi,
      options: { data: { username, level } }
    });

    if (errDaftar) throw errDaftar;

    // --- 3. langsung masuk ---
    tombol.textContent = 'Masuk…';
    const { error: errMasuk } = await supabase.auth.signInWithPassword({
      email: `${username}@${DOMAIN}`,
      password: sandi
    });

    if (errMasuk) {
      kabar('Akun dibuat. Silakan masuk.', 'ok');
      setTimeout(() => location.href = 'login.html', 1200);
      return;
    }

    kabar('Akun dibuat. Mengalihkan…', 'ok');
    location.replace(`${level}/index.html`);

  } catch (err) {
    kabar(terjemah(err));
    tombol.disabled = false;
    tombol.textContent = 'Daftar';
  }
});

/* ---------- konfigurasi ---------- */
function mulai() {
  if (!window.konfigSiap || !window.konfigSiap()) {
    document.body.insertAdjacentHTML('beforeend',
      `<div style="max-width:440px;margin:40px auto;padding:20px;border-left:3px solid #c0392b;font:14px/1.6 system-ui;color:#16181d">
         <b>Konfigurasi belum diisi.</b><br>
         Buka <code>aset/konfig.js</code> lalu isi <code>url</code> dan <code>kunci</code>
         dari Supabase → Settings → API.
       </div>`);
    form.style.display = 'none';
    return;
  }
  supabase = createClient(window.KONFIG.url, window.KONFIG.kunci, {
    auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: false }
  });
}

mulai();
