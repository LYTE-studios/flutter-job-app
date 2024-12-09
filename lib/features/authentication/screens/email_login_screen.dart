import 'package:flutter/material.dart';
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

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  // Text editing controllers
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'that work.',
              style: TextStyle(
                fontSize: 21,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 124,
        ),
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
            controller: tecEmail,
            hintText: "Jouw email",
          ),
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
