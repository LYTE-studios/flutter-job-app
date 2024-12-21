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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              appbarTitle,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Icon(
            icon,
            color: Colors.pink,
          )
        ],
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
