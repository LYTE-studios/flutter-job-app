// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:jobr/core/routing/mixins/screen_state_mixin.dart';
// import 'package:jobr/data/providers/auth_providers.dart';
// import 'package:jobr/features/authentication/screens/email_register_screen.dart';
// import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
// import 'package:jobr/ui/buttons/jobr_icon_button.dart';
// import 'package:jobr/ui/theme/jobr_icons.dart';

// class LoginScreen extends StatefulWidget {
//   static const String route = '/$location';
//   static const String location = 'login';

//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> with ScreenStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         JobrIconButton(
//           reverseAlign: true,
//           icon: JobrIcons.appleIcon,
//           label: "Doorgaan met",
//           onPressed: () {
//             print("Icon-Label Button Pressed");
//           },
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         JobrIconButton(
//           reverseAlign: true,
//           icon: JobrIcons.googleIcon,
//           label: "Doorgaan met",
//           onPressed: () {
//             print("Icon-Label Button Pressed");
//           },
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         JobrIconButton(
//           reverseAlign: true,
//           icon: JobrIcons.emailIcon,
//           label: "Doorgaan met Email",
//           onPressed: () {
//             context.push(EmailRegisterScreen.route);
//           },
//         ),
//         const PrivacyPolicyBlock(),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/mixins/screen_state_mixin.dart';
import 'package:jobr/data/providers/auth_providers.dart';
import 'package:jobr/features/authentication/screens/email_register_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/ui/buttons/jobr_icon_button.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String route = '/$location';
  static const String location = 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with ScreenStateMixin {
  String? _errorMessage;

  void _handleLogin(Future<void> Function() loginMethod) async {
    // Clear previous errors
    setState(() => _errorMessage = null);

    try {
      await loginMethod();
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            JobrIconButton(
              reverseAlign: true,
              icon: JobrIcons.appleIcon,
              label: "Doorgaan met",
              onPressed: authState.isLoading
                  ? () => null
                  : () => _handleLogin(() async {
                        // Implement Apple login functionality here
                        print("Apple login triggered");
                      }),
            ),
            const SizedBox(height: 10),
            JobrIconButton(
              reverseAlign: true,
              icon: JobrIcons.googleIcon,
              label: "Doorgaan met",
              onPressed: authState.isLoading
                  ? () => null
                  : () => _handleLogin(() async {
                        // Implement Google login functionality here
                        print("Google login triggered");
                      }),
            ),
            const SizedBox(height: 10),
            JobrIconButton(
              reverseAlign: true,
              icon: JobrIcons.emailIcon,
              label: "Doorgaan met Email",
              onPressed: authState.isLoading
                  ? () => null
                  : () => context.push(EmailRegisterScreen.route),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            const PrivacyPolicyBlock(),
          ],
        ),
        if (authState.isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
