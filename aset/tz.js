
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
  return { data, simpan, baca, ucap, esc, gelap, furi };
})();
