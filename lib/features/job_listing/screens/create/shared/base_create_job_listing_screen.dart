import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class BaseCreateJobListingScreen extends StatelessWidget {
  final Widget child;

  final bool isNavigationEnabled;

  final double progress;

  final Function()? onNavigate;

  final String buttonLabel;

  const BaseCreateJobListingScreen({
    super.key,
    required this.child,
    this.isNavigationEnabled = false,
    this.onNavigate,
    this.progress = 0,
    this.buttonLabel = "Continue",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            CupertinoIcons.back,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Nieuwe vacature",
          style: TextStyles.titleMedium,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: HexColor.fromHex("#FF3E68"),
                ),
                height: 6,
                width: MediaQuery.of(context).size.width * progress,
              ),
              Expanded(
                child: Container(
                  height: 6,
                  color: Colors.grey[300], // Remaining 80% width
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          PaddingSizes.large,
        ),
        child: SafeArea(
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: PaddingSizes.small),
              child,
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSizes.large,
                ),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: isNavigationEnabled
                            ? HexColor.fromHex("#FF3E68")
                            : HexColor.fromHex('#DADADA'),
                        shape: RoundedRectangleBorder(
                          borderRadius: isNavigationEnabled
                              ? BorderRadius.circular(65)
                              : BorderRadius.circular(65),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: onNavigate,
                      child: Text(
                        buttonLabel,
                        style: const TextStyle(
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
        ),
      ),
    );
  }
}
