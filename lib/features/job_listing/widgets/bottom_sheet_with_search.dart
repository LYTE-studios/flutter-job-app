import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

void bottomSheetWithsearch({
  required BuildContext context,
  required Function(String value) onSelected,
  required List<String> options,
  required String title,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return _FunctionBottomSheet(
          options: options, onSelected: onSelected, title: title);
    },
  );
}

class _FunctionBottomSheet extends StatefulWidget {
  final void Function(String value) onSelected;
  final List<String> options;
  final String title;

  const _FunctionBottomSheet(
      {required this.onSelected, required this.options, required this.title});

  @override
  State<_FunctionBottomSheet> createState() => __FunctionBottomSheetState();
}

class __FunctionBottomSheetState extends State<_FunctionBottomSheet> {
  String? selectedOption;

  // final List<String> options = [
  //   "All-round",
  //   "Zaal",
  //   "Bar",
  //   "Keuken",
  //   "Management",
  //   "Back-office",
  //   "Financieel",
  //   "Hygiëne",
  //   "Afwasser",
  //   "Sommelier",
  //   "Barista",
  //   "Ober/Serveerster",
  //   "Cateringmanagement",
  // ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  size: 29,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 60,
              ),
              Center(
                child: Text(
                  widget.title,
                  style: TextStyles.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: HexColor.fromHex("#D9D9D9").withOpacity(0.31),
              hintText: "Zoek een functie",
              hintStyle: TextStyles.bodySmall
                  .copyWith(fontSize: 17, color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: HexColor.fromHex("#D9D9D9").withOpacity(0.31))),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                final option = widget.options[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  title: Text(
                    option,
                    style: TextStyles.titleMedium.copyWith(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                        color: selectedOption == option
                            ? Colors.pinkAccent
                            : Colors.black),
                  ),
                  onTap: () {
                    setState(() {
                      selectedOption = option;
                    });
                  },
                  selected: selectedOption == option,
                  selectedTileColor: Colors.pink.shade50,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 58,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: selectedOption != null
                        ? HexColor.fromHex("#FF3E68")
                        : HexColor.fromHex('#DADADA'),
                    shape: RoundedRectangleBorder(
                      borderRadius: selectedOption != null
                          ? BorderRadius.circular(65)
                          : BorderRadius.circular(65),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () {
                    selectedOption == null
                        ? null
                        : widget.onSelected(selectedOption!);
                  },
                  child: const Text(
                    "Bevestigen",
                    style: TextStyle(
                      fontSize: 17.5,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
