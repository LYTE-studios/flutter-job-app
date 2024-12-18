import 'package:flutter/material.dart';
import 'package:flutter_exam/add_company.dart';
import 'package:flutter_exam/features/authentication/screens/chat_screen.dart';
import 'package:flutter_exam/ui/theme/jobr_theme.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Jobr',
      theme: jobrTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child ?? const SizedBox(),
        );
      },
      home: NewCompanyPage(), // Replace this with your home screen widget
    ),
  );
}
