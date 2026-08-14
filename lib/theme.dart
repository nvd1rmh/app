import 'package:flutter/material.dart';

class AppColors {
  // Dark — شب الکترونیکی
  static const dBg = Color(0xFF05080F);
  static const dBg2 = Color(0xFF0A1020);
  static const dCard = Color(0xFF101828);
  static const dCard2 = Color(0xFF162033);
  static const dLine = Color(0xFF243044);
  static const dText = Color(0xFFF1F5F9);
  static const dMuted = Color(0xFF94A3B8);
  static const dDim = Color(0xFF64748B);

  // Light — روز تمیز با حس الکترونیک
  static const lBg = Color(0xFFF2F5FA);
  static const lBg2 = Color(0xFFE4EBF5);
  static const lCard = Color(0xFFFFFFFF);
  static const lCard2 = Color(0xFFEEF3FA);
  static const lLine = Color(0xFFCDD6E5);
  static const lText = Color(0xFF0B1220);
  static const lMuted = Color(0xFF5B6B82);
  static const lDim = Color(0xFF8B9BB0);

  static const orange = Color(0xFFFF6B1A);
  static const cyan = Color(0xFF00D4FF);
  static const green = Color(0xFF22E07A);
  static const purple = Color(0xFF9B6DFF);
  static const gold = Color(0xFFFFC107);
  static const rose = Color(0xFFFF5C7A);
  static const blue = Color(0xFF3B82F6);
  static const neon = Color(0xFF39FF14);
}

class AppTheme {
  static ThemeData dark() {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.dark, fontFamily: 'Roboto');
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.dBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.orange,
        secondary: AppColors.cyan,
        surface: AppColors.dCard,
        onSurface: AppColors.dText,
        outline: AppColors.dLine,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.dText,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.dText),
      ),
      cardTheme: CardTheme(
        color: AppColors.dCard,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: _input(AppColors.dCard2, AppColors.dLine, AppColors.dDim, AppColors.dMuted),
      elevatedButtonTheme: _btn(),
      dividerColor: AppColors.dLine,
    );
  }

  static ThemeData light() {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light, fontFamily: 'Roboto');
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.lBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.orange,
        secondary: AppColors.blue,
        surface: AppColors.lCard,
        onSurface: AppColors.lText,
        outline: AppColors.lLine,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.lText,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.lText),
      ),
      cardTheme: CardTheme(
        color: AppColors.lCard,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: _input(AppColors.lCard2, AppColors.lLine, AppColors.lDim, AppColors.lMuted),
      elevatedButtonTheme: _btn(),
      dividerColor: AppColors.lLine,
    );
  }

  static InputDecorationTheme _input(Color fill, Color line, Color hint, Color label) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: line)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: line)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.orange, width: 1.6)),
      hintStyle: TextStyle(color: hint, fontSize: 14),
      labelStyle: TextStyle(color: label, fontSize: 13),
    );
  }

  static ElevatedButtonThemeData _btn() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
      ),
    );
  }
}

extension ThemeX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get cBg => isDark ? AppColors.dBg : AppColors.lBg;
  Color get cBg2 => isDark ? AppColors.dBg2 : AppColors.lBg2;
  Color get cCard => isDark ? AppColors.dCard : AppColors.lCard;
  Color get cCard2 => isDark ? AppColors.dCard2 : AppColors.lCard2;
  Color get cLine => isDark ? AppColors.dLine : AppColors.lLine;
  Color get cText => isDark ? AppColors.dText : AppColors.lText;
  Color get cMuted => isDark ? AppColors.dMuted : AppColors.lMuted;
  Color get cDim => isDark ? AppColors.dDim : AppColors.lDim;
}

/// باکس نتیجه محاسبات — همیشه راست‌چین و خوانا
class ResultBox extends StatelessWidget {
  final String text;
  final Color? accent;
  const ResultBox(this.text, {super.key, this.accent});

  @override
  Widget build(BuildContext context) {
    final a = accent ?? AppColors.orange;
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [a.withOpacity(0.18), a.withOpacity(0.06)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: a.withOpacity(0.4), width: 1.2),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16,
            height: 1.75,
            fontWeight: FontWeight.w700,
            color: context.cText,
          ),
        ),
      ),
    );
  }
}
