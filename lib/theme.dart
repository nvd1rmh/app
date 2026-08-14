import 'package:flutter/material.dart';

class AppColors {
  static const dBg = Color(0xFF070B14);
  static const dBg2 = Color(0xFF0D1424);
  static const dCard = Color(0xFF121A2B);
  static const dCard2 = Color(0xFF1A2438);
  static const dLine = Color(0xFF2A3548);
  static const dText = Color(0xFFF1F5F9);
  static const dMuted = Color(0xFF94A3B8);
  static const dDim = Color(0xFF64748B);

  static const lBg = Color(0xFFF4F6FB);
  static const lBg2 = Color(0xFFE8EDF7);
  static const lCard = Color(0xFFFFFFFF);
  static const lCard2 = Color(0xFFF0F4FA);
  static const lLine = Color(0xFFD0D8E8);
  static const lText = Color(0xFF0F172A);
  static const lMuted = Color(0xFF64748B);
  static const lDim = Color(0xFF94A3B8);

  static const orange = Color(0xFFF97316);
  static const cyan = Color(0xFF22D3EE);
  static const green = Color(0xFF4ADE80);
  static const purple = Color(0xFFA78BFA);
  static const gold = Color(0xFFFBBF24);
  static const rose = Color(0xFFFB7185);
  static const blue = Color(0xFF3B82F6);
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
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.dText),
      ),
      cardTheme: CardThemeData(
        color: AppColors.dCard,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.dCard2,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.dLine)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.dLine)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.orange, width: 1.5)),
        hintStyle: const TextStyle(color: AppColors.dDim, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.dMuted, fontSize: 13),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
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
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.lText),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lCard,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lCard2,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.lLine)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.lLine)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.orange, width: 1.5)),
        hintStyle: const TextStyle(color: AppColors.lDim, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.lMuted, fontSize: 13),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      dividerColor: AppColors.lLine,
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
