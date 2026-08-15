import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/order_service.dart';
import '../theme.dart';
import 'auth/login_screen.dart';

class HistoryScreen extends StatefulWidget {
  final VoidCallback onChanged;
  const HistoryScreen({super.key, required this.onChanged});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<OrderRecord> _orders = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final list = await OrderService.instance.fetchHistory();
    if (mounted) {
      setState(() {
        _orders = list;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final logged = AuthService.instance.currentUser != null;
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 100),
        children: [
          Text('تاریخچه سفارش‌ها',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w900, color: context.cText)),
          const SizedBox(height: 8),
          if (!logged)
            Column(
              children: [
                Text('برای دیدن تاریخچه وارد شو.',
                    style: TextStyle(color: context.cMuted)),
                TextButton(
                  onPressed: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                    widget.onChanged();
                    _load();
                  },
                  child: const Text('ورود'),
                ),
              ],
            )
          else if (_loading)
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_orders.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                  child: Text('هنوز سفارشی ثبت نشده',
                      style: TextStyle(color: context.cDim))),
            )
          else
            ..._orders.map((o) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text('سفارش ${o.orderCode}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900)),
                          ),
                          Text(o.statusLabel,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ...o.items.map((it) => Text(
                          '• ${it.product} — ${it.value} × ${it.count}',
                          style: TextStyle(
                              fontSize: 13, color: context.cMuted))),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
