class SupabaseConfig {
  /// 🛑 PASTE YOUR SUPABASE DETAILS HERE 🛑
  /// 1. Go to your Supabase Project Dashboard -> Settings -> API
  /// 2. Copy the "Project URL" into [url]
  /// 3. Copy the "anon" public key into [anonKey]
  
  static const String url = 'https://cejcovxjzmxcijzzpctz.supabase.co';
  
  static const String anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNlamNvdnhqem14Y2lqenpwY3R6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQwMjYwNDgsImV4cCI6MjA4OTYwMjA0OH0.vogLREw_tcxi8Li-uX-2PwKlgal2FF2Fcg9jUwMMv7c';

  /// Helper to check if the user has configured the keys
  static bool get isConfigured => url != 'YOUR_SUPABASE_URL' && anonKey != 'YOUR_SUPABASE_ANON_KEY';
}
