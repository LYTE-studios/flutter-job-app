import 'package:flutter/material.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/navigation/jobr_loading_switcher.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class BaseOptionBottomSheet extends StatelessWidget with BottomSheetMixin {
  final String title;

  final void Function(int index) onSelected;

  final List<String> options;

  final bool loading;

  final String? selectedOption; // add this

  const BaseOptionBottomSheet({
    super.key,
    required this.onSelected,
    required this.title,
    required this.options,
    this.loading = false,
    this.selectedOption, // pass it
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 5,
          ),
          Center(
              child: Container(
            height: 5,
            width: 48,
            color: const Color(0xffD9D9D9),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyles.titleMedium.copyWith(fontSize: 21),
                  ),
                  const SizedBox(height: 12),
                  JobrLoadingSwitcher(
                    loading: loading,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options[index];
                        final isSelected =
                            option == selectedOption; // highlight match

                        return GestureDetector(
                          onTap: () => onSelected(index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1)
                                  : HexColor.fromHex("#F3F3F3"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                option,
                                style: TextStyles.titleSmall.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
