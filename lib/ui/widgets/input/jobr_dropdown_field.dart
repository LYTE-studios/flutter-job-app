import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/selectable/clear_ink_well.dart';

class JobrDropdownField extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  final String? selectedValue;
  final String? iconPadding;

  const JobrDropdownField({
    super.key,
    required this.title,
    this.onPressed,
    this.selectedValue,
    this.iconPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ClearInkWell(
      onTap: () => onPressed?.call(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: title,
              style: TextStyles.titleMedium.copyWith(fontSize: 16.5),
              children: [
                TextSpan(
                  text: "*",
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
                  selectedValue ?? "Kies een optie",
                  style: TextStyles.titleSmall.copyWith(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      color: selectedValue == null
                          ? Colors.grey[400]
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
                    : Text(
                        "Wijzigen",
                        style: TextStyles.titleSmall.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: HexColor.fromHex("#FF3E68"),
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
