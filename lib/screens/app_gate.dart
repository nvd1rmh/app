import 'package:flutter/material.dart';
import '../services/app_status_service.dart';
import '../theme.dart';
import 'shell_screen.dart';

class AppGate extends StatefulWidget {
  const AppGate({super.key});

  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {
  bool _checking = true;
  String? _error;
  AppStatus? _status;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    setState(() {
      _checking = true;
      _error = null;
    });
    try {
      final status = await AppStatus.fetch();
      if (mounted) setState(() { _status = status; _checking = false; });
    } catch (_) {
      if (mounted) setState(() {
        _status = null;
        _error = 'برای استفاده از فرنو الکترونیک، اینترنت را روشن کن و دوباره تلاش کن.\n\nوضعیت نسخه از GitHub دریافت نشد.';
        _checking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_status?.isCurrentVersionAllowed == true) return const ShellScreen();
    final stopped = !_checking && _error == null && _status != null;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFF050A14), Color(0xFF102A43), Color(0xFF17112D)])),
        child: SafeArea(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(28), child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(stopped ? Icons.system_update_alt_rounded : Icons.wifi_rounded, size: 68, color: AppColors.cyan),
          const SizedBox(height: 24),
          Text(stopped ? 'این نسخه قابل استفاده نیست' : 'بررسی اتصال', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Text(_checking ? 'در حال بررسی نسخه و اتصال…' : stopped ? _status!.message : _error!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.8)),
          const SizedBox(height: 22),
          if (_checking) const CircularProgressIndicator(color: AppColors.cyan)
          else FilledButton.icon(onPressed: _checkStatus, icon: const Icon(Icons.refresh_rounded), label: const Text('تلاش دوباره')),
          const SizedBox(height: 20),
          const Text('V1.0.0  •  @FarnoElectronic', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w700)),
        ])))),
      ),
    );
  }
}
