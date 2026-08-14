import 'dart:math' as math;

String formatNumber(num n, {int precision = 4}) {
  if (n == 0) return '0';
  final rounded = double.parse(n.toStringAsFixed(precision));
  if (rounded == rounded.roundToDouble()) return rounded.toInt().toString();
  return rounded.toString().replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
}

String formatResistance(num ohms) {
  final abs = ohms.abs();
  final sign = ohms < 0 ? '-' : '';
  if (abs >= 1e12) return '$sign${formatNumber(abs / 1e12)} ترا اهم';
  if (abs >= 1e9) return '$sign${formatNumber(abs / 1e9)} گیگا اهم';
  if (abs >= 1e6) return '$sign${formatNumber(abs / 1e6)} مگا اهم';
  if (abs >= 1e3) return '$sign${formatNumber(abs / 1e3)} کیلو اهم';
  if (abs >= 1) return '$sign${formatNumber(abs)} اهم';
  if (abs >= 1e-3) return '$sign${formatNumber(abs / 1e-3)} میلی‌اهم';
  return '$sign${formatNumber(abs / 1e-6)} میکرو‌اهم';
}

String formatCapacitance(num farads) {
  final abs = farads.abs();
  final sign = farads < 0 ? '-' : '';
  if (abs >= 1) return '$sign${formatNumber(abs)} فاراد';
  if (abs >= 1e-3) return '$sign${formatNumber(abs / 1e-3)} میلی‌فاراد';
  if (abs >= 1e-6) return '$sign${formatNumber(abs / 1e-6)} میکروفاراد';
  if (abs >= 1e-9) return '$sign${formatNumber(abs / 1e-9)} نانوفاراد';
  return '$sign${formatNumber(abs / 1e-12)} پیکوفاراد';
}

String formatInductance(num henries) {
  final abs = henries.abs();
  final sign = henries < 0 ? '-' : '';
  if (abs >= 1) return '$sign${formatNumber(abs)} هانری';
  if (abs >= 1e-3) return '$sign${formatNumber(abs / 1e-3)} میلی‌هانری';
  return '$sign${formatNumber(abs / 1e-6)} میکروهانری';
}

String formatFrequency(num hz) {
  if (hz >= 1e9) return '${formatNumber(hz / 1e9)} GHz';
  if (hz >= 1e6) return '${formatNumber(hz / 1e6)} MHz';
  if (hz >= 1e3) return '${formatNumber(hz / 1e3)} kHz';
  return '${formatNumber(hz)} Hz';
}

String formatVoltage(num v) {
  if (v.abs() >= 1000) return '${formatNumber(v / 1000)} کیلوولت';
  if (v.abs() >= 1) return '${formatNumber(v)} ولت';
  return '${formatNumber(v * 1000)} میلی‌ولت';
}

String formatCurrent(num a) {
  if (a.abs() >= 1000) return '${formatNumber(a / 1000)} کیلو آمپر';
  if (a.abs() >= 1) return '${formatNumber(a)} آمپر';
  if (a.abs() >= 1e-3) return '${formatNumber(a * 1000)} میلی آمپر';
  return '${formatNumber(a * 1e6)} میکرو آمپر';
}

String formatPower(num w) {
  if (w.abs() >= 1e6) return '${formatNumber(w / 1e6)} مگاوات';
  if (w.abs() >= 1e3) return '${formatNumber(w / 1e3)} کیلووات';
  if (w.abs() >= 1) return '${formatNumber(w)} وات';
  return '${formatNumber(w * 1000)} میلی‌وات';
}

double? parseResistance(String text) {
  if (text.trim().isEmpty) return null;
  var s = text.trim().toLowerCase()
      .replaceAll('۰', '0').replaceAll('۱', '1').replaceAll('۲', '2')
      .replaceAll('۳', '3').replaceAll('۴', '4').replaceAll('۵', '5')
      .replaceAll('۶', '6').replaceAll('۷', '7').replaceAll('۸', '8')
      .replaceAll('۹', '9').replaceAll(',', '.').replaceAll('،', '.');
  double mult = 1;
  if (s.contains('کیلو') || s.endsWith('k')) {
    mult = 1000;
    s = s.replaceAll('کیلو', '').replaceAll('k', '');
  } else if (s.contains('مگا') || s.endsWith('m') && !s.contains('میلی')) {
    mult = 1e6;
    s = s.replaceAll('مگا', '').replaceAll(RegExp(r'm$'), '');
  } else if (s.contains('میلی')) {
    mult = 0.001;
    s = s.replaceAll('میلی', '');
  }
  s = s.replaceAll(RegExp(r'[^0-9.]'), '');
  final v = double.tryParse(s);
  return v == null ? null : v * mult;
}

