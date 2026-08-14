import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

const eia96 = {
  1: 100, 2: 102, 3: 105, 4: 107, 5: 110, 6: 113, 7: 115, 8: 118, 9: 121, 10: 124,
  11: 127, 12: 130, 13: 133, 14: 137, 15: 140, 16: 143, 17: 147, 18: 150, 19: 154, 20: 158,
  21: 162, 22: 165, 23: 169, 24: 174, 25: 178, 26: 182, 27: 187, 28: 191, 29: 196, 30: 200,
  31: 205, 32: 210, 33: 215, 34: 221, 35: 226, 36: 232, 37: 237, 38: 243, 39: 249, 40: 255,
  41: 261, 42: 267, 43: 274, 44: 280, 45: 287, 46: 294, 47: 301, 48: 309, 49: 316, 50: 324,
  51: 332, 52: 340, 53: 348, 54: 357, 55: 365, 56: 374, 57: 383, 58: 392, 59: 402, 60: 412,
  61: 422, 62: 432, 63: 442, 64: 453, 65: 464, 66: 475, 67: 487, 68: 499, 69: 511, 70: 523,
  71: 536, 72: 549, 73: 562, 74: 576, 75: 590, 76: 604, 77: 619, 78: 634, 79: 649, 80: 665,
  81: 681, 82: 698, 83: 715, 84: 732, 85: 750, 86: 768, 87: 787, 88: 806, 89: 825, 90: 845,
  91: 866, 92: 887, 93: 909, 94: 931, 95: 953, 96: 976,
};

const eia96Mult = {
  'Z': 0.001, 'Y': 0.01, 'X': 0.1, 'A': 1.0, 'B': 10.0, 'H': 10.0,
  'C': 100.0, 'D': 1000.0, 'E': 10000.0, 'F': 100000.0,
};

class SmdResistorScreen extends StatefulWidget {
  const SmdResistorScreen({super.key});

  @override
  State<SmdResistorScreen> createState() => _SmdResistorScreenState();
}

class _SmdResistorScreenState extends State<SmdResistorScreen> {
  final _ctrl = TextEditingController();
  String? result;

  void _calc() {
    final code = _ctrl.text.trim().toUpperCase();
    if (code.isEmpty) {
      setState(() => result = 'کد را وارد کن');
      return;
    }
    // R notation: 4R7 = 4.7
    final rMatch = RegExp(r'^(\d*)R(\d+)$').firstMatch(code);
    if (rMatch != null) {
      final whole = rMatch.group(1)!.isEmpty ? '0' : rMatch.group(1)!;
      final val = double.parse('$whole.${rMatch.group(2)}');
      setState(() => result = formatResistance(val));
      return;
    }
    // EIA-96: 01A
    final eia = RegExp(r'^(\d{2})([A-Z])$').firstMatch(code);
    if (eia != null) {
      final num = int.parse(eia.group(1)!);
      final letter = eia.group(2)!;
      if (eia96.containsKey(num) && eia96Mult.containsKey(letter)) {
        final val = eia96[num]! * eia96Mult[letter]! / 100;
        setState(() => result = formatResistance(val));
        return;
      }
    }
    // 3 or 4 digit
    if (RegExp(r'^\d{3,4}$').hasMatch(code)) {
      final significant = code.substring(0, code.length - 1);
      final mult = int.parse(code[code.length - 1]);
      final val = int.parse(significant) * (1 * _pow10(mult));
      setState(() => result = formatResistance(val.toDouble()));
      return;
    }
    setState(() => result = 'کد شناخته نشد');
  }

  int _pow10(int e) {
    int r = 1;
    for (int i = 0; i < e; i++) r *= 10;
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🔢 مقاومت SMD')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'کد را وارد کن:\n• ۳ یا ۴ رقمی (مثلاً 103 = 10k)\n• EIA-96 (مثلاً 01C)\n• با R (مثلاً 4R7)',
            style: GoogleFonts.vazirmatn(color: AppTheme.muted, height: 1.5),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _ctrl,
            textCapitalization: TextCapitalization.characters,
            style: GoogleFonts.vazirmatn(color: AppTheme.text, fontSize: 20, letterSpacing: 2),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(labelText: 'کد SMD'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null) ...[
            const SizedBox(height: 28),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: AppTheme.card2, borderRadius: BorderRadius.circular(18)),
              child: Text(
                result!,
                textAlign: TextAlign.center,
                style: GoogleFonts.vazirmatn(fontSize: 24, fontWeight: FontWeight.w800, color: AppTheme.accent),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
