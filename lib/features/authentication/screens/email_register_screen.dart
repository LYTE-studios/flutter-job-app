import 'package:flutter/material.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/ui/buttons/primary_button.dart';
import 'package:jobr/ui/input/custom_textfield.dart';

class EmailRegisterScreen extends StatefulWidget {
  static const String route = '${LoginScreen.route}/$location';
  static const String location = 'email-register';

  const EmailRegisterScreen({super.key});

  @override
  State<EmailRegisterScreen> createState() => _EmailRegisterScreenState();
}

class _EmailRegisterScreenState extends State<EmailRegisterScreen> {
  // Text editing controllers
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomTextField(
          controller: tecEmail,
          hintText: "Jouw email",
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          controller: tecEmail,
          hintText: "Wachtwoord",
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          controller: tecEmail,
          hintText: "Herhaal wachtwoord",
        ),
        const SizedBox(
          height: 10,
        ),
        const PrimaryButton(
          buttonText: 'Account maken',
        ),
        const PrivacyPolicyBlock(),
      ],
    );
  }
}
