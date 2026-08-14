import 'dart:math' as math;

String _faDigits(String s) {
  const en = '0123456789';
  const fa = '۰۱۲۳۴۵۶۷۸۹';
  for (var i = 0; i < 10; i++) {
    s = s.replaceAll(en[i], fa[i]);
  }
  return s;
}

String formatResistance(double ohms) {
  if (ohms.isNaN || ohms.isInfinite) return '—';
  if (ohms >= 1e6) return '${_trim(ohms / 1e6)} MΩ';
  if (ohms >= 1e3) return '${_trim(ohms / 1e3)} kΩ';
  if (ohms >= 1) return '${_trim(ohms)} Ω';
  if (ohms >= 0.001) return '${_trim(ohms * 1e3)} mΩ';
  return '${_trim(ohms)} Ω';
}

String formatCapacitance(double f) {
  if (f.isNaN || f.isInfinite) return '—';
  if (f >= 1) return '${_trim(f)} F';
  if (f >= 1e-3) return '${_trim(f * 1e3)} mF';
  if (f >= 1e-6) return '${_trim(f * 1e6)} µF';
  if (f >= 1e-9) return '${_trim(f * 1e9)} nF';
  if (f >= 1e-12) return '${_trim(f * 1e12)} pF';
  return '${_trim(f)} F';
}

String formatInductance(double h) {
  if (h.isNaN || h.isInfinite) return '—';
  if (h >= 1) return '${_trim(h)} H';
  if (h >= 1e-3) return '${_trim(h * 1e3)} mH';
  if (h >= 1e-6) return '${_trim(h * 1e6)} µH';
  if (h >= 1e-9) return '${_trim(h * 1e9)} nH';
  return '${_trim(h)} H';
}

String formatFrequency(double hz) {
  if (hz.isNaN || hz.isInfinite) return '—';
  if (hz >= 1e9) return '${_trim(hz / 1e9)} GHz';
  if (hz >= 1e6) return '${_trim(hz / 1e6)} MHz';
  if (hz >= 1e3) return '${_trim(hz / 1e3)} kHz';
  return '${_trim(hz)} Hz';
}

String formatPower(double w) {
  if (w.isNaN || w.isInfinite) return '—';
  if (w >= 1e3) return '${_trim(w / 1e3)} kW';
  if (w >= 1) return '${_trim(w)} W';
  if (w >= 1e-3) return '${_trim(w * 1e3)} mW';
  return '${_trim(w * 1e6)} µW';
}

String _trim(double v) {
  if (v == v.roundToDouble()) return v.toInt().toString();
  final s = v.toStringAsFixed(4);
  return s.replaceAll(RegExp(r'\.?0+$'), '');
}

String toPersianNum(num n) => _faDigits(n.toString());

double? parseResistance(String text) {
  if (text.trim().isEmpty) return null;
  var s = _normalize(text);
  double mult = 1;
  if (s.contains('meg') || s.contains('مگ')) {
    mult = 1e6;
  } else if (s.contains('k') || s.contains('ک') || s.contains('کیلو')) {
    mult = 1e3;
  } else if (s.contains('m') && !s.contains('meg') || s.contains('میلی')) {
    mult = 1e-3;
  }
  s = s.replaceAll(RegExp(r'[^0-9.]'), '');
  final v = double.tryParse(s);
  return v == null ? null : v * mult;
}

double? parseCapacitance(String text) {
  if (text.trim().isEmpty) return null;
  var s = _normalize(text);
  double mult = 1e-6; // default uF
  if (s.contains('pf') || s.contains('پیکو') || s.contains('p')) {
    mult = 1e-12;
  } else if (s.contains('nf') || s.contains('نانو') || s.contains('n')) {
    mult = 1e-9;
  } else if (s.contains('uf') || s.contains('µf') || s.contains('میکرو') || s.contains('u')) {
    mult = 1e-6;
  } else if (s.contains('mf') || s.contains('میلی')) {
    mult = 1e-3;
  } else if (s.contains('f') && !s.contains('uf') && !s.contains('nf') && !s.contains('pf')) {
    mult = 1;
  }
  s = s.replaceAll(RegExp(r'[^0-9.]'), '');
  final v = double.tryParse(s);
  return v == null ? null : v * mult;
}

