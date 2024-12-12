import 'package:flutter/material.dart';

class TextStyles {
  static Color mainText = Colors.black;
  static Color clearText = Colors.white;

  // --------------------------------------
  // Title
  static TextStyle titleLarge = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w900,
    fontSize: 27,
    color: mainText,
    letterSpacing: -0.352,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    color: mainText,
    letterSpacing: -0.352,
  );

  static TextStyle titleSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.352,
    color: mainText,
  );

  // --------------------------------------
  // body
  /// large text in body
  static TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 27,
    color: mainText,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.352,
  );

  /// medium text in body
  static TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: mainText,
    letterSpacing: -0.352,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: mainText,
    letterSpacing: -0.352,
  );

  // --------------------------------------
  // label
  /// text input label
  static TextStyle labelLarge = TextStyle(
    color: mainText,
    fontSize: 27,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    letterSpacing: -0.352,
  );

  /// tool tip text
  static TextStyle labelMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.352,
    color: mainText,
  );

  // not used yet -
  static TextStyle labelSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: mainText,
    letterSpacing: -0.352,
  );
}
