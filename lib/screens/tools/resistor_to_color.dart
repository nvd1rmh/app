import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

class ResistorToColorScreen extends StatefulWidget {
  const ResistorToColorScreen({super.key});
  @override
  State<ResistorToColorScreen> createState() => _ResistorToColorScreenState();
}

class _ResistorToColorScreenState extends State<ResistorToColorScreen> {
  final ctrl = TextEditingController();
  List<String>? colors;
  String? info;

  Color _hex(String name) {
    final c = colorHex[name];
    return c != null ? Color(c.value) : Colors.grey;
  }

  void _calc() {
    final r = parseResistance(ctrl.text);
    if (r == null || r <= 0) {
      setState(() {
        colors = null;
        info = 'مقدار نامعتبر';
      });
      return;
    }
    final cols = valueToColors(r);
    final near = findNearestE24(r);
    final lower = near[0];
    final higher = near[1];
    setState(() {
      colors = cols;
      info = 'ورودی: ${formatResistance(r)}\n'
          '${lower != null ? 'پایین‌تر E24: ${formatResistance(lower)}\n' : ''}'
          '${higher != null ? 'بالاتر E24: ${formatResistance(higher)}' : ''}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مقدار ← رنگ'),
        leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: ctrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'مقاومت (مثلاً 4.7k یا 4700)',
              hintText: '10k',
            ),
            onSubmitted: (_) => _calc(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _calc, child: const Text('محاسبه رنگ')),
          if (colors != null) ...[
            const SizedBox(height: 24),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4A574),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < colors!.length; i++) ...[
                      if (i == 3) const SizedBox(width: 16),
                      if (i > 0 && i < 3) const SizedBox(width: 10),
                      Container(
                        width: 14,
                        height: 65,
                        decoration: BoxDecoration(
                          color: _hex(colors![i]),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(colors!.length, (i) {
              final labels = ['رقم ۱ (چپ)', 'رقم ۲', 'ضریب', 'تلرانس'];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _hex(colors![i]),
                        shape: BoxShape.circle,
                        border: Border.all(color: context.cLine),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('${labels[i]}: ${colors![i]}', style: TextStyle(color: context.cText, fontSize: 15)),
                  ],
                ),
              );
            }),
          ],
          if (info != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: context.cCard2,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(info!, style: TextStyle(color: context.cText, height: 1.5)),
            ),
          ],
        ],
      ),
    );
  }
}