double? parseInductance(String text) {
  if (text.trim().isEmpty) return null;
  var s = _normalize(text);
  double mult = 1e-6;
  if (s.contains('uh') || s.contains('µh') || s.contains('میکرو')) {
    mult = 1e-6;
  } else if (s.contains('mh') || s.contains('میلی')) {
    mult = 1e-3;
  } else if (s.contains('nh') || s.contains('نانو')) {
    mult = 1e-9;
  } else if (s.contains('h') && !s.contains('uh') && !s.contains('mh')) {
    mult = 1;
  }
  s = s.replaceAll(RegExp(r'[^0-9.]'), '');
  final v = double.tryParse(s);
  return v == null ? null : v * mult;
}

double? parseFrequency(String text) {
  if (text.trim().isEmpty) return null;
  var s = _normalize(text);
  double mult = 1e6;
  if (s.contains('ghz')) {
    mult = 1e9;
  } else if (s.contains('mhz') || s.contains('مگاهرتز') || s.contains('مگا')) {
    mult = 1e6;
  } else if (s.contains('khz') || s.contains('کیلوهرتز') || s.contains('کیلو')) {
    mult = 1e3;
  } else if (s.contains('hz') || s.contains('هرتز')) {
    mult = 1;
  }
  s = s.replaceAll(RegExp(r'[^0-9.]'), '');
  final v = double.tryParse(s);
  return v == null ? null : v * mult;
}

double? parseNumber(String text) {
  if (text.trim().isEmpty) return null;
  var s = _normalize(text);
  s = s.replaceAll(RegExp(r'[^0-9.]'), '');
  return double.tryParse(s);
}

String _normalize(String text) {
  return text
      .trim()
      .toLowerCase()
      .replaceAll('۰', '0')
      .replaceAll('۱', '1')
      .replaceAll('۲', '2')
      .replaceAll('۳', '3')
      .replaceAll('۴', '4')
      .replaceAll('۵', '5')
      .replaceAll('۶', '6')
      .replaceAll('۷', '7')
      .replaceAll('۸', '8')
      .replaceAll('۹', '9')
      .replaceAll(',', '.')
      .replaceAll('،', '.')
      .replaceAll('ي', 'ی')
      .replaceAll('ك', 'ک');
}

const e24 = [
  1.0, 1.1, 1.2, 1.3, 1.5, 1.6, 1.8, 2.0, 2.2, 2.4, 2.7, 3.0,
  3.3, 3.6, 3.9, 4.3, 4.7, 5.1, 5.6, 6.2, 6.8, 7.5, 8.2, 9.1
];

List<double?> findNearestE24(double ideal) {
  if (ideal <= 0) return [null, null];
  int exp = 0;
  double r = ideal;
  while (r < 1) {
    r *= 10;
    exp--;
  }
  while (r >= 10) {
    r /= 10;
    exp++;
  }
  double? lower, higher;
  for (final v in e24) {
    final real = v * math.pow(10, exp);
    if (real <= ideal) lower = real.toDouble();
    if (real >= ideal && higher == null) higher = real.toDouble();
  }
  if (higher == null) higher = e24[0] * math.pow(10, exp + 1).toDouble();
  return [lower, higher];
}

