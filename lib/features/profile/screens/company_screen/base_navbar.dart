import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobrNavigationItem {
  String route;
  String icon;
  String name;

  JobrNavigationItem({
    required this.route,
    required this.icon,
    required this.name,
  });
}

class BaseNavBarScreen extends StatelessWidget {
  final Widget child;

  final int? selectedIndex;

  final List<JobrNavigationItem> routes;

  const BaseNavBarScreen({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.routes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: selectedIndex == null
          ? null
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex ?? 0,
              onTap: (int index) {
                HapticFeedback.lightImpact();

                String route = routes[index].route;

                // Use GoRouter for navigation
                router.pushReplacement(route);
              },
              selectedLabelStyle: TextStyles.bodySmall.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 12,
              ),
              unselectedLabelStyle: TextStyles.bodySmall.copyWith(
                fontSize: 12,
              ),
              items: routes
                  .map((route) => BottomNavigationBarItem(
                        label: route.name,
                        icon: _NavigationBarIcon(
                          icon: route.icon,
                          selected: selectedIndex == routes.indexOf(route),
                        ),
                      ))
                  .toList(),
            ),
      body: child,
    );
  }
}

class _NavigationBarIcon extends StatelessWidget {
  final String icon;

  final bool selected;

  const _NavigationBarIcon({
    required this.icon,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: Center(
        child: SvgIcon(
          icon,
          size: 24,
          color: selected
              ? Theme.of(context).primaryColor
              : HexColor.fromHex('#999999'),
        ),
      ),
    );
  }
}
