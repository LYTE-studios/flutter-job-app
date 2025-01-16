import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

Widget buildSocialButton({
  required String icon,
  required String label,
  required VoidCallback onPressed,
  bool showPlus = false,
  bool showClose = false,
  bool isInstagram = false,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: isInstagram ? Colors.pink[50] : Colors.grey[100],
      foregroundColor: isInstagram ? TextStyles.red : TextStyles.lightgrey,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.45),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          width: 22.12,
          height: 22.12,
          colorFilter: ColorFilter.mode(
            isInstagram ? TextStyles.red : TextStyles.lightgrey,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w500,
            color: isInstagram ? TextStyles.red : TextStyles.lightgrey,
          ),
        ),
        if (showClose) const SizedBox(width: 4),
        if (showClose)
          SvgIcon(JobrIcons.close, size: 10, color: TextStyles.red),
        if (showPlus) ...[
          const SizedBox(width: 4),
          const SvgIcon(JobrIcons.plus, size: 10),
        ],
      ],
    ),
  );
}
