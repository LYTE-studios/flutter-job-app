import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr/qr.dart'; // Importing the correct QR package

class QrCodeWidget extends StatelessWidget {
  final Map<String, String> cardData;

  const QrCodeWidget({
    super.key,
    required this.cardData,
  });

  @override
  Widget build(BuildContext context) {
    final String dataString = cardData.toString();

    // Wrapping in a Container to ensure it's a valid Widget
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: QrImageView(
          data: dataString, // Use cardData to generate QR code
          version: QrVersions.auto,
          size: 250.0,
        ),
      ),
    );
  }
}
