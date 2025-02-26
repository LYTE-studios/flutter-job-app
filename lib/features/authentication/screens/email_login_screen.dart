// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/features/authentication/screens/add_company.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/features/core/widgets/exception_popup.dart';
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

  @override
  void setError(String error) {
    ExceptionPopup.show(context, error);
    setLoading(false);
  }

  // Login function
  Future<void> _login() async {
    if (tecEmail.text.isEmpty || tecPassword.text.isEmpty) {
      setError("Please fill in all fields");
      return;
    }

    setLoading(true);
    try {
      UserType userType =
          await AccountsService().login(tecEmail.text, tecPassword.text);

      switch (userType) {
        case UserType.employee:
          context.pushReplacement(
              JobrRouter.getRoute(
                NewCompanyPage.location,
                JobrRouter.employeeInitialroute,
              ),
              extra: {
                'userType': widget.userType,
              });
          break;
        case UserType.employer:
          context.pushReplacement(
              JobrRouter.getRoute(
                NewCompanyPage.location,
                JobrRouter.employerInitialroute,
              ),
              extra: {
                'userType': widget.userType,
              });
          break;
      }
    } catch (e) {
      setError("Invalid credentials");
      return;
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
                      isPassword: true,
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
