import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class LcResonanceScreen extends StatefulWidget {
  const LcResonanceScreen({super.key});
  @override
  State<LcResonanceScreen> createState() => _LcResonanceScreenState();
}

class _LcResonanceScreenState extends State<LcResonanceScreen> {
  final lCtrl = TextEditingController();
  final cCtrl = TextEditingController();
  String? result;

  void _calc() {
    final l = parseInductance(lCtrl.text);
    final c = parseCapacitance(cCtrl.text);
    if (l == null || c == null || l <= 0 || c <= 0) {
      setState(() => result = 'نامعتبر');
      return;
    }
    final f = 1 / (2 * math.pi * math.sqrt(l * c));
    final z0 = math.sqrt(l / c);
    setState(() => result = 'fr = ${formatFrequency(f)}\nZ₀ ≈ ${formatResistance(z0)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تشدید LC'), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(controller: lCtrl, decoration: const InputDecoration(labelText: 'سلف L', hintText: '10uH')),
          const SizedBox(height: 10),
          TextField(controller: cCtrl, decoration: const InputDecoration(labelText: 'خازن C', hintText: '100pF')),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null)
            Container(margin: const EdgeInsets.only(top: 16), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.green.withOpacity(0.12), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.green.withOpacity(0.35))), child: Text(result!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: context.cText, height: 1.5))),
        ],
      ),
    );
  }
}
