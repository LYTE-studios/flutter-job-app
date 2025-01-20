import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobrAppbarNavigation extends StatelessWidget
    implements PreferredSizeWidget {
  final String appbarTitle;

  final String? description;

  final Widget? icon;

  final bool canGoBack;

  final bool center;

  final Widget? trailing;

  const JobrAppbarNavigation({
    super.key,
    required this.appbarTitle,
    this.description,
    this.canGoBack = false,
    this.icon,
    this.center = true,
    this.trailing,
  });

  static const double barHeight = 89;

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top + 10;

    return Container(
      padding: EdgeInsets.only(
        top: statusbarHeight,
        left: PaddingSizes.medium,
        right: PaddingSizes.medium,
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment:
                center ? MainAxisAlignment.center : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 4.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: center
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      appbarTitle,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (description != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                          bottom: PaddingSizes.small,
                        ),
                        child: Text(
                          description!,
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                            color: HexColor.fromHex('#6D6D6D'),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  child: icon!,
                ),
            ],
          ),
          if (canGoBack)
            Positioned(
              left: 0,
              bottom: 0,
              child: IconButton(
                icon: const SvgIcon(
                  JobrIcons.close,
                  color: Colors.black,
                ),
                onPressed: () => context.pop(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
