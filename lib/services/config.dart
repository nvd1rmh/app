/// تنظیمات Supabase — پروژه farno
class AppConfig {
  static const String supabaseUrl = 'https://disnuzorcjfaultoqhkz.supabase.co';

  /// Publishable / anon key
  static const String supabaseAnonKey =
      'sb_publishable_5K3PhdR1lRRSFdTfU9ZqTw_kyHc8Eua';

  static bool get hasServer {
    final u = supabaseUrl.trim();
    final k = supabaseAnonKey.trim();
    return u.startsWith('https://') && k.isNotEmpty && !k.contains('YOUR_');
  }

  static String get authBase => '${supabaseUrl.trim()}/auth/v1';
  static String get restBase => '${supabaseUrl.trim()}/rest/v1';
}
