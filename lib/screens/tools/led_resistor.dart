import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class LedResistorScreen extends StatefulWidget {
  const LedResistorScreen({super.key});
  @override
  State<LedResistorScreen> createState() => _LedResistorScreenState();
}

class _LedResistorScreenState extends State<LedResistorScreen> {
  final vin = TextEditingController(text: '5');
  final vf = TextEditingController(text: '2');
  final ma = TextEditingController(text: '20');
  String? result;

  void _calc() {
    final v = parseNumber(vin.text);
    final f = parseNumber(vf.text);
    final i = parseNumber(ma.text);
    if (v == null || f == null || i == null || i <= 0) {
      setState(() => result = 'نامعتبر');
      return;
    }
    final r = (v - f) / (i / 1000.0);
    if (r < 0) {
      setState(() => result = 'Vf نباید از Vin بیشتر باشد');
      return;
    }
    final near = findNearestE24(r);
    setState(() {
      result = 'R = ${formatResistance(r)}\n'
          'نزدیک E24 پایین: ${near[0] != null ? formatResistance(near[0]!) : "—"}\n'
          'نزدیک E24 بالا: ${near[1] != null ? formatResistance(near[1]!) : "—"}\n'
          'توان تقریبی: ${formatPower((v - f) * (i / 1000.0))}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💡 مقاومت LED'), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(controller: vin, decoration: const InputDecoration(labelText: 'Vin (ولت)'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          const SizedBox(height: 10),
          TextField(controller: vf, decoration: const InputDecoration(labelText: 'Vf ال‌ای‌دی (ولت)'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          const SizedBox(height: 10),
          TextField(controller: ma, decoration: const InputDecoration(labelText: 'جریان (میلی‌آمپر)'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null)
            Container(margin: const EdgeInsets.only(top: 16), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.orange.withOpacity(0.12), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.orange.withOpacity(0.35))), child: Text(result!, style: TextStyle(fontSize: 15, height: 1.6, fontWeight: FontWeight.w600, color: context.cText))),
        ],
      ),
    );
  }
}
