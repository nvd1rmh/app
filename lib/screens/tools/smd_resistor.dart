import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class SmdResistorScreen extends StatefulWidget {
  const SmdResistorScreen({super.key});
  @override
  State<SmdResistorScreen> createState() => _SmdResistorScreenState();
}

class _SmdResistorScreenState extends State<SmdResistorScreen> {
  final ctrl = TextEditingController();
  String? result;

  void _calc() {
    final p = parseSmdCode(ctrl.text);
    setState(() {
      result = p == null ? 'کد نامعتبر\nمثال: 103 ، 472 ، 4R7 ، 01A' : '${formatResistance(p.$1)}\nکد: ${p.$2}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🔢 SMD'), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('سه/چهار رقمی، فرم R، یا EIA-96', style: TextStyle(fontSize: 13)),
          const SizedBox(height: 12),
          TextField(controller: ctrl, decoration: const InputDecoration(labelText: 'کد SMD', hintText: '103'), textCapitalization: TextCapitalization.characters, onSubmitted: (_) => _calc()),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null)
            ResultBox(result!),
        ],
      ),
    );
  }
}
