import 'package:flutter/material.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/ui/buttons/primary_button.dart';
import 'package:jobr/ui/input/custom_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobr/data/providers/auth_providers.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (authState.error != null)
          Text(
            authState.error!,
            style: const TextStyle(color: Colors.red),
          ),
        CustomTextField(
          controller: tecEmail,
          hintText: "Jouw email",
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          controller: tecPassword,
          hintText: "Wachtwoord",
          obscureText: true,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          controller: tecConfirmPassword,
          hintText: "Herhaal wachtwoord",
          obscureText: true,
        ),
        const SizedBox(
          height: 10,
        ),
        PrimaryButton(
          onTap: authState.isLoading ? null : _register,
          buttonText: authState.isLoading ? 'Laden...' : 'Account maken',
        ),
        const PrivacyPolicyBlock(),
      ],
    );
  }
}
