# Panduan Setup — Media Pembelajaran Interaktif "Jenis Instrumen Investasi"

Media ini terdiri dari 5 file:
- `index.html` — struktur halaman (Beranda, Teori, LKPD, Quiz, Evaluasi)
- `style.css` — tampilan
- `app.js` — seluruh logika interaktif
- `config.js` — tempat memasukkan kunci Supabase Anda
- `schema.sql` — perintah untuk membuat database di Supabase

Ikuti langkah berikut secara berurutan.

## Langkah 1 — Buat akun & project Supabase

1. Buka https://supabase.com lalu **Sign Up** (bisa pakai akun Google).
2. Setelah masuk ke dashboard, klik **New Project**.
3. Isi:
   - **Name**: misalnya `media-instrumen-investasi`
   - **Database Password**: buat password lalu simpan baik-baik
   - **Region**: pilih yang terdekat, misalnya Singapore
4. Klik **Create new project** dan tunggu 1–2 menit sampai project siap.

## Langkah 2 — Buat tabel database

1. Di sidebar kiri dashboard Supabase, klik **SQL Editor**.
2. Klik **New query**.
3. Buka file `schema.sql` yang sudah disediakan, salin **seluruh isinya**, lalu tempel ke SQL Editor.
4. Klik **Run** (atau tekan Ctrl/Cmd + Enter).
5. Jika berhasil akan muncul "Success. No rows returned". Cek di menu **Table Editor** — harus muncul 3 tabel: `lkpd_submissions`, `evaluasi_hasil`, `quiz_progress`.

> **Catatan bila project Supabase sudah dibuat sebelumnya:** kalau tabel `evaluasi_hasil` sudah lebih dulu ada (dari versi sebelum ada soal pilihan ganda kompleks), Anda tidak perlu menghapusnya. Cukup jalankan satu baris ini saja di SQL Editor untuk menambah kolom baru tanpa menghapus data lama:
> ```sql
> alter table public.evaluasi_hasil add column if not exists jawaban_pgk jsonb not null default '{}';
> ```

## Langkah 3 — Ambil URL dan Anon Key project Anda

1. Di sidebar, klik ikon gerigi **Project Settings** → **API**.
2. Salin nilai **Project URL** (contoh: `https://xxxxx.supabase.co`).
3. Salin nilai **anon public** di bagian **Project API keys**.

## Langkah 4 — Masukkan kunci ke `config.js`

Buka file `config.js` dengan text editor (Notepad, VS Code, dll), lalu ganti:

```js
const SUPABASE_URL = "GANTI_DENGAN_PROJECT_URL_ANDA";
const SUPABASE_ANON_KEY = "GANTI_DENGAN_ANON_KEY_ANDA";
```

menjadi milik Anda sendiri, misalnya:

```js
const SUPABASE_URL = "https://xxxxx.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9....";
```

Simpan file.

## Langkah 5 — Coba jalankan di komputer Anda

Cara termudah: buka folder ini di **VS Code**, install ekstensi **Live Server**, klik kanan `index.html` → **Open with Live Server**. Browser akan terbuka dan Anda bisa mencoba seluruh menu (Beranda, Teori, LKPD, Quiz, Evaluasi).

Alternatif tanpa VS Code: klik dua kali file `index.html` untuk membukanya langsung di browser (sebagian besar fitur akan berjalan; jika ada kendala pengiriman data, gunakan cara hosting di Langkah 6).

## Langkah 6 — Publikasikan agar bisa diakses siswa (pilih salah satu)

**Opsi A — Netlify Drop (paling mudah, tanpa akun wajib)**
1. Buka https://app.netlify.com/drop
2. Seret (drag) seluruh folder berisi 5 file di atas ke halaman tersebut.
3. Tunggu proses upload selesai — Anda akan mendapat link publik, misalnya `https://nama-acak.netlify.app`.
4. Bagikan link tersebut ke siswa.

**Opsi B — GitHub Pages**
1. Buat repository baru di GitHub, unggah kelima file tersebut.
2. Masuk ke **Settings → Pages**, pilih branch `main` dan folder `/root`, simpan.
3. Tunggu beberapa menit, link akan muncul di halaman yang sama.

## Langkah 7 — Uji coba alur lengkap

