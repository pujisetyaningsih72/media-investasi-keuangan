/* =========================================================
   KONFIGURASI SUPABASE
   Ganti dua nilai di bawah ini dengan milik project Anda.
   Lokasi: Supabase Dashboard -> Project Settings -> API
   - Project URL   -> SUPABASE_URL
   - anon public   -> SUPABASE_ANON_KEY
   ========================================================= */

const SUPABASE_URL = "https://mbxlvvmvewzflivfdrzu.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_xeAsgUDPP5ke9ews-syZ9Q_pr7_3WGP";

/* Kata sandi sederhana untuk membuka halaman "Daftar Nilai" (khusus guru).
   Ganti dengan kata sandi pilihan Anda sendiri.
   CATATAN: ini bukan pengaman tingkat tinggi (kata sandi tetap ada di kode
   halaman), hanya untuk mencegah siswa iseng membuka daftar nilai. */
const GURU_PASSWORD = "guruinves";

// Jangan diubah di bawah ini
const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
