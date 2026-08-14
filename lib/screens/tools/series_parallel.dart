import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class SeriesParallelScreen extends StatefulWidget {
  final String type; // R, C, L
  const SeriesParallelScreen({super.key, required this.type});

  @override
  State<SeriesParallelScreen> createState() => _SeriesParallelScreenState();
}

class _SeriesParallelScreenState extends State<SeriesParallelScreen> {
  final _ctrl = TextEditingController();
  bool series = true;
  String? result;

  String get title {
    switch (widget.type) {
      case 'C': return 'سری/موازی خازن';
      case 'L': return 'سری/موازی سلف';
      default: return 'سری/موازی مقاومت';
    }
  }

  void _calc() {
    final parts = _ctrl.text.split(RegExp(r'[,،\s\n]+')).where((s) => s.trim().isNotEmpty).toList();
    if (parts.isEmpty) {
      setState(() => result = 'حداقل یک مقدار وارد کن');
      return;
    }
    final values = <double>[];
    for (final p in parts) {
      double? v;
      if (widget.type == 'C') v = parseCapacitance(p);
      else if (widget.type == 'L') v = parseInductance(p);
      else v = parseResistance(p);
      if (v == null || v <= 0) {
        setState(() => result = 'مقدار نامعتبر: $p');
        return;
      }
      values.add(v);
    }

    double eq;
    if (series) {
      if (widget.type == 'C') {
        // capacitors series: 1/Ceq = sum 1/C
        eq = 1 / values.map((c) => 1 / c).reduce((a, b) => a + b);
      } else {
        eq = values.reduce((a, b) => a + b);
      }
    } else {
      if (widget.type == 'C') {
        eq = values.reduce((a, b) => a + b);
      } else {
        eq = 1 / values.map((r) => 1 / r).reduce((a, b) => a + b);
      }
    }

    String formatted;
    if (widget.type == 'C') formatted = formatCapacitance(eq);
    else if (widget.type == 'L') formatted = formatInductance(eq);
    else formatted = formatResistance(eq);

    setState(() => result = '${series ? "سری" : "موازی"} → $formatted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text('سری'),
                  selected: series,
                  onSelected: (_) => setState(() => series = true),
                  selectedColor: AppTheme.accent.withOpacity(0.3),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ChoiceChip(
                  label: const Text('موازی'),
                  selected: !series,
                  onSelected: (_) => setState(() => series = false),
                  selectedColor: AppTheme.accent.withOpacity(0.3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'مقادیر را با کاما یا خط جدید جدا کن\nمثال: 100, 220, 4.7k',
            style: GoogleFonts.vazirmatn(color: AppTheme.muted, fontSize: 13),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _ctrl,
            maxLines: 4,
            style: GoogleFonts.vazirmatn(color: AppTheme.text),
            decoration: const InputDecoration(labelText: 'مقادیر'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: AppTheme.card2, borderRadius: BorderRadius.circular(18)),
              child: Text(result!, textAlign: TextAlign.center, style: GoogleFonts.vazirmatn(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.accent)),
            ),
          ],
        ],
      ),
    );
  }
}
