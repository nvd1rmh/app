import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';

class UserProfile {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String token;

  UserProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'address': address,
        'token': token,
      };

  factory UserProfile.fromJson(Map<String, dynamic> j) => UserProfile(
        id: j['id']?.toString() ?? '',
        name: j['name']?.toString() ?? '',
        phone: j['phone']?.toString() ?? '',
        address: j['address']?.toString() ?? '',
        token: j['token']?.toString() ?? '',
      );
}

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  UserProfile? currentUser;
  static const _prefsKey = 'farno_user_v2';

  Map<String, String> get _anonHeaders => {
        'apikey': AppConfig.supabaseAnonKey,
        'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
        'Content-Type': 'application/json',
      };

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null) {
      currentUser = null;
      return;
    }
    try {
      currentUser =
          UserProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      currentUser = null;
    }
  }

  Future<void> _save(UserProfile? u) async {
    currentUser = u;
    final prefs = await SharedPreferences.getInstance();
    if (u == null) {
      await prefs.remove(_prefsKey);
    } else {
      await prefs.setString(_prefsKey, jsonEncode(u.toJson()));
    }
  }

  Future<void> logout() => _save(null);

  /// شماره ایران → ایمیل مصنوعی برای Supabase Auth (بدون SMS)
  static String phoneToEmail(String phone) {
    final p = normalizePhone(phone);
    return '$p@farno.users';
  }

  static String normalizePhone(String phone) {
    var p = phone.replaceAll(RegExp(r'[\s\-]'), '');
    if (p.startsWith('+98')) p = '0${p.substring(3)}';
    if (p.startsWith('98') && p.length >= 12) p = '0${p.substring(2)}';
    return p;
  }

  Future<String?> register({
    required String name,
    required String phone,
    required String password,
    required String address,
  }) async {
    if (!AppConfig.hasServer) {
      return 'Supabase تنظیم نشده. URL و anon key را در config.dart بگذار.';
    }
    final ph = normalizePhone(phone);
    if (ph.length < 10) return 'شماره موبایل نامعتبر است';
    if (password.length < 6) return 'رمز عبور حداقل ۶ کاراکتر باشد';
    if (name.trim().isEmpty) return 'نام را وارد کن';

    final email = phoneToEmail(ph);
    final uri = Uri.parse('${AppConfig.authBase}/signup');

    try {
      final res = await http
          .post(
            uri,
            headers: _anonHeaders,
            body: jsonEncode({
              'email': email,
              'password': password,
              'data': {
                'name': name.trim(),
                'phone': ph,
                'address': address.trim(),
              },
            }),
          )
          .timeout(const Duration(seconds: 25));

      final body = _tryJson(res.body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        // اگر session برگشت، ذخیره کن؛ وگرنه لاگین کن
        final access = body?['access_token']?.toString();
        final user = body?['user'] as Map<String, dynamic>?;
        if (access != null && access.isNotEmpty && user != null) {
          await _save(_fromSupabaseUser(user, access, ph, name, address));
          return null;
        }
        return await login(phone: ph, password: password);
      }

      final msg = (body?['msg'] ?? body?['error_description'] ?? body?['message'] ?? '')
          .toString()
          .toLowerCase();
      if (res.statusCode == 400 || res.statusCode == 422) {
        if (msg.contains('already') ||
            msg.contains('registered') ||
            msg.contains('exists') ||
            msg.contains('user_already')) {
          return 'این شماره قبلاً ثبت‌نام کرده. از ورود استفاده کن.';
        }
        return body?['msg']?.toString() ??
            body?['error_description']?.toString() ??
            'خطا در ثبت‌نام';
      }
      return 'خطای سرور (${res.statusCode})';
    } catch (e) {
      return 'اتصال به Supabase برقرار نشد. اینترنت را بررسی کن.';
    }
  }

  Future<String?> login({
    required String phone,
    required String password,
  }) async {
    if (!AppConfig.hasServer) {
      return 'Supabase تنظیم نشده. URL و anon key را در config.dart بگذار.';
    }
    final ph = normalizePhone(phone);
    final email = phoneToEmail(ph);
    final uri = Uri.parse('${AppConfig.authBase}/token?grant_type=password');

    try {
      final res = await http
          .post(
            uri,
            headers: _anonHeaders,
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 25));

      final body = _tryJson(res.body);
      if (res.statusCode == 200 && body != null) {
        final access = body['access_token']?.toString() ?? '';
        final user = body['user'] as Map<String, dynamic>? ?? {};
        final meta = user['user_metadata'] as Map<String, dynamic>? ?? {};
        await _save(UserProfile(
          id: user['id']?.toString() ?? '',
          name: meta['name']?.toString() ?? '',
          phone: meta['phone']?.toString() ?? ph,
          address: meta['address']?.toString() ?? '',
          token: access,
        ));
        return null;
      }

      if (res.statusCode == 400 || res.statusCode == 401) {
        return 'شماره یا رمز عبور اشتباه است';
      }
      return 'خطای سرور (${res.statusCode})';
    } catch (_) {
      return 'اتصال به Supabase برقرار نشد. اینترنت را بررسی کن.';
    }
  }

  UserProfile _fromSupabaseUser(
    Map<String, dynamic> user,
    String token,
    String phone,
    String name,
    String address,
  ) {
    final meta = user['user_metadata'] as Map<String, dynamic>? ?? {};
    return UserProfile(
      id: user['id']?.toString() ?? '',
      name: meta['name']?.toString() ?? name,
      phone: meta['phone']?.toString() ?? phone,
      address: meta['address']?.toString() ?? address,
      token: token,
    );
  }

  Map<String, dynamic>? _tryJson(String s) {
    try {
      return jsonDecode(s) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
