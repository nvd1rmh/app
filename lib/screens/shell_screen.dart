import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme.dart';
import 'about_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
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
    if (mounted) setState(() => _loading = false);
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final pages = [
      HomeTab(onAuthChanged: _refresh),
      const ToolsHubScreen(),
      AboutScreen(onAuthChanged: _refresh),
    ];

    final user = AuthService.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('فرنو یار'),
        actions: [
          // تم
          IconButton(
            tooltip: 'تم روز / شب',
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.wb_sunny_rounded
                  : Icons.nightlight_round,
            ),
            onPressed: () {
              FarnoYarThemeScope.of(context)?.toggleTheme();
            },
          ),
          if (user == null) ...[
            TextButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
                _refresh();
              },
              child: Text(
                'ورود',
                style: TextStyle(
                  color: AppColors.cyan,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 4),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: const Size(0, 36),
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                  _refresh();
                },
                child: const Text('ثبت‌نام', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => _showAccountSheet(context),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.cyan.withOpacity(0.25),
                      child: Text(
                        user.name.isNotEmpty ? user.name.characters.first : '؟',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.cyan,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 110),
                      child: Text(
                        user.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'خانه',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_outlined),
            selectedIcon: Icon(Icons.build_rounded),
            label: 'ابزارها',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline_rounded),
            selectedIcon: Icon(Icons.info_rounded),
            label: 'درباره ما',
          ),
        ],
      ),
    );
  }

  void _showAccountSheet(BuildContext context) {
    final user = AuthService.instance.currentUser;
    if (user == null) return;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(user.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(user.phone, style: TextStyle(color: context.cMuted)),
              if (user.address.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(user.address, style: TextStyle(color: context.cMuted, fontSize: 13)),
              ],
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () async {
                  await AuthService.instance.logout();
                  if (ctx.mounted) Navigator.pop(ctx);
                  _refresh();
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text('خروج از حساب'),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// دسترسی به تغییر تم از Shell بدون وابستگی سخت به main
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
  bool updateShouldNotify(FarnoYarThemeScope oldWidget) =>
      isDark != oldWidget.isDark;
}
