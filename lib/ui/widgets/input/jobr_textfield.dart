import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/text_styles.dart';

class JobrTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? hintTextColor;
  final Color? formColor;
  final double borderRadius;
  final double width;
  final double height;
  final EdgeInsets contentPadding;
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
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyles.bodySmall,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.w500,
              color: hintTextColor ??
                  Colors.grey[400] ??
                  Theme.of(context).hintColor,
            ),
            contentPadding: contentPadding.copyWith(
              top: (height - 17.5) / 2, // Adjust padding for height
              bottom: (height - 17.5) / 2,
            ),
            filled: true,
            fillColor:
                formColor ?? Theme.of(context).inputDecorationTheme.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
