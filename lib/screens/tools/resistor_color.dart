import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

const colorMap = {
  'مشکی': 0,
  'قهوه‌ای': 1,
  'قرمز': 2,
  'نارنجی': 3,
  'زرد': 4,
  'سبز': 5,
  'آبی': 6,
  'بنفش': 7,
  'خاکستری': 8,
  'سفید': 9,
};

const multMap = {
  'مشکی': 1.0,
  'قهوه‌ای': 10.0,
  'قرمز': 100.0,
  'نارنجی': 1000.0,
  'زرد': 10000.0,
  'سبز': 100000.0,
  'آبی': 1000000.0,
  'بنفش': 10000000.0,
  'طلایی': 0.1,
  'نقره‌ای': 0.01,
};

const tolMap = {
  'طلایی': '±5%',
  'نقره‌ای': '±10%',
  'قهوه‌ای': '±1%',
  'قرمز': '±2%',
};

const colorHex = {
  'مشکی': Color(0xFF111111),
  'قهوه‌ای': Color(0xFF8B4513),
  'قرمز': Color(0xFFE11D48),
  'نارنجی': Color(0xFFF97316),
  'زرد': Color(0xFFEAB308),
  'سبز': Color(0xFF22C55E),
  'آبی': Color(0xFF3B82F6),
  'بنفش': Color(0xFFA855F7),
  'خاکستری': Color(0xFF94A3B8),
  'سفید': Color(0xFFF8FAFC),
  'طلایی': Color(0xFFFFD700),
  'نقره‌ای': Color(0xFFC0C0C0),
};

class ResistorColorScreen extends StatefulWidget {
  const ResistorColorScreen({super.key});

  @override
  State<ResistorColorScreen> createState() => _ResistorColorScreenState();
}

class _ResistorColorScreenState extends State<ResistorColorScreen> {
  String? band1, band2, band3, band4;
  String? result;

  void _calc() {
    if (band1 == null || band2 == null || band3 == null) {
      setState(() => result = 'حداقل سه باند را انتخاب کن');
      return;
    }
    final d1 = colorMap[band1]!;
    final d2 = colorMap[band2]!;
    final mult = multMap[band3] ?? 1.0;
    final ohms = (d1 * 10 + d2) * mult;
    final tol = band4 != null ? (tolMap[band4] ?? '') : '';
    setState(() {
      result = '${formatResistance(ohms)}${tol.isNotEmpty ? '\nتلرانس: $tol' : ''}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🎨 رنگ مقاومت')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // visual resistor
          Container(
            height: 90,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFC4A484),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _band(band1),
                const SizedBox(width: 18),
                _band(band2),
                const SizedBox(width: 18),
                _band(band3),
                const SizedBox(width: 18),
                _band(band4),
              ],
            ),
          ),
          _picker('باند ۱ (رقم اول)', colorMap.keys.toList(), band1, (v) => setState(() => band1 = v)),
          _picker('باند ۲ (رقم دوم)', colorMap.keys.toList(), band2, (v) => setState(() => band2 = v)),
          _picker('باند ۳ (ضریب)', multMap.keys.toList(), band3, (v) => setState(() => band3 = v)),
          _picker('باند ۴ (تلرانس)', ['طلایی', 'نقره‌ای', 'قهوه‌ای', 'قرمز'], band4, (v) => setState(() => band4 = v)),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppTheme.card2,
                borderRadius: BorderRadius.circular(18),
              ),
              child: SelectableText(
                result!,
                textAlign: TextAlign.center,
                style: GoogleFonts.vazirmatn(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.accent,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _band(String? color) {
    return Container(
      width: 18,
      height: 70,
      decoration: BoxDecoration(
        color: color != null ? colorHex[color] : Colors.black26,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.black54),
      ),
    );
  }

  Widget _picker(String label, List<String> options, String? value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.vazirmatn(color: AppTheme.muted, fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((c) {
              final selected = value == c;
              return GestureDetector(
                onTap: () => onChanged(c),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? colorHex[c]!.withOpacity(0.3) : AppTheme.card2,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? colorHex[c]! : AppTheme.line,
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: colorHex[c],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(c, style: GoogleFonts.vazirmatn(fontSize: 13, color: AppTheme.text)),
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
