import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double borderRadius;
  final double width;
  final double height;
  final TextStyle? textStyle;
  final Widget? suffixIcon; // Make suffixIcon optional

  const PrimaryButton({
    super.key,
    this.onTap,
    required this.buttonText,
    this.suffixIcon, // Make suffixIcon optional
    this.buttonColor = const Color(0xFFFF3E68),
    this.textColor = Colors.white,
    this.borderRadius = 18,
    this.width = double.infinity,
    this.height = 56,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (suffixIcon != null) ...[
                const SizedBox(width: 8),
                suffixIcon!,
              ],
              Text(
                buttonText,
                style: textStyle ??
                    TextStyle(
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
