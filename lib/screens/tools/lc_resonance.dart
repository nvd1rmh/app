import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class LcResonanceScreen extends StatefulWidget {
  const LcResonanceScreen({super.key});

  @override
  State<LcResonanceScreen> createState() => _LcResonanceScreenState();
}

class _LcResonanceScreenState extends State<LcResonanceScreen> {
  final _l = TextEditingController();
  final _c = TextEditingController();
  String? result;

  void _calc() {
    final L = parseInductance(_l.text);
    final C = parseCapacitance(_c.text);
    if (L == null || C == null || L <= 0 || C <= 0) {
      setState(() => result = 'مقادیر نامعتبر');
      return;
    }
    final f = 1 / (2 * math.pi * math.sqrt(L * C));
    setState(() {
      result = 'فرکانس تشدید\n${formatFrequency(f)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💎 فرکانس تشدید LC')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(controller: _l, style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'سلف (مثلاً 10uH یا 1mH)')),
          const SizedBox(height: 12),
          TextField(controller: _c, style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'خازن (مثلاً 100pF یا 10nF)')),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null) ...[
            const SizedBox(height: 28),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(color: AppTheme.card2, borderRadius: BorderRadius.circular(18)),
              child: Text(result!, textAlign: TextAlign.center, style: GoogleFonts.vazirmatn(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.success, height: 1.5)),
            ),
          ],
        ],
      ),
    );
  }
}
