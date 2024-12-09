import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/chat/screens/chat_screen.dart';
import 'package:jobr/ui/buttons/jobr_icon_button.dart';

class FirstGlanceScreen extends StatefulWidget {
  static const String route = '/$location';
  static const String location = '';

  const FirstGlanceScreen({super.key});

  @override
  State<FirstGlanceScreen> createState() => _FirstGlanceScreenState();
}

class _FirstGlanceScreenState extends State<FirstGlanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 200,
        ),
        JobrIconButton(
          label: "⚡ Ik zoek een job",
          onPressed: () {
            context.pushReplacement(ChatScreen.route);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        JobrIconButton(
          label: "💼 Ik zoek talent",
          onPressed: () {
            context.push(LoginScreen.route);
          },
        ),
      ],
    );
  }
}
