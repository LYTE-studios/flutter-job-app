import 'package:flutter/material.dart';
import 'package:flutter_exam/features/profile/screens/profile_screen.dart';
import 'package:flutter_exam/ui/theme/jobr_theme.dart';

void main() {
  runApp(
    MaterialApp(
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
      home: ProfileScreen(),
    ),
  );
}
