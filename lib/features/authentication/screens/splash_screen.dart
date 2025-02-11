import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/features/authentication/screens/first_glance_screen.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/features/jobs/job_screen_verified.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/$location';
  static const String location = '';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with ScreenStateMixin {
  @override
  Future<void> loadData() async {
    await Hive.initFlutter();

    await JobrIcons.preload(context);

    await Future.delayed(Duration(seconds: 1));

    try {
      UserType userType = await AccountsService().checkAuthentication();

      switch (userType) {
        case UserType.employee:
          context.pushReplacement(
            JobrRouter.getRoute(
              JobVerifiedScreen.location,
              JobrRouter.employeeInitialroute,
            ),
          );
          break;
        case UserType.employer:
          context.pushReplacement(
            JobrRouter.getRoute(
              JobListingsScreen.location,
              JobrRouter.employerInitialroute,
            ),
          );
          break;
      }
    } catch (e) {
      context.pushReplacement(FirstGlanceScreen.route);

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          height: 90,
          decoration: const BoxDecoration(),
          child: const Center(
            child: SvgIcon(
              JobrIcons.logoLight,
              size: 90,
              leaveUnaltered: true,
            ),
          ),
        ),
      ),
    );
  }
}
