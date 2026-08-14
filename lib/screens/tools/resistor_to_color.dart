import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';
import 'resistor_color.dart' show colorHex;

class ResistorToColorScreen extends StatefulWidget {
  const ResistorToColorScreen({super.key});

  @override
  State<ResistorToColorScreen> createState() => _ResistorToColorScreenState();
}

class _ResistorToColorScreenState extends State<ResistorToColorScreen> {
  final _ctrl = TextEditingController();
  List<String>? bands;
  String? valueText;

  void _calc() {
    final ohms = parseResistance(_ctrl.text);
    if (ohms == null || ohms <= 0) {
      setState(() {
        bands = null;
        valueText = 'مقدار نامعتبر';
      });
      return;
    }
    final nearest = findNearestE24(ohms);
    final target = nearest[1] ?? nearest[0] ?? ohms;
    // encode 4-band
    final digitNames = {0: 'مشکی', 1: 'قهوه‌ای', 2: 'قرمز', 3: 'نارنجی', 4: 'زرد', 5: 'سبز', 6: 'آبی', 7: 'بنفش', 8: 'خاکستری', 9: 'سفید'};
    final multNames = {1.0: 'مشکی', 10.0: 'قهوه‌ای', 100.0: 'قرمز', 1000.0: 'نارنجی', 10000.0: 'زرد', 100000.0: 'سبز', 1000000.0: 'آبی', 0.1: 'طلایی', 0.01: 'نقره‌ای'};

    double r = target;
    int exp = 0;
    if (r < 1) {
      // gold/silver
      if (r >= 0.1) {
        final sig = (r * 10).round().clamp(1, 99);
        final d1 = sig ~/ 10;
        final d2 = sig % 10;
        setState(() {
          bands = [digitNames[d1]!, digitNames[d2]!, 'طلایی', 'طلایی'];
          valueText = formatResistance(target);
        });
        return;
      }
    }
    while (r >= 100) { r /= 10; exp++; }
    while (r < 10 && r > 0) { r *= 10; exp--; }
    final sig = r.round().clamp(10, 99);
    final d1 = sig ~/ 10;
    final d2 = sig % 10;
    final multVal = (1.0 * (exp >= 0 ? (1 * _pow10(exp)) : (1.0 / _pow10(-exp))));
    final multName = multNames[multVal] ?? 'مشکی';
    setState(() {
      bands = [digitNames[d1]!, digitNames[d2]!, multName, 'طلایی'];
      valueText = formatResistance(target);
    });
  }

  int _pow10(int e) {
    int r = 1;
    for (int i = 0; i < e; i++) r *= 10;
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مقدار ← رنگ')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _ctrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: GoogleFonts.vazirmatn(color: AppTheme.text),
            decoration: const InputDecoration(
              labelText: 'مقدار مقاومت (مثلاً 4.7k یا 220)',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('تبدیل به رنگ')),
          if (bands != null) ...[
            const SizedBox(height: 28),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFC4A484),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bands!.map((c) {
                  return Container(
                    width: 22,
                    height: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: colorHex[c],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black54),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              bands!.join(' · '),
              textAlign: TextAlign.center,
              style: GoogleFonts.vazirmatn(fontSize: 16, color: AppTheme.text, fontWeight: FontWeight.w600),
            ),
            if (valueText != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  valueText!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.vazirmatn(fontSize: 20, color: AppTheme.accent, fontWeight: FontWeight.w800),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
