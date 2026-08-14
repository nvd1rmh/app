import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors matching the bot style
  static const bg = Color(0xFF0B1220);
  static const card = Color(0xFF151E2E);
  static const card2 = Color(0xFF1A2438);
  static const accent = Color(0xFFF97316); // orange
  static const accent2 = Color(0xFF38BDF8); // sky
  static const success = Color(0xFF4ADE80);
  static const text = Color(0xFFF1F5F9);
  static const muted = Color(0xFF94A3B8);
  static const dim = Color(0xFF64748B);
  static const line = Color(0xFF334155);
  static const purple = Color(0xFFA78BFA);
  static const gold = Color(0xFFFBBF24);

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: bg,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accent2,
        surface: card,
        onSurface: text,
        background: bg,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.vazirmatn(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: text,
        ),
        iconTheme: const IconThemeData(color: text),
      ),
      cardTheme: CardTheme(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card2,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: line, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: accent, width: 1.5),
        ),
        labelStyle: GoogleFonts.vazirmatn(color: muted),
        hintStyle: GoogleFonts.vazirmatn(color: dim),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.vazirmatn(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.vazirmatn(color: text, fontWeight: FontWeight.w800),
        displayMedium: GoogleFonts.vazirmatn(color: text, fontWeight: FontWeight.w700),
        headlineMedium: GoogleFonts.vazirmatn(color: text, fontWeight: FontWeight.w700),
        titleLarge: GoogleFonts.vazirmatn(color: text, fontWeight: FontWeight.w700),
        titleMedium: GoogleFonts.vazirmatn(color: text, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.vazirmatn(color: text, fontSize: 16),
        bodyMedium: GoogleFonts.vazirmatn(color: muted, fontSize: 14),
        labelLarge: GoogleFonts.vazirmatn(color: text, fontWeight: FontWeight.w600),
      ),
    );
  }
}
