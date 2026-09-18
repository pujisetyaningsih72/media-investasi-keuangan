/* =========================================================
   KONFIGURASI SUPABASE
   Ganti dua nilai di bawah ini dengan milik project Anda.
   Lokasi: Supabase Dashboard -> Project Settings -> API
   - Project URL   -> SUPABASE_URL
   - anon public   -> SUPABASE_ANON_KEY
   ========================================================= */

const SUPABASE_URL = "GANTI_DENGAN_PROJECT_URL_ANDA";
const SUPABASE_ANON_KEY = "GANTI_DENGAN_ANON_KEY_ANDA";

// Jangan diubah di bawah ini
const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
