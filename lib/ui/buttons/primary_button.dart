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

  const PrimaryButton({
    super.key,
    this.onTap,
    required this.buttonText,
    this.buttonColor = const Color(0xFFFF3E68),
    this.textColor = Colors.white,
    this.borderRadius = 27,
    this.width = 346,
    this.height = 50,
    this.textStyle,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: Text(
            buttonText,
            style:textStyle ?? TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
