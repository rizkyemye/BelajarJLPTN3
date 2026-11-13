
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
  // ---- animasi bottom nav ----
  function nav() {
    const bar = document.querySelector('.nav');
    if (!bar) return;
    bar.classList.add('nav-masuk');
    bar.querySelectorAll('a').forEach((a, i) => {
      a.addEventListener('click', (ev) => {
        if (a.classList.contains('aktif')) return;
        ev.preventDefault();
        const tanda = bar.querySelector('.nav-tanda');
        if (tanda) tanda.style.setProperty('--i', String(i));
        bar.style.setProperty('--i', String(i));
        a.classList.add('aktif', 'ditekan');
        bar.querySelectorAll('a').forEach((b) => { if (b !== a) b.classList.remove('aktif'); });
        const box = a.getBoundingClientRect();
        const rip = document.createElement('span');
        rip.className = 'nav-ripple';
        rip.style.left = (box.left + box.width / 2) + 'px';
        rip.style.top = (box.top + box.height / 2) + 'px';
        document.body.appendChild(rip);
        setTimeout(() => rip.remove(), 600);
        setTimeout(() => { location.href = a.getAttribute('href'); }, 230);
      });
    });
  }
  let mulai = Date.now();
  function flush() { tambahMenit((Date.now() - mulai) / 1000); mulai = Date.now(); }
  window.addEventListener('pagehide', flush);
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', nav);
  } else { nav(); }
  document.addEventListener('visibilitychange', () => { if (document.hidden) flush(); });
  setInterval(() => { if (!document.hidden) flush(); }, 60000);
  return { data, simpan, baca, ucap, esc, gelap, furi, logMenit, tambahMenit };
})();
