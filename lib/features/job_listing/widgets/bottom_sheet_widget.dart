import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

void bottomSheet({
  required BuildContext context,
  required Function(String value) onSelected,
  required List<String> options,
  required String title,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return _ContractTypeBottomSheet(
        onSelected: onSelected,
        options: options,
        title: title,
      );
    },
  );
}

class _ContractTypeBottomSheet extends StatelessWidget {
  final void Function(String value) onSelected;
  final List<String>? options;
  final String title;

  const _ContractTypeBottomSheet(
      {required this.onSelected, required this.options, required this.title});

  // final List<String> options = const [
  //   "Full-time",
  //   "Half-time",
  //   "Flexi",
  //   "Student",
  //   "Stagair",
  //   "Freelance",
  // ];

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
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyles.titleMedium.copyWith(fontSize: 21),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: options!.length,
                  itemBuilder: (context, index) {
                    final option = options![index];
                    return GestureDetector(
                      onTap: () => onSelected(option),
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
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
