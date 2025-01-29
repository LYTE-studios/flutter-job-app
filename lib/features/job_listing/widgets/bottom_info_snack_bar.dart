import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure correct import for SvgPicture

class InfoDialog extends StatelessWidget {
  final String description;
  final String label;

  const InfoDialog({
    Key? key,
    required this.description,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 17,
                right: 5,
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/icons/cross.svg', // Correct argument type
                    colorFilter: ColorFilter.mode(Colors.grey[400]!,
                        BlendMode.srcIn), // Correct parameter usage
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showInfoDialog(BuildContext context, String description, String label) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return InfoDialog(
        description: description,
        label: label,
      );
    },
  );
}
