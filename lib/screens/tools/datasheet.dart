import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme.dart';

const datasheets = {
  'NE555': 'https://www.ti.com/lit/ds/symlink/ne555.pdf',
  'LM358': 'https://www.ti.com/lit/ds/symlink/lm358.pdf',
  'LM324': 'https://www.ti.com/lit/ds/symlink/lm324.pdf',
  'LM741': 'https://www.ti.com/lit/ds/symlink/lm741.pdf',
  'LM317': 'https://www.ti.com/lit/ds/symlink/lm317.pdf',
  'LM386': 'https://www.ti.com/lit/ds/symlink/lm386.pdf',
  '7805': 'https://www.st.com/resource/en/datasheet/l7805.pdf',
  '7812': 'https://www.st.com/resource/en/datasheet/l7812.pdf',
  'L298': 'https://www.st.com/resource/en/datasheet/l298.pdf',
  'L293D': 'https://www.ti.com/lit/ds/symlink/l293d.pdf',
  'A4988': 'https://www.pololu.com/file/0J450/A4988.pdf',
  'ULN2003': 'https://www.ti.com/lit/ds/symlink/uln2003a.pdf',
  'ATmega328': 'https://ww1.microchip.com/downloads/en/DeviceDoc/Atmega328-328P_summary.pdf',
  'ATtiny85': 'https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2586-AVR-8-bit-Microcontroller-ATtiny25-ATtiny45-ATtiny85_Datasheet.pdf',
  'ESP32': 'https://www.espressif.com/sites/default/files/documentation/esp32_datasheet_en.pdf',
  'ESP8266': 'https://www.espressif.com/sites/default/files/documentation/0a-esp8266ex_datasheet_en.pdf',
  'STM32F103': 'https://www.st.com/resource/en/datasheet/stm32f103c8.pdf',
  'BC547': 'https://www.onsemi.com/pdf/datasheet/bc546-d.pdf',
  '2N2222': 'https://www.onsemi.com/pdf/datasheet/p2n2222a-d.pdf',
  'IRFZ44N': 'https://www.infineon.com/dgdl/irfz44n.pdf',
  '1N4007': 'https://www.vishay.com/docs/88503/1n4001.pdf',
  '1N4148': 'https://www.vishay.com/docs/85713/1n4148.pdf',
  'HC-SR04': 'https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf',
  'DHT11': 'https://www.mouser.com/datasheet/2/758/DHT11-Technical-Data-Sheet-Translated-Version-1143054.pdf',
  'DHT22': 'https://www.sparkfun.com/datasheets/Sensors/Temperature/DHT22.pdf',
  'DS18B20': 'https://www.analog.com/media/en/technical-documentation/data-sheets/ds18b20.pdf',
  'MPU6050': 'https://invensense.tdk.com/wp-content/uploads/2015/02/MPU-6000-Datasheet1.pdf',
  'RC522': 'https://www.nxp.com/docs/en/data-sheet/MFRC522.pdf',
  'TP4056': 'https://dlnmh9ip6v2uc.cloudfront.net/datasheets/Prototyping/TP4056.pdf',
  'CH340': 'https://www.wch-ic.com/downloads/CH340DS1_PDF.html',
};

class DatasheetScreen extends StatefulWidget {
  const DatasheetScreen({super.key});
  @override
  State<DatasheetScreen> createState() => _DatasheetScreenState();
}

class _DatasheetScreenState extends State<DatasheetScreen> {
  String q = '';

  @override
  Widget build(BuildContext context) {
    final keys = datasheets.keys.where((k) => k.toLowerCase().contains(q.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('📄 دیتاشیت'), leading: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => Navigator.pop(context))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(labelText: 'جستجو', hintText: 'NE555 ، ESP32 ، …', prefixIcon: Icon(Icons.search)),
              onChanged: (v) => setState(() => q = v),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              itemCount: keys.length,
              itemBuilder: (context, i) {
                final name = keys[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(name, style: TextStyle(fontWeight: FontWeight.w700, color: context.cText)),
                    trailing: const Icon(Icons.open_in_new, size: 18),
                    onTap: () async {
                      final uri = Uri.parse(datasheets[name]!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
