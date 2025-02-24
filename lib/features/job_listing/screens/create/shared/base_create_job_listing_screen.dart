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
  final bool showProgressBar;
  final bool loading;
  final String title;

  const BaseCreateJobListingScreen({
    super.key,
    required this.child,
    this.title = "Nieuwe vacature",
    this.isNavigationEnabled = false,
    this.onNavigate,
    this.progress = 0,
    this.buttonLabel = "Continue",
    this.secondaryButtonLabel,
    this.buttonMustBeAtBottom = true,
    this.loading = false,
    this.showProgressBar = true,
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
          title,
          style: TextStyles.titleMedium,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: !showProgressBar
              ? Row()
              : Row(
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
//       body: GestureDetector(
//         behavior: HitTestBehavior.translucent,
//         onTap: () {
//           KeyboardUtil.close();
//         },
//         child: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.all(
//                   PaddingSizes.large,
//                 ),
//                 child: SafeArea(
//                   minimum: const EdgeInsets.only(
//                     bottom: 64,
//                   ),
//                   child: child,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 10,
//               right: 0,
//               left: 0,
//               child: SafeArea(
//                 bottom: true,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: PaddingSizes.medium,
//                     horizontal: PaddingSizes.extraLarge,
//                   ),
//                   child: Center(
//                     child: PrimaryButton(
//                       borderRadius: 30,
//                       onTap: loading ? null : onNavigate,
//                       buttonText: loading
//                           ? 'Laden...'
//                           : !isNavigationEnabled
//                               ? buttonLabel
//                               : (secondaryButtonLabel ?? buttonLabel),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],

      body: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: child,
          );
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: ListView(
                padding: EdgeInsets.all(PaddingSizes.large),
                children: [
                  child,
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: PaddingSizes.large,
              right: PaddingSizes.large,
              child: SafeArea(
                bottom: true,
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
            ),
          ],
        ),
      ),
    );
  }
}
