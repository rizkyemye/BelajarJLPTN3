/* Isi sendiri, JANGAN kirim lewat chat.
   Supabase -> Settings -> API Keys
     url   : https://xxxx.supabase.co
     kunci : sb_publishable_...
   JANGAN taruh secret key (sb_secret_...) di file ini.
*/
window.KONFIG = {url: 'https://kimohryslbvzffqqwcoy.supabase.co',          // contoh: 'https://abcdefghijkl.supabase.co'
  kunci: 'sb_publishable_P_aaSUa7uIur4pusIzErAQ_cYq9vsdF' };
window.konfigSiap = function () {
  return window.KONFIG.url.startsWith('https://') && window.KONFIG.kunci.length > 20;
};