double? parseCapacitance(String text) {
  if (text.trim().isEmpty) return null;
  var s = text.trim().toLowerCase()
      .replaceAll('۰', '0').replaceAll('۱', '1').replaceAll('۲', '2')
      .replaceAll('۳', '3').replaceAll('۴', '4').replaceAll('۵', '5')
      .replaceAll('۶', '6').replaceAll('۷', '7').replaceAll('۸', '8')
      .replaceAll('۹', '9').replaceAll(',', '.').replaceAll('،', '.');
  double mult = 1;
  if (s.contains('pf') || s.contains('پیکو')) mult = 1e-12;
  else if (s.contains('nf') || s.contains('نانو')) mult = 1e-9;
  else if (s.contains('uf') || s.contains('µf') || s.contains('میکرو')) mult = 1e-6;
  else if (s.contains('mf') || s.contains('میلی')) mult = 1e-3;
  s = s.replaceAll(RegExp(r'[^0-9.]'), '');
  final v = double.tryParse(s);
  return v == null ? null : v * mult;
}

double? parseInductance(String text) {
  if (text.trim().isEmpty) return null;
  var s = text.trim().toLowerCase()
      .replaceAll('۰', '0').replaceAll('۱', '1').replaceAll('۲', '2')
      .replaceAll('۳', '3').replaceAll('۴', '4').replaceAll('۵', '5')
      .replaceAll('۶', '6').replaceAll('۷', '7').replaceAll('۸', '8')
      .replaceAll('۹', '9').replaceAll(',', '.').replaceAll('،', '.');
  double mult = 1;
  if (s.contains('uh') || s.contains('µh') || s.contains('میکرو')) mult = 1e-6;
  else if (s.contains('mh') || s.contains('میلی')) mult = 1e-3;
  else if (s.contains('nh') || s.contains('نانو')) mult = 1e-9;
  s = s.replaceAll(RegExp(r'[^0-9.]'), '');
  final v = double.tryParse(s);
  return v == null ? null : v * mult;
}

double? parseFrequency(String text) {
  if (text.trim().isEmpty) return null;
  var s = text.trim().toLowerCase()
      .replaceAll('۰', '0').replaceAll('۱', '1').replaceAll('۲', '2')
      .replaceAll('۳', '3').replaceAll('۴', '4').replaceAll('۵', '5')
      .replaceAll('۶', '6').replaceAll('۷', '7').replaceAll('۸', '8')
      .replaceAll('۹', '9').replaceAll(',', '.').replaceAll('،', '.');
  double mult = 1e6; // default MHz like bot
  if (s.contains('mhz') || s.contains('مگاهرتز') || s.contains('مگا هرتز')) mult = 1e6;
  else if (s.contains('khz') || s.contains('کیلوهرتز') || s.contains('کیلو هرتز')) mult = 1e3;
  else if (s.contains('hz') || s.contains('هرتز')) mult = 1;
  else if (s.contains('ghz')) mult = 1e9;
  s = s.replaceAll(RegExp(r'[^0-9.]'), '');
  final v = double.tryParse(s);
  return v == null ? null : v * mult;
}

double? parseNumber(String text) {
  if (text.trim().isEmpty) return null;
  var s = text.trim()
      .replaceAll('۰', '0').replaceAll('۱', '1').replaceAll('۲', '2')
      .replaceAll('۳', '3').replaceAll('۴', '4').replaceAll('۵', '5')
      .replaceAll('۶', '6').replaceAll('۷', '7').replaceAll('۸', '8')
      .replaceAll('۹', '9').replaceAll(',', '.').replaceAll('،', '.');
  s = s.replaceAll(RegExp(r'[^0-9.]'), '');
  return double.tryParse(s);
}

// E24 series
const e24 = [1.0, 1.1, 1.2, 1.3, 1.5, 1.6, 1.8, 2.0, 2.2, 2.4, 2.7, 3.0,
  3.3, 3.6, 3.9, 4.3, 4.7, 5.1, 5.6, 6.2, 6.8, 7.5, 8.2, 9.1];

List<double?> findNearestE24(double ideal) {
  if (ideal <= 0) return [null, null];
  int exp = 0;
  double r = ideal;
  while (r < 1) { r *= 10; exp--; }
  while (r >= 10) { r /= 10; exp++; }
  double? lower, higher;
  for (final v in e24) {
    final real = v * math.pow(10, exp);
    if (real <= ideal) lower = real;
    if (real >= ideal && higher == null) higher = real;
  }
  if (higher == null) higher = e24[0] * math.pow(10, exp + 1).toDouble();
  return [lower, higher];
}
