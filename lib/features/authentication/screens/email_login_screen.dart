// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/input/jobr_textfield.dart';
import 'package:jobr/data/providers/auth_providers.dart';

class EmailLoginScreen extends ConsumerStatefulWidget {
  final UserType userType;

  const EmailLoginScreen({
    super.key,
    required this.userType,
  });

  static const String route = '${LoginScreen.route}/$location';
  static const String location = 'email';

  @override
  ConsumerState<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends ConsumerState<EmailLoginScreen> {
  // Text editing controllers
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();

  // Login function
  void _login() {
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
    
    ref.read(authProvider.notifier).login(tecEmail.text, tecPassword.text);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

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
                    if (authState.error != null)
                      Text(
                        authState.error!,
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
                      onTap: authState.isLoading ? null : _login,
                      buttonText: authState.isLoading ? 'Laden...' : 'Inloggen',
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
