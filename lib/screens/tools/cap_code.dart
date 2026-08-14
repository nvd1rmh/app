import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class CapCodeScreen extends StatefulWidget {
  const CapCodeScreen({super.key});
  @override
  State<CapCodeScreen> createState() => _CapCodeScreenState();
}

class _CapCodeScreenState extends State<CapCodeScreen> {
  final ctrl = TextEditingController();
  String? result;

  void _calc() {
    final f = parseCapCode(ctrl.text);
    setState(() {
      result = f == null ? 'کد نامعتبر\nمثال: 104 ، 473 ، 220 ، 4R7' : formatCapacitance(f);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🟠 کد خازن'), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(controller: ctrl, decoration: const InputDecoration(labelText: 'کد خازن', hintText: '104'), onSubmitted: (_) => _calc()),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه')),
          if (result != null)
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.purple.withOpacity(0.12), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.purple.withOpacity(0.35))),
              child: Text(result!, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: context.cText)),
            ),
        ],
      ),
    );
  }
}
