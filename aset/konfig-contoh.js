/* ============================================================================
   ISI SENDIRI — jangan kirim lewat chat.

   Ambil dari Supabase → Settings → DATA API:
     Project URL   : https://xxxxxxxx.supabase.co
     Publishable key: sb_publishable_...

   ⚠️ URL HARUS pola:  https://<kode>.supabase.co
      ✗ SALAH: https://supabase.com/dashboard/project/xxxx
      ✗ SALAH: xxx.supabase.co            (tanpa https://)
      ✗ SALAH: https://xxxx.supabase.co/rest/v1   (ada path tambahan)

   ⚠️ JANGAN taruh secret key (sb_secret_...) di file ini.
   ============================================================================ */

window.KONFIG = {
  url: '',      // https://xxxxxxxx.supabase.co
  kunci: ''     // sb_publishable_...
};

window.konfigSiap = function () {
  const u = window.KONFIG.url || '';
  const k = window.KONFIG.kunci || '';

  // harus https://<sesuatu>.supabase.co tanpa path
  const pola = /^https:\/\/[a-z0-9-]+\.supabase\.co$/i;

  return pola.test(u) && k.length > 20 && !k.startsWith('sb_secret_');
};

/* penjelasan kalau salah */
window.konfigMasalah = function () {
  const u = window.KONFIG.url || '';
  const k = window.KONFIG.kunci || '';

  if (!u) return 'URL belum diisi di aset/konfig.js';
  if (u.includes('supabase.com/dashboard')) return 'Itu URL dashboard, bukan Project URL';
  if (u.includes('/rest/')) return 'URL-nya kelebihan /rest/v1 — cukup sampai .supabase.co';
  if (!u.startsWith('https://')) return 'URL harus diawali https://';
  if (!/\.supabase\.co\/?$/i.test(u)) return 'URL harus berakhiran .supabase.co';
  if (!k) return 'Kunci belum diisi';
  if (k.startsWith('sb_secret_')) return 'Itu SECRET key — pakai Publishable key';
  if (k.length <= 20) return 'Kunci kelihatannya terpotong';
  return '';
};
