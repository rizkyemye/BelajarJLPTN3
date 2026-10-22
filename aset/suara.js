/* ============================================================================
   suara.js — pelafalan bahasa Jepang lewat Web Speech API
   Dipakai SEMUA level (n5 / n4 / n3). Tidak butuh file audio.

   Cara pakai:
     import { ucapkan, suaraSiap, adaSuaraJepang } from '../aset/suara.js';
     ucapkan('生活');            // pelan, normal
     ucapkan('生活', { rate: 0.7 });
     ucapkan('生活', { kanji: true });   // 生活 dibaca せいかつ otomatis?
     → untuk kanji, kirim yomi-nya. Browser tidak bisa baca kanji.
   ============================================================================ */

const BAHASA = 'ja-JP';
let suara = null;
let sudahCari = false;

/* pilih suara Jepang terbaik yang tersedia di perangkat */
function cariSuara() {
  if (!('speechSynthesis' in window)) return null;

  const semua = speechSynthesis.getVoices();
  if (!semua.length) return null;

  const jepang = semua.filter(v => v.lang && v.lang.toLowerCase().startsWith('ja'));
  if (!jepang.length) return null;

  // prioritaskan suara lokal + nama yang umum bagus di Android/iOS/Windows
  const prioritas = ['nanami', 'kyoko', 'otoya', 'haruka', 'ayumi', 'google'];
  jepang.sort((a, b) => {
    const na = prioritas.findIndex(p => a.name.toLowerCase().includes(p));
    const nb = prioritas.findIndex(p => b.name.toLowerCase().includes(p));
    const wa = (na === -1 ? 99 : na) - (a.localService ? 1 : 0);
    const wb = (nb === -1 ? 99 : nb) - (b.localService ? 1 : 0);
    return wa - wb;
  });

  return jepang[0];
}

/* dipanggil sekali di awal — getVoices() sering kosong saat halaman baru dibuka */
export function suaraSiap() {
  return new Promise((resolve) => {
    if (!('speechSynthesis' in window)) return resolve(null);

    if (!sudahCari) {
      suara = cariSuara();
      sudahCari = true;
    }
    if (suara) return resolve(suara);

    const coba = () => {
      suara = cariSuara();
      if (suara) {
        speechSynthesis.removeEventListener('voiceschanged', coba);
        resolve(suara);
      }
    };
    speechSynthesis.addEventListener('voiceschanged', coba);
    setTimeout(() => resolve(cariSuara()), 1200);
  });
}

export function adaSuaraJepang() {
  return !!suara;
}

/* ucapkan teks Jepang */
export function ucapkan(teks, opsi = {}) {
  if (!('speechSynthesis' in window) || !teks) return false;

  speechSynthesis.cancel();          // hentikan yang sedang jalan

  const u = new SpeechSynthesisUtterance(String(teks));
  u.lang   = BAHASA;
  u.rate   = opsi.rate   ?? 0.9;
  u.pitch  = opsi.pitch  ?? 1;
  u.volume = opsi.volume ?? 1;
  if (suara || (suara = cariSuara())) u.voice = suara;

  speechSynthesis.speak(u);
  return true;
}

/* ucapkan beberapa baris berurutan (percakapan) — selesai = Promise
   dipakai soal mendengar (choukai): tiap baris dibaca, lalu jeda sebentar. */
export function bacaBerurutan(daftar, opsi = {}) {
  return new Promise((selesai) => {
    if (!('speechSynthesis' in window) || !daftar || !daftar.length) return selesai(false);

    speechSynthesis.cancel();
    let i = 0;

    const satu = () => {
      if (i >= daftar.length) return selesai(true);

      const butir = daftar[i++];
      const teks = typeof butir === 'string' ? butir : butir.teks;
      const u = new SpeechSynthesisUtterance(String(teks));
      u.lang = BAHASA;
      u.rate = (typeof butir === 'object' && butir.rate != null) ? butir.rate : (opsi.rate ?? 0.9);
      u.pitch = (typeof butir === 'object' && butir.pitch != null) ? butir.pitch : (opsi.pitch ?? 1);
      u.volume = opsi.volume ?? 1;
      if (suara || (suara = cariSuara())) u.voice = suara;

      u.onend = () => setTimeout(satu, opsi.jeda ?? 320);
      u.onerror = () => selesai(false);
      speechSynthesis.speak(u);
    };

    satu();
  });
}

export function berhenti() {
  if ('speechSynthesis' in window) speechSynthesis.cancel();
}

/* ---------- pemeriksaan cepat di konsol ---------- */
if (location.search.includes('uji=suara')) {
  suaraSiap().then((v) => {
    console.log('[suara]', v ? `pakai: ${v.name} (${v.lang})` : 'TIDAK ada suara Jepang di perangkat ini');
    ucapkan('生活が忙しい。');
  });
}
