/* =========================================================
   KONFIGURASI SUPABASE
   Ganti dua nilai di bawah ini dengan milik project Anda.
   Lokasi: Supabase Dashboard -> Project Settings -> API
   - Project URL   -> SUPABASE_URL
   - anon public   -> SUPABASE_ANON_KEY
   ========================================================= */

const SUPABASE_URL = "GANTI_DENGAN_PROJECT_URL_ANDA";
const SUPABASE_ANON_KEY = "GANTI_DENGAN_ANON_KEY_ANDA";

/* Kata sandi sederhana untuk membuka halaman "Daftar Nilai" (khusus guru).
   Ganti dengan kata sandi pilihan Anda sendiri.
   CATATAN: ini bukan pengaman tingkat tinggi (kata sandi tetap ada di kode
   halaman), hanya untuk mencegah siswa iseng membuka daftar nilai. */
const GURU_PASSWORD = "guru123";

// Jangan diubah di bawah ini
const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
