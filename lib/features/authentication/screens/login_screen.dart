import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/features/authentication/screens/email_login_screen.dart';
import 'package:jobr/features/authentication/screens/email_register_screen.dart';
import 'package:jobr/features/authentication/screens/first_glance_screen.dart';
import 'package:jobr/features/authentication/widgets/privacy_policy_block.dart';
import 'package:jobr/ui/widgets/buttons/jobr_icon_button.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:lyte_studios_flutter_ui/mixins/screen_state_mixin.dart';

class LoginScreen extends StatefulWidget {
  final UserType userType;

  final bool isNewUser;

  const LoginScreen({
    super.key,
    required this.userType,
    required this.isNewUser,
  });

  static const String route = '${FirstGlanceScreen.route}/$location';
  static const String location = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ScreenStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        JobrIconButton(
          reverseAlign: true,
          icon: JobrIcons.appleIcon,
          label: "Doorgaan met",
          onPressed: () {
            print("Icon-Label Button Pressed");
          },
        ),
        const SizedBox(
          height: 10,
        ),
        JobrIconButton(
          reverseAlign: true,
          icon: JobrIcons.googleIcon,
          label: "Doorgaan met",
          onPressed: () {
            print("Icon-Label Button Pressed");
          },
        ),
        const SizedBox(
          height: 10,
        ),
        JobrIconButton(
          reverseAlign: true,
          icon: JobrIcons.emailIcon,
          label: "Doorgaan met Email",
          onPressed: () {
            if (widget.isNewUser) {
              context.push(EmailRegisterScreen.route, extra: {
                'userType': widget.userType,
                'isNewUser': widget.isNewUser,
              });
            } else {
              context.push(EmailLoginScreen.route, extra: {
                'userType': widget.userType,
                'isNewUser': widget.isNewUser,
              });
            }
          },
        ),
        const PrivacyPolicyBlock(),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
