import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../services/order_service.dart';
import '../theme.dart';
import 'auth/login_screen.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onChanged;
  const CartScreen({super.key, required this.onChanged});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _busy = false;

  Future<void> _checkout() async {
    if (AuthService.instance.currentUser == null) {
      await Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      widget.onChanged();
      return;
    }
    setState(() => _busy = true);
    final err = await OrderService.instance.checkout();
    setState(() => _busy = false);
    if (!mounted) return;
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('سفارش ثبت شد و برای ادمین ارسال شد'),
        backgroundColor: AppColors.green,
      ));
      widget.onChanged();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = CartService.instance.items;
    final logged = AuthService.instance.currentUser != null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 100),
      children: [
        Text('سبد خرید',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w900, color: context.cText)),
        if (!logged)
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text('برای ثبت سفارش وارد حساب شو.',
                style: TextStyle(color: context.cMuted)),
          ),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Text('سبد خالی است',
                  style: TextStyle(color: context.cDim)),
            ),
          ),
        ...items.map((it) {
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(it.product,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              subtitle: Text(it.value),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () async {
                      await CartService.instance.setCount(it, it.count - 1);
                      setState(() {});
                      widget.onChanged();
                    },
                  ),
                  Text('${it.count}',
                      style: const TextStyle(fontWeight: FontWeight.w900)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () async {
                      await CartService.instance.setCount(it, it.count + 1);
                      setState(() {});
                      widget.onChanged();
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        if (items.isNotEmpty) ...[
          const SizedBox(height: 12),
          if (logged)
            Text(
              'ثبت نهایی با نام «${AuthService.instance.currentUser!.name}» و شماره ${AuthService.instance.currentUser!.phone}',
              style: TextStyle(fontSize: 12, color: context.cMuted),
            ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: _busy ? null : _checkout,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.orange,
              minimumSize: const Size.fromHeight(48),
            ),
            child: Text(_busy ? 'در حال ثبت...' : 'ثبت نهایی سفارش',
                style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ],
    );
  }
}
