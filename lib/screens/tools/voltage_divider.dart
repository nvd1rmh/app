import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class VoltageDividerScreen extends StatefulWidget {
  const VoltageDividerScreen({super.key});
  @override
  State<VoltageDividerScreen> createState() => _VoltageDividerScreenState();
}

class _VoltageDividerScreenState extends State<VoltageDividerScreen> {
  final vin = TextEditingController();
  final r1 = TextEditingController();
  final r2 = TextEditingController();
  String? result;

  void _calc() {
    final v = parseNumber(vin.text);
    final a = parseResistance(r1.text);
    final b = parseResistance(r2.text);
    if (v == null || a == null || b == null || (a + b) == 0) {
      setState(() => result = 'نامعتبر');
      return;
    }
    final out = v * b / (a + b);
    setState(() => result = 'Vout = ${out.toStringAsFixed(4)} ولت\nنسبت: ${(b / (a + b) * 100).toStringAsFixed(1)}٪');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تقسیم‌کننده ولتاژ'), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Vin ── R1 ──●── R2 ── GND\n              Vout', style: TextStyle(fontFamily: 'monospace', color: context.cMuted)),
          const SizedBox(height: 12),
          TextField(controller: vin, decoration: const InputDecoration(labelText: 'Vin (ولت)')),
          const SizedBox(height: 10),
          TextField(controller: r1, decoration: const InputDecoration(labelText: 'R1')),
          const SizedBox(height: 10),
          TextField(controller: r2, decoration: const InputDecoration(labelText: 'R2')),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null)
            Container(margin: const EdgeInsets.only(top: 16), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.orange.withOpacity(0.12), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.orange.withOpacity(0.35))), child: Text(result!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: context.cText, height: 1.5))),
        ],
      ),
    );
  }
}
