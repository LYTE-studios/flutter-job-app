import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class SelectionButton extends StatefulWidget {
  const SelectionButton(
      {super.key,
      required this.label,
      required this.controller,
      this.color,
      this.hintText = 'Kies locatie',
      this.hintTextStyle = const TextStyle(
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        color: Color(0xFF919191),
      ),
      this.leading,
      this.onTap,
      this.prefixIcon});
  final Widget? prefixIcon;
  final Widget? leading;
  final String label;
  final TextEditingController controller;

  final Color? color;
  final TextStyle hintTextStyle;
  final String hintText;
  final GestureTapCallback? onTap;

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    bool isLocationSelected = widget.label == 'Locatie' &&
        widget.controller.text != widget.hintText &&
        widget.controller.text.isNotEmpty;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            widget.label.padRight(12),
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: HexColor.fromHex('#565656'),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: widget.onTap,
            child: isLocationSelected
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IntrinsicWidth(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black.withOpacity(.06),
                                  ),
                                ),
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.prefixIcon != null)
                                  SvgPicture.asset(
                                    JobrIcons.location,
                                    width: 12,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    widget.controller.text,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15.36,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.05,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (widget.leading != null) widget.leading!,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black.withOpacity(.06),
                      )
                    ],
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black.withOpacity(.06),
                        ),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        if (widget.prefixIcon != null) widget.prefixIcon!,
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.controller.text.isEmpty
                                ? widget.hintText
                                : widget.controller.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: widget.controller.text.isEmpty
                                ? widget.hintTextStyle
                                : const TextStyle(
                                    fontSize: 15.36,
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0.05,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                        if (widget.leading != null) widget.leading!,
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
