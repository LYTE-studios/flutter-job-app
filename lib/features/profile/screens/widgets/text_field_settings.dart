import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class TextFieldSettings extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final int? maxLines;
  final Color? color;
  final TextStyle hintTextStyle;
  final String hintText;
  TextFieldSettings(
      {required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.inputFormatters,
      this.readOnly = true,
      this.maxLines,
      this.color,
      this.hintText = 'Kies een aantal',
      this.hintTextStyle = const TextStyle(
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        color: Color(0xFF919191),
      )});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 101,
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: HexColor.fromHex('#565656'),
            ),
          ),
        ),
        const SizedBox(width: 10),
        if (readOnly)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(.2),
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: maxLines != null && maxLines == 3
                  ? const EdgeInsets.only(top: 10, bottom: 40)
                  : const EdgeInsets.symmetric(vertical: 10),
              child: Text(hintText, style: hintTextStyle),
            ),
          )
        else
          Expanded(
            child: TextFormField(
              keyboardType: keyboardType,
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: color ?? HexColor.fromHex('#000000'),
              ),
              inputFormatters: inputFormatters,
              readOnly: readOnly,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintTextStyle,
                filled: false,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(.2),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 0,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(.2),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
