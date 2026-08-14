import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class Timer555Screen extends StatefulWidget {
  const Timer555Screen({super.key});

  @override
  State<Timer555Screen> createState() => _Timer555ScreenState();
}

class _Timer555ScreenState extends State<Timer555Screen> {
  bool astable = true;
  final _r1 = TextEditingController();
  final _r2 = TextEditingController();
  final _c = TextEditingController();
  String? result;

  void _calc() {
    final c = parseCapacitance(_c.text);
    if (c == null || c <= 0) {
      setState(() => result = 'خازن نامعتبر');
      return;
    }
    if (astable) {
      final r1 = parseResistance(_r1.text);
      final r2 = parseResistance(_r2.text);
      if (r1 == null || r2 == null) {
        setState(() => result = 'مقاومت‌ها نامعتبر');
        return;
      }
      final freq = 1.44 / ((r1 + 2 * r2) * c);
      final duty = (r1 + r2) / (r1 + 2 * r2) * 100;
      final period = 1 / freq;
      final thigh = 0.693 * (r1 + r2) * c;
      final tlow = 0.693 * r2 * c;
      setState(() {
        result = 'فرکانس: ${formatFrequency(freq)}\n'
            'Duty: ${duty.toStringAsFixed(1)}%\n'
            'پریود: ${(period * 1000).toStringAsFixed(3)} ms\n'
            'Th: ${(thigh * 1000).toStringAsFixed(3)} ms\n'
            'Tl: ${(tlow * 1000).toStringAsFixed(3)} ms';
      });
    } else {
      final r = parseResistance(_r1.text);
      if (r == null) {
        setState(() => result = 'مقاومت نامعتبر');
        return;
      }
      final pulse = 1.1 * r * c;
      setState(() {
        result = 'عرض پالس ≈ ${(pulse * 1000).toStringAsFixed(3)} ms';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⏱️ تایمر ۵۵۵')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(child: ChoiceChip(label: const Text('Astable'), selected: astable, onSelected: (_) => setState(() => astable = true), selectedColor: AppTheme.accent.withOpacity(0.3))),
              const SizedBox(width: 10),
              Expanded(child: ChoiceChip(label: const Text('Monostable'), selected: !astable, onSelected: (_) => setState(() => astable = false), selectedColor: AppTheme.accent.withOpacity(0.3))),
            ],
          ),
          const SizedBox(height: 16),
          TextField(controller: _r1, style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: InputDecoration(labelText: astable ? 'R1' : 'R')),
          if (astable) ...[
            const SizedBox(height: 12),
            TextField(controller: _r2, style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'R2')),
          ],
          const SizedBox(height: 12),
          TextField(controller: _c, style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'C (مثلاً 10uF)')),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppTheme.card2, borderRadius: BorderRadius.circular(18)),
              child: SelectableText(result!, style: GoogleFonts.vazirmatn(fontSize: 16, height: 1.7, color: AppTheme.accent, fontWeight: FontWeight.w600)),
            ),
          ],
        ],
      ),
    );
  }
}
