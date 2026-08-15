import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import 'cart_service.dart';
import 'config.dart';

class OrderRecord {
  final String id;
  final String orderCode;
  final String status;
  final List<CartItem> items;
  final String name;
  final String phone;
  final String address;
  final DateTime createdAt;

  OrderRecord({
    required this.id,
    required this.orderCode,
    required this.status,
    required this.items,
    required this.name,
    required this.phone,
    required this.address,
    required this.createdAt,
  });

  static const statusLabels = {
    'pending': '⏳ در حال بررسی',
    'confirmed': '✅ تأیید / آماده‌سازی',
    'shipped': '🚚 ارسال شد',
    'delivered': '📦 تحویل شد',
    'cancelled': '❌ لغو شد',
  };

  String get statusLabel => statusLabels[status] ?? status;
}

class OrderService {
  OrderService._();
  static final OrderService instance = OrderService._();

  /// اول از دامنه Supabase (معمولاً در ایران بازتر) بعد Worker کلادفلر
  List<String> get _notifyUrls {
    final list = <String>[
      '${AppConfig.supabaseUrl}/functions/v1/telegram-order',
    ];
    final cf = AppConfig.orderProxyUrl.trim().replaceAll(RegExp(r'/$'), '');
    if (cf.startsWith('https://')) list.add(cf);
    return list;
  }

  Future<List<OrderRecord>> fetchHistory() async {
    final user = AuthService.instance.currentUser;
    if (user == null || !AppConfig.hasServer) return [];
    try {
      final uri = Uri.parse(
        '${AppConfig.restBase}/orders?user_id=eq.${user.id}&select=*&order=created_at.desc',
      );
      final res = await http.get(uri, headers: {
        'apikey': AppConfig.supabaseAnonKey,
        'Authorization': 'Bearer ${user.token}',
      }).timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) return [];
      final list = jsonDecode(res.body) as List;
      return list.map((e) {
        final m = e as Map<String, dynamic>;
        final rawItems = m['items'] is String
            ? jsonDecode(m['items'] as String)
            : m['items'];
        final items = (rawItems as List? ?? [])
            .map((x) => CartItem.fromJson(Map<String, dynamic>.from(x as Map)))
            .toList();
        return OrderRecord(
          id: m['id']?.toString() ?? '',
          orderCode: m['order_code']?.toString() ?? '',
          status: m['status']?.toString() ?? 'pending',
          items: items,
          name: m['name']?.toString() ?? '',
          phone: m['phone']?.toString() ?? '',
          address: m['address']?.toString() ?? '',
          createdAt: DateTime.tryParse(m['created_at']?.toString() ?? '') ??
              DateTime.now(),
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }

  Future<bool> _notifyTelegram(Map<String, dynamic> payload) async {
    final body = jsonEncode(payload);
    for (final url in _notifyUrls) {
      try {
        final res = await http
            .post(
              Uri.parse(url),
              headers: {
                'Content-Type': 'application/json',
                'apikey': AppConfig.supabaseAnonKey,
                'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
              },
              body: body,
            )
            .timeout(const Duration(seconds: 25));
        if (res.statusCode >= 200 && res.statusCode < 300) {
          return true;
        }
      } catch (_) {
        // URL بعدی را امتحان کن
      }
    }
    return false;
  }

  Future<String?> checkout() async {
    final user = AuthService.instance.currentUser;
    if (user == null) return 'ابتدا وارد حساب شو.';
    if (CartService.instance.items.isEmpty) return 'سبد خرید خالی است.';

    final code =
        'FY${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
    final itemsJson = CartService.instance.items.map((e) => e.toJson()).toList();

    final payload = {
      'name': user.name,
      'phone': user.phone,
      'note':
          '📱 سفارش از اپلیکیشن فرنو یار\n🔢 کد: $code\n📍 آدرس: ${user.address}',
      'items': itemsJson,
      'tg_user': {'id': user.id, 'username': user.phone},
    };

    // 1) ذخیره در Supabase (اصلی)
    if (AppConfig.hasServer) {
      try {
        final uri = Uri.parse('${AppConfig.restBase}/orders');
        final res = await http
            .post(
              uri,
              headers: {
                'apikey': AppConfig.supabaseAnonKey,
                'Authorization': 'Bearer ${user.token}',
                'Content-Type': 'application/json',
                'Prefer': 'return=minimal',
              },
              body: jsonEncode({
                'user_id': user.id,
                'order_code': code,
                'status': 'pending',
                'items': itemsJson,
                'name': user.name,
                'phone': user.phone,
                'address': user.address,
              }),
            )
            .timeout(const Duration(seconds: 20));
        if (res.statusCode >= 400) {
          return 'ثبت سفارش در سرور ناموفق بود (${res.statusCode}). جداول SQL را چک کن.';
        }
      } catch (_) {
        return 'اتصال به Supabase برای ثبت سفارش برقرار نشد.';
      }
    }

    // 2) اطلاع به تلگرام (اگر نشد، سفارش باز هم ثبت شده)
    final notified = await _notifyTelegram(payload);
    await CartService.instance.clear();

    if (!notified) {
      return 'ORDER_SAVED_NO_TELEGRAM';
    }
    return null;
  }
}
