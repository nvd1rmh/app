import 'package:flutter/material.dart';
import '../data/products_data.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../services/products_service.dart';
import '../theme.dart';
import 'auth/login_screen.dart';

class ProductsScreen extends StatefulWidget {
  final VoidCallback onNeedAuth;
  const ProductsScreen({super.key, required this.onNeedAuth});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _search = TextEditingController();
  bool _loading = true;
  List<ProductInfo> _all = [];
  List<ProductInfo> _filtered = [];

  @override
  void initState() {
    super.initState();
    _boot();
    _search.addListener(_applyFilter);
  }

  Future<void> _boot() async {
    await ProductsService.instance.load();
    if (!mounted) return;
    setState(() {
      _all = ProductsService.instance.items;
      _filtered = _all;
      _loading = false;
    });
  }

  void _applyFilter() {
    final q = _search.text.trim().toLowerCase().replaceAll('‌', '');
    setState(() {
      if (q.isEmpty) {
        _filtered = _all;
      } else {
        _filtered = _all
            .where((p) =>
                p.name.toLowerCase().contains(q) ||
                p.id.toLowerCase().contains(q))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // سرچ شبیه تسک‌بار
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(colors: [
                context.cCard,
                Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF0D1524)
                    : const Color(0xFFF0F7FF),
              ]),
              border: Border.all(color: AppColors.cyan.withOpacity(0.4), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyan.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _search,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'جستجوی قطعه...',
                hintStyle: TextStyle(color: context.cDim, fontSize: 14),
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.cyan),
                suffixIcon: _search.text.isEmpty
                    ? null
                    : IconButton(
                        icon: Icon(Icons.close_rounded, color: context.cDim, size: 20),
                        onPressed: () {
                          _search.clear();
                          _applyFilter();
                        },
                      ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _filtered.isEmpty
                  ? Center(
                      child: Text('قطعه‌ای پیدا نشد',
                          style: TextStyle(color: context.cDim)))
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 100),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.88,
                      ),
                      itemCount: _filtered.length,
                      itemBuilder: (context, i) {
                        final p = _filtered[i];
                        return _ProductCard(
                          product: p,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductOrderScreen(
                                  product: p,
                                  onNeedAuth: widget.onNeedAuth,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductInfo product;
  final VoidCallback onTap;
  const _ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.cCard,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.cyan.withOpacity(0.28)),
            boxShadow: [
              BoxShadow(
                color: AppColors.cyan.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  product.assetPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFF121A28),
                    child: const Center(
                      child: Icon(Icons.image_outlined,
                          color: AppColors.cyan, size: 36),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 13),
                      ),
                      const Spacer(),
                      if (product.price != null && product.price!.isNotEmpty)
                        Text(product.price!,
                            style: const TextStyle(
                                color: AppColors.orange,
                                fontWeight: FontWeight.w800,
                                fontSize: 11))
                      else
                        Text(product.exampleCount,
                            style: TextStyle(
                                fontSize: 10.5, color: context.cMuted)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductOrderScreen extends StatefulWidget {
  final ProductInfo product;
  final VoidCallback onNeedAuth;
  const ProductOrderScreen(
      {super.key, required this.product, required this.onNeedAuth});

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('برای افزودن به سبد ابتدا ثبت‌نام یا ورود کن')));
      await Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      widget.onNeedAuth();
      return;
    }
    setState(() => _busy = true);
    final err = await CartService.instance.add(
      product: widget.product.name,
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
    final p = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(p.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1.4,
              child: Image.asset(
                p.assetPath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF121A28),
                  child: const Icon(Icons.image_outlined,
                      size: 48, color: AppColors.cyan),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
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
            child: Text(p.prompt,
                style: TextStyle(height: 1.6, color: context.cText)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _value,
            decoration: InputDecoration(
              labelText: 'مقدار / نوع',
              hintText: 'مثال داخل متن بالا',
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
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
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w900)),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
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
