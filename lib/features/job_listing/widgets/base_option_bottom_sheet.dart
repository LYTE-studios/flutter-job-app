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

  BaseOptionBottomSheet({
    super.key,
    required this.onSelected,
    required this.title,
    required this.options,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
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
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  title,
                  style: TextStyles.titleMedium.copyWith(fontSize: 21),
                ),
                JobrLoadingSwitcher(
                  loading: loading,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 16,
                    ),
                    children: [
                      ...options.map(
                        (option) => GestureDetector(
                          onTap: () => onSelected(options.indexOf(option)),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#F3F3F3"),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                option,
                                style: TextStyles.titleSmall.copyWith(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
