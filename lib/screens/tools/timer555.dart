import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class Timer555Screen extends StatefulWidget {
  const Timer555Screen({super.key});
  @override
  State<Timer555Screen> createState() => _Timer555ScreenState();
}

class _Timer555ScreenState extends State<Timer555Screen> {
  bool astable = true;
  final r1 = TextEditingController();
  final r2 = TextEditingController();
  final c = TextEditingController();
  String? result;

  void _calc() {
    final cc = parseCapacitance(c.text);
    if (cc == null || cc <= 0) {
      setState(() => result = 'خازن نامعتبر');
      return;
    }
    if (astable) {
      final a = parseResistance(r1.text);
      final b = parseResistance(r2.text);
      if (a == null || b == null || a <= 0 || b <= 0) {
        setState(() => result = 'R1 و R2 نامعتبر');
        return;
      }
      final tHigh = 0.693 * (a + b) * cc;
      final tLow = 0.693 * b * cc;
      final period = tHigh + tLow;
      final freq = 1 / period;
      final duty = tHigh / period * 100;
      setState(() {
        result = 'فرکانس: ${formatFrequency(freq)}\n'
            'پریود: ${(period * 1000).toStringAsFixed(3)} ms\n'
            'T_high: ${(tHigh * 1000).toStringAsFixed(3)} ms\n'
            'T_low: ${(tLow * 1000).toStringAsFixed(3)} ms\n'
            'Duty: ${duty.toStringAsFixed(1)}٪';
      });
    } else {
      final r = parseResistance(r1.text);
      if (r == null || r <= 0) {
        setState(() => result = 'R نامعتبر');
        return;
      }
      final tw = 1.1 * r * cc;
      setState(() => result = 'عرض پالس ≈ ${(tw * 1000).toStringAsFixed(3)} ms\n(${tw.toStringAsFixed(6)} s)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تایمر ۵۵۵'), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(children: [
            ChoiceChip(label: const Text('Astable'), selected: astable, onSelected: (_) => setState(() => astable = true)),
            const SizedBox(width: 8),
            ChoiceChip(label: const Text('Monostable'), selected: !astable, onSelected: (_) => setState(() => astable = false)),
          ]),
          const SizedBox(height: 14),
          TextField(controller: r1, decoration: InputDecoration(labelText: astable ? 'R1' : 'R')),
          if (astable) ...[
            const SizedBox(height: 10),
            TextField(controller: r2, decoration: const InputDecoration(labelText: 'R2')),
          ],
          const SizedBox(height: 10),
          TextField(controller: c, decoration: const InputDecoration(labelText: 'C', hintText: '100nF')),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null)
            ResultBox(result!, accent: AppColors.cyan),
        ],
      ),
    );
  }
}
