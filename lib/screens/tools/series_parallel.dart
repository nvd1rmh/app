import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class SeriesParallelScreen extends StatefulWidget {
  final String type; // R C L
  const SeriesParallelScreen({super.key, required this.type});
  @override
  State<SeriesParallelScreen> createState() => _SeriesParallelScreenState();
}

class _SeriesParallelScreenState extends State<SeriesParallelScreen> {
  final ctrl = TextEditingController();
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
    final parts = ctrl.text.split(RegExp(r'[,،\s]+')).where((s) => s.isNotEmpty);
    final vals = <double>[];
    for (final p in parts) {
      double? v;
      if (widget.type == 'C') {
        v = parseCapacitance(p);
      } else if (widget.type == 'L') {
        v = parseInductance(p);
      } else {
        v = parseResistance(p);
      }
      if (v != null && v > 0) vals.add(v);
    }
    if (vals.isEmpty) {
      setState(() => result = 'مقادیر نامعتبر');
      return;
    }
    double out;
    if (series) {
      if (widget.type == 'C') {
        out = 1.0 / vals.map((v) => 1.0 / v).reduce((a, b) => a + b);
      } else {
        out = vals.reduce((a, b) => a + b);
      }
    } else {
      if (widget.type == 'C') {
        out = vals.reduce((a, b) => a + b);
      } else {
        out = 1.0 / vals.map((v) => 1.0 / v).reduce((a, b) => a + b);
      }
    }
    String fmt;
    if (widget.type == 'C') {
      fmt = formatCapacitance(out);
    } else if (widget.type == 'L') {
      fmt = formatInductance(out);
    } else {
      fmt = formatResistance(out);
    }
    setState(() => result = '${series ? "سری" : "موازی"}: $fmt\nتعداد: ${vals.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('مقادیر را با فاصله یا ویرگول جدا کن', style: TextStyle(color: context.cMuted)),
          const SizedBox(height: 12),
          TextField(controller: ctrl, decoration: InputDecoration(labelText: 'مقادیر', hintText: widget.type == 'C' ? '100nF, 220nF' : '1k 2.2k 4.7k')),
          const SizedBox(height: 12),
          Row(
            children: [
              ChoiceChip(label: const Text('سری'), selected: series, onSelected: (_) => setState(() => series = true)),
              const SizedBox(width: 8),
              ChoiceChip(label: const Text('موازی'), selected: !series, onSelected: (_) => setState(() => series = false)),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null)
            ResultBox(result!),
        ],
      ),
    );
  }
}
