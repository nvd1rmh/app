import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class ReactanceScreen extends StatefulWidget {
  const ReactanceScreen({super.key});
  @override
  State<ReactanceScreen> createState() => _ReactanceScreenState();
}

class _ReactanceScreenState extends State<ReactanceScreen> {
  final fCtrl = TextEditingController();
  final cCtrl = TextEditingController();
  final lCtrl = TextEditingController();
  String? result;

  void _calc() {
    final f = parseFrequency(fCtrl.text);
    final c = parseCapacitance(cCtrl.text);
    final l = parseInductance(lCtrl.text);
    if (f == null || f <= 0) {
      setState(() => result = 'فرکانس نامعتبر');
      return;
    }
    final buf = StringBuffer('f = ${formatFrequency(f)}\n');
    if (c != null && c > 0) {
      final xc = 1 / (2 * math.pi * f * c);
      buf.writeln('Xc = ${formatResistance(xc)}');
    }
    if (l != null && l > 0) {
      final xl = 2 * math.pi * f * l;
      buf.writeln('XL = ${formatResistance(xl)}');
    }
    if ((c == null || c <= 0) && (l == null || l <= 0)) {
      setState(() => result = 'حداقل C یا L را وارد کن');
      return;
    }
    setState(() => result = buf.toString().trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('راکتانس'), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(controller: fCtrl, decoration: const InputDecoration(labelText: 'فرکانس', hintText: '1kHz یا 1MHz')),
          const SizedBox(height: 10),
          TextField(controller: cCtrl, decoration: const InputDecoration(labelText: 'خازن (اختیاری)', hintText: '100nF')),
          const SizedBox(height: 10),
          TextField(controller: lCtrl, decoration: const InputDecoration(labelText: 'سلف (اختیاری)', hintText: '10mH')),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null)
            ResultBox(result!, accent: AppColors.gold),
        ],
      ),
    );
  }
}
