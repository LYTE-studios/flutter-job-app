import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class JobrIcons {
  static const String _basePath = 'assets/images';
  static const String _baseIconPath = '$_basePath/icons';
  static const String _baseLogoPath = '$_basePath/logos';

  static Future<void> preload(BuildContext context) async {
    for (String icon in icons) {
      if (icon.contains('.svg')) {
        await precacheImage(
          Svg(icon),
          context,
        );
      } else {
        await precacheImage(
          AssetImage(icon),
          context,
        );
      }
    }
  }

  static const String logoLight = '$_baseLogoPath/jobr_logo_light.svg';

  static const String googleIcon = '$_baseIconPath/google.svg';
  static const String appleIcon = '$_baseIconPath/apple.svg';
  static const String emailIcon = '$_baseIconPath/email.svg';
  static const String chevronLeftIcon = '$_baseIconPath/chevron_left.svg';
  static const String chat = '$_baseIconPath/chat.svg';
  static const String send = '$_baseIconPath/send.svg';
  static const String profile = '$_baseIconPath/profile.svg';
  static const String magnifyingGlass = '$_baseIconPath/magnifying_glass.svg';
  static const String sheet = '$_baseIconPath/sheet.svg';
  static const String location = '$_baseIconPath/location.svg';
  static const String jobApplications = '$_baseIconPath/job_applications.svg';
  static const String phone = '$_baseIconPath/phone.svg';
  static const String camera = '$_baseIconPath/camera.svg';
  static const String dashboard = '$_baseIconPath/dashboard.svg';
  static const String blockquote = '$_baseIconPath/blockquote.svg';
  static const String add = '$_baseIconPath/add.svg';
  static const String addIcon = '$_baseIconPath/add-icon.svg';
  static const String chevronDown = '$_baseIconPath/chevron-down.svg';
  static const String edit = '$_baseIconPath/edit.svg';
  static const String backArrow = '$_baseIconPath/back-arrow.svg';
  static const String close = '$_baseIconPath/close.svg';
  static const String check = '$_baseIconPath/check.svg';
  static const String calenda = '$_baseIconPath/calenda.svg';
  static const String people = '$_baseIconPath/people.svg';
  static const String company = '$_baseIconPath/company.svg';

  static const List<String> icons = [
    logoLight,
    googleIcon,
    appleIcon,
    emailIcon,
  ];
}