/// SMD: 103, 472, 4R7, 01A (EIA-96)
(double, String)? parseSmdCode(String raw) {
  final code = raw.trim().toUpperCase().replaceAll(' ', '');
  if (code.isEmpty) return null;

  // R form: 4R7, 0R22
  if (code.contains('R')) {
    final parts = code.split('R');
    if (parts.length != 2) return null;
    final a = parts[0].isEmpty ? '0' : parts[0];
    final b = parts[1].isEmpty ? '0' : parts[1];
    final v = double.tryParse('$a.$b');
    if (v == null) return null;
    return (v, code);
  }

  // EIA-96: 2 digits + letter
  final eia96 = {
    1: 100, 2: 102, 3: 105, 4: 107, 5: 110, 6: 113, 7: 115, 8: 118, 9: 121, 10: 124,
    11: 127, 12: 130, 13: 133, 14: 137, 15: 140, 16: 143, 17: 147, 18: 150, 19: 154, 20: 158,
    21: 162, 22: 165, 23: 169, 24: 174, 25: 178, 26: 182, 27: 187, 28: 191, 29: 196, 30: 200,
    31: 205, 32: 210, 33: 215, 34: 221, 35: 226, 36: 232, 37: 237, 38: 243, 39: 249, 40: 255,
    41: 261, 42: 267, 43: 274, 44: 280, 45: 287, 46: 294, 47: 301, 48: 309, 49: 316, 50: 324,
    51: 332, 52: 340, 53: 348, 54: 357, 55: 365, 56: 374, 57: 383, 58: 392, 59: 402, 60: 412,
    61: 422, 62: 432, 63: 442, 64: 453, 65: 464, 66: 475, 67: 487, 68: 499, 69: 511, 70: 523,
    71: 536, 72: 549, 73: 562, 74: 576, 75: 590, 76: 604, 77: 619, 78: 634, 79: 649, 80: 665,
    81: 681, 82: 698, 83: 715, 84: 732, 85: 750, 86: 768, 87: 787, 88: 806, 89: 825, 90: 845,
    91: 866, 92: 887, 93: 909, 94: 931, 95: 953, 96: 976,
  };
  final eiaMult = {
    'Z': 0.001, 'Y': 0.01, 'X': 0.1, 'A': 1.0, 'B': 10.0, 'H': 10.0,
    'C': 100.0, 'D': 1000.0, 'E': 10000.0, 'F': 100000.0,
  };
  if (code.length == 3 && RegExp(r'^\d{2}[A-Z]$').hasMatch(code)) {
    final idx = int.tryParse(code.substring(0, 2));
    final letter = code[2];
    if (idx != null && eia96.containsKey(idx) && eiaMult.containsKey(letter)) {
      return (eia96[idx]! * eiaMult[letter]!, code);
    }
  }

  // 3-digit: AB * 10^C
  if (code.length == 3 && RegExp(r'^\d{3}$').hasMatch(code)) {
    final a = int.parse(code[0]);
    final b = int.parse(code[1]);
    final c = int.parse(code[2]);
    return (((a * 10 + b) * math.pow(10, c)).toDouble(), code);
  }

  // 4-digit: ABC * 10^D
  if (code.length == 4 && RegExp(r'^\d{4}$').hasMatch(code)) {
    final abc = int.parse(code.substring(0, 3));
    final d = int.parse(code[3]);
    return ((abc * math.pow(10, d)).toDouble(), code);
  }

  return null;
}

/// Ceramic cap code: 104 = 10 * 10^4 pF = 100nF
double? parseCapCode(String raw) {
  final code = raw.trim().toUpperCase().replaceAll(' ', '');
  if (code.isEmpty) return null;

  if (code.contains('R')) {
    final parts = code.split('R');
    if (parts.length != 2) return null;
    final a = parts[0].isEmpty ? '0' : parts[0];
    final b = parts[1].isEmpty ? '0' : parts[1];
    final v = double.tryParse('$a.$b');
    return v == null ? null : v * 1e-12; // pF
  }

  if (RegExp(r'^\d{2,3}$').hasMatch(code)) {
    if (code.length == 2) {
      final v = double.tryParse(code);
      return v == null ? null : v * 1e-12;
    }
    final sig = int.parse(code.substring(0, 2));
    final exp = int.parse(code[2]);
    return sig * math.pow(10, exp).toDouble() * 1e-12;
  }
  return null;
}

