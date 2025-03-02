import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/features/core/widgets/exception_popup.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/features/profile/screens/create_profile_screen.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/input/jobr_textfield.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class EmailRegisterScreen extends StatefulWidget {
  final UserType userType;

  const EmailRegisterScreen({
    super.key,
    required this.userType,
  });

  static const String route = '${LoginScreen.route}/$location';
  static const String location = 'email-register';

  @override
  State<EmailRegisterScreen> createState() => _EmailRegisterScreenState();
}

class _EmailRegisterScreenState extends State<EmailRegisterScreen>
    with ScreenStateMixin, WidgetsBindingObserver {
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();
  final TextEditingController tecConfirmPassword = TextEditingController();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      _isKeyboardVisible = bottomInset > 0;
    });
  }

  void setError(String error) {
    ExceptionPopup.show(context, error);
    setLoading(false);
  }

  Future<void> _register() async {
    if (tecEmail.text.isEmpty) {
      setError('Email is verplicht');
      return;
    }

    if (tecPassword.text.isEmpty) {
      setError('Wachtwoord is verplicht');
      return;
    }

    if (tecPassword.text != tecConfirmPassword.text) {
      setError('Wachtwoorden komen niet overeen');
      return;
    }

    try {
      await AccountsService().register(
        email: tecEmail.text,
        password: tecPassword.text,
        userType: widget.userType,
      );

      switch (widget.userType) {
        case UserType.employee:
          context.pushReplacement(CreateProfileScreen.employeeRoute);
          break;
        case UserType.employer:
          context.pushReplacement(JobListingsScreen.employerRoute);
          break;
      }
    } catch (e) {
      setError('E-mail bestaat al');
      return;
    }
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
                  children: [
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
                      isPassword: true,
                    ),
                    const SizedBox(height: 10),
                    JobrTextField(
                      controller: tecConfirmPassword,
                      hintText: "Herhaal wachtwoord",
                      obscureText: true,
                      height: 45,
                      isPassword: true,
                    ),
                    const SizedBox(height: 10),
                    PrimaryButton(
                      borderRadius: 30,
                      onTap: loading ? null : _register,
                      buttonText: loading ? 'Laden...' : 'Account maken',
                    ),
                    if (!_isKeyboardVisible) const PrivacyPolicyBlock(),
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
