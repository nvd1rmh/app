import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class PowerCalcScreen extends StatefulWidget {
  const PowerCalcScreen({super.key});
  @override
  State<PowerCalcScreen> createState() => _PowerCalcScreenState();
}

class _PowerCalcScreenState extends State<PowerCalcScreen> {
  final v = TextEditingController();
  final i = TextEditingController();
  final r = TextEditingController();
  String? result;

  void _calc() {
    final vv = parseNumber(v.text);
    final ii = parseNumber(i.text);
    final rr = parseResistance(r.text);
    double? p;
    if (vv != null && ii != null) {
      p = vv * ii;
    } else if (vv != null && rr != null && rr > 0) {
      p = vv * vv / rr;
    } else if (ii != null && rr != null) {
      p = ii * ii * rr;
    }
    setState(() => result = p == null ? 'حداقل دو پارامتر مرتبط وارد کن' : 'P = ${formatPower(p)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('محاسبه توان'), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(controller: v, decoration: const InputDecoration(labelText: 'V (ولت)')),
          const SizedBox(height: 10),
          TextField(controller: i, decoration: const InputDecoration(labelText: 'I (آمپر)')),
          const SizedBox(height: 10),
          TextField(controller: r, decoration: const InputDecoration(labelText: 'R (اختیاری)')),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null)
            Container(margin: const EdgeInsets.only(top: 16), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.12), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gold.withOpacity(0.35))), child: Text(result!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: context.cText))),
        ],
      ),
    );
  }
}
