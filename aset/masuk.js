/* ============================================================================
   masuk.js — halaman login (khusus masuk)
   Username dipetakan ke email internal: <username>@n3master.local
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

function terjemah(err) {
  const p = ((err && (err.message || err.error_description)) || '').toLowerCase();
  if (p.includes('invalid login') || p.includes('invalid credentials'))
    return 'Nama pengguna atau sandi salah.';
  if (p.includes('rate limit')) return 'Terlalu banyak percobaan. Tunggu sebentar.';
  if (p.includes('network') || p.includes('fetch') || p.includes('failed to fetch'))
    return 'Tidak bisa menghubungi server. Periksa koneksi.';
  return 'Gagal masuk: ' + (err && err.message ? err.message : 'coba lagi.');
}

/* ---------- kirim ---------- */
form.addEventListener('submit', async (e) => {
  e.preventDefault();
  bersihkan();

  const username = ($('username').value || '').trim().toLowerCase();
  const sandi    = $('sandi').value || '';

  if (!/^[a-z0-9._]{3,24}$/.test(username))
    return kabar('Nama pengguna 3–24 karakter: huruf kecil, angka, titik, garis bawah.');
  if (sandi.length < 8)
    return kabar('Sandi minimal 8 karakter.');

  tombol.disabled = true;
  tombol.textContent = 'Memeriksa…';

  try {
    // 1. masuk — server yang memverifikasi sandi
    const { error } = await supabase.auth.signInWithPassword({
      email: `${username}@${DOMAIN}`,
      password: sandi
    });
    if (error) throw error;

    // 2. baca profil dari DATABASE (bukan cache)
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return kabar('Berhasil masuk, tapi sesi tidak terbaca. Coba lagi.');

    const { data: baris, error: errProfil } = await supabase.rpc('profil_saya');
    const profil = Array.isArray(baris) ? baris[0] : baris;

    if (errProfil || !profil) {
      await supabase.auth.signOut();
      return kabar('Profil akun tidak ditemukan. Hubungi admin.');
    }

    if (profil.status === 'ditangguhkan') {
      await supabase.auth.signOut();
      return kabar('Akun ini sedang ditangguhkan. Hubungi admin.');
    }

    // 3. catat waktu login (abaikan kalau gagal)
    supabase.rpc('tandai_login').then(() => {});

    kabar('Berhasil. Mengalihkan…', 'ok');
    location.replace(`${profil.level || 'n5'}/index.html`);

  } catch (err) {
    kabar(terjemah(err));
    tombol.disabled = false;
    tombol.textContent = 'Masuk';
  }
});

/* ---------- kalau sudah login, langsung alihkan ---------- */
async function sudahLogin() {
  const { data: { user } } = await supabase.auth.getUser();   // tanya server
  if (!user) return;

  const { data: baris2 } = await supabase.rpc('profil_saya');
  const profil = Array.isArray(baris2) ? baris2[0] : baris2;

  if (!profil) return;

  if (profil.status === 'ditangguhkan') {
    await supabase.auth.signOut();
    kabar('Akun ini sedang ditangguhkan. Hubungi admin.');
    return;
  }

  kabar('Sudah masuk. Mengalihkan…', 'ok');
  location.replace(`${profil.level || 'n5'}/index.html`);
}

/* ---------- mulai ---------- */
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

  sudahLogin();
}

mulai();
