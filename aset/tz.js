
const TZ = (() => {
  const kunci = (k) => 'tz:' + k;
  async function data(nama) {
    const r = await fetch((location.pathname.includes('/n3/') ? '../aset/' : 'aset/') + nama);
    return r.json();
  }
  function simpan(k, v) { try { localStorage.setItem(kunci(k), JSON.stringify(v)); } catch (e) {} }
  function baca(k, d) {
    try { const v = localStorage.getItem(kunci(k)); return v ? JSON.parse(v) : d; }
    catch (e) { return d; }
  }
  function ucap(teks) {
    if (!('speechSynthesis' in window)) return;
    speechSynthesis.cancel();
    const u = new SpeechSynthesisUtterance(teks);
    u.lang = 'ja-JP'; u.rate = .9;
    speechSynthesis.speak(u);
  }
  function furi(teks, baca) {
    if (!baca) return teks;
    return teks;
  }
  function esc(s) {
    return String(s || '').replace(/[&<>"']/g, (c) =>
      ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
  }
  function gelap(nyala) {
    document.documentElement.classList.toggle('mode-gelap', !!nyala);
    simpan('gelap', !!nyala);
  }
  // ---- lacak waktu belajar ----
  const kunciHari = () => new Date().toLocaleDateString('sv-SE');
  function logMenit() { return baca('logMenit', {}); }
  function tambahMenit(detik) {
    if (!detik || detik < 5) return;
    const lg = logMenit();
    const t = kunciHari();
    lg[t] = Math.round(((lg[t] || 0) * 60 + detik)) / 60;
    lg[t] = Math.round(lg[t] * 10) / 10;
    simpan('logMenit', lg);
  }
  let mulai = Date.now();
  function flush() { tambahMenit((Date.now() - mulai) / 1000); mulai = Date.now(); }
  window.addEventListener('pagehide', flush);
  document.addEventListener('visibilitychange', () => { if (document.hidden) flush(); });
  setInterval(() => { if (!document.hidden) flush(); }, 60000);
  return { data, simpan, baca, ucap, esc, gelap, furi, logMenit, tambahMenit };
})();
