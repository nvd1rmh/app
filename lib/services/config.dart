/// تنظیمات Supabase + پروکسی کلادفلر برای سفارش تلگرام
class AppConfig {
  static const String supabaseUrl = 'https://disnuzorcjfaultoqhkz.supabase.co';

  static const String supabaseAnonKey =
      'sb_publishable_5K3PhdR1lRRSFdTfU9ZqTw_kyHc8Eua';

  /// Worker کلادفلر — پروکسی سفارش به pythonanywhere
  static const String orderProxyUrl =
      'https://workers-playground-odd-bread-2b8d.navidrameh1.workers.dev';

  static bool get hasServer {
    final u = supabaseUrl.trim();
    final k = supabaseAnonKey.trim();
    return u.startsWith('https://') && k.isNotEmpty && !k.contains('YOUR_');
  }

  static bool get hasOrderProxy {
    final u = orderProxyUrl.trim();
    return u.startsWith('https://') && u.contains('workers.dev');
  }

  static String get authBase => '${supabaseUrl.trim()}/auth/v1';
  static String get restBase => '${supabaseUrl.trim()}/rest/v1';
}
