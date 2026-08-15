import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/products_data.dart';
import 'config.dart';

class ProductsService {
  ProductsService._();
  static final ProductsService instance = ProductsService._();

  List<ProductInfo> _items = List.from(allProducts);
  List<ProductInfo> get items => _items;

  /// از سرور بخوان؛ اگر نبود همان لیست محلی
  Future<void> load() async {
    if (!AppConfig.hasServer) {
      _items = List.from(allProducts);
      return;
    }
    try {
      final uri = Uri.parse(
        '${AppConfig.restBase}/products?select=*&active=eq.true&order=sort_order.asc,name.asc',
      );
      final res = await http.get(uri, headers: {
        'apikey': AppConfig.supabaseAnonKey,
        'Authorization': 'Bearer ${AppConfig.supabaseAnonKey}',
      }).timeout(const Duration(seconds: 12));
      if (res.statusCode != 200) {
        _items = List.from(allProducts);
        return;
      }
      final list = jsonDecode(res.body) as List;
      if (list.isEmpty) {
        _items = List.from(allProducts);
        return;
      }
      _items = list.map((e) {
        final m = e as Map<String, dynamic>;
        final name = m['name']?.toString() ?? '';
        final local = productsCatalog[name];
        return ProductInfo(
          id: m['id']?.toString() ?? name,
          name: name,
          prompt: m['prompt']?.toString() ?? local?.prompt ?? 'مقدار/نوع را وارد کنید',
          exampleCount: m['example_count']?.toString() ?? local?.exampleCount ?? '',
          imageFile: m['image_file']?.toString() ?? local?.imageFile ?? 'placeholder.jpg',
          price: m['price']?.toString(),
        );
      }).toList();
    } catch (_) {
      _items = List.from(allProducts);
    }
  }
}
