// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jobr/core/routing/mixins/screen_state_mixin.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/data/services/api_service.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/ui/buttons/primary_button.dart';
import 'package:jobr/ui/input/custom_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobr/data/providers/auth_providers.dart';

class EmailLoginScreen extends ConsumerStatefulWidget {
  static const String route = '${LoginScreen.route}/$location';
  static const String location = 'email';

  const EmailLoginScreen({super.key});

  @override
  ConsumerState<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends ConsumerState<EmailLoginScreen> {
  // Text editing controllers
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();

  // Login function
  void _login() {
    ref.read(authProvider.notifier).login(tecEmail.text, tecPassword.text);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Column(
      children: [
        if (authState.error != null)
          Text(
            authState.error!,
            style: const TextStyle(color: Colors.red),
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
            controller: tecPassword,
            hintText: "Wachtwoord",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        PrimaryButton(
          onTap: authState.isLoading ? null : _login,
          buttonText: authState.isLoading ? 'Laden...' : 'Inloggen',
        ),
        const PrivacyPolicyBlock(),
      ],
    );
  }
}
