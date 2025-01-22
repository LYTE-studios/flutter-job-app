import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/selectable/clear_ink_well.dart';

class JobrDropdownField extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  final String? selectedValue;

  const JobrDropdownField({
    super.key,
    required this.title,
    this.onPressed,
    this.selectedValue,
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
              color: HexColor.fromHex("#E4E4E4").withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue ?? "Kies een optie",
                  style: TextStyles.titleSmall.copyWith(
                      fontSize: 16.5,
                      color: selectedValue == null
                          ? Colors.black45
                          : Colors.black),
                ),
                selectedValue == null
                    ? const Icon(
                        CupertinoIcons.chevron_down,
                        color: Colors.black45,
                        size: 18,
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
