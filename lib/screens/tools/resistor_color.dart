import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../utils/formatters.dart';

/// باندها از چپ به راست (استاندارد): رقم۱، رقم۲، ضریب، تلرانس
class ResistorColorScreen extends StatefulWidget {
  const ResistorColorScreen({super.key});

  @override
  State<ResistorColorScreen> createState() => _ResistorColorScreenState();
}

class _ResistorColorScreenState extends State<ResistorColorScreen> {
  String? band1, band2, band3, band4;
  String? result;

  static const digitOpts = [
    'مشکی', 'قهوه‌ای', 'قرمز', 'نارنجی', 'زرد', 'سبز', 'آبی', 'بنفش', 'خاکستری', 'سفید'
  ];
  static const multOpts = [
    'مشکی', 'قهوه‌ای', 'قرمز', 'نارنجی', 'زرد', 'سبز', 'آبی', 'بنفش', 'طلایی', 'نقره‌ای'
  ];
  static const tolOpts = ['طلایی', 'نقره‌ای', 'قهوه‌ای', 'قرمز', 'سبز', 'آبی', 'بنفش'];

  Color _hex(String name) {
    final c = colorHex[name];
    return c != null ? Color(c.value) : Colors.grey;
  }

  void _calc() {
    if (band1 == null || band2 == null || band3 == null) {
      setState(() => result = 'حداقل سه باند (رقم۱، رقم۲، ضریب) را انتخاب کن');
      return;
    }
    final d1 = digitColors[band1]!;
    final d2 = digitColors[band2]!;
    final mult = multColors[band3] ?? 1.0;
    final ohms = (d1 * 10 + d2) * mult;
    final tol = band4 != null ? (tolColors[band4] ?? '') : '';
    setState(() {
      result = '${formatResistance(ohms)}${tol.isNotEmpty ? '\nتلرانس: $tol' : ''}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎨 رنگ مقاومت'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // راهنما
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.orange.withOpacity(0.3)),
            ),
            child: Text(
              'باندها از چپ به راست: رقم ۱ ← رقم ۲ ← ضریب ← تلرانس\n'
              '(همان ترتیب استاندارد روی مقاومت واقعی)',
              style: TextStyle(fontSize: 12.5, color: context.cText, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),

          // Visual — ALWAYS LTR so left = first band
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFD4A574),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _band(band1),
                  const SizedBox(width: 10),
                  _band(band2),
                  const SizedBox(width: 10),
                  _band(band3),
                  const SizedBox(width: 18),
                  _band(band4),
                ],
              ),
            ),
          ),
          // Labels under visual (also LTR order labels in Persian context)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _label('تلرانس'),
                _label('ضریب'),
                _label('رقم ۲'),
                _label('رقم ۱'),
              ],
            ),
          ),

          _picker('باند ۱ — رقم اول (چپ)', digitOpts, band1, (v) {
            setState(() {
              band1 = v;
              _calc();
            });
          }),
          _picker('باند ۲ — رقم دوم', digitOpts, band2, (v) {
            setState(() {
              band2 = v;
              _calc();
            });
          }),
          _picker('باند ۳ — ضریب', multOpts, band3, (v) {
            setState(() {
              band3 = v;
              _calc();
            });
          }),
          _picker('باند ۴ — تلرانس (اختیاری)', tolOpts, band4, (v) {
            setState(() {
              band4 = v;
              _calc();
            });
          }),

          if (result != null) ResultBox(result!),
        ],
      ),
    );
  }

  Widget _band(String? name) {
    return Container(
      width: 14,
      height: 70,
      decoration: BoxDecoration(
        color: name != null ? _hex(name) : Colors.black26,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.black26),
      ),
    );
  }

  Widget _label(String t) {
    return Text(t, style: TextStyle(fontSize: 11, color: context.cMuted));
  }

  Widget _picker(String label, List<String> options, String? value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: context.cMuted, fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((c) {
              final selected = value == c;
              return GestureDetector(
                onTap: () => onChanged(c),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? _hex(c).withOpacity(0.28) : context.cCard2,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? _hex(c) : context.cLine,
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: _hex(c),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(c, style: TextStyle(fontSize: 13, color: context.cText)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
