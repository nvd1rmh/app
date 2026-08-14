import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class OhmLawScreen extends StatefulWidget {
  const OhmLawScreen({super.key});

  @override
  State<OhmLawScreen> createState() => _OhmLawScreenState();
}

class _OhmLawScreenState extends State<OhmLawScreen> {
  final _v = TextEditingController();
  final _i = TextEditingController();
  final _r = TextEditingController();
  String? _result;

  void _calc() {
    final v = parseNumber(_v.text);
    final i = parseNumber(_i.text);
    final r = parseResistance(_r.text);

    String? out;
    if (v != null && i != null && r == null) {
      out = 'مقاومت = ${formatResistance(v / i)}';
    } else if (v != null && r != null && i == null) {
      out = 'جریان = ${formatCurrent(v / r)}';
    } else if (i != null && r != null && v == null) {
      out = 'ولتاژ = ${formatVoltage(i * r)}';
    } else if (v != null && i != null && r != null) {
      out = 'بررسی:\nV = ${formatVoltage(v)}\nI = ${formatCurrent(i)}\nR = ${formatResistance(r)}\n\nP = ${formatPower(v * i)}';
    } else {
      out = 'حداقل دو مقدار وارد کن (V و I یا V و R یا I و R)';
    }
    setState(() => _result = out);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⚡ قانون اهم')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'دو مقدار را وارد کن تا سومی محاسبه شود.\nP = V × I هم نمایش داده می‌شود.',
            style: GoogleFonts.vazirmatn(color: AppTheme.muted),
          ),
          const SizedBox(height: 20),
          _field(_v, 'ولتاژ (V)'),
          _field(_i, 'جریان (A یا mA)'),
          _field(_r, 'مقاومت (Ω ، k ، M)'),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (_result != null) _resultCard(_result!),
        ],
      ),
    );
  }

  Widget _field(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: c,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: GoogleFonts.vazirmatn(color: AppTheme.text),
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _resultCard(String text) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppTheme.card2,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppTheme.accent.withOpacity(0.35)),
          ),
          child: SelectableText(
            text,
            style: GoogleFonts.vazirmatn(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.accent,
              height: 1.7,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('کپی شد'), duration: Duration(seconds: 1)),
            );
          },
          icon: const Icon(Icons.copy, size: 18),
          label: Text('کپی', style: GoogleFonts.vazirmatn()),
        ),
      ],
    );
  }
}
