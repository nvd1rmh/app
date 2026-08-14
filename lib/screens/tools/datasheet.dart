import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';

const knownDatasheets = {
  '555': 'https://www.ti.com/lit/ds/symlink/ne555.pdf',
  'ne555': 'https://www.ti.com/lit/ds/symlink/ne555.pdf',
  'lm358': 'https://www.ti.com/lit/ds/symlink/lm358.pdf',
  'lm324': 'https://www.ti.com/lit/ds/symlink/lm324.pdf',
  'lm741': 'https://www.ti.com/lit/ds/symlink/lm741.pdf',
  'atmega328': 'https://ww1.microchip.com/downloads/en/DeviceDoc/Atmega328-328P_summary.pdf',
  'atmega8': 'https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2486-8-bit-AVR-microcontroller-ATmega8_L_datasheet.pdf',
  'esp32': 'https://www.espressif.com/sites/default/files/documentation/esp32_datasheet_en.pdf',
  'esp8266': 'https://www.espressif.com/sites/default/files/documentation/0a-esp8266ex_datasheet_en.pdf',
  '7805': 'https://www.st.com/resource/en/datasheet/l7805.pdf',
  '7812': 'https://www.st.com/resource/en/datasheet/l7812.pdf',
  'lm317': 'https://www.ti.com/lit/ds/symlink/lm317.pdf',
  'bc547': 'https://www.onsemi.com/pdf/datasheet/bc546-d.pdf',
  '2n2222': 'https://www.onsemi.com/pdf/datasheet/p2n2222a-d.pdf',
  'irfz44n': 'https://www.infineon.com/dgdl/irfz44n.pdf',
  '1n4007': 'https://www.vishay.com/docs/88503/1n4001.pdf',
  '1n4148': 'https://www.vishay.com/docs/85713/1n4148.pdf',
  'hc-sr04': 'https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf',
  'dht11': 'https://www.mouser.com/datasheet/2/758/DHT11-Technical-Data-Sheet-Translated-Version-1143054.pdf',
  'dht22': 'https://www.sparkfun.com/datasheets/Sensors/Temperature/DHT22.pdf',
  'ds18b20': 'https://www.analog.com/media/en/technical-documentation/data-sheets/ds18b20.pdf',
  'mpu6050': 'https://invensense.tdk.com/wp-content/uploads/2015/02/MPU-6000-Datasheet1.pdf',
  'l298': 'https://www.st.com/resource/en/datasheet/l298.pdf',
  'uln2003': 'https://www.ti.com/lit/ds/symlink/uln2003a.pdf',
  'tp4056': 'https://dlnmh9ip6v2uc.cloudfront.net/datasheets/Prototyping/TP4056.pdf',
};

class DatasheetScreen extends StatefulWidget {
  const DatasheetScreen({super.key});

  @override
  State<DatasheetScreen> createState() => _DatasheetScreenState();
}

class _DatasheetScreenState extends State<DatasheetScreen> {
  final _ctrl = TextEditingController();
  String? link;
  String? message;

  void _search() {
    final q = _ctrl.text.trim().toLowerCase().replaceAll(' ', '');
    if (q.isEmpty) {
      setState(() {
        link = null;
        message = 'اسم قطعه را بنویس';
      });
      return;
    }
    for (final e in knownDatasheets.entries) {
      final key = e.key.replaceAll(' ', '');
      if (key.contains(q) || q.contains(key)) {
        setState(() {
          link = e.value;
          message = 'پیدا شد: ${e.key}';
        });
        return;
      }
    }
    final search = 'https://www.alldatasheet.com/view.jsp?Searchword=${Uri.encodeComponent(_ctrl.text.trim())}';
    setState(() {
      link = search;
      message = 'در لیست داخلی نبود — لینک جستجو:';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📄 دیتاشیت')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'اسم یا کد قطعه را بنویس (مثلاً 555، atmega328، lm358)',
            style: GoogleFonts.vazirmatn(color: AppTheme.muted),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _ctrl,
            style: GoogleFonts.vazirmatn(color: AppTheme.text),
            decoration: const InputDecoration(labelText: 'نام قطعه'),
            onSubmitted: (_) => _search(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _search, child: const Text('جستجو')),
          if (message != null) ...[
            const SizedBox(height: 24),
            Text(message!, style: GoogleFonts.vazirmatn(color: AppTheme.success, fontWeight: FontWeight.w600)),
            if (link != null) ...[
              const SizedBox(height: 12),
              SelectableText(
                link!,
                style: GoogleFonts.vazirmatn(color: AppTheme.accent2, fontSize: 13),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: link!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('لینک کپی شد'), duration: Duration(seconds: 1)),
                  );
                },
                icon: const Icon(Icons.copy, size: 18),
                label: Text('کپی لینک', style: GoogleFonts.vazirmatn()),
              ),
              Text(
                'لینک را در مرورگر گوشی باز کن (اپ کاملاً آفلاین است و خودش مرورگر باز نمی‌کند)',
                style: GoogleFonts.vazirmatn(color: AppTheme.dim, fontSize: 12),
              ),
            ],
          ],
          const SizedBox(height: 32),
          Text('قطعات موجود در لیست:', style: GoogleFonts.vazirmatn(color: AppTheme.muted, fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: knownDatasheets.keys.map((k) {
              return ActionChip(
                label: Text(k, style: GoogleFonts.vazirmatn(fontSize: 12)),
                onPressed: () {
                  _ctrl.text = k;
                  _search();
                },
                backgroundColor: AppTheme.card2,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
