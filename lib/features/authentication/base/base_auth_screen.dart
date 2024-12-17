import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class BaseAuthScreen extends StatelessWidget {
  final bool canPop;

  final Widget child;

  const BaseAuthScreen({
    super.key,
    required this.child,
    this.canPop = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/background/login_video.gif',
            ),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.4,
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 90,
                                decoration: const BoxDecoration(),
                                child: const Center(
                                  child: SvgIcon(
                                    JobrIcons.logoLight,
                                    size: 90,
                                    leaveUnaltered: true,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyles.titleMedium.copyWith(
                                    color: TextStyles.clearText,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Making ',
                                    ),
                                    TextSpan(
                                      text: 'matches',
                                      style: TextStyles.titleMedium.copyWith(
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' that work.',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: PaddingSizes.large,
                            left: PaddingSizes.large,
                            child: SafeArea(
                              bottom: false,
                              top: true,
                              child: Visibility(
                                visible: canPop,
                                child: ClearInkWell(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: SvgIcon(
                                      JobrIcons.chevronLeftIcon,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: SafeArea(
                        top: false,
                        bottom: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: PaddingSizes.xxl,
                          ),
                          child: child,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
