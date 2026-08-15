import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../services/config.dart';
import '../theme.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';

class AccountScreen extends StatefulWidget {
  final VoidCallback onChanged;
  const AccountScreen({super.key, required this.onChanged});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _pass = TextEditingController();
  bool _busy = false;
  bool _obscure = true;
  String? _msg;

  @override
  void initState() {
    super.initState();
    final u = AuthService.instance.currentUser;
    if (u != null) {
      _name.text = u.name;
      _phone.text = u.phone;
      _address.text = u.address;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _pass.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final u = AuthService.instance.currentUser;
    if (u == null) return;
    setState(() {
      _busy = true;
      _msg = null;
    });
    try {
      final uri = Uri.parse('${AppConfig.authBase}/user');
      final body = <String, dynamic>{
        'data': {
          'name': _name.text.trim(),
          'phone': AuthService.normalizePhone(_phone.text.trim()),
          'address': _address.text.trim(),
        },
      };
      if (_pass.text.trim().length >= 6) {
        body['password'] = _pass.text.trim();
      }
      final res = await http
          .put(
            uri,
            headers: {
              'apikey': AppConfig.supabaseAnonKey,
              'Authorization': 'Bearer ${u.token}',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 20));

      if (res.statusCode == 200) {
        final j = jsonDecode(res.body) as Map<String, dynamic>;
        final meta = (j['user_metadata'] as Map<String, dynamic>?) ?? {};
        final updated = UserProfile(
          id: u.id,
          name: meta['name']?.toString() ?? _name.text.trim(),
          phone: meta['phone']?.toString() ??
              AuthService.normalizePhone(_phone.text.trim()),
          address: meta['address']?.toString() ?? _address.text.trim(),
          token: u.token,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('farno_user_v2', jsonEncode(updated.toJson()));
        await AuthService.instance.loadSession();
        setState(() => _msg = 'اطلاعات با موفقیت ذخیره شد');
        widget.onChanged();
      } else {
        setState(() => _msg = 'خطا در ذخیره (${res.statusCode})');
      }
    } catch (_) {
      setState(() => _msg = 'اتصال به سرور برقرار نشد');
    }
    setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;

    if (user == null) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
        children: [
          Text('حساب کاربری',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w900, color: context.cText)),
          const SizedBox(height: 12),
          Text('برای مدیریت حساب وارد شو یا ثبت‌نام کن.',
              style: TextStyle(color: context.cMuted)),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () async {
              await Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              widget.onChanged();
              setState(() {});
            },
            style: FilledButton.styleFrom(
                backgroundColor: AppColors.cyan,
                minimumSize: const Size.fromHeight(48)),
            child: const Text('ورود', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()));
              widget.onChanged();
              setState(() {});
            },
            child: const Text('ثبت‌نام'),
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      children: [
        Text('حساب من',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w900, color: context.cText)),
        const SizedBox(height: 14),
        TextField(
          controller: _name,
          decoration: const InputDecoration(
            labelText: 'نام و نام خانوادگی',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _phone,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          decoration: const InputDecoration(
            labelText: 'شماره موبایل',
            prefixIcon: Icon(Icons.phone_android),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _address,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'آدرس',
            prefixIcon: Icon(Icons.location_on_outlined),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _pass,
          obscureText: _obscure,
          decoration: InputDecoration(
            labelText: 'رمز عبور جدید (اختیاری)',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
        ),
        if (_msg != null) ...[
          const SizedBox(height: 12),
          Text(_msg!, style: const TextStyle(color: AppColors.green, fontWeight: FontWeight.w700)),
        ],
        const SizedBox(height: 18),
        FilledButton(
          onPressed: _busy ? null : _save,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.orange,
            minimumSize: const Size.fromHeight(48),
          ),
          child: Text(_busy ? '...' : 'ذخیره تغییرات',
              style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () async {
            await AuthService.instance.logout();
            await CartService.instance.load();
            widget.onChanged();
            setState(() {});
          },
          icon: const Icon(Icons.logout),
          label: const Text('خروج از حساب'),
        ),
      ],
    );
  }
}
