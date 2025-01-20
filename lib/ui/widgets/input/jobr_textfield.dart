import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/text_styles.dart';

class JobrTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;

  /// By default, this is the theme-set color
  final Color? hintTextColor;

  /// By default, this is the theme-set color
  final Color? formColor;

  final double borderRadius;

  final double width;

  final double height;

  final EdgeInsets contentPadding;

  /// Determines whether the text field hides input
  final bool obscureText;

  const JobrTextField({
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyles.bodySmall,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 17.5,
            color: hintTextColor ??
                Colors.grey[400] ??
                Theme.of(context).hintColor,
          ),
          contentPadding: contentPadding,
          filled: true,
          fillColor:
              formColor ?? Theme.of(context).inputDecorationTheme.fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
        ),
        // Constraining the width and height directly
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
