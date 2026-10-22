#!/usr/bin/env python3
"""Rakit halaman HTML: masukkan inc/*.html ke setiap halaman + stempel aset.

Kenapa begini: HTML murni TIDAK punya "import file" (HTML Imports sudah
dihapus dari semua browser tahun 2019). Jadi penggabungan dikerjakan SEKALI
di sini (waktu build), hasilnya HTML biasa — tidak ada JavaScript.

Stempel ?v=<hash> ditambahkan ke aset/*.css & *.js supaya browser tidak
memakai salinan lama setelah berkasnya diganti.

Cara pakai:
    python3 alat/rakit.py

Di halaman taruh penanda:
    <!-- @SIDEBAR -->              menu level (inc/sidebar.html)
    <!-- @SIDEBAR-ADMIN:users -->  menu admin (inc/sidebar-admin.html), tab aktif: users

Aman dijalankan berulang.
"""
import hashlib
import re
import sys
from pathlib import Path

BASE = Path(__file__).resolve().parent.parent
INC = BASE / "inc"

# penanda + (kalau sudah pernah dirakit) blok <aside> di belakangnya
POLA = re.compile(r"<!-- @SIDEBAR(?:-ADMIN:(\w+))? -->[ \t]*\n?(<aside.*?</aside>)?", re.S)

# alamat aset: href/src=".../aset/berkas.css" (tanpa query)
ASET = re.compile(r'((?:href|src)=")((?:\.\./)*aset/[^"?]+)(")')
# query lama yang mau dibuang dulu: ?v=abcd1234
QUERY = re.compile(r"\?v=[0-9a-f]{6,16}")


def isi_menu(berkas: Path, level: str, aktif: str) -> str:
    """Ambil partial, tandai menu yang aktif, buang atribut data-untuk."""
    html = (INC / berkas).read_text(encoding="utf-8").replace("{{LEVEL}}", level)

    def satu(m: re.Match) -> str:
        tag = m.group(0)
        kunci = re.search(r'data-untuk="([^"]+)"', tag).group(1).split()
        if aktif in kunci:
            tag = tag.replace("<a ", '<a class="aktif" ', 1)
        return re.sub(r' data-untuk="[^"]*"', "", tag)

    return re.sub(r'<a [^>]*data-untuk="[^"]*"[^>]*>', satu, html)


def stempel(teks: str, halaman: Path) -> str:
    """Beri ?v=<hash isi berkas> pada setiap alamat aset."""
    teks = QUERY.sub("", teks)          # bersihkan stempel lama

    def ganti(m: re.Match) -> str:
        awalan, alamat, penutup = m.group(1), m.group(2), m.group(3)
        p = (halaman.parent / alamat).resolve()
        if not p.exists():
            return m.group(0)
        v = hashlib.md5(p.read_bytes()).hexdigest()[:8]
        return f"{awalan}{alamat}?v={v}{penutup}"

    return ASET.sub(ganti, teks)


def pwa(teks: str, halaman: Path) -> str:
    """Sisipkan <link rel=manifest>, theme-color, apple-touch-icon (idempoten)."""
    if "manifest.webmanifest" in teks:
        return teks

    naik = "../" if halaman.parent != BASE else ""
    tag = (
        f'<link rel="manifest" href="{naik}manifest.webmanifest">\n'
        f'<meta name="theme-color" content="#b7202e">\n'
        f'<link rel="apple-touch-icon" href="{naik}ikon-192.png">\n'
        '<meta name="apple-mobile-web-app-capable" content="yes">\n'
        '<meta name="apple-mobile-web-app-status-bar-style" content="default">\n'
    )
    if "</head>" in teks:
        return teks.replace("</head>", tag + "</head>", 1)
    return tag + teks


def rakit(berkas: Path) -> bool:
    teks = berkas.read_text(encoding="utf-8")
    baru = teks

    if "@SIDEBAR" in teks:
        def ganti_menu(m: re.Match) -> str:
            if m.group(1) is None:                   # menu level
                penanda = "<!-- @SIDEBAR -->"
                isi = isi_menu(Path("sidebar.html"), "N3", berkas.name)
            else:                                    # menu admin
                tab = m.group(1)
                penanda = f"<!-- @SIDEBAR-ADMIN:{tab} -->"
                isi = isi_menu(Path("sidebar-admin.html"), "N3", tab)
            return penanda + "\n" + isi.rstrip()

        baru = POLA.sub(ganti_menu, teks)
        baru = re.sub(r"(</aside>)\n+", r"\1\n", baru)   # tepat satu baris sesudah aside

    baru = stempel(baru, berkas)
    baru = pwa(baru, berkas)

    if baru != teks:
        berkas.write_text(baru, encoding="utf-8")
        return True
    return False


def main() -> int:
    halaman = [p for p in BASE.rglob("*.html") if INC not in p.parents]
    ubah = [p for p in halaman if rakit(p)]

    # penjaga: jangan sampai ada penanda yang belum terisi
    sisa = [str(p.relative_to(BASE)) for p in halaman
            if re.search(r"<!-- @SIDEBAR[^>]*-->(?!\s*<aside)", p.read_text(encoding="utf-8"))]

    for p in ubah:
        print("dirakit:", p.relative_to(BASE))
    print(f"{len(ubah)} halaman dirakit, {len(halaman)} halaman diperiksa")

    if sisa:
        print("MASIH ADA PENANDA KOSONG:", sisa, file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
