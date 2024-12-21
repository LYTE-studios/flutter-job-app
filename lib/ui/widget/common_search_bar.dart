import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class CommonSearchBar extends StatelessWidget {
  final Function(String)? onChanged;
  final String hintText;

  const CommonSearchBar({
    super.key,
    this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: HexColor.fromHex('#D9D9D9').withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextField(
          onChanged: onChanged,
          cursorHeight: 20,
          style: TextStyles.labelSmall,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: TextStyles.labelSmall.copyWith(
              color: HexColor.fromHex('#000000').withOpacity(0.33),
            ),
            border: InputBorder.none,
            prefixIcon: Container(
              width: 40,
              height: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Center(
                child: SvgIcon(
                  JobrIcons.magnifyingGlass,
                  size: 20,
                  color: HexColor.fromHex('#999999'),
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
