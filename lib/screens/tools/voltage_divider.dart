import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class VoltageDividerScreen extends StatefulWidget {
  const VoltageDividerScreen({super.key});

  @override
  State<VoltageDividerScreen> createState() => _VoltageDividerScreenState();
}

class _VoltageDividerScreenState extends State<VoltageDividerScreen> {
  final _vin = TextEditingController();
  final _r1 = TextEditingController();
  final _r2 = TextEditingController();
  String? result;

  void _calc() {
    final vin = parseNumber(_vin.text);
    final r1 = parseResistance(_r1.text);
    final r2 = parseResistance(_r2.text);
    if (vin == null || r1 == null || r2 == null || (r1 + r2) == 0) {
      setState(() => result = 'ورودی نامعتبر');
      return;
    }
    final vout = vin * r2 / (r1 + r2);
    final i = vin / (r1 + r2);
    final pr1 = i * i * r1;
    final pr2 = i * i * r2;
    setState(() {
      result = 'Vout = ${formatVoltage(vout)}\n'
          'نسبت = ${(vout / vin * 100).toStringAsFixed(1)}%\n\n'
          'جریان = ${formatCurrent(i)}\n'
          'توان R1 = ${formatPower(pr1)}\n'
          'توان R2 = ${formatPower(pr2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📐 تقسیم‌کننده ولتاژ')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(controller: _vin, keyboardType: const TextInputType.numberWithOptions(decimal: true), style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'Vin (ولت)')),
          const SizedBox(height: 12),
          TextField(controller: _r1, keyboardType: const TextInputType.numberWithOptions(decimal: true), style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'R1 (بالا)')),
          const SizedBox(height: 12),
          TextField(controller: _r2, keyboardType: const TextInputType.numberWithOptions(decimal: true), style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'R2 (پایین)')),
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
