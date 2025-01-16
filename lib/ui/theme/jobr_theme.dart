import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import './text_styles.dart';

final jobrTheme = ThemeData(
  hoverColor: Colors.transparent,
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: HexColor.fromHex('#FF3E68'),
    onPrimary: Colors.white,
    secondary: HexColor.fromHex('#191919'),
    onSecondary: Colors.white,
    tertiary: Colors.black.withOpacity(0.03),
    error: HexColor.fromHex('#F62C2C'),
    onError: Colors.white,
    errorContainer: HexColor.fromHex('#F62C2C'),
    onErrorContainer: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    primaryContainer: HexColor.fromHex('#F9F9F9'),
    onPrimaryContainer: Colors.black,
    secondaryContainer: Colors.black.withOpacity(0.03),
    onSecondaryContainer: Colors.black,
    outline: Colors.black,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyles.titleLarge,
    titleMedium: TextStyles.titleMedium,
    titleSmall: TextStyles.titleSmall,
    bodyLarge: TextStyles.bodyLarge,
    bodyMedium: TextStyles.bodyMedium,
    bodySmall: TextStyles.bodySmall,
    labelLarge: TextStyles.labelLarge,
    labelMedium: TextStyles.labelMedium,
    labelSmall: TextStyles.labelSmall,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: HexColor.fromHex('#B7B7B7'),
      fontSize: 16,
    ),
    filled: true,
    fillColor: HexColor.fromHex('#F7F7F7'),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 16,
    ),
  ),
);
