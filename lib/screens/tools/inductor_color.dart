import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class InductorColorScreen extends StatefulWidget {
  const InductorColorScreen({super.key});
  @override
  State<InductorColorScreen> createState() => _InductorColorScreenState();
}

class _InductorColorScreenState extends State<InductorColorScreen> {
  String? b1, b2, b3;
  String? result;

  static const digits = [
    'مشکی', 'قهوه‌ای', 'قرمز', 'نارنجی', 'زرد', 'سبز', 'آبی', 'بنفش', 'خاکستری', 'سفید'
  ];

  Color _hex(String name) {
    final c = colorHex[name];
    return c != null ? Color(c.value) : Colors.grey;
  }

  void _calc() {
    if (b1 == null || b2 == null || b3 == null) {
      setState(() => result = 'هر سه باند را انتخاب کن');
      return;
    }
    final d1 = digitColors[b1]!;
    final d2 = digitColors[b2]!;
    final mult = indMultColors[b3] ?? 1.0;
    final uh = (d1 * 10 + d2) * mult;
    setState(() => result = formatInductance(uh * 1e-6));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رنگ سلف'),
        leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              height: 90,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF7C9EB2),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _band(b1),
                  const SizedBox(width: 12),
                  _band(b2),
                  const SizedBox(width: 12),
                  _band(b3),
                ],
              ),
            ),
          ),
          _pick('باند ۱ — رقم اول (چپ)', digits, b1, (v) {
            setState(() {
              b1 = v;
              _calc();
            });
          }),
          _pick('باند ۲ — رقم دوم', digits, b2, (v) {
            setState(() {
              b2 = v;
              _calc();
            });
          }),
          _pick('باند ۳ — ضریب', digits, b3, (v) {
            setState(() {
              b3 = v;
              _calc();
            });
          }),
          if (result != null) ResultBox(result!, accent: AppColors.cyan),
        ],
      ),
    );
  }

  Widget _band(String? n) => Container(
        width: 14,
        height: 65,
        decoration: BoxDecoration(
          color: n != null ? _hex(n) : Colors.black26,
          borderRadius: BorderRadius.circular(3),
        ),
      );

  Widget _pick(String label, List<String> opts, String? value, ValueChanged<String> on) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: context.cMuted, fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: opts.map((c) {
              final sel = value == c;
              return GestureDetector(
                onTap: () => on(c),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: sel ? _hex(c).withOpacity(0.28) : context.cCard2,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: sel ? _hex(c) : context.cLine, width: sel ? 2 : 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 14, height: 14, decoration: BoxDecoration(color: _hex(c), shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Text(c, style: TextStyle(fontSize: 13, color: context.cText)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
