import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/ui/theme/jobr_theme.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp.router(
      title: 'Jobr',
      theme: jobrTheme,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child ?? const SizedBox(),
        );
      },
      routerConfig: router,
    ),
  ));
}
