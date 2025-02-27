import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/ui/theme/text_styles.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final String? icon;
  final Color? backgroundColor;
  final VoidCallback onButtonPressed;

  const ActionButton({
    super.key,
    required this.buttonText,
    required this.icon,
    required this.onButtonPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onButtonPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      label: Text(
        buttonText,
        style: TextStyle(
          color: TextStyles.clearText,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
      ),
      icon: SvgPicture.asset(
        icon.toString(),
        width: 22,
        height: 22,
        colorFilter: ColorFilter.mode(
          TextStyles.clearText,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
