import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF050812);
  static const Color surface = Color(0xFF0F172A);
  static const Color neonBlue = Color(0xFF48D1FF);
  static const Color neonPurple = Color(0xFF9B5CFF);
  static const Color accent = Color(0xFF7C3AED);
  static const Color card = Color(0xFF111A2E);
  static const Color border = Color(0xFF2E3A59);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primaryColor: neonBlue,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      surface: surface,
      primary: neonBlue,
      secondary: neonPurple,
      onSurface: Colors.white,
    ),
    textTheme: Typography.whiteMountainView.copyWith(
      bodyLarge: const TextStyle(color: Colors.white70, fontFamily: 'Inter'),
      bodyMedium: const TextStyle(color: Colors.white60, fontFamily: 'Inter'),
      titleLarge: const TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontWeight: FontWeight.w700),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardTheme: CardThemeData(
      color: card,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
    splashColor: const Color.fromRGBO(72, 209, 255, 0.18),
    highlightColor: const Color.fromRGBO(155, 92, 255, 0.12),
  );

  static final ThemeData lightTheme = darkTheme;
}
