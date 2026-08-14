import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class ReactanceScreen extends StatefulWidget {
  const ReactanceScreen({super.key});

  @override
  State<ReactanceScreen> createState() => _ReactanceScreenState();
}

class _ReactanceScreenState extends State<ReactanceScreen> {
  bool capacitive = true;
  final _f = TextEditingController();
  final _comp = TextEditingController();
  String? result;

  void _calc() {
    final f = parseFrequency(_f.text);
    if (f == null || f <= 0) {
      setState(() => result = 'فرکانس نامعتبر');
      return;
    }
    if (capacitive) {
      final C = parseCapacitance(_comp.text);
      if (C == null || C <= 0) {
        setState(() => result = 'خازن نامعتبر');
        return;
      }
      final xc = 1 / (2 * math.pi * f * C);
      setState(() => result = 'Xc = ${formatResistance(xc)}');
    } else {
      final L = parseInductance(_comp.text);
      if (L == null || L <= 0) {
        setState(() => result = 'سلف نامعتبر');
        return;
      }
      final xl = 2 * math.pi * f * L;
      setState(() => result = 'XL = ${formatResistance(xl)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('راکتانس')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(child: ChoiceChip(label: const Text('خازنی (Xc)'), selected: capacitive, onSelected: (_) => setState(() => capacitive = true), selectedColor: AppTheme.accent.withOpacity(0.3))),
              const SizedBox(width: 10),
              Expanded(child: ChoiceChip(label: const Text('سلفی (XL)'), selected: !capacitive, onSelected: (_) => setState(() => capacitive = false), selectedColor: AppTheme.accent.withOpacity(0.3))),
            ],
          ),
          const SizedBox(height: 16),
          TextField(controller: _f, style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'فرکانس (مثلاً 1kHz یا 50Hz)')),
          const SizedBox(height: 12),
          TextField(
            controller: _comp,
            style: GoogleFonts.vazirmatn(color: AppTheme.text),
            decoration: InputDecoration(labelText: capacitive ? 'خازن (مثلاً 100nF)' : 'سلف (مثلاً 10uH)'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: AppTheme.card2, borderRadius: BorderRadius.circular(18)),
              child: Text(result!, textAlign: TextAlign.center, style: GoogleFonts.vazirmatn(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.accent)),
            ),
          ],
        ],
      ),
    );
  }
}
