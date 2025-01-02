import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/chat/screens/chat_screen.dart';
import 'package:jobr/ui/buttons/jobr_icon_button.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstGlanceScreen extends StatelessWidget {
  static const String route = '/$location';
  static const String location = '';

  const FirstGlanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(
          height: 200,
        ),
        JobrIconButton(
          textIcon: "⚡",
          label: "Ik zoek een job",
          onPressed: () {
            context.push(
              LoginScreen.route,
              extra: {
                'userType': UserType.employee,
                'isNewUser': true,
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        JobrIconButton(
          textIcon: "💼",
          label: "Ik zoek talent",
          onPressed: () {
            context.push(
              LoginScreen.route,
              extra: {
                'userType': UserType.employer,
                'isNewUser': true,
              },
            );
          },
        ),
        SizedBox(
          height: 81,
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: TextStyles.clearText,
                ),
                children: [
                  const TextSpan(
                    text: 'Heb je al een account? ',
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.push(
                          LoginScreen.route,
                          extra: {
                            'userType': UserType.employer,
                            'isNewUser': false,
                          },
                        );
                      },
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    ),
                    text: 'Log in',
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
