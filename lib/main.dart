import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './login_screen.dart';
import 'features/profile/screens/profile_screen.dart';

void main() {
  runApp(
    const ScreenUtilInit(
      designSize: Size(393, 1317),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: AppTheme.lightTheme,
        home: ProfileScreen(),
      ),
    ),
  );
}
