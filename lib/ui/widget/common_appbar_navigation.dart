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
    this.canGoBack = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (canGoBack)
            IconButton(
              icon: const SvgIcon(
                JobrIcons.close,
                color: Colors.black,
              ),
              onPressed: () => context.pop(),
            ),
          const Spacer(),
          Text(
            appbarTitle,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              fontFamily: 'inter',
            ),
          ),
          if (icon != null) icon!,
          const Spacer(),
        ],
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
