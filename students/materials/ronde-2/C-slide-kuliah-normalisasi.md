# Basis Data — Pertemuan 7: Normalisasi

*Universitas Nusantara Jaya · Program Studi Teknik Informatika · Materi kuliah, dipublikasikan di situs program studi (akses publik)*

## Slide 1 — Mengapa normalisasi

- Menghilangkan **redundansi**: data yang sama tersimpan berkali-kali.
- Mencegah **anomali** saat insert, update, dan delete.
- Membuat skema mudah dipahami dan dikembangkan.

## Slide 2 — Bentuk normal pertama (1NF)

- Setiap kolom berisi **nilai atomik** (tidak ada daftar dalam satu sel).
- Tidak ada kolom berulang (`telp1`, `telp2`, `telp3`).
- Setiap baris unik — ada kunci utama.

## Slide 3 — Bentuk normal kedua (2NF)

- Sudah 1NF.
- Setiap kolom non-kunci **bergantung penuh** pada seluruh kunci utama (bukan hanya sebagian kunci gabungan).
- Contoh masalah: `Pesanan(id_pesanan, id_produk, nama_produk, jumlah)` — `nama_produk` hanya bergantung pada `id_produk`.

## Slide 4 — Bentuk normal ketiga (3NF)

- Sudah 2NF.
- Tidak ada **ketergantungan transitif**: kolom non-kunci tidak boleh bergantung pada kolom non-kunci lain.
- Contoh masalah: `Pesanan(id_pesanan, id_pelanggan, nama_pelanggan, kota_pelanggan)` — `kota_pelanggan` bergantung pada `id_pelanggan`, bukan pada `id_pesanan`.

## Slide 5 — Contoh normalisasi

Tabel awal:

| nim | nama_mhs | kode_mk | nama_mk | dosen | nilai |
|---|---|---|---|---|---|
| 2201 | Ayu | IF301 | Basis Data | Pak Rudi | A |
| 2201 | Ayu | IF302 | Jaringan | Bu Sinta | B |
| 2202 | Bima | IF301 | Basis Data | Pak Rudi | B |

Hasil 3NF: `Mahasiswa(nim, nama_mhs)`, `MataKuliah(kode_mk, nama_mk, dosen)`, `Nilai(nim, kode_mk, nilai)`.

## Slide 6 — Latihan

1. Normalkan tabel `Peminjaman(id_pinjam, nim, nama_mhs, kode_buku, judul_buku, tgl_pinjam)` sampai 3NF.
2. Sebutkan anomali yang terjadi kalau tabel itu dibiarkan tanpa normalisasi.
3. Kapan denormalisasi justru dibenarkan? Beri satu contoh.
