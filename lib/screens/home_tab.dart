import 'package:flutter/material.dart';
import '../theme.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onOrderTap;
  const HomeTab({super.key, required this.onOrderTap});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final fg = dark ? Colors.white : const Color(0xFF102033);
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft,
        colors: dark ? const [Color(0xFF050A14), Color(0xFF0A1C30), Color(0xFF10112A)] : const [Color(0xFFE5F6FF), Color(0xFFF8FAFF), Color(0xFFEDEBFF)])),
      child: Stack(children: [
        Positioned(top: 70, left: -55, child: _orb(180, AppColors.cyan.withOpacity(.12))),
        Positioned(bottom: 80, right: -70, child: _orb(210, AppColors.purple.withOpacity(.13))),
        SafeArea(child: LayoutBuilder(builder: (context, box) => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 34),
          child: ConstrainedBox(constraints: BoxConstraints(minHeight: box.maxHeight - 60), child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 104, height: 104, decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF04C7E8), Color(0xFF4264E8), Color(0xFF9D4EDD)]),
                boxShadow: [BoxShadow(color: AppColors.cyan.withOpacity(.32), blurRadius: 34, spreadRadius: 2)],
              ), child: const Icon(Icons.memory_rounded, color: Colors.white, size: 56)),
              const SizedBox(height: 26),
              Text('فرنو الکترونیک', textAlign: TextAlign.center, style: TextStyle(color: fg, fontSize: 31, fontWeight: FontWeight.w900, letterSpacing: -.5)),
              const SizedBox(height: 9),
              Text('جعبه‌ابزار هوشمند مهندسی الکترونیک', textAlign: TextAlign.center, style: TextStyle(color: context.cMuted, fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 34),
              _featureStrip(context, fg),
              const SizedBox(height: 28),
              Material(color: Colors.transparent, child: InkWell(
                onTap: onOrderTap, borderRadius: BorderRadius.circular(23),
                child: Ink(decoration: BoxDecoration(borderRadius: BorderRadius.circular(23), gradient: const LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [Color(0xFF00B9D8), Color(0xFF4265E8), Color(0xFF7747D9)]), boxShadow: [BoxShadow(color: AppColors.blue.withOpacity(.3), blurRadius: 22, offset: const Offset(0, 9))]),
                  child: const Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 19), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.electrical_services_rounded, color: Colors.white, size: 25), SizedBox(width: 12), Text('ابزار ها', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w900)), SizedBox(width: 10), Icon(Icons.arrow_back_rounded, color: Colors.white70, size: 21)])),
                ),
              )),
              const SizedBox(height: 18),
              Text('V1.0.0  •  ابزارهای تخصصی الکترونیک', style: TextStyle(color: context.cDim, fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          )),
        ))),
      ]),
    );
  }

  Widget _featureStrip(BuildContext context, Color fg) => Row(children: [
    _feature(context, Icons.bolt_rounded, 'محاسبات سریع', fg), const SizedBox(width: 9),
    _feature(context, Icons.tune_rounded, 'ابزار تخصصی', fg), const SizedBox(width: 9),
    _feature(context, Icons.wifi_off_rounded, 'بدون اینترنت', fg),
  ]);

  Widget _feature(BuildContext context, IconData icon, String label, Color fg) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
    decoration: BoxDecoration(color: context.cCard.withOpacity(.75), borderRadius: BorderRadius.circular(17), border: Border.all(color: context.cLine.withOpacity(.7))),
    child: Column(children: [Icon(icon, color: AppColors.cyan, size: 21), const SizedBox(height: 7), Text(label, textAlign: TextAlign.center, style: TextStyle(color: fg, fontSize: 10, fontWeight: FontWeight.w800))]),
  ));

  Widget _orb(double size, Color color) => Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, color: color));
}