// Resistor color maps
const digitColors = {
  'مشکی': 0,
  'قهوه‌ای': 1,
  'قرمز': 2,
  'نارنجی': 3,
  'زرد': 4,
  'سبز': 5,
  'آبی': 6,
  'بنفش': 7,
  'خاکستری': 8,
  'سفید': 9,
};

const multColors = {
  'مشکی': 1.0,
  'قهوه‌ای': 10.0,
  'قرمز': 100.0,
  'نارنجی': 1000.0,
  'زرد': 10000.0,
  'سبز': 100000.0,
  'آبی': 1000000.0,
  'بنفش': 10000000.0,
  'طلایی': 0.1,
  'نقره‌ای': 0.01,
};

const indMultColors = {
  'مشکی': 1.0,
  'قهوه‌ای': 10.0,
  'قرمز': 100.0,
  'نارنجی': 1000.0,
  'زرد': 10000.0,
  'سبز': 100000.0,
  'آبی': 1000000.0,
  'بنفش': 10000000.0,
  'خاکستری': 100000000.0,
  'سفید': 1000000000.0,
};

const tolColors = {
  'طلایی': '±5%',
  'نقره‌ای': '±10%',
  'قهوه‌ای': '±1%',
  'قرمز': '±2%',
  'سبز': '±0.5%',
  'آبی': '±0.25%',
  'بنفش': '±0.1%',
};

const colorHex = {
  'مشکی': ColorData(0xFF111111),
  'قهوه‌ای': ColorData(0xFF8B4513),
  'قرمز': ColorData(0xFFE11D48),
  'نارنجی': ColorData(0xFFF97316),
  'زرد': ColorData(0xFFEAB308),
  'سبز': ColorData(0xFF22C55E),
  'آبی': ColorData(0xFF3B82F6),
  'بنفش': ColorData(0xFFA855F7),
  'خاکستری': ColorData(0xFF94A3B8),
  'سفید': ColorData(0xFFF8FAFC),
  'طلایی': ColorData(0xFFFFD700),
  'نقره‌ای': ColorData(0xFFC0C0C0),
};

// Color helper - use Color(colorHex[name]!) in UI
class ColorData {
  final int value;
  const ColorData(this.value);
}

/// مقدار اهم → رنگ‌های ۴ باند (چپ به راست: رقم۱، رقم۲، ضریب، تلرانس)
List<String>? valueToColors(double ohmValue) {
  if (ohmValue <= 0) return null;
  final pair = findNearestE24(ohmValue);
  final lower = pair[0];
  final higher = pair[1];
  double nearest;
  if (lower == null) {
    nearest = higher!;
  } else if (higher == null) {
    nearest = lower;
  } else {
    nearest = (ohmValue - lower).abs() <= (higher - ohmValue).abs() ? lower : higher;
  }

  final digitNames = {for (final e in digitColors.entries) e.value: e.key};
  final multNames = {for (final e in multColors.entries) e.value: e.key};

  double r = nearest;
  if (r < 1) {
    int sig;
    double mult;
    if (r >= 0.1) {
      sig = (r * 10).round();
      mult = 0.1;
    } else {
      sig = (r * 100).round();
      mult = 0.01;
    }
    sig = sig.clamp(1, 99);
    var d1 = sig ~/ 10;
    var d2 = sig % 10;
    if (d1 == 0) {
      d1 = d2;
      d2 = 0;
    }
    return [digitNames[d1]!, digitNames[d2]!, multNames[mult]!, 'طلایی'];
  }

  int exp = 0;
  double scaled = r;
  while (scaled >= 100) {
    scaled /= 10;
    exp++;
  }
  while (scaled < 10 && exp > -2) {
    scaled *= 10;
    exp--;
  }
  final sig = scaled.round().clamp(10, 99);
  final d1 = sig ~/ 10;
  final d2 = sig % 10;
  final mult = math.pow(10, exp).toDouble();
  final multName = multNames[mult] ?? multNames[1.0]!;
  return [digitNames[d1]!, digitNames[d2]!, multName, 'طلایی'];
}
