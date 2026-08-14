import 'dart:math' as math;
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
import 'tools/inductor_color.dart';
import 'tools/generic_tool.dart';
import '../utils/formatters.dart';

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
    case 'ind_color':
      page = const InductorColorScreen();
      break;
    case 'res_e_series':
      page = GenericToolScreen(
        title: 'نزدیک‌ترین E24',
        description: 'مقاومت ایده‌آل را وارد کن.',
        fields: const ['مقاومت (مثلاً 4.7k)'],
        compute: (vals) {
          final r = parseResistance(vals[0]);
          if (r == null || r <= 0) return 'نامعتبر';
          final n = findNearestE24(r);
          return 'ورودی: ${formatResistance(r)}\nپایین: ${n[0] != null ? formatResistance(n[0]!) : "—"}\nبالا: ${n[1] != null ? formatResistance(n[1]!) : "—"}';
        },
      );
      break;
    case 'res_zener':
      page = GenericToolScreen(
        title: 'مقاومت سری زنر',
        description: 'Vin، ولتاژ زنر و جریان زنر',
        fields: const ['Vin (V)', 'Vz (V)', 'Iz (mA)'],
        compute: (vals) {
          final vin = parseNumber(vals[0]);
          final vz = parseNumber(vals[1]);
          final iz = parseNumber(vals[2]);
          if (vin == null || vz == null || iz == null || iz <= 0) return 'نامعتبر';
          final r = (vin - vz) / (iz / 1000);
          if (r < 0) return 'Vz نباید از Vin بیشتر باشد';
          final p = (vin - vz) * (iz / 1000);
          return 'R = ${formatResistance(r)}\nتوان مقاومت ≈ ${formatPower(p)}';
        },
      );
      break;
    case 'cap_energy':
      page = GenericToolScreen(
        title: 'انرژی خازن',
        description: 'E = ½ C V²',
        fields: const ['ظرفیت C', 'ولتاژ V'],
        hints: const ['100uF', '12'],
        compute: (vals) {
          final c = parseCapacitance(vals[0]);
          final v = parseNumber(vals[1]);
          if (c == null || v == null) return 'نامعتبر';
          final e = 0.5 * c * v * v;
          return 'انرژی ≈ ${e < 1 ? "${(e * 1000).toStringAsFixed(3)} mJ" : "${e.toStringAsFixed(4)} J"}';
        },
      );
      break;
    case 'rc_tau':
      page = GenericToolScreen(
        title: 'ثابت زمانی RC',
        description: 'τ = R × C',
        fields: const ['R', 'C'],
        hints: const ['10k', '100nF'],
        compute: (vals) {
          final r = parseResistance(vals[0]);
          final c = parseCapacitance(vals[1]);
          if (r == null || c == null) return 'نامعتبر';
          final t = r * c;
          return 'τ = ${(t * 1000).toStringAsFixed(4)} ms\n≈ ${t.toStringAsFixed(6)} s\n۵τ ≈ ${(5 * t * 1000).toStringAsFixed(3)} ms';
        },
      );
      break;
    case 'ind_energy':
      page = GenericToolScreen(
        title: 'انرژی سلف',
        description: 'E = ½ L I²',
        fields: const ['L', 'I (آمپر)'],
        hints: const ['10mH', '0.5'],
        compute: (vals) {
          final l = parseInductance(vals[0]);
          final i = parseNumber(vals[1]);
          if (l == null || i == null) return 'نامعتبر';
          final e = 0.5 * l * i * i;
          return 'انرژی ≈ ${e < 1 ? "${(e * 1000).toStringAsFixed(3)} mJ" : "${e.toStringAsFixed(4)} J"}';
        },
      );
      break;
    case 'crystal':
      page = GenericToolScreen(
        title: 'کریستال / اسیلاتور',
        description: 'فرکانس را وارد کن',
        fields: const ['فرکانس'],
        hints: const ['16MHz'],
        compute: (vals) {
          final f = parseFrequency(vals[0]);
          if (f == null || f <= 0) return 'نامعتبر';
          final t = 1 / f;
          final lambda = 299792458 / f;
          return 'f = ${formatFrequency(f)}\nپریود = ${(t * 1e9).toStringAsFixed(3)} ns\nλ ≈ ${lambda >= 1 ? "${lambda.toStringAsFixed(3)} m" : "${(lambda * 100).toStringAsFixed(2)} cm"}';
        },
      );
      break;
    case 'filter_rc':
      page = GenericToolScreen(
        title: 'فرکانس قطع فیلتر',
        description: 'fc = 1/(2πRC) یا R/(2πL)',
        fields: const ['R', 'C یا L', 'نوع (C یا L)'],
        hints: const ['10k', '100nF', 'C'],
        compute: (vals) {
          final r = parseResistance(vals[0]);
          final type = vals[2].trim().toUpperCase();
          if (r == null || r <= 0) return 'R نامعتبر';
          if (type.startsWith('L')) {
            final l = parseInductance(vals[1]);
            if (l == null || l <= 0) return 'L نامعتبر';
            final fc = r / (2 * math.pi * l);
            return 'fc (RL) ≈ ${formatFrequency(fc)}';
          }
          final c = parseCapacitance(vals[1]);
          if (c == null || c <= 0) return 'C نامعتبر';
          final fc = 1 / (2 * math.pi * r * c);
          return 'fc (RC) ≈ ${formatFrequency(fc)}';
        },
      );
      break;
    case 'wavelength':
      page = GenericToolScreen(
        title: 'طول موج / آنتن',
        description: 'فرکانس را وارد کن',
        fields: const ['فرکانس'],
        hints: const ['433MHz'],
        compute: (vals) {
          final f = parseFrequency(vals[0]);
          if (f == null || f <= 0) return 'نامعتبر';
          final lambda = 299792458 / f;
          String fmt(double m) => m >= 1 ? '${m.toStringAsFixed(3)} m' : '${(m * 100).toStringAsFixed(2)} cm';
          return 'λ = ${fmt(lambda)}\nλ/2 = ${fmt(lambda / 2)}\nλ/4 = ${fmt(lambda / 4)}';
        },
      );
      break;
    case 'ldo':
      page = GenericToolScreen(
        title: 'دراپ رگولاتور',
        description: 'توان تلفاتی = (Vin − Vout) × I',
        fields: const ['Vin', 'Vout', 'I (آمپر)'],
        compute: (vals) {
          final vin = parseNumber(vals[0]);
          final vout = parseNumber(vals[1]);
          final i = parseNumber(vals[2]);
          if (vin == null || vout == null || i == null) return 'نامعتبر';
          final p = (vin - vout) * i;
          return 'تلفات ≈ ${formatPower(p)}\nراندمان تقریبی ≈ ${(vout / vin * 100).toStringAsFixed(1)}٪';
        },
      );
      break;
    case 'battery':
      page = GenericToolScreen(
        title: 'عمر باتری',
        description: 'ظرفیت (mAh) و جریان مصرف (mA)',
        fields: const ['ظرفیت (mAh)', 'جریان (mA)'],
        compute: (vals) {
          final cap = parseNumber(vals[0]);
          final cur = parseNumber(vals[1]);
          if (cap == null || cur == null || cur == 0) return 'نامعتبر';
          final hours = cap / cur;
          return 'عمر تقریبی ≈ ${hours.toStringAsFixed(1)} ساعت\n≈ ${(hours / 24).toStringAsFixed(2)} روز';
        },
      );
      break;
    case 'pwm':
      page = GenericToolScreen(
        title: 'PWM → ولتاژ',
        description: 'ولتاژ متوسط = Duty × Vsupply',
        fields: const ['Duty (%)', 'Vsupply'],
        compute: (vals) {
          final d = parseNumber(vals[0]);
          final v = parseNumber(vals[1]);
          if (d == null || v == null) return 'نامعتبر';
          return 'Vavg ≈ ${(d / 100 * v).toStringAsFixed(3)} ولت';
        },
      );
      break;
    case 'opamp':
      page = GenericToolScreen(
        title: 'گین آپ‌آمپ',
        description: 'اینورتینگ: −Rf/Rin  |  نان‌اینورتینگ: 1+Rf/Rg',
        fields: const ['Rin یا Rg', 'Rf'],
        compute: (vals) {
          final r1 = parseResistance(vals[0]);
          final rf = parseResistance(vals[1]);
          if (r1 == null || rf == null || r1 == 0) return 'نامعتبر';
          return 'گین اینورتینگ ≈ ${(-rf / r1).toStringAsFixed(3)}\nگین نان‌اینورتینگ ≈ ${(1 + rf / r1).toStringAsFixed(3)}';
        },
      );
      break;
    case 'impedance':
      page = GenericToolScreen(
        title: 'امپدانس RL/RC سری',
        description: 'R و X را وارد کن (Xc را منفی وارد کن)',
        fields: const ['R (اهم)', 'X (اهم)'],
        compute: (vals) {
          final r = parseNumber(vals[0]);
          final x = parseNumber(vals[1]);
          if (r == null || x == null) return 'نامعتبر';
          final z = math.sqrt(r * r + x * x);
          final phase = math.atan2(x, r) * 180 / math.pi;
          return '|Z| ≈ ${formatResistance(z)}\nفاز ≈ ${phase.toStringAsFixed(2)}°';
        },
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
