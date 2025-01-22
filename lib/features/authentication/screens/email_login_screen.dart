// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/input/jobr_textfield.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class EmailLoginScreen extends StatefulWidget {
  final UserType userType;

  const EmailLoginScreen({
    super.key,
    required this.userType,
  });

  static const String route = '${LoginScreen.route}/$location';
  static const String location = 'email';

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen>
    with ScreenStateMixin {
  // Text editing controllers
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();

  String? error;

  // Login function
  Future<void> _login() async {
    setLoading(true);
    try {
      await AccountsService().login(tecEmail.text, tecPassword.text);
    } catch (e) {
      setLoading(false);
      return;
    }

    if (widget.userType == UserType.employee) {
      context.go(
        JobrRouter.getRoute(
          JobScreen.location,
          JobrRouter.employeeInitialroute,
        ),
      );
    } else {
      context.go(
        JobrRouter.getRoute(
          JobListingsScreen.location,
          JobrRouter.employerInitialroute,
        ),
      );
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (error != null)
                      Text(
                        error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    JobrTextField(
                      controller: tecEmail,
                      hintText: "Jouw email",
                      height: 45,
                    ),
                    const SizedBox(height: 10),
                    JobrTextField(
                      controller: tecPassword,
                      hintText: "Wachtwoord",
                      height: 45,
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    PrimaryButton(
                      borderRadius: 30,
                      onTap: loading ? null : _login,
                      buttonText: loading ? 'Laden...' : 'Inloggen',
                    ),
                    const PrivacyPolicyBlock(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
