import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class CapCodeScreen extends StatefulWidget {
  const CapCodeScreen({super.key});

  @override
  State<CapCodeScreen> createState() => _CapCodeScreenState();
}

class _CapCodeScreenState extends State<CapCodeScreen> {
  final _ctrl = TextEditingController();
  String? result;

  void _calc() {
    final code = _ctrl.text.trim().toUpperCase();
    if (code.isEmpty) {
      setState(() => result = 'کد را وارد کن');
      return;
    }
    // R notation
    final rMatch = RegExp(r'^(\d*)R(\d+)$').firstMatch(code);
    if (rMatch != null) {
      final whole = rMatch.group(1)!.isEmpty ? '0' : rMatch.group(1)!;
      final pf = double.parse('$whole.${rMatch.group(2)}');
      setState(() => result = formatCapacitance(pf * 1e-12));
      return;
    }
    if (RegExp(r'^\d+$').hasMatch(code)) {
      if (code.length >= 3) {
        final sig = code.substring(0, code.length - 1);
        final mult = int.parse(code[code.length - 1]);
        final pf = int.parse(sig) * _pow10(mult);
        setState(() => result = formatCapacitance(pf * 1e-12));
        return;
      }
      if (code.length <= 2) {
        final pf = double.parse(code);
        setState(() => result = formatCapacitance(pf * 1e-12));
        return;
      }
    }
    setState(() => result = 'کد شناخته نشد');
  }

  int _pow10(int e) {
    int r = 1;
    for (int i = 0; i < e; i++) r *= 10;
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🟠 کد خازن سرامیکی')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'کد خازن را وارد کن (مثلاً 104 = 100nF ، 22 = 22pF)',
            style: GoogleFonts.vazirmatn(color: AppTheme.muted),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _ctrl,
            keyboardType: TextInputType.number,
            style: GoogleFonts.vazirmatn(color: AppTheme.text, fontSize: 22, letterSpacing: 2),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(labelText: 'کد'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null) ...[
            const SizedBox(height: 28),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: AppTheme.card2, borderRadius: BorderRadius.circular(18)),
              child: Text(
                result!,
                textAlign: TextAlign.center,
                style: GoogleFonts.vazirmatn(fontSize: 24, fontWeight: FontWeight.w800, color: AppTheme.accent2),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
