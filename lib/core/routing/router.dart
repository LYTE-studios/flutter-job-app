import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/authentication/base/base_auth_screen.dart';
import 'package:jobr/features/authentication/screens/email_login_screen.dart';
import 'package:jobr/features/authentication/screens/email_register_screen.dart';
import 'package:jobr/features/authentication/screens/first_glance_screen.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/chat/screens/chat_screen.dart';
import 'package:jobr/features/job_listing/general_job_listing_screen.dart';
import 'package:jobr/features/job_listing/job_listing_availability_screen.dart';
import 'package:jobr/features/job_listing/skills_page.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/features/profile/screens/company_screen/base_navbar.dart';
import 'package:jobr/features/profile/screens/company_screen/company_profile.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:jobr/features/profile/screens/recruteren/jobr_ai_suggestions_screen.dart';
import 'package:jobr/features/profile/screens/recruteren/recruitment_detail_screen.dart';
import 'package:jobr/features/profile/screens/recruteren_screen.dart';
import 'package:jobr/features/vacatures/vacatures.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';

import '../../features/profile/screens/create_profile_screen.dart';

/// Builds a custom transition page with a slide-up animation.
CustomTransitionPage buildPageWithSlideUpTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
        ) {
      late final Animation<Offset> offsetAnimation = Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
      );

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

/// Router class to manage application routes.
class JobrRouter {
  static const String initialRoute = '/';
  static const String employeeInitialroute = '/employee';
  static const String employerInitialroute = '/employer';

  /// Constructs a route string based on location and base.
  static String getRoute(String location, String base) {
    return "$base/$location";
  }

  static List<String> employeeNavigationLocations = [
    JobScreen.location,
    ChatScreen.location,
    ProfileScreen.location,
  ];

  static List<String> employerNavigationLocations = [
    VacaturesPage.location,
    RecruterenScreen.location,
    ChatScreen.location,
    CompanyProfileScreen.location,
  ];

  /// Gets the selected index for navigation based on the current route.
  static int? getSelectedIndex(String route, List<String> routes) {
    for (String r in routes) {
      if (route.split('/').last == r) {
        return routes.indexOf(r);
      }
    }
    return null;
  }
}

