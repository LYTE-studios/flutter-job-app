import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class CustomListPicker extends StatefulWidget {
  final List<String> options;
  final String hint;
  final void Function(String) onOptionSelected;

  const CustomListPicker({
    super.key,
    required this.options,
    required this.onOptionSelected,
    required this.hint,
  });

  @override
  State<CustomListPicker> createState() => _CustomListPickerState();
}

class _CustomListPickerState extends State<CustomListPicker> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#D9D9D9'),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.hint,
              style: const TextStyle(
                fontSize: 21,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < widget.options.length; i++)
            GestureDetector(
              onTap: () {
                widget.onOptionSelected(widget.options[i]);
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#F3F3F3'),
                  borderRadius: BorderRadius.circular(18),
                ),
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: Text(
                  widget.options[i],
                  style: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
