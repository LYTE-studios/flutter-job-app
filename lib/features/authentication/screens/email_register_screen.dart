import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/data/providers/auth_providers.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/input/jobr_textfield.dart';

class EmailRegisterScreen extends ConsumerStatefulWidget {
  final UserType userType;

  const EmailRegisterScreen({
    super.key,
    required this.userType,
  });

  static const String route = '${LoginScreen.route}/$location';
  static const String location = 'email-register';

  @override
  ConsumerState<EmailRegisterScreen> createState() =>
      _EmailRegisterScreenState();
}

class _EmailRegisterScreenState extends ConsumerState<EmailRegisterScreen> {
  // Text editing controllers
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();
  final TextEditingController tecConfirmPassword = TextEditingController();

  void _register() {
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
    final data = {
      "email": tecEmail.text,
      "password": tecPassword.text,
      "confirm_password": tecConfirmPassword.text,
    };

    // Call the provider to register the employee (or employer if needed)
    ref.read(authProvider.notifier).registerEmployee(data);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent background
      resizeToAvoidBottomInset: true, // Prevent overflow when keyboard appears
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse:
                    true, // Keeps focus on the bottom when the keyboard opens
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      hintText: "Kies wachtwoord",
                      obscureText: true,
                      height: 45,
                    ),
                    const SizedBox(height: 10),
                    JobrTextField(
                      controller: tecConfirmPassword,
                      hintText: "Herhaal wachtwoord",
                      obscureText: true,
                      height: 45,
                    ),
                    const SizedBox(height: 10),
                    PrimaryButton(
                      borderRadius: 30,
                      onTap: authState.isLoading ? null : _register,
                      buttonText:
                          authState.isLoading ? 'Laden...' : 'Account maken',
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
