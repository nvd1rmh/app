import 'package:flutter/material.dart';
import 'tools/ohm_law.dart';
import 'tools/resistor_color.dart';
import 'tools/resistor_to_color.dart';
import 'tools/led_resistor.dart';
import 'tools/voltage_divider.dart';
import 'tools/smd_resistor.dart';
import 'tools/cap_code.dart';
import 'tools/lc_resonance.dart';
import 'tools/series_parallel.dart';
import 'tools/reactance.dart';
import 'tools/timer555.dart';
import 'tools/power_calc.dart';
import 'tools/datasheet.dart';
import 'tools/generic_tool.dart';

void openTool(BuildContext context, String id) {
  Widget page;
  switch (id) {
    case 'ohm':
      page = const OhmLawScreen();
      break;
    case 'res_color':
      page = const ResistorColorScreen();
      break;
    case 'res_to_color':
      page = const ResistorToColorScreen();
      break;
    case 'res_led':
      page = const LedResistorScreen();
      break;
    case 'vdiv':
      page = const VoltageDividerScreen();
      break;
    case 'res_smd':
      page = const SmdResistorScreen();
      break;
    case 'cap_code':
      page = const CapCodeScreen();
      break;
    case 'lc_res':
      page = const LcResonanceScreen();
      break;
    case 'res_series_parallel':
      page = const SeriesParallelScreen(type: 'R');
      break;
    case 'cap_series_parallel':
      page = const SeriesParallelScreen(type: 'C');
      break;
    case 'ind_series_parallel':
      page = const SeriesParallelScreen(type: 'L');
      break;
    case 'reactance':
      page = const ReactanceScreen();
      break;
    case 'timer555':
      page = const Timer555Screen();
      break;
    case 'power':
      page = const PowerCalcScreen();
      break;
    case 'datasheet':
      page = const DatasheetScreen();
      break;
    // Placeholders for remaining tools (UI ready, logic can be extended)
    case 'res_e_series':
      page = GenericToolScreen(
        title: 'نزدیک‌ترین E-series',
        description: 'مقاومت ایده‌آل را وارد کن تا نزدیک‌ترین مقدار استاندارد E24 نمایش داده شود.',
        fields: ['مقاومت ایده‌آل (اهم)'],
        compute: (vals) {
          final r = double.tryParse(vals[0].replaceAll(',', '.'));
          if (r == null || r <= 0) return 'مقدار نامعتبر';
          // simple nearest
          return 'نزدیک‌ترین E24 ≈ ${r.toStringAsFixed(2)} اهم\n(پیاده‌سازی کامل در نسخه بعدی)';
        },
      );
      break;
    case 'res_zener':
      page = GenericToolScreen(
        title: 'مقاومت سری زنر',
        description: 'Vin، Vz و Iz را وارد کن.',
        fields: ['Vin (ولت)', 'Vz (ولت)', 'Iz (میلی‌آمپر)'],
        compute: (vals) {
          final vin = double.tryParse(vals[0].replaceAll(',', '.'));
          final vz = double.tryParse(vals[1].replaceAll(',', '.'));
          final iz = double.tryParse(vals[2].replaceAll(',', '.'));
          if (vin == null || vz == null || iz == null || iz == 0) return 'ورودی نامعتبر';
          final rs = (vin - vz) / (iz / 1000);
          final pr = (vin - vz) * (iz / 1000);
          final pz = vz * (iz / 1000);
          return 'Rs = ${rs.toStringAsFixed(1)} اهم\nتوان مقاومت ≈ ${pr.toStringAsFixed(3)} وات\nتوان زنر ≈ ${pz.toStringAsFixed(3)} وات';
        },
      );
      break;
    case 'cap_energy':
      page = GenericToolScreen(
        title: 'انرژی خازن',
        description: 'ظرفیت و ولتاژ را وارد کن (E = ½CV²)',
        fields: ['ظرفیت (مثلاً 100uF)', 'ولتاژ (ولت)'],
        compute: (vals) {
          // simplified
          return 'برای محاسبه دقیق از فرمت‌های واحد استفاده کن (در نسخه کامل).';
        },
      );
      break;
    case 'cap_rc':
      page = GenericToolScreen(
        title: 'ثابت زمانی RC',
        description: 'τ = R × C',
        fields: ['مقاومت (اهم)', 'خازن (مثلاً 10uF)'],
        compute: (vals) => 'τ = R × C',
      );
      break;
    case 'ind_color':
      page = GenericToolScreen(
        title: 'رنگ سلف',
        description: 'رنگ‌ها را انتخاب کن (نسخه کامل رنگی به‌زودی)',
        fields: [],
        compute: (_) => 'از بخش مقاومت رنگی می‌توانی الگو بگیری.',
      );
      break;
    case 'ind_energy':
      page = GenericToolScreen(
        title: 'انرژی سلف',
        description: 'E = ½ L I²',
        fields: ['سلف (مثلاً 10mH)', 'جریان (آمپر)'],
        compute: (_) => 'E = ½LI²',
      );
      break;
    case 'crystal':
      page = GenericToolScreen(
        title: 'کریستال / اسیلاتور',
        description: 'فرکانس را وارد کن',
        fields: ['فرکانس (مثلاً 16MHz)'],
        compute: (vals) {
          final f = double.tryParse(vals[0].replaceAll(RegExp(r'[^0-9.]'), ''));
          if (f == null) return 'نامعتبر';
          final period = 1 / (f * 1e6);
          return 'پریود ≈ ${(period * 1e9).toStringAsFixed(2)} ns';
        },
      );
      break;
    case 'filter_rc':
      page = GenericToolScreen(
        title: 'فرکانس قطع فیلتر',
        description: 'fc = 1/(2πRC) یا R/(2πL)',
        fields: ['R (اهم)', 'C یا L'],
        compute: (_) => 'fc = 1 / (2πRC)',
      );
      break;
    case 'wavelength':
      page = GenericToolScreen(
        title: 'طول موج / آنتن',
        description: 'فرکانس را وارد کن',
        fields: ['فرکانس (MHz)'],
        compute: (vals) {
          final f = double.tryParse(vals[0].replaceAll(',', '.'));
          if (f == null || f == 0) return 'نامعتبر';
          final lambda = 300 / f; // meters approx for MHz
          return 'λ ≈ ${lambda.toStringAsFixed(2)} متر\nλ/2 ≈ ${(lambda / 2).toStringAsFixed(2)} متر\nλ/4 ≈ ${(lambda / 4).toStringAsFixed(2)} متر';
        },
      );
      break;
    case 'ldo':
      page = GenericToolScreen(
        title: 'دراپ رگولاتور',
        description: 'تلفات توان رگولاتور خطی',
        fields: ['Vin', 'Vout', 'I (آمپر)'],
        compute: (vals) {
          final vin = double.tryParse(vals[0].replaceAll(',', '.'));
          final vout = double.tryParse(vals[1].replaceAll(',', '.'));
          final i = double.tryParse(vals[2].replaceAll(',', '.'));
          if (vin == null || vout == null || i == null) return 'نامعتبر';
          final p = (vin - vout) * i;
          return 'توان تلفاتی ≈ ${p.toStringAsFixed(3)} وات';
        },
      );
      break;
    case 'battery':
      page = GenericToolScreen(
        title: 'عمر باتری',
        description: 'ظرفیت (mAh) و جریان مصرف (mA)',
        fields: ['ظرفیت (mAh)', 'جریان (mA)'],
        compute: (vals) {
          final cap = double.tryParse(vals[0].replaceAll(',', '.'));
          final cur = double.tryParse(vals[1].replaceAll(',', '.'));
          if (cap == null || cur == null || cur == 0) return 'نامعتبر';
          final hours = cap / cur;
          return 'عمر تقریبی ≈ ${hours.toStringAsFixed(1)} ساعت\n≈ ${(hours / 24).toStringAsFixed(1)} روز';
        },
      );
      break;
    case 'pwm':
      page = GenericToolScreen(
        title: 'PWM → ولتاژ',
        description: 'Duty Cycle و ولتاژ تغذیه',
        fields: ['Duty (%)', 'Vsupply'],
        compute: (vals) {
          final d = double.tryParse(vals[0].replaceAll(',', '.'));
          final v = double.tryParse(vals[1].replaceAll(',', '.'));
          if (d == null || v == null) return 'نامعتبر';
          return 'ولتاژ متوسط ≈ ${(d / 100 * v).toStringAsFixed(2)} ولت';
        },
      );
      break;
    case 'opamp':
      page = GenericToolScreen(
        title: 'گین آپ‌آمپ',
        description: 'اینورتینگ: Av = -Rf/Rin  |  نان‌اینورتینگ: Av = 1+Rf/Rg',
        fields: ['Rin یا Rg', 'Rf'],
        compute: (vals) {
          final r1 = double.tryParse(vals[0].replaceAll(',', '.'));
          final rf = double.tryParse(vals[1].replaceAll(',', '.'));
          if (r1 == null || rf == null || r1 == 0) return 'نامعتبر';
          final inv = -rf / r1;
          final non = 1 + rf / r1;
          return 'گین اینورتینگ ≈ ${inv.toStringAsFixed(2)}\nگین نان‌اینورتینگ ≈ ${non.toStringAsFixed(2)}';
        },
      );
      break;
    case 'impedance':
      page = GenericToolScreen(
        title: 'امپدانس مدار',
        description: 'برای محاسبه کامل از ربات استفاده کن یا در نسخه بعدی تکمیل می‌شود.',
        fields: [],
        compute: (_) => 'در حال توسعه',
      );
      break;
    default:
      page = Scaffold(
        appBar: AppBar(title: const Text('ابزار')),
        body: const Center(child: Text('این ابزار به‌زودی اضافه می‌شود')),
      );
  }

  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}
