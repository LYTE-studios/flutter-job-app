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
  final String? secondaryButtonLabel;
  final bool buttonMustBeAtBottom;

  const BaseCreateJobListingScreen({
    super.key,
    required this.child,
    this.isNavigationEnabled = false,
    this.onNavigate,
    this.progress = 0,
    this.buttonLabel = "Continue",
    this.secondaryButtonLabel,
    this.buttonMustBeAtBottom = true,
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
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: HexColor.fromHex("#FF3E68"),
                    ),
                    height: 6,
                    width: MediaQuery.of(context).size.width * value,
                  );
                },
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
      body: SafeArea(
        bottom: true,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: child,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(PaddingSizes.large),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: PaddingSizes.small),
                      child,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSizes.large,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
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
                        onPressed: isNavigationEnabled ? onNavigate : () {},
                        child: Text(
                          !isNavigationEnabled
                              ? buttonLabel
                              : (secondaryButtonLabel ?? buttonLabel),
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
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
