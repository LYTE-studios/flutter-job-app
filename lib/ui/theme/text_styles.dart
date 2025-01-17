import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class TextStyles {
  static Color mainText = Colors.black;
  static Color clearText = Colors.white;
  static Color secondaryText = HexColor.fromHex('#494A54');
  static Color unselectedText = HexColor.fromHex('#9FA0A5');
  static Color selectedText = HexColor.fromHex('#666666');
  static Color disabledText = const Color(0xFF4A4C53);
  static Color brooklyn = const Color(0xFF6F717C);
  static Color darkGray = const Color(0xFFF6F6F6);
  static Color green = const Color(0xFF35BD78);
  static Color lightgrey = const Color(0xFF616161);
  static Color lightbg = const Color(0xFFE4E4E4);
  static Color red = const Color(0xFFFF3E68);
  static Color deepgrey = const Color(0xFF565656);

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
