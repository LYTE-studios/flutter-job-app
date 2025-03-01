import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobrSearchBar extends StatelessWidget {
  final Function(String)? onChanged;
  final String hintText;

  const JobrSearchBar({
    super.key,
    this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle interTextStyle = TextStyle(
      fontFamily: 'Inter',
      fontSize: 17.21,
      fontWeight: TextStyles.labelSmall.fontWeight,
      color: TextStyles.labelSmall.color,
    );

    return Container(
      height: 43,
      decoration: BoxDecoration(
        color: HexColor.fromHex('#D9D9D94F').withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextField(
          onChanged: onChanged,
          cursorHeight: 20,
          style: interTextStyle,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: interTextStyle.copyWith(
              color: HexColor.fromHex('#000000').withOpacity(0.33),
            ),
            border: InputBorder.none,
            prefixIcon: SizedBox(
              width: 40,
              height: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SvgIcon(
                    JobrIcons.magnifyingGlass,
                    size: 21,
                    color: HexColor.fromHex('#999999'),
                  ),
                ),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }
}
