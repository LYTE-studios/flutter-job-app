import 'package:flutter/material.dart';

class CommonAppbarNavigation extends StatelessWidget
    implements PreferredSizeWidget {
  final String appbarTitle;

  const CommonAppbarNavigation({super.key, required this.appbarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Text(
          appbarTitle,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
