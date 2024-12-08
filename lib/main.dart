import 'package:flutter/material.dart';
import 'ui/themes.dart';
import 'ui/custom_button.dart';
import 'package:flutter_exam/features/dashboard/screen/first_screen.dart';
import 'package:flutter_exam/features/dashboard/screen/doorgaan_screen.dart';
import 'package:flutter_exam/features/dashboard/screen/account_screen.dart';
import './login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // theme: AppTheme.lightTheme,
    home: LoginScreen(),
  ));
}