1. Buka link yang sudah dipublikasikan.
2. Coba isi salah satu LKPD, klik **Simpan sebagai PDF** (pastikan file PDF benar-benar terunduh), lalu klik **Kirim ke Guru**.
3. Buka dashboard Supabase → **Table Editor** → tabel `lkpd_submissions`, pastikan data yang tadi dikirim muncul di sana.
4. Coba kerjakan **Evaluasi** sampai selesai, lalu cek tabel `evaluasi_hasil` — pastikan datanya tersimpan dan skor sesuai.
5. Coba buka Evaluasi lagi dengan nama & kelas yang sama — sistem akan menolak dan memberi tahu bahwa evaluasi sudah pernah dikerjakan.

## Melihat & menilai hasil siswa (untuk guru)

Cara paling sederhana: buka Supabase → **Table Editor**:
- `lkpd_submissions` → hasil LKPD tiap aktivitas, per siswa.
- `evaluasi_hasil` → skor pilihan ganda otomatis + jawaban esai (kolom `jawaban_essai`) untuk dinilai manual.

Jika ingin tampilan rekap yang lebih rapi (misalnya diexport ke Excel), gunakan menu **Table Editor → Export** di Supabase, atau minta bantuan untuk dibuatkan halaman rekap tambahan.

## Melihat Daftar Nilai

Menu **Daftar Nilai** di sidebar sekarang dikunci dengan **kata sandi sederhana** khusus guru. Saat pertama kali menu ini diklik, akan muncul kotak permintaan kata sandi.

- Kata sandi diatur di file `config.js`, variabel `GURU_PASSWORD` (bawaan: `guru123`). **Ganti ini dengan kata sandi pilihan Anda sendiri** sebelum dibagikan ke siswa.
- Setelah kata sandi benar dimasukkan sekali, halaman Daftar Nilai akan tetap terbuka selama tab browser itu belum ditutup (tersimpan sementara di sesi browser). Kalau tab ditutup atau dibuka dari perangkat/browser lain, kata sandi perlu dimasukkan lagi.
- **Catatan keamanan:** ini adalah pengunci sederhana untuk mencegah siswa iseng membuka, bukan pengaman tingkat tinggi — kata sandinya tetap tersimpan di dalam kode halaman (`config.js`), sehingga siswa yang cukup paham teknis bisa saja menemukannya lewat "View Page Source". Jangan gunakan kata sandi yang sama dengan akun penting lainnya.

Menu ini menampilkan rekap seluruh skor evaluasi siswa (nama, kelas, jumlah benar, skor objektif, waktu mengerjakan), diambil langsung dari tabel `evaluasi_hasil` di Supabase, dan bisa difilter per kelas.

## Mengganti / menambah soal

- Evaluasi sekarang berisi **20 soal**: 10 pilihan ganda biasa (`MC_QUESTIONS`), 5 pilihan ganda kompleks/boleh pilih lebih dari satu jawaban (`PGK_QUESTIONS`), dan 5 esai (`ESSAY_QUESTIONS`) — semuanya ada di `app.js`.
- Untuk soal PGK, isi `correct` dengan array indeks jawaban benar, contoh `correct: [0,2,4]` berarti opsi A, C, dan E semuanya benar. Siswa dinilai benar hanya jika mencentang tepat opsi-opsi itu (tidak kurang, tidak lebih).
- Skor otomatis dihitung dari total 15 soal objektif (10 PG + 5 PGK); soal esai tidak ikut dihitung otomatis dan tetap diperiksa manual oleh guru lewat kolom `jawaban_essai` di tabel `evaluasi_hasil`.
- Kata untuk permainan Cari Kata ada di `app.js`, variabel `WORDS` di dalam fungsi `wordSearchQuiz`.
- Item permainan Drag & Drop ada di `app.js`, variabel `ITEMS` di dalam fungsi `dragDropQuiz`.
- Materi teori ada langsung di `index.html`, pada bagian `<section id="teori">`.

## Catatan keamanan

Karena media ini dipakai tanpa proses login siswa, kunci **anon key** Supabase memang ditulis langsung di `config.js` — ini wajar untuk aplikasi publik semacam ini, tetapi jangan pernah menaruh **service role key** (kunci rahasia penuh) di file front-end. Kebijakan Row Level Security pada `schema.sql` sudah membatasi agar anon key hanya bisa **insert** dan **select** pada tiga tabel yang disediakan.
