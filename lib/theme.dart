import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 255, 87, 34),
);

final _darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 255, 87, 34),
);

class AppTheme {
  static ThemeData get theme {
    return ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: _colorScheme,
      textTheme: GoogleFonts.latoTextTheme(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      textTheme: GoogleFonts.latoTextTheme(
        TextTheme(
          displayLarge: TextStyle(color: _darkColorScheme.onBackground),
          displayMedium: TextStyle(color: _darkColorScheme.onBackground),
          displaySmall: TextStyle(color: _darkColorScheme.onBackground),
          headlineLarge: TextStyle(color: _darkColorScheme.onBackground),
          headlineMedium: TextStyle(color: _darkColorScheme.onBackground),
          headlineSmall: TextStyle(color: _darkColorScheme.onBackground),
          titleLarge: TextStyle(color: _darkColorScheme.onBackground),
          titleMedium: TextStyle(color: _darkColorScheme.onBackground),
          titleSmall: TextStyle(color: _darkColorScheme.onBackground),
          bodyLarge: TextStyle(color: _darkColorScheme.onBackground),
          bodyMedium: TextStyle(color: _darkColorScheme.onBackground),
          bodySmall: TextStyle(color: _darkColorScheme.onBackground),
          labelLarge: TextStyle(color: _darkColorScheme.onBackground),
          labelMedium: TextStyle(color: _darkColorScheme.onBackground),
          labelSmall: TextStyle(color: _darkColorScheme.onBackground),
        ),
      ),
    );
  }
}
