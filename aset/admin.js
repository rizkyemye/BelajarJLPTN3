/* ============================================================================
   admin.js — panel admin
   Butuh: profil.role = 'admin' (dijaga sesi.js + RLS apakah_admin())
   Fitur: daftar pengguna · ubah level · tangguhkan · statistik · bahan
   ============================================================================ */

const $ = (id) => document.getElementById(id);
let supabase = null;
let daftarUser = [];

/* ---------- bantu ---------- */
function tanggal(w) {
  if (!w) return '—';
  const d = new Date(w);
  return d.toLocaleDateString('id-ID', { day: '2-digit', month: 'short', year: '2-digit' })
       + ' ' + d.toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' });
}
const esc = (s) => String(s ?? '').replace(/[&<>"]/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));

/* ---------- tab ---------- */
function pilihTab(nama) {
  ['users', 'bahan', 'statistik'].forEach(t => {
    $('tab-' + t).hidden = (t !== nama);
  });
  document.querySelectorAll('.menu a').forEach(a => {
    a.classList.toggle('aktif', a.dataset.tab === nama);
  });
}
document.querySelectorAll('.menu a').forEach(a => {
  if (!a.dataset.tab) return;   // tautan ke halaman lain: biarkan pindah
  a.addEventListener('click', (e) => {
    e.preventDefault();
    pilihTab(a.dataset.tab);
  });
});

/* ============================================================================
   PENGGUNA
   ============================================================================ */
async function muatUser() {
  const { data, error } = await supabase
    .from('profiles')
    .select('id, username, level, role, status, created_at, last_login_at')
    .order('created_at', { ascending: false });

  if (error) {
    $('isi-user').innerHTML = `<tr><td colspan="5" class="kosong-baris">Gagal memuat: ${esc(error.message)}</td></tr>`;
    return;
  }

  daftarUser = data || [];
  $('info-user').textContent = `${daftarUser.length} akun`;
  gambarUser(daftarUser);
}

function gambarUser(baris) {
  if (!baris.length) {
    $('isi-user').innerHTML = `<tr><td colspan="5" class="kosong-baris">Tidak ada pengguna.</td></tr>`;
    return;
  }

  $('isi-user').innerHTML = baris.map(u => `
    <tr data-id="${u.id}">
      <td>
        <span class="nama-sel">${esc(u.username)}</span>
        ${u.role === 'admin' ? '<span class="lencana">admin</span>' : ''}
      </td>
      <td>
        <select class="pilih-level" data-id="${u.id}">
          ${['n5', 'n4', 'n3'].map(l =>
            `<option value="${l}"${u.level === l ? ' selected' : ''}>${l.toUpperCase()}</option>`).join('')}
        </select>
      </td>
      <td>
        <span class="status ${u.status === 'ditangguhkan' ? 'mati' : 'hidup'}">
          ${u.status === 'ditangguhkan' ? 'ditangguhkan' : 'aktif'}
        </span>
      </td>
      <td class="mono kecil">${tanggal(u.last_login_at)}</td>
      <td class="aksi-sel">
        <button class="tbl-teks" data-aksi="tangguh" data-id="${u.id}">
          ${u.status === 'ditangguhkan' ? 'aktifkan' : 'tangguhkan'}
        </button>
      </td>
    </tr>
  `).join('');

  // ubah level
  document.querySelectorAll('.pilih-level').forEach(sel => {
    sel.addEventListener('change', async () => {
      const id = sel.dataset.id;
      const level = sel.value;
      sel.disabled = true;
      const { error } = await supabase.from('profiles').update({ level }).eq('id', id);
      sel.disabled = false;
      if (error) { alert('Gagal ubah level: ' + error.message); return; }
      const u = daftarUser.find(x => x.id === id);
      if (u) u.level = level;
    });
  });

  // tangguhkan / aktifkan
  document.querySelectorAll('[data-aksi="tangguh"]').forEach(btn => {
    btn.addEventListener('click', async () => {
      const id = btn.dataset.id;
      const u = daftarUser.find(x => x.id === id);
      const baru = u.status === 'ditangguhkan' ? 'aktif' : 'ditangguhkan';
      btn.disabled = true;
      const { error } = await supabase.from('profiles').update({ status: baru }).eq('id', id);
      btn.disabled = false;
      if (error) { alert('Gagal: ' + error.message); return; }
      await muatUser();
    });
  });
}

/* ---------- pencarian ---------- */
$('cari-user').addEventListener('input', (e) => {
  const q = e.target.value.trim().toLowerCase();
  gambarUser(q ? daftarUser.filter(u => u.username.toLowerCase().includes(q)) : daftarUser);
});

/* ============================================================================
   BAHAN
   ============================================================================ */
async function muatBahan() {
  // RPC: PostgREST memotong hasil select di 1000 baris, jadi rekap dihitung
  // di database (42 baris per level) — bukan dengan membaca semua kata.
  const hasil = await Promise.all(
    ['n5', 'n4', 'n3'].map(l => supabase.rpc('rekap_kosakata', { p_level: l }))
  );
  const error = hasil.find(h => h.error)?.error;
  const data = hasil.flatMap((h, i) =>
    (h.data || []).map(r => ({ level: ['n5','n4','n3'][i], hari_ke: r.hari_ke, jumlah: r.jumlah })));

  if (error) {
    $('isi-bahan').innerHTML = `<tr><td colspan="4" class="kosong-baris">Gagal memuat: ${esc(error.message)}</td></tr>`;
    return;
  }

  // kelompokkan
  const peta = {};
  (data || []).forEach(k => {
    const kunci = k.level + '|' + k.hari_ke;
    peta[kunci] = { level: k.level, hari: k.hari_ke, jumlah: k.jumlah, contoh: [] };
  });

  const baris = Object.values(peta).sort((a, b) =>
    a.level === b.level ? a.hari - b.hari : a.level.localeCompare(b.level));

  const totalKata = (data || []).reduce((n, k) => n + k.jumlah, 0);
  $('info-bahan').textContent = `${baris.length} porsi · ${totalKata} kata`;

  // ringkasan per level (jumlah kata, bukan jumlah hari)
  const perLevel = { n5: 0, n4: 0, n3: 0 };
  (data || []).forEach(k => { perLevel[k.level] = (perLevel[k.level] || 0) + k.jumlah; });

  $('ringkas-bahan').innerHTML = ['n5', 'n4', 'n3'].map(l => `
    <div class="angka-kotak">
      <b>${perLevel[l] || 0}</b>
      <span>${l.toUpperCase()} · kata</span>
    </div>`).join('');

  $('isi-bahan').innerHTML = baris.length ? baris.map(b => `
    <tr>
      <td class="mono">${b.level.toUpperCase()}</td>
      <td>Hari ${b.hari}</td>
      <td class="mono">${b.jumlah}</td>
      <td class="kecil">${b.contoh.length ? esc(b.contoh.join(' · ')) + '…' : '—'}</td>
    </tr>`).join('')
    : `<tr><td colspan="4" class="kosong-baris">Belum ada bahan. Jalankan SQL contoh-kosakata.</td></tr>`;
}

/* ============================================================================
   STATISTIK
   ============================================================================ */
async function muatStatistik() {
  const { data: u } = await supabase
    .from('profiles')
    .select('level, status, role, last_login_at, created_at');

  const semua = u || [];
  const seminggu = new Date(Date.now() - 7 * 864e5);
  const aktif7 = semua.filter(x => x.last_login_at && new Date(x.last_login_at) > seminggu).length;
  const tangguh = semua.filter(x => x.status === 'ditangguhkan').length;
  const admin = semua.filter(x => x.role === 'admin').length;

  const { count: jumlahReview } = await supabase
    .from('review').select('*', { count: 'exact', head: true });
  const { count: jumlahHari } = await supabase
    .from('hari').select('*', { count: 'exact', head: true })
    .eq('status', 'selesai');

  const kotak = [
    ['total akun', semua.length],
    ['aktif 7 hari', aktif7],
    ['ditangguhkan', tangguh],
    ['admin', admin],
    ['hari selesai', jumlahHari ?? 0],
    ['review tercatat', jumlahReview ?? 0]
  ];

  $('kartu-angka').innerHTML = kotak.map(([label, n]) => `
    <div class="angka-kotak">
      <b>${n}</b>
      <span>${label}</span>
    </div>`).join('');
}

/* ============================================================================
   MULAI
   ============================================================================ */
async function jalankan() {
  if (!window.sesiSiap) {
    document.addEventListener('sesi-siap', jalankan, { once: true });
    return;
  }

  supabase = window.sesiSiap.supabase;

  // sesi.js sudah menolak non-admin
  if (window.sesiSiap.profil.role !== 'admin') {
    location.replace('../n3/index.html');
    return;
  }

  document.querySelector('[data-akun="level"]').textContent = 'ADMIN';

  await muatUser();
  await muatBahan();
  await muatStatistik();

  pilihTab('users');
}

jalankan();
