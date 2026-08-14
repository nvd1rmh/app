import 'package:flutter/material.dart';
import '../../theme.dart';

class GenericToolScreen extends StatefulWidget {
  final String title;
  final String description;
  final List<String> fields;
  final String Function(List<String> vals) compute;
  final List<String>? hints;

  const GenericToolScreen({
    super.key,
    required this.title,
    required this.description,
    required this.fields,
    required this.compute,
    this.hints,
  });

  @override
  State<GenericToolScreen> createState() => _GenericToolScreenState();
}

class _GenericToolScreenState extends State<GenericToolScreen> {
  late final List<TextEditingController> ctrls;
  String? result;

  @override
  void initState() {
    super.initState();
    ctrls = List.generate(widget.fields.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final c in ctrls) {
      c.dispose();
    }
    super.dispose();
  }

  void _run() {
    setState(() {
      result = widget.compute(ctrls.map((c) => c.text).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(widget.description, style: TextStyle(color: context.cMuted, height: 1.5)),
          const SizedBox(height: 16),
          for (var i = 0; i < widget.fields.length; i++) ...[
            TextField(
              controller: ctrls[i],
              decoration: InputDecoration(
                labelText: widget.fields[i],
                hintText: widget.hints != null && i < widget.hints!.length ? widget.hints![i] : null,
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
          ],
          ElevatedButton(onPressed: _run, child: const Text('محاسبه')),
          if (result != null)
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.orange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.orange.withOpacity(0.35)),
              ),
              child: Text(result!, style: TextStyle(fontSize: 16, height: 1.6, fontWeight: FontWeight.w600, color: context.cText)),
            ),
        ],
      ),
    );
  }
}
