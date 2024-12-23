import 'package:flutter/material.dart';

class CommonAppbarNavigation extends StatelessWidget
    implements PreferredSizeWidget {
  final String appbarTitle;
  final IconData? icon;

  const CommonAppbarNavigation({
    super.key,
    required this.appbarTitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appbarTitle,
        style: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.w700, fontFamily: 'inter'),
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
