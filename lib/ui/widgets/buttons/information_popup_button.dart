import 'package:flutter/material.dart';
import 'package:jobr/features/job_listing/widgets/bottom_info_snack_bar.dart';

class InformationPopupButton extends StatelessWidget {
  final String title;

  final String description;

  const InformationPopupButton({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.info_outline,
        size: 22,
      ),
      color: Color(0xFFA6A6A6),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return InfoDialog(
              description: description,
              label: title,
            );
          },
        );
      },
    );
  }
}
