import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/authentication/base/base_auth_screen.dart';
import 'package:jobr/features/authentication/screens/email_login_screen.dart';
import 'package:jobr/features/authentication/screens/email_register_screen.dart';
import 'package:jobr/features/authentication/screens/first_glance_screen.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/chat/screens/chat_screen.dart';
import 'package:jobr/features/dashboard/base/base_dashboard_screen.dart';
import 'package:jobr/features/profile/screens/job_screen.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';

import '../../features/profile/screens/create_profile_screen.dart';
import '../../features/profile/screens/recruteren/jobr_ai_suggestions_screen.dart';
import '../../features/profile/screens/recruteren/recruitment_detail_screen.dart';
import '../../features/profile/screens/recruteren_screen.dart';

GoRouter router = GoRouter(
  initialLocation: FirstGlanceScreen.route,
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        String route = state.fullPath ?? '';

        int index = 0;

        if (route.contains(ProfileScreen.location)) {
          index = 3;
        } else if (route.contains(ChatScreen.location)) {
          index = 2;
        } else if (route.contains(RecruterenScreen.location)) {
          index = 1;
        } else if (route.contains(JobScreen.location)) {
          index = 0;
        }

        return BaseDashboardScreen(
          selectedIndex: index,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: ChatScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: ChatScreen(),
          ),
        ),
        GoRoute(
          path: ProfileScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
        GoRoute(
          path: RecruterenScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: RecruterenScreen(),
          ),
        ),
        GoRoute(
          path: JobScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: JobScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: CreateProfileScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: CreateProfileScreen(),
      ),
    ),
    GoRoute(
      path: '/recruitment/:category',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final category = state.pathParameters['category'] ?? '';
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;

        return NoTransitionPage(
          child: RecruitmentDetailScreen(
            category: category,
            title: extra['title'],
            image: extra['image'],
          ),
        );
      },
    ),
    GoRoute(
      path: JobrAiSuggestionsScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: JobrAiSuggestionsScreen(),
      ),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BaseAuthScreen(
          canPop: state.fullPath != FirstGlanceScreen.route,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: FirstGlanceScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: FirstGlanceScreen(),
          ),
          routes: [
            GoRoute(
              path: LoginScreen.location,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage(
                child: LoginScreen(),
              ),
              routes: [
                GoRoute(
                  path: EmailLoginScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      const NoTransitionPage(
                    child: EmailLoginScreen(),
                  ),
                ),
                GoRoute(
                  path: EmailRegisterScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      const NoTransitionPage(
                    child: EmailRegisterScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