/// Main router configuration using GoRouter.
GoRouter router = GoRouter(
  initialLocation: FirstGlanceScreen.route,
  routes: <RouteBase>[
    // Shell route for employer navigation
    ShellRoute(
      builder: (context, state, child) {
        return BaseNavBarScreen(
          routes: [
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                VacaturesPage.location,
                JobrRouter.employerInitialroute,
              ),
              icon: JobrIcons.profile3,
              name: 'Vacatures',
            ),
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                RecruterenScreen.location,
                JobrRouter.employerInitialroute,
              ),
              icon: JobrIcons.magnifyingGlass,
              name: 'Recruteren',
            ),
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                ChatScreen.location,
                JobrRouter.employerInitialroute,
              ),
              icon: JobrIcons.chat,
              name: 'Chat',
            ),
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                CompanyProfileScreen.location,
                JobrRouter.employerInitialroute,
              ),
              icon: JobrIcons.aboutUs,
              name: 'Over ons',
            ),
          ],
          selectedIndex: JobrRouter.getSelectedIndex(
            state.fullPath ?? '',
            JobrRouter.employerNavigationLocations,
          ),
          child: child,
        );
      },
      routes: [
        // Nested routes for employer navigation
        GoRoute(
          path: JobrRouter.getRoute(
            VacaturesPage.location,
            JobrRouter.employerInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
              NoTransitionPage(
                child: VacaturesPage(),
              ),
          routes: [
            GoRoute(
              path: GeneralJobListingScreen.location,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return buildPageWithSlideUpTransition(
                  context: context,
                  state: state,
                  child: const GeneralJobListingScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: JobListingSkillsScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage(
                    child: JobListingSkillsScreen(),
                  ),
                  routes: [
                    GoRoute(
                      path: JobListingSkillsScreen.location,
                      pageBuilder:
                          (BuildContext context, GoRouterState state) =>
                      const NoTransitionPage(
                        child: JobListingSkillsScreen(),
                      ),
                      routes: [
                        GoRoute(
                          path: JobListingAvailabilityScreen.location,
                          pageBuilder:
                              (BuildContext context, GoRouterState state) =>
                          const NoTransitionPage(
                            child: JobListingAvailabilityScreen(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: JobrRouter.getRoute(
            GeneralJobListingScreen.location,
            JobrRouter.employerInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
            child: GeneralJobListingScreen(),
          ),
        ),
        GoRoute(
          path: JobrRouter.getRoute(
            RecruterenScreen.location,
            JobrRouter.employerInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
            child: RecruterenScreen(),
          ),
          routes: [
            GoRoute(
              path: RecruitmentDetailScreen.location,
              pageBuilder: (BuildContext context, GoRouterState state) {
                Map data = state.extra as Map;

                return buildPageWithSlideUpTransition(
                  context: context,
                  state: state,
                  child: RecruitmentDetailScreen(
                    title: data["title"],
                    image: data["image"],
                    category: data["category"],
                  ),
                );
              },
            ),
            GoRoute(
              path: JobrAiSuggestionsScreen.location,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return buildPageWithSlideUpTransition(
                  context: context,
                  state: state,
                  child: const JobrAiSuggestionsScreen(),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: JobrRouter.getRoute(
            ChatScreen.location,
            JobrRouter.employerInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
            child: ChatScreen(),
          ),
        ),
        GoRoute(
          path: JobrRouter.getRoute(
            CompanyProfileScreen.location,
            JobrRouter.employerInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
            child: CompanyProfileScreen(),
          ),
        ),
      ],
    ),
    // Shell route for employee navigation
    ShellRoute(
      builder: (context, state, child) {
        return BaseNavBarScreen(
          selectedIndex: JobrRouter.getSelectedIndex(
            state.path ?? '',
            JobrRouter.employerNavigationLocations,
          ),
          routes: [
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                JobScreen.location,
                JobrRouter.employerInitialroute,
              ),
              icon: JobrIcons.magnifyingGlass,
              name: 'Jobs',
            ),
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                ChatScreen.location,
                JobrRouter.employerInitialroute,
              ),
              icon: JobrIcons.chat,
              name: 'Chat',
            ),
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                ProfileScreen.location,
                JobrRouter.employerInitialroute,
              ),
              icon: JobrIcons.profile,
              name: 'Profile',
            ),
          ],
          child: child,
        );
      },
      routes: [
        // Nested routes for employee navigation
        GoRoute(
          path: JobrRouter.getRoute(
            JobScreen.location,
            JobrRouter.employeeInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
            child: JobScreen(),
          ),
        ),
        GoRoute(
          path: JobrRouter.getRoute(
            ChatScreen.location,
            JobrRouter.employeeInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
            child: ChatScreen(),
          ),
        ),
        GoRoute(
          path: JobrRouter.getRoute(
            ProfileScreen.location,
            JobrRouter.employeeInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
        GoRoute(
          path: JobrRouter.getRoute(
            CreateProfileScreen.location,
            JobrRouter.employeeInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
            child: CreateProfileScreen(),
          ),
        ),
      ],
    ),
    // Shell route for authentication screens
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
                Map<String, dynamic> data = state.extra as Map<String, dynamic>;

                return NoTransitionPage(
                  child: LoginScreen(
                    userType: data["userType"],
                    isNewUser: data["isNewUser"],
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: EmailLoginScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    Map<String, dynamic> data =
                    state.extra as Map<String, dynamic>;

                    return NoTransitionPage(
                      child: EmailLoginScreen(
                        userType: data["userType"],
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: EmailRegisterScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    Map<String, dynamic> data =
                    state.extra as Map<String, dynamic>;

                    return NoTransitionPage(
                      child: EmailRegisterScreen(
                        userType: data["userType"],
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