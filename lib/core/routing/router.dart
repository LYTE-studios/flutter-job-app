import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/features/authentication/base/base_auth_screen.dart';
import 'package:jobr/features/authentication/screens/email_login_screen.dart';
import 'package:jobr/features/authentication/screens/email_register_screen.dart';
import 'package:jobr/features/authentication/screens/first_glance_screen.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/chat/screens/chat_screen.dart';
import 'package:jobr/features/dashboard/base/base_dashboard_screen.dart';
import 'package:jobr/features/jobs/filter.dart';
import 'package:jobr/features/jobs/job_listing.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/features/jobs/job_screen_verified.dart';
import 'package:jobr/features/jobs/jobdetail_screen.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:jobr/features/vacatures/delete_vacancy.dart';
import 'package:jobr/features/vacatures/vacature_card_example.dart';
import 'package:jobr/features/vacatures/vacatures.dart';

import '../../features/profile/screens/create_profile_screen.dart';
import '../../features/profile/screens/recruteren/jobr_ai_suggestions_screen.dart';
import '../../features/profile/screens/recruteren/recruitment_detail_screen.dart';
import '../../features/profile/screens/recruteren_screen.dart';
import '../../features/profile/screens/edit/choose_company_screen.dart';
import '../../features/profile/screens/edit/choose_sector_screen.dart';
import '../../features/profile/screens/edit/create_new_company_screen.dart';
import '../../features/profile/screens/edit/edit_profile_details_screen.dart';
import '../../features/profile/screens/edit/make_a_choice_screen.dart';
import '../../features/profile/screens/edit/new_experience_screen.dart';

GoRouter router = GoRouter(
  initialLocation: FirstGlanceScreen.route,
  routes: <RouteBase>[
    // Employee
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

        return BaseEmployeeDashboard(
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
              NoTransitionPage(
            child: VacatureScreen(),
          ),
        ),
      ],
    ),
    // Employer
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

        return BaseEmployerDashboard(
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
            child: JobVerifiedScreen(),
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
      path: '/jobs/:category',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final category = state.pathParameters['category'] ?? '';
        if (category == 'filters') {
          return const NoTransitionPage(
            child: FilterScreen(),
          );
        }
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;

        return NoTransitionPage(
          child: JobDetailScreen(
            category: category,
            title: extra['title'],
            image: extra['image'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/jobs/filters/jobupdates',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(
          child: JobListScreen(),
        );
      },
    ),
    GoRoute(
        path: '/vacancies/delete_vacancy',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            NoTransitionPage(
              child: DeleteVacancyPage(),
            )),
    GoRoute(
      path: JobrAiSuggestionsScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: JobrAiSuggestionsScreen(),
      ),
    ),
    GoRoute(
      path: EditProfileDetailsScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: EditProfileDetailsScreen(),
      ),
    ),
    GoRoute(
      path: ChooseSectorScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: ChooseSectorScreen(),
      ),
    ),
    GoRoute(
      path: ChooseCompanyScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: ChooseCompanyScreen(),
      ),
    ),
    GoRoute(
      path: NewExpereinceScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: NewExpereinceScreen(),
      ),
    ),
    GoRoute(
      path: CreateNewCompanyScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: CreateNewCompanyScreen(),
      ),
    ),
    GoRoute(
      path: MakeAChoiceScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: MakeAChoiceScreen(),
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
              pageBuilder: (BuildContext context, GoRouterState state) {
                final Map<String, dynamic> params =
                    state.extra as Map<String, dynamic>;

                return NoTransitionPage(
                  child: LoginScreen(
                    userType: params['userType'] as UserType,
                    isNewUser: params['isNewUser'] as bool,
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: EmailLoginScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    final Map<String, dynamic> params =
                        state.extra as Map<String, dynamic>;

                    return NoTransitionPage(
                      child: EmailLoginScreen(
                        userType: params['userType'] as UserType,
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: EmailRegisterScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    final Map<String, dynamic> params =
                        state.extra as Map<String, dynamic>;

                    return NoTransitionPage(
                      child: EmailRegisterScreen(
                        userType: params['userType'] as UserType,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
