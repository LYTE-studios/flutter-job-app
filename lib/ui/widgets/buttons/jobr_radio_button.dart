import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobrRadioButton extends StatefulWidget {
  final int value;
  final int groupValue;
  final void Function(int) onChanged;

  const JobrRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _JobrRadioButtonState createState() => _JobrRadioButtonState();
}

class _JobrRadioButtonState extends State<JobrRadioButton> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected
                ? HexColor.fromHex("#FF3E68").withOpacity(0.17)
                : HexColor.fromHex("#D5D5D5").withOpacity(0.46)),
        child: Icon(
          Icons.circle,
          size: 20,
          color: selected
              ? HexColor.fromHex("#FF3E68")
              : HexColor.fromHex("#D5D5D5").withOpacity(0.46),
        ),
      ),
    );
  }
}
