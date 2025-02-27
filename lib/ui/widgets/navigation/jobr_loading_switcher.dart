import 'package:flutter/material.dart';

class JobrLoadingSwitcher extends StatelessWidget {
  final bool loading;

  final Widget child;

  const JobrLoadingSwitcher({
    super.key,
    required this.loading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: loading
          ? Center(
              child: SizedBox(
                height: 21,
                width: 21,
                child: CircularProgressIndicator(),
              ),
            )
          : child,
    );
  }
}
