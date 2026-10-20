import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';
import 'home_tab.dart';
import 'tools_hub_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});
  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;
  bool _stopped = false;
  Timer? _holdTimer;

  @override
  void initState() {
    super.initState();
    _loadStopState();
  }

  Future<void> _loadStopState() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) setState(() => _stopped = prefs.getBool('v100_stopped') ?? false);
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    super.dispose();
  }

  Future<void> _showAdmin() async {
    final controller = TextEditingController();
    final code = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ورود مدیر'),
        content: TextField(
          controller: controller,
          autofocus: true,
          obscureText: true,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.ltr,
          decoration: const InputDecoration(labelText: 'رمز مدیر'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('انصراف')),
          FilledButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('ادامه')),
        ],
      ),
    );
    controller.dispose();
    if (code != '1080' || !mounted) return;
    final stop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('توقف نسخه V1.0.0؟'),
        content: const Text('این توقف فقط روی همین دستگاه اثر می‌گذارد. برای توقف سراسری، فایل app-status.json مخزن FCoin را ویرایش کن: minimumVersion را روی 1.0.1 بگذار تا نسخهٔ 1.0.0 در همهٔ گوشی‌ها قفل شود.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('بازگشت')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('توقف نسخه')),
        ],
      ),
    );
    if (stop == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('v100_stopped', true);
      if (mounted) setState(() => _stopped = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_stopped) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF07111F), Color(0xFF102A43)])),
          child: SafeArea(child: Center(child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.system_update_alt_rounded, size: 68, color: AppColors.cyan),
              const SizedBox(height: 24),
              const Text('این نسخه قدیمی شده است', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              const Text('لطفاً اپلیکیشن را کامل حذف کنید و برای قابلیت‌های خفن‌تر، نسخهٔ جدید را از کانال تلگرام @FarnoElectronic نصب کنید.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.8)),
            ]),
          ))),
        ),
      );
    }
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('فرنو الکترونیک', style: TextStyle(fontWeight: FontWeight.w900)),
        leading: IconButton(
          tooltip: 'تغییر تم',
          icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.wb_sunny_rounded : Icons.nightlight_round),
          onPressed: () => FarnoYarThemeScope.of(context)?.toggleTheme(),
        ),
        actions: const [Padding(padding: EdgeInsetsDirectional.only(end: 16), child: Center(child: Text('V1.0.0', style: TextStyle(color: AppColors.cyan, fontWeight: FontWeight.w800))))],
      ),
      body: IndexedStack(index: _index, children: [
        HomeTab(onOrderTap: () => setState(() => _index = 1)),
        const ToolsHubScreen(),
      ]),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: context.cCard.withOpacity(0.96),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: AppColors.cyan.withOpacity(0.28)),
          boxShadow: [BoxShadow(color: AppColors.cyan.withOpacity(0.14), blurRadius: 24, offset: const Offset(0, 7))],
        ),
        child: SafeArea(top: false, child: Row(children: [
          _nav(0, Icons.home_rounded, 'خانه'),
          _nav(1, Icons.electrical_services_rounded, 'ابزار'),
        ])),
      ),
    );
  }

  Widget _nav(int i, IconData icon, String label) {
    final selected = _index == i;
    return Expanded(child: GestureDetector(
      onTap: () => setState(() => _index = i),
      onTapDown: i == 0 ? (_) => _holdTimer = Timer(const Duration(seconds: 5), _showAdmin) : null,
      onTapUp: i == 0 ? (_) => _holdTimer?.cancel() : null,
      onTapCancel: i == 0 ? () => _holdTimer?.cancel() : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280), curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          gradient: selected ? const LinearGradient(colors: [Color(0xFF007EA8), Color(0xFF5533A8)]) : null,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: selected ? Colors.white : context.cDim, size: 22),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(color: selected ? Colors.white : context.cDim, fontSize: 11, fontWeight: FontWeight.w800)),
        ]),
      ),
    ));
  }
}

class FarnoYarThemeScope extends InheritedWidget {
  final Future<void> Function() toggleTheme;
  final bool isDark;
  const FarnoYarThemeScope({super.key, required this.toggleTheme, required this.isDark, required super.child});
  static FarnoYarThemeScope? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FarnoYarThemeScope>();
  @override
  bool updateShouldNotify(FarnoYarThemeScope old) => isDark != old.isDark;
}
