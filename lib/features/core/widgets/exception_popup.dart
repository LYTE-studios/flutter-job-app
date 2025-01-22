import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class ExceptionPopup extends StatelessWidget {
  final String message;

  const ExceptionPopup({
    super.key,
    required this.message,
  });

  static void show(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);

    messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: ExceptionPopup(
          message: message,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: PaddingSizes.large,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: HexColor.fromHex('#FFF0F3'),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(
            vertical: PaddingSizes.extraSmall,
            horizontal: PaddingSizes.small,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: PaddingSizes.small,
              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
