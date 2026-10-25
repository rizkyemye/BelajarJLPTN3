/* ============================================================================
   sw.js — service worker sederhana (biar bisa dipasang di HP + buka saat sinyal
   jelek). Naikkan VERSI kalau isi situs berubah besar.

   Aturan:
   · halaman (navigation)  → coba jaringan dulu, kalau gagal pakai simpanan
   · aset (css/js/svg/png) → pakai simpanan dulu, perbarui di latar belakang
   ============================================================================ */

const VERSI = 'n3-v4';

const INTI = [
  './',
  './index.html',
  './login.html',
  './n3/index.html',
  './n3/belajar.html',
  './n3/kartu.html',
  './n3/review.html',
  './n3/kanji.html',
  './n3/kanji-daftar.html',
  './n3/bunpou.html',
  './n3/dokkai.html',
  './n3/choukai.html',
  './aset/desain.css',
  './aset/splash.js',
  './manifest.webmanifest',
  './ikon-192.png'
];

self.addEventListener('install', (e) => {
  e.waitUntil(
    caches.open(VERSI)
      .then((c) => Promise.allSettled(INTI.map((u) => c.add(u))))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys()
      .then((k) => Promise.all(k.filter((x) => x !== VERSI).map((x) => caches.delete(x))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (e) => {
  const req = e.request;
  if (req.method !== 'GET') return;

  const sama = new URL(req.url).origin === location.origin;
  if (!sama) return;                       // Supabase & font: langsung jaringan

  if (req.mode === 'navigate') {
    e.respondWith(
      fetch(req)
        .then((r) => {
          const salinan = r.clone();
          caches.open(VERSI).then((c) => c.put(req, salinan));
          return r;
        })
        .catch(() => caches.match(req).then((r) => r || caches.match('./n3/index.html')))
    );
    return;
  }

  /* konfig (kunci Supabase) & file .js inti: SELALU ambil dari jaringan dulu,
     cache hanya kalau offline — supaya perubahan di repo langsung kebaca */
  const selalubaru = /konfig\.js|sesi\.js$/.test(req.url);

  if (selalubaru) {
    e.respondWith(
      fetch(req)
        .then((r) => {
          const salinan = r.clone();
          caches.open(VERSI).then((c) => c.put(req, salinan));
          return r;
        })
        .catch(() => caches.match(req))
    );
    return;
  }

  e.respondWith(
    caches.match(req).then((r) => {
      const ambil = fetch(req).then((res) => {
        if (res && res.status === 200) caches.open(VERSI).then((c) => c.put(req, res.clone()));
        return res;
      }).catch(() => r);
      return r || ambil;
    })
  );
});
