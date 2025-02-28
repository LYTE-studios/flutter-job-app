import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/selectable/clear_ink_well.dart';

class JobrDropdownField extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final bool showWijzigenText;
  final bool showTitle;
  final bool showDropdownMenu; // New parameter
  final String hintText;
  final String? selectedValue;
  final String? iconPadding;
  final TextStyle? textStyle;
  final bool? showstar;

  const JobrDropdownField(
      {super.key,
      required this.title,
      this.onPressed,
      this.selectedValue,
      this.iconPadding,
      this.showTitle = true,
      this.hintText = "Kies een optie",
      this.showWijzigenText = true,
      this.showDropdownMenu = false,
      this.textStyle,
      this.showstar = true}); // Initialize new parameter

  @override
  Widget build(BuildContext context) {
    return ClearInkWell(
      onTap: () => onPressed?.call(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTitle)
            RichText(
              text: TextSpan(
                text: title,
                style: TextStyles.titleMedium.copyWith(fontSize: 16.5),
                children: [
                  TextSpan(
                    text: showstar == true ? "*" : "",
                    style: TextStyles.titleMedium.copyWith(
                      fontSize: 16.5,
                      color: HexColor.fromHex("#FF3F3F"),
                    ),
                  )
                ],
              ),
            ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingSizes.large,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: HexColor.fromHex("#E4E4E4").withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue ?? hintText,
                  style: textStyle ??
                      TextStyles.titleSmall.copyWith(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w500,
                          color: selectedValue == null
                              ? Color(0xFF878787)
                              : Colors.black),
                ),
                selectedValue == null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SvgPicture.asset(
                          'assets/images/icons/chevron-down.svg',
                          color: Colors.black45,
                          height: 8,
                        ),
                      )
                    : showWijzigenText
                        ? Text(
                            "Wijzigen",
                            style: TextStyles.titleSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: HexColor.fromHex("#FF3E68"),
                            ),
                          )
                        : Text(''),
                if (showDropdownMenu) // Conditionally show dropdown menu
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SvgPicture.asset(
                      'assets/images/icons/chevron-down.svg',
                      color: Color(0xFF4A4C53),
                      height: 8,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
