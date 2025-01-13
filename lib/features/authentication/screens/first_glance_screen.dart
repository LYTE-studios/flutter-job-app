import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/features/vacatures/vacatures.dart';
import 'package:jobr/ui/buttons/jobr_icon_button.dart';
import 'package:jobr/ui/theme/text_styles.dart';

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
    return SingleChildScrollView(
      child: Column(
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
              context.go(
                JobrRouter.getRoute(
                  JobScreen.location,
                  JobrRouter.employeeInitialroute,
                ),
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
              context.go(
                JobrRouter.getRoute(
                  VacaturesPage.location,
                  JobrRouter.employerInitialroute,
                ),
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
                    TextSpan(
                      text: 'Heb je al een account? ',
                    ),
                    TextSpan(
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
      ),
    );
  }
}