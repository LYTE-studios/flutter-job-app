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

import '../../features/jobs/filter.dart';
import '../../features/jobs/job_listing.dart';
import '../../features/jobs/jobdetail_screen.dart';
import '../../features/profile/screens/company/edit_company_profile_screen.dart';
import '../../features/profile/screens/company/edit_company_profile_screen_two.dart';
import '../../features/profile/screens/create_profile_screen.dart';
import '../../features/profile/screens/edit/choose_company_screen.dart';
import '../../features/profile/screens/edit/choose_sector_screen.dart';
import '../../features/profile/screens/edit/create_new_company_screen.dart';
import '../../features/profile/screens/edit/edit_profile_details_screen.dart';
import '../../features/profile/screens/edit/make_a_choice_screen.dart';
import '../../features/profile/screens/edit/new_experience_screen.dart';

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

class JobrRouter {
  static const String initialRoute = '/';

  static const String employeeInitialroute = '/employee';
  static const String employerInitialroute = '/employer';

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

  static int? getSelectedIndex(String route, List<String> routes) {
    for (String r in routes) {
      if (route.split('/').last == r) {
        return routes.indexOf(r);
      }
    }
    return null;
  }
}

GoRouter router = GoRouter(
  // initialLocation: EditCompanyProfileScreenTwo.route,
  initialLocation: EditCompanyProfileScreen.route,
  routes: <RouteBase>[
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
    GoRoute(
      path: CreateProfileScreen.location,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: CreateProfileScreen(),
      ),
    ),
    GoRoute(
      path: EditCompanyProfileScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: EditCompanyProfileScreen(),
      ),
    ),
    GoRoute(
      path: EditCompanyProfileScreenTwo.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: EditCompanyProfileScreenTwo(),
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
      path: JobrAiSuggestionsScreen.location,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: JobrAiSuggestionsScreen(),
      ),
    ),
    GoRoute(
      path: EditProfileDetailsScreen.location,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: EditProfileDetailsScreen(),
      ),
    ),
    GoRoute(
      path: ChooseSectorScreen.location,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: ChooseSectorScreen(),
      ),
    ),
    GoRoute(
      path: ChooseCompanyScreen.location,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: ChooseCompanyScreen(),
      ),
    ),
    GoRoute(
      path: NewExpereinceScreen.location,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: NewExpereinceScreen(),
      ),
    ),
    GoRoute(
      path: CreateNewCompanyScreen.location,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: CreateNewCompanyScreen(),
      ),
    ),
    GoRoute(
      path: MakeAChoiceScreen.location,
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
