import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class LedResistorScreen extends StatefulWidget {
  const LedResistorScreen({super.key});

  @override
  State<LedResistorScreen> createState() => _LedResistorScreenState();
}

class _LedResistorScreenState extends State<LedResistorScreen> {
  final _vs = TextEditingController(text: '5');
  final _vf = TextEditingController(text: '2.0');
  final _ma = TextEditingController(text: '20');
  final _series = TextEditingController(text: '1');
  final _parallel = TextEditingController(text: '1');
  String? result;

  void _calc() {
    final vs = parseNumber(_vs.text);
    final vf = parseNumber(_vf.text);
    final ma = parseNumber(_ma.text);
    final series = (parseNumber(_series.text) ?? 1).toInt().clamp(1, 100);
    final parallel = (parseNumber(_parallel.text) ?? 1).toInt().clamp(1, 100);
    if (vs == null || vf == null || ma == null || ma <= 0) {
      setState(() => result = 'ورودی نامعتبر');
      return;
    }
    final totalVf = vf * series;
    if (totalVf >= vs) {
      setState(() => result = 'ولتاژ منبع کمتر از مجموع افت LEDهاست!');
      return;
    }
    final i = ma / 1000;
    final idealR = (vs - totalVf) / i;
    final power = (vs - totalVf) * i;
    final nearest = findNearestE24(idealR);
    final higher = nearest[1];
    final lower = nearest[0];

    final buf = StringBuffer();
    buf.writeln('مقاومت ایده‌آل: ${formatResistance(idealR)}');
    buf.writeln('توان تقریبی: ${formatPower(power)}');
    buf.writeln('پیشنهاد توان: حداقل ${formatPower(power * 2)}');
    if (higher != null) {
      final actualMa = (vs - totalVf) / higher * 1000;
      buf.writeln('\n↑ E24 بالاتر: ${formatResistance(higher)} → ≈ ${actualMa.toStringAsFixed(1)} mA');
    }
    if (lower != null && (higher == null || (lower - higher).abs() > 1e-9)) {
      final actualMa = (vs - totalVf) / lower * 1000;
      buf.writeln('↓ E24 پایین‌تر: ${formatResistance(lower)} → ≈ ${actualMa.toStringAsFixed(1)} mA');
    }
    buf.writeln('\nجریان کل ≈ ${(ma * parallel).toStringAsFixed(1)} mA');
    setState(() => result = buf.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💡 مقاومت LED')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _f(_vs, 'ولتاژ منبع (V)'),
          _f(_vf, 'ولتاژ افت هر LED (Vf)'),
          _f(_ma, 'جریان هر شاخه (mA)'),
          _f(_series, 'تعداد سری'),
          _f(_parallel, 'تعداد موازی'),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.card2,
                borderRadius: BorderRadius.circular(18),
              ),
              child: SelectableText(
                result!,
                style: GoogleFonts.vazirmatn(
                  fontSize: 15,
                  height: 1.7,
                  color: AppTheme.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _f(TextEditingController c, String label) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: c,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: GoogleFonts.vazirmatn(color: AppTheme.text),
          decoration: InputDecoration(labelText: label),
        ),
      );
}
