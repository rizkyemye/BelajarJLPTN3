/* ============================================================================
   konfig.js — alamat & kunci Supabase (PUBLISHABLE / publik)
   File ini memang boleh terlihat publik. Yang TIDAK boleh ada di sini:
   service_role key atau sb_secret_...
   ============================================================================ */

window.KONFIG = {
  url: 'https://kimohryslbvzffqqwcoy.supabase.co',
  kunci: 'sb_publishable_P_aaSUa7uIur4pusIzErAQ_cYq9vsdF'
};

window.konfigSiap = function () {
  const u = (window.KONFIG.url || '').trim();
  const k = (window.KONFIG.kunci || '').trim();
  return u.startsWith('https://') && k.length > 20 && !k.startsWith('sb_secret_');
};
