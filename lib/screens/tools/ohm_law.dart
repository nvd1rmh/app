import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class OhmLawScreen extends StatefulWidget {
  const OhmLawScreen({super.key});
  @override
  State<OhmLawScreen> createState() => _OhmLawScreenState();
}

class _OhmLawScreenState extends State<OhmLawScreen> {
  final vCtrl = TextEditingController();
  final iCtrl = TextEditingController();
  final rCtrl = TextEditingController();
  String? result;

  void _calc() {
    final v = parseNumber(vCtrl.text);
    final i = parseNumber(iCtrl.text);
    final r = parseResistance(rCtrl.text);
    final filled = [v != null, i != null, r != null].where((x) => x).length;
    if (filled < 2) {
      setState(() => result = 'حداقل دو مقدار وارد کن');
      return;
    }
    double? vv = v, ii = i, rr = r;
    if (vv == null && ii != null && rr != null) vv = ii * rr;
    if (ii == null && vv != null && rr != null && rr != 0) ii = vv / rr;
    if (rr == null && vv != null && ii != null && ii != 0) rr = vv / ii;
    final p = (vv != null && ii != null) ? vv * ii : null;
    setState(() {
      result = 'V = ${vv?.toStringAsFixed(4) ?? "—"} ولت\n'
          'I = ${ii?.toStringAsFixed(6) ?? "—"} آمپر\n'
          'R = ${rr != null ? formatResistance(rr) : "—"}\n'
          '${p != null ? "P = ${formatPower(p)}" : ""}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⚡ قانون اهم'), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('دو مقدار را پر کن؛ سومی حساب می‌شود.', style: TextStyle(fontSize: 13)),
          const SizedBox(height: 12),
          TextField(controller: vCtrl, decoration: const InputDecoration(labelText: 'ولتاژ V (ولت)'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          const SizedBox(height: 10),
          TextField(controller: iCtrl, decoration: const InputDecoration(labelText: 'جریان I (آمپر)'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          const SizedBox(height: 10),
          TextField(controller: rCtrl, decoration: const InputDecoration(labelText: 'مقاومت R (مثلاً 1k)'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null) _resultBox(context, result!),
        ],
      ),
    );
  }
}

Widget _resultBox(BuildContext context, String text) {
  return Container(
    margin: const EdgeInsets.only(top: 16),
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.orange.withOpacity(0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.orange.withOpacity(0.35)),
    ),
    child: Text(text, style: TextStyle(fontSize: 16, height: 1.6, fontWeight: FontWeight.w600, color: context.cText)),
  );
}
