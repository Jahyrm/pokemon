import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Creo esta clase para que el archivo principal "main" sea más legible y tenga
/// menos código. En esta clase se definen el tema claro y oscuro de la
/// aplicación, cualquier cosa que tenga que ver con diseño, se intentará
/// escribir aquí, a menos que sea algo muy específico de cada widget.
class AppThemes {
  /// Tema claro por defecto de flutter
  static final ThemeData defaultLightTheme = ThemeData.light(
    useMaterial3: true,
  );

  /// Tema oscuro por defecto de flutter
  static final ThemeData defaultDarkTheme = ThemeData.dark(useMaterial3: true);

  /// Mi tema claro
  static final light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primarySwatch: Colors.red,
    colorScheme: defaultLightTheme.colorScheme.copyWith(
      primary: Colors.red,
    ),
    textTheme: GoogleFonts.montserratTextTheme(),
    appBarTheme: defaultLightTheme.appBarTheme.copyWith(
      centerTitle: true,
    ),
  );

  /// Mi tema oscuro
  static final dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    primarySwatch: Colors.red,
    colorScheme: defaultDarkTheme.colorScheme.copyWith(
      primary: Colors.red,
    ),
    textTheme: GoogleFonts.montserratTextTheme(defaultDarkTheme.textTheme),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
    ),
    appBarTheme: defaultDarkTheme.appBarTheme.copyWith(
      centerTitle: true,
    ),
  );
}
