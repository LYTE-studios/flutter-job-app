import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/utils/keyboard_util.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class BaseCreateJobListingScreen extends StatelessWidget {
  final Widget child;

  final bool isNavigationEnabled;

  final double progress;

  final Function()? onNavigate;

  final String buttonLabel;
  final String? secondaryButtonLabel;
  final bool buttonMustBeAtBottom;

  final bool loading;

  const BaseCreateJobListingScreen({
    super.key,
    required this.child,
    this.isNavigationEnabled = false,
    this.onNavigate,
    this.progress = 0,
    this.buttonLabel = "Continue",
    this.secondaryButtonLabel,
    this.buttonMustBeAtBottom = true,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
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
                  color: Colors.grey[100], // Remaining 80% width
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          KeyboardUtil.close();
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(
                  PaddingSizes.large,
                ),
                child: SafeArea(
                  minimum: const EdgeInsets.only(
                    bottom: 64,
                  ),
                  child: child,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: SafeArea(
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: PaddingSizes.medium,
                    horizontal: PaddingSizes.extraLarge,
                  ),
                  child: Center(
                    child: PrimaryButton(
                      borderRadius: 30,
                      onTap: loading ? null : onNavigate,
                      buttonText: loading
                          ? 'Laden...'
                          : !isNavigationEnabled
                              ? buttonLabel
                              : (secondaryButtonLabel ?? buttonLabel),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
