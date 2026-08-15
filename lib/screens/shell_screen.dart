import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../theme.dart';
import 'about_screen.dart';
import 'account_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';
import 'history_screen.dart';
import 'home_tab.dart';
import 'tools_hub_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});
  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    await AuthService.instance.loadSession();
    await CartService.instance.load();
    if (mounted) setState(() => _loading = false);
  }

  void _refresh() => setState(() {});

  void goCategories() => setState(() => _index = 1);

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final pages = [
      HomeTab(onOrderTap: goCategories),
      CategoriesScreen(onNeedAuth: _refresh),
      CartScreen(onChanged: _refresh),
      const ToolsHubScreen(),
      HistoryScreen(onChanged: _refresh),
      AccountScreen(onChanged: _refresh),
    ];

    final cartN = CartService.instance.totalCount;

    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'فرنو یار',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          leading: IconButton(
            tooltip: 'تم',
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.wb_sunny_rounded
                  : Icons.nightlight_round,
              size: 22,
            ),
            onPressed: () => FarnoYarThemeScope.of(context)?.toggleTheme(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 6),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AboutScreen(onAuthChanged: _refresh)),
                  );
                },
                icon: const Icon(Icons.info_outline_rounded, size: 18, color: AppColors.cyan),
                label: const Text(
                  'درباره ما',
                  style: TextStyle(
                    color: AppColors.cyan,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              context.cCard,
              Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF0D1524)
                  : const Color(0xFFF0F7FF),
            ],
          ),
          border: Border.all(color: AppColors.cyan.withOpacity(0.35), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyan.withOpacity(0.18),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              _nav(0, Icons.home_rounded, 'خانه'),
              _nav(1, Icons.grid_view_rounded, 'دسته'),
              _nav(2, Icons.shopping_bag_rounded, 'سبد', badge: cartN),
              _nav(3, Icons.build_rounded, 'ابزار'),
              _nav(4, Icons.receipt_long_rounded, 'تاریخچه'),
              _nav(5, Icons.person_rounded, 'حساب'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nav(int i, IconData icon, String label, {int badge = 0}) {
    final sel = _index == i;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => setState(() => _index = i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: sel
                ? LinearGradient(colors: [
                    AppColors.cyan.withOpacity(0.28),
                    AppColors.orange.withOpacity(0.14),
                  ])
                : null,
            boxShadow: sel
                ? [
                    BoxShadow(
                      color: AppColors.cyan.withOpacity(0.25),
                      blurRadius: 10,
                    )
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(icon, size: 20, color: sel ? AppColors.cyan : context.cDim),
                  if (badge > 0)
                    Positioned(
                      left: -8,
                      top: -5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [AppColors.orange, Color(0xFFFF6B4A)]),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$badge',
                          style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: sel ? FontWeight.w900 : FontWeight.w500,
                  color: sel ? AppColors.cyan : context.cDim,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FarnoYarThemeScope extends InheritedWidget {
  final Future<void> Function() toggleTheme;
  final bool isDark;
  const FarnoYarThemeScope({
    super.key,
    required this.toggleTheme,
    required this.isDark,
    required super.child,
  });
  static FarnoYarThemeScope? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FarnoYarThemeScope>();
  @override
  bool updateShouldNotify(FarnoYarThemeScope old) => isDark != old.isDark;
}
