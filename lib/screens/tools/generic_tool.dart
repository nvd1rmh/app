import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';

class GenericToolScreen extends StatefulWidget {
  final String title;
  final String description;
  final List<String> fields;
  final String Function(List<String> values) compute;

  const GenericToolScreen({
    super.key,
    required this.title,
    required this.description,
    required this.fields,
    required this.compute,
  });

  @override
  State<GenericToolScreen> createState() => _GenericToolScreenState();
}

class _GenericToolScreenState extends State<GenericToolScreen> {
  late List<TextEditingController> _ctrls;
  String? _result;

  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(widget.fields.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final c in _ctrls) c.dispose();
    super.dispose();
  }

  void _calc() {
    final vals = _ctrls.map((c) => c.text.trim()).toList();
    setState(() => _result = widget.compute(vals));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(widget.description, style: GoogleFonts.vazirmatn(color: AppTheme.muted, fontSize: 14)),
          const SizedBox(height: 20),
          ...List.generate(widget.fields.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: TextField(
                controller: _ctrls[i],
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: GoogleFonts.vazirmatn(color: AppTheme.text),
                decoration: InputDecoration(labelText: widget.fields[i]),
              ),
            );
          }),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _calc,
            child: const Text('محاسبه'),
          ),
          if (_result != null) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.card2,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
              ),
              child: SelectableText(
                _result!,
                style: GoogleFonts.vazirmatn(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.accent,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _result!));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('کپی شد'), duration: Duration(seconds: 1)),
                );
              },
              icon: const Icon(Icons.copy, size: 18),
              label: Text('کپی نتیجه', style: GoogleFonts.vazirmatn()),
            ),
          ],
        ],
      ),
    );
  }
}
