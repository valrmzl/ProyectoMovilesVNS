import 'package:flutter/material.dart';
import 'package:proyecto_vsn/theme/color_schemas.dart';

enum AppTheme {
  LightApp,
  DarkApp,
}

final appThemeData = {
 
  // cree la variante con material 3 y los color schemas
  AppTheme.LightApp: ThemeData(
    useMaterial3: true,
    colorScheme: LightColorScheme,
  ),
  AppTheme.DarkApp: ThemeData(
    useMaterial3: true,
    colorScheme: DarkColorScheme,
  ),
};