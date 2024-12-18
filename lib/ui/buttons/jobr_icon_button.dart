import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobrIconButton extends StatelessWidget {
  final double? width;
  final double height;
  final Color? textColor;
  final Color? buttonColor;
  final String label;
  final String? icon;
  final String? textIcon;
  final double fontSize;
  final double radius;

  final bool reverseAlign;

  final VoidCallback onPressed;

  const JobrIconButton({
    super.key,
    this.width,
    this.height = 52.0,
    this.textColor,
    this.textIcon,
    this.buttonColor,
    this.fontSize = 18,
    this.radius = 27,
    required this.label,
    this.icon,
    required this.onPressed,
    this.reverseAlign = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClearInkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor ?? HexColor.fromHex('#F6F6F6F6'),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          textDirection: reverseAlign ? TextDirection.rtl : TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgIcon(
                      icon!,
                      size: 20,
                      leaveUnaltered: true,
                    ),
                  ),
            textIcon == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '$textIcon ',
                      style: TextStyles.bodyMedium.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
            Text(
              label,
              style: TextStyles.bodyMedium.copyWith(
                fontSize: fontSize,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
