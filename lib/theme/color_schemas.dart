import 'package:flutter/material.dart';

// https://m3.material.io/theme-builder#/custom
const LightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 184, 243, 223),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFEADDFF),
  onPrimaryContainer: Color(0xFF21005D),
  secondary: Color.fromARGB(
              255, 47, 125, 121),
  onSecondary: Color(0xFFFFFFFF),
  onSecondaryContainer: Color(0xFF1D192B),
  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFF9DEDC),
  onErrorContainer: Color(0xFF410E0B),
  outline: Color(0xFF79747E),
  background: Color(0xFFFFFBFE),
  onBackground: Color(0xFF1C1B1F),
  surface: Color(0xFFFFFBFE),
  onSurface: Color(0xFF1C1B1F),
  surfaceVariant: Color(0xFFE7E0EC),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
);

const DarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF18453B), // Verde oscuro
  onPrimary: Color(0xFFFFFFFF), // Texto sobre el verde oscuro
  primaryContainer: Color(0xFF235A4F), // Fondo para elementos principales
  onPrimaryContainer: Color(0xFFEADDFF), // Texto sobre el fondo de elementos principales
  secondary: Color(0xFF2F7D79), // Verde más claro
  onSecondary: Color(0xFFFFFFFF), // Texto sobre el verde claro
  onSecondaryContainer: Color(0xFF1D192B), // Texto sobre el fondo de elementos secundarios
  error: Color(0xFFB3261E), // Color de error
  onError: Color(0xFFFFFFFF), // Texto sobre el color de error
  errorContainer: Color(0xFFF9DEDC), // Fondo para elementos de error
  onErrorContainer: Color(0xFF410E0B), // Texto sobre el fondo de elementos de error
  outline: Color(0xFF79747E), // Color de contorno
  background: Color(0xFF1C1B1F), // Fondo de la aplicación
  onBackground: Color(0xFFE6E1E5), // Texto sobre el fondo de la aplicación
  surface: Color(0xFF1C1B1F), // Superficie
  onSurface: Color(0xFFE6E1E5), // Texto sobre la superficie
  surfaceVariant: Color(0xFF49454F), // Variante de la superficie
  shadow: Color(0xFF000000), // Color de sombra
  scrim: Color(0xFF000000), // Color de la pantalla de bloqueo
);
