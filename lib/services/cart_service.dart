import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';
import 'config.dart';

class CartItem {
  final String product;
  final String value;
  int count;
  CartItem({required this.product, required this.value, required this.count});

  Map<String, dynamic> toJson() => {
        'product': product,
        'value': value,
        'count': count,
      };

  factory CartItem.fromJson(Map<String, dynamic> j) => CartItem(
        product: j['product']?.toString() ?? '',
        value: j['value']?.toString() ?? '',
        count: int.tryParse('${j['count']}') ?? 1,
      );
}

class CartService {
  CartService._();
  static final CartService instance = CartService._();

  final List<CartItem> items = [];
  static const _localKey = 'farno_cart_local';

  int get totalCount => items.fold(0, (a, b) => a + b.count);

  Future<void> load() async {
    items.clear();
    final user = AuthService.instance.currentUser;
    if (user != null && AppConfig.hasServer) {
      await _loadRemote(user.id, user.token);
    } else {
      await _loadLocal();
    }
  }

  Future<void> _loadLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_localKey);
    if (raw == null) return;
    try {
      final list = jsonDecode(raw) as List;
      items.addAll(list.map((e) => CartItem.fromJson(e as Map<String, dynamic>)));
    } catch (_) {}
  }

  Future<void> _saveLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localKey, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  Map<String, String> _headers(String token) => {
        'apikey': AppConfig.supabaseAnonKey,
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Prefer': 'return=minimal',
      };

  Future<void> _loadRemote(String userId, String token) async {
    try {
      final uri = Uri.parse(
        '${AppConfig.restBase}/cart_items?user_id=eq.$userId&select=product,value,count',
      );
      final res = await http
          .get(uri, headers: {
            'apikey': AppConfig.supabaseAnonKey,
            'Authorization': 'Bearer $token',
          })
          .timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        final list = jsonDecode(res.body) as List;
        items.addAll(list.map((e) => CartItem.fromJson(e as Map<String, dynamic>)));
      }
    } catch (_) {
      await _loadLocal();
    }
  }

  Future<void> _syncRemote() async {
    final user = AuthService.instance.currentUser;
    if (user == null || !AppConfig.hasServer) {
      await _saveLocal();
      return;
    }
    try {
      // delete all then insert
      final del = Uri.parse('${AppConfig.restBase}/cart_items?user_id=eq.${user.id}');
      await http.delete(del, headers: _headers(user.token));
      if (items.isEmpty) return;
      final ins = Uri.parse('${AppConfig.restBase}/cart_items');
      final body = items
          .map((e) => {
                'user_id': user.id,
                'product': e.product,
                'value': e.value,
                'count': e.count,
              })
          .toList();
      await http.post(
        ins,
        headers: {
          ..._headers(user.token),
          'Prefer': 'return=minimal',
        },
        body: jsonEncode(body),
      );
    } catch (_) {
      await _saveLocal();
    }
  }

  Future<String?> add({
    required String product,
    required String value,
    int count = 1,
  }) async {
    if (AuthService.instance.currentUser == null) {
      return 'برای افزودن به سبد، ابتدا وارد حساب شو یا ثبت‌نام کن.';
    }
    final v = value.trim();
    if (v.isEmpty) return 'مقدار / نوع قطعه را وارد کن.';
    final existing = items.where((e) => e.product == product && e.value == v);
    if (existing.isNotEmpty) {
      existing.first.count += count;
    } else {
      items.add(CartItem(product: product, value: v, count: count));
    }
    await _syncRemote();
    return null;
  }

  Future<void> setCount(CartItem item, int count) async {
    if (count <= 0) {
      items.remove(item);
    } else {
      item.count = count;
    }
    await _syncRemote();
  }

  Future<void> clear() async {
    items.clear();
    await _syncRemote();
  }
}
