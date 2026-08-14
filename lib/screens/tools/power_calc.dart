import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class PowerCalcScreen extends StatefulWidget {
  const PowerCalcScreen({super.key});

  @override
  State<PowerCalcScreen> createState() => _PowerCalcScreenState();
}

class _PowerCalcScreenState extends State<PowerCalcScreen> {
  final _v = TextEditingController();
  final _i = TextEditingController();
  final _r = TextEditingController();
  String? result;

  void _calc() {
    final v = parseNumber(_v.text);
    final i = parseNumber(_i.text);
    final r = parseResistance(_r.text);

    if (v != null && i != null) {
      setState(() => result = 'P = ${formatPower(v * i)}');
    } else if (v != null && r != null) {
      setState(() => result = 'P = ${formatPower(v * v / r)}');
    } else if (i != null && r != null) {
      setState(() => result = 'P = ${formatPower(i * i * r)}');
    } else {
      setState(() => result = 'حداقل دو مقدار از V، I، R وارد کن');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🔋 محاسبه توان')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('P = V×I = V²/R = I²R', style: GoogleFonts.vazirmatn(color: AppTheme.muted)),
          const SizedBox(height: 16),
          TextField(controller: _v, style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'ولتاژ (V)')),
          const SizedBox(height: 12),
          TextField(controller: _i, style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'جریان (A)')),
          const SizedBox(height: 12),
          TextField(controller: _r, style: GoogleFonts.vazirmatn(color: AppTheme.text), decoration: const InputDecoration(labelText: 'مقاومت (Ω)')),
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
