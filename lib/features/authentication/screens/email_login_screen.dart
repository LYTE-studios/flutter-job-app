import 'package:flutter/material.dart';
import 'package:jobr/core/routing/mixins/screen_state_mixin.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/data/services/api_service.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/ui/buttons/primary_button.dart';
import 'package:jobr/ui/input/custom_textfield.dart';

class EmailLoginScreen extends StatefulWidget {
  static const String route = '${LoginScreen.route}/$location';
  static const String location = 'email';

  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen>
    with ScreenStateMixin {
  // Text editing controllers
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  // Login function
  Future<void> _login() async {
    final accountsService = AccountsService(ApiService());

    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      final response = await accountsService.login(
        tecEmail.text,
        tecPassword.text,
      );

      // Assuming response['success'] is true if login is successful
      if (response['success'] == true) {
        // Navigate to home screen or dashboard
        Navigator.of(context).pushReplacementNamed(
          '/home',
        ); // Replace '/home' with actual route name
      } else {
        setState(() {
          errorMessage = response['message'] ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: CustomTextField(
            controller: tecEmail,
            hintText: "Jouw email",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          // width: 340,
          child: CustomTextField(
            controller: tecPassword,
            hintText: "Wachtwoord",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        PrimaryButton(
          onTap: _login,
          buttonText: 'Inloggen',
        ),
        const PrivacyPolicyBlock(),
      ],
    );
  }
}
