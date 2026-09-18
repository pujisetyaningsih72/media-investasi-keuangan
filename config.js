/* =========================================================
   KONFIGURASI SUPABASE
   Ganti dua nilai di bawah ini dengan milik project Anda.
   Lokasi: Supabase Dashboard -> Project Settings -> API
   - Project URL   -> SUPABASE_URL
   - anon public   -> SUPABASE_ANON_KEY
   ========================================================= */

const SUPABASE_URL = "https://mbxlvvmvewzflivfdrzu.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_xeAsgUDPP5ke9ews-syZ9Q_pr7_3WGP";

// Jangan diubah di bawah ini
const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
