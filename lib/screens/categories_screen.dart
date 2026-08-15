import 'package:flutter/material.dart';
import '../data/products_data.dart';
import '../data/part_images.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../theme.dart';
import 'auth/login_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final VoidCallback onNeedAuth;
  const CategoriesScreen({super.key, required this.onNeedAuth});

  static const _meta = {
    'مقاومت': ('🎨', Color(0xFF00C2FF)),
    'خازن': ('🔵', Color(0xFF4F8CFF)),
    'سلف': ('🌀', Color(0xFF7C5CFF)),
    'دیود': ('🔶', Color(0xFFFF9F43)),
    'IC و نیمه‌هادی': ('🔧', Color(0xFF2ED573)),
    'نمایشگر': ('💡', Color(0xFFFFD32A)),
    'فرکانس و حفاظتی': ('📶', Color(0xFF1E90FF)),
    'کلید و اتصال': ('🔌', Color(0xFFFF6B81)),
    'برد و لحیم': ('🛠️', Color(0xFFA4B0BE)),
  };

  @override
  Widget build(BuildContext context) {
    final keys = categoryGroups.keys.toList();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              'دسته‌بندی قطعات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: context.cText),
            ),
          ),
        ),
                SliverPadding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 100),
          sliver:           SliverGrid(
            gridDelegate: const             SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.92,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final g = keys[i];
                final meta = _meta[g] ?? ('📦', AppColors.cyan);
                final color = meta.$2;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryProductsScreen(
                            group: g,
                            onNeedAuth: onNeedAuth,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color.withOpacity(0.22),
                            context.cCard,
                          ],
                        ),
                        border: Border.all(color: color.withOpacity(0.45), width: 1.3),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.18),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                              child: PartImages.forCategory(g) != null
                                  ? Image.asset(
                                      PartImages.forCategory(g)!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Center(
                                        child: Text(meta.$1, style: const TextStyle(fontSize: 36)),
                                      ),
                                    )
                                  : Center(
                                      child: Text(meta.$1, style: const TextStyle(fontSize: 36)),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                            child: Column(
                              children: [
                                Text(
                                  g,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13,
                                    color: context.cText,
                                  ),
                                ),
                                Text(
                                  '${categoryGroups[g]!.length} قطعه',
                                  style: TextStyle(fontSize: 10.5, color: context.cMuted),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: keys.length,
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryProductsScreen extends StatelessWidget {
  final String group;
  final VoidCallback onNeedAuth;
  const CategoryProductsScreen({super.key, required this.group, required this.onNeedAuth});

  @override
  Widget build(BuildContext context) {
    final list = categoryGroups[group] ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(group),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.95,
        ),
        itemCount: list.length,
        itemBuilder: (context, i) {
          final name = list[i];
          final info = productsCatalog[name];
          return Material(
            color: context.cCard,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductOrderScreen(
                      productName: name,
                      onNeedAuth: onNeedAuth,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cyan.withOpacity(0.25)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image.asset(
                        PartImages.forProduct(name) ?? 'assets/parts/cat_resistor.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const ColoredBox(
                          color: Color(0xFF1A2233),
                          child: Icon(Icons.memory, color: AppColors.cyan),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                            const Spacer(),
                            Text(info?.exampleCount ?? '',
                                style: TextStyle(fontSize: 10, color: context.cMuted)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductOrderScreen extends StatefulWidget {
  final String productName;
  final VoidCallback onNeedAuth;
  const ProductOrderScreen({super.key, required this.productName, required this.onNeedAuth});
  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
  final _value = TextEditingController();
  int _qty = 1;
  bool _busy = false;

  @override
  void dispose() {
    _value.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    if (AuthService.instance.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('برای افزودن به سبد ابتدا ثبت‌نام یا ورود کن')));
      await Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      widget.onNeedAuth();
      return;
    }
    setState(() => _busy = true);
    final err = await CartService.instance.add(
      product: widget.productName,
      value: _value.text.trim(),
      count: _qty,
    );
    setState(() => _busy = false);
    if (!mounted) return;
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('به سبد اضافه شد'), backgroundColor: AppColors.green));
      widget.onNeedAuth();
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = productsCatalog[widget.productName];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(colors: [
                AppColors.cyan.withOpacity(0.12),
                AppColors.orange.withOpacity(0.06),
              ]),
              border: Border.all(color: AppColors.cyan.withOpacity(0.3)),
            ),
            child: Text(info?.prompt ?? 'مقدار یا نوع را وارد کن',
                style: TextStyle(height: 1.6, color: context.cText)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _value,
            decoration: InputDecoration(
              labelText: 'مقدار / نوع',
              hintText: 'مثال داخل متن بالا',
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
          const SizedBox(height: 18),
          Text('تعداد', style: TextStyle(color: context.cMuted)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _circleBtn(Icons.remove, () {
                if (_qty > 1) setState(() => _qty--);
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text('$_qty',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
              ),
              _circleBtn(Icons.add, () => setState(() => _qty++)),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _busy ? null : _add,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.orange,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            icon: const Icon(Icons.add_shopping_cart_rounded),
            label: Text(_busy ? '...' : 'افزودن به سبد',
                style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData ic, VoidCallback on) => Material(
        color: AppColors.cyan.withOpacity(0.15),
        shape: const CircleBorder(),
        child: IconButton(onPressed: on, icon: Icon(ic, color: AppColors.cyan)),
      );
}
