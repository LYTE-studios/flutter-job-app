import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class CommonAppbarNavigation extends StatelessWidget
    implements PreferredSizeWidget {
  final String appbarTitle;

  final Widget? icon;

  final bool canGoBack;

  const CommonAppbarNavigation({
    super.key,
    required this.appbarTitle,
    this.canGoBack = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      appbarTitle,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'inter',
                      ),
                    ),
                  ),
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                      ),
                      child: icon!,
                    ),
                ],
              ),
            ),
          ),
          if (canGoBack)
            IconButton(
              icon: const SvgIcon(
                JobrIcons.close,
                color: Colors.black,
              ),
              onPressed: () => context.pop(),
            ),
        ],
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
