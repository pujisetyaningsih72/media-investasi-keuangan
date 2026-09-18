-- =========================================================
-- SKEMA DATABASE SUPABASE
-- Media Pembelajaran Interaktif: Jenis Instrumen Investasi
-- Konsentrasi Keahlian Akuntansi dan Keuangan Lembaga
-- Penyusun: Puji Setyaningsih, SMKN 1 Purwodadi
-- =========================================================
-- CARA PAKAI:
-- 1. Buka project Supabase Anda -> menu "SQL Editor"
-- 2. Klik "New query", tempel seluruh isi file ini
-- 3. Klik "Run"
-- =========================================================

-- Ekstensi untuk membuat id otomatis (uuid)
create extension if not exists "pgcrypto";

-- ---------------------------------------------------------
-- 1. TABEL: lkpd_submissions
-- Menyimpan hasil pengerjaan LKPD yang dikirim siswa
-- ---------------------------------------------------------
create table if not exists public.lkpd_submissions (
  id uuid primary key default gen_random_uuid(),
  nama_siswa text not null,
  kelas text not null,
  aktivitas text not null,          -- contoh: 'Aktivitas 1: Mengenal Instrumen Pasar Uang'
  jawaban jsonb not null,           -- semua jawaban dalam bentuk JSON
  dikirim_pada timestamptz not null default now()
);

comment on table public.lkpd_submissions is 'Hasil LKPD yang dikirim siswa ke guru';

-- ---------------------------------------------------------
-- 2. TABEL: evaluasi_hasil
-- Menyimpan hasil evaluasi akhir siswa (1 siswa = 1 baris)
-- ---------------------------------------------------------
create table if not exists public.evaluasi_hasil (
  id uuid primary key default gen_random_uuid(),
  nama_siswa text not null,
  kelas text not null,
  jawaban_pilihan_ganda jsonb not null,        -- soal no. 1-10, { "1": "A", "2": "C", ... }
  jawaban_pgk jsonb not null default '{}',     -- soal no. 11-15 (pilihan ganda kompleks), { "11": ["A","C"], ... }
  jawaban_essai jsonb not null,                -- soal no. 16-20, { "16": "jawaban...", ... }
  skor_pilihan_ganda numeric not null,         -- skor otomatis gabungan 15 soal objektif (skala 0-100)
  jumlah_benar integer not null,
  dikerjakan_pada timestamptz not null default now(),
  unique (nama_siswa, kelas)
);

comment on table public.evaluasi_hasil is 'Hasil evaluasi akhir siswa (20 soal: 10 PG + 5 PGK + 5 esai). Kombinasi nama+kelas unik agar siswa tidak bisa mengulang.';

-- ---------------------------------------------------------
-- MIGRASI: jalankan baris ini SAJA jika tabel evaluasi_hasil
-- sudah pernah dibuat sebelumnya (sebelum ada soal PGK), agar
-- tidak perlu drop tabel dan kehilangan data lama.
-- ---------------------------------------------------------
alter table public.evaluasi_hasil add column if not exists jawaban_pgk jsonb not null default '{}';

-- ---------------------------------------------------------
-- 3. TABEL: quiz_progress (opsional - rekap permainan quiz)
-- ---------------------------------------------------------
create table if not exists public.quiz_progress (
  id uuid primary key default gen_random_uuid(),
  nama_siswa text not null,
  kelas text not null,
  jenis_quiz text not null,        -- 'drag_drop' atau 'word_search'
  skor integer not null,
  waktu_detik integer,
  diselesaikan_pada timestamptz not null default now()
);

comment on table public.quiz_progress is 'Rekap permainan quiz (drag & drop dan cari kata)';

-- ---------------------------------------------------------
-- KEAMANAN (Row Level Security)
-- Aplikasi ini dipakai tanpa login siswa (anonim), jadi kita
-- izinkan siapa saja mengirim (insert) dan membaca data
-- seperlunya lewat anon key. Untuk kelas nyata, anon key
-- HANYA boleh dipakai di sisi front-end (bukan rahasia penuh),
-- jadi jangan simpan data sensitif di sini.
-- ---------------------------------------------------------
alter table public.lkpd_submissions enable row level security;
alter table public.evaluasi_hasil enable row level security;
alter table public.quiz_progress enable row level security;

-- LKPD: siapa saja boleh kirim & lihat hasilnya
create policy "lkpd_insert_public" on public.lkpd_submissions
  for insert to anon with check (true);
create policy "lkpd_select_public" on public.lkpd_submissions
  for select to anon using (true);

-- Evaluasi: siapa saja boleh kirim & lihat (untuk cek "sudah pernah mengerjakan")
create policy "evaluasi_insert_public" on public.evaluasi_hasil
  for insert to anon with check (true);
create policy "evaluasi_select_public" on public.evaluasi_hasil
  for select to anon using (true);

-- Quiz progress: siapa saja boleh kirim & lihat
create policy "quiz_insert_public" on public.quiz_progress
  for insert to anon with check (true);
create policy "quiz_select_public" on public.quiz_progress
  for select to anon using (true);

-- Selesai. Setelah ini, buka Table Editor untuk memastikan
-- 3 tabel (lkpd_submissions, evaluasi_hasil, quiz_progress) sudah muncul.
