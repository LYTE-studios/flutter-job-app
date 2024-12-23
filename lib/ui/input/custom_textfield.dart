import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;

  /// By default this is the theme set color
  final Color? hintTextColor;

  /// By default this is the theme set color
  final Color? formColor;

  final double borderRadius;

  final double width;

  final double height;

  final EdgeInsets contentPadding;

  /// Determines whether the text field hides input
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintTextColor,
    this.formColor,
    this.borderRadius = 27,
    this.width = 346,
    this.height = 42,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 23,
    ),
    this.obscureText = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 27,
      style: TextStyles.bodySmall,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
