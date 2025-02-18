import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/Sollicitaties/questions.dart';
import 'package:jobr/features/Sollicitaties/sollicitaties.dart';
import 'package:jobr/features/Sollicitaties/sollicitaties_tabs_info.dart';
import 'package:jobr/features/authentication/base/base_auth_screen.dart';
import 'package:jobr/features/authentication/screens/email_login_screen.dart';
import 'package:jobr/features/authentication/screens/email_register_screen.dart';
import 'package:jobr/features/authentication/screens/first_glance_screen.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';
import 'package:jobr/features/authentication/screens/splash_screen.dart';
import 'package:jobr/features/chat/screens/employee/chat_page_employee_screen.dart';
import 'package:jobr/features/chat/screens/employee/chat_request_page_employee_screen.dart';
import 'package:jobr/features/chat/screens/employer/chat_page_screen.dart';
import 'package:jobr/features/chat/screens/employer/chat_request_page_screen.dart';
import 'package:jobr/features/chat/screens/chat_request_screen.dart';
import 'package:jobr/features/chat/screens/chat_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_availability_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_overview_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_questionnaire_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_salary_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_talent_screen.dart';
import 'package:jobr/features/job_listing/screens/general/filter_screen.dart';
import 'package:jobr/features/job_listing/screens/general/skills_info_screen.dart';
import 'package:jobr/features/job_listing/screens/vacatures/delete_vacancy.dart';
import 'package:jobr/features/job_listing/screens/vacatures/vacancy_info_page.dart';
import 'package:jobr/features/jobs/filter.dart';
import 'package:jobr/features/jobs/job_listing.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/features/jobs/job_screen_verified.dart';
import 'package:jobr/features/jobs/jobdetail_screen.dart';
import 'package:jobr/features/profile/screens/company/edit_company_profile_screen.dart';
import 'package:jobr/features/profile/screens/company/select_location_page.dart';
import 'package:jobr/features/profile/screens/company_screen/base_navbar.dart';
import 'package:jobr/features/profile/screens/company_screen/company_profile.dart';
import 'package:jobr/features/profile/screens/company_screen/company_venue_profile.dart';
import 'package:jobr/features/profile/screens/company_screen/settings_screen.dart';
import 'package:jobr/features/profile/screens/edit/choose_sector_screen.dart';
import 'package:jobr/features/profile/screens/edit/choose_skills.dart';
import 'package:jobr/features/profile/screens/edit/choose_talent_screen.dart';
import 'package:jobr/features/profile/screens/edit/create_new_company_screen.dart';
import 'package:jobr/features/profile/screens/edit/edit_profile_details_screen.dart';
import 'package:jobr/features/profile/screens/edit/fill_choice_form.dart';
import 'package:jobr/features/profile/screens/edit/make_a_choice_screen.dart';
import 'package:jobr/features/profile/screens/edit/new_experience_screen.dart';
import 'package:jobr/features/profile/screens/employee_profile_screen_display.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:jobr/features/job_listing/screens/general/jobr_ai_suggestions_screen.dart';
import 'package:jobr/features/Sollicitaties/recruitment_detail_screen.dart';
import 'package:jobr/features/Sollicitaties/recruitment_screen.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';

import '../../features/profile/screens/create_profile_screen.dart';

CustomTransitionPage buildPageWithSlideLeftTransition<T>({
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
        begin: const Offset(1, 0),
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
    JobVerifiedScreen.location,
    SollicitatiesScreen.location,
    ChatScreen.location,
    ProfileScreen.location,
  ];
  static List<String> employerNavigationLocations = [
    JobListingsScreen.location,
    RecruitmentScreen.location,
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
  initialLocation: SplashScreen.route,
  routes: <RouteBase>[
    GoRoute(
      path: SplashScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(
        child: SplashScreen(),
      ),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BaseNavBarScreen(
          routes: [
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                JobListingsScreen.location,
                JobrRouter.employerInitialroute,
              ),
              icon: JobrIcons.profile3,
              name: 'Vacatures',
            ),
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                RecruitmentScreen.location,
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
            JobListingsScreen.location,
            JobrRouter.employerInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: JobListingsScreen(),
          ),
          routes: [
            GoRoute(
                path: VacancyInfoScreen.location,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return buildPageWithSlideUpTransition(
                    context: context,
                    state: state,
                    child: VacancyInfoScreen(),
                  );
                },
                routes: [
                  GoRoute(
                    path: DeleteVacancyPage.location,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return buildPageWithSlideUpTransition(
                        context: context,
                        state: state,
                        child: DeleteVacancyPage(),
                      );
                    },
                  ),
                ]),
            GoRoute(
              path: CreateJobListingGeneralScreen.location,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return buildPageWithSlideUpTransition(
                  context: context,
                  state: state,
                  child: const CreateJobListingGeneralScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: CreateJobListingDescriptionScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      const NoTransitionPage(
                    child: CreateJobListingDescriptionScreen(),
                  ),
                  routes: [
                    GoRoute(
                      path: CreateJobListingSkillsScreen.location,
                      pageBuilder:
                          (BuildContext context, GoRouterState state) =>
                              const NoTransitionPage(
                        child: CreateJobListingSkillsScreen(),
                      ),
                      routes: [
                        GoRoute(
                          path: CreateJobListingAvailabilityScreen.location,
                          pageBuilder:
                              (BuildContext context, GoRouterState state) =>
                                  const NoTransitionPage(
                            child: CreateJobListingAvailabilityScreen(),
                          ),
                          routes: [
                            GoRoute(
                              path: CreateJobListingTalentScreen.location,
                              pageBuilder:
                                  (BuildContext context, GoRouterState state) =>
                                      const NoTransitionPage(
                                child: CreateJobListingTalentScreen(),
                              ),
                              routes: [
                                GoRoute(
                                  path: CreateJobListingSalaryScreen.location,
                                  pageBuilder: (BuildContext context,
                                          GoRouterState state) =>
                                      const NoTransitionPage(
                                    child: CreateJobListingSalaryScreen(),
                                  ),
                                  routes: [
                                    GoRoute(
                                      path: CreateJobListingVragenlijstScreen
                                          .location,
                                      pageBuilder: (BuildContext context,
                                              GoRouterState state) =>
                                          const NoTransitionPage(
                                        child:
                                            CreateJobListingVragenlijstScreen(),
                                      ),
                                      routes: [
                                        GoRoute(
                                          path: CreateJobListingOverviewScreen
                                              .location,
                                          pageBuilder: (BuildContext context,
                                                  GoRouterState state) =>
                                              const NoTransitionPage(
                                            child:
                                                CreateJobListingOverviewScreen(),
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
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: EmployProfileDisplayScreen.employerRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideUpTransition(
              context: context,
              state: state,
              child: const EmployProfileDisplayScreen(),
            );
          },
        ),
        GoRoute(
          path: CompanyVenueProfile.employerRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideUpTransition(
              context: context,
              state: state,
              child: const CompanyVenueProfile(),
            );
          },
        ),
        GoRoute(
          path: SettingsScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideUpTransition(
              context: context,
              state: state,
              child: SettingsScreen(),
            );
          },
        ),
        GoRoute(
          path: EditCompanyProfileScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideUpTransition(
              context: context,
              state: state,
              child: const EditCompanyProfileScreen(),
            );
          },
        ),
        GoRoute(
          path: SelectLocationPage.route,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideUpTransition(
              context: context,
              state: state,
              child: const SelectLocationPage(),
            );
          },
        ),
        GoRoute(
          path: FilterScreen.employerRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideUpTransition(
              context: context,
              state: state,
              child: const FilterScreen(),
            );
          },
        ),
        GoRoute(
          path: SkillsInfoScreen.employerRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideUpTransition(
              context: context,
              state: state,
              child: const SkillsInfoScreen(),
            );
          },
        ),
        GoRoute(
          path: ChatPageScreen.employerRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideLeftTransition(
              context: context,
              state: state,
              child: const ChatPageScreen(),
            );
          },
        ),
        GoRoute(
          path: ChatRequestScreen.employerRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideLeftTransition(
              context: context,
              state: state,
              child: const ChatRequestScreen(),
            );
          },
        ),
        GoRoute(
          path: ChatRequestPageScreen.employerRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideLeftTransition(
              context: context,
              state: state,
              child: const ChatRequestPageScreen(),
            );
          },
        ),
        GoRoute(
          path: JobrRouter.getRoute(
            RecruitmentScreen.location,
            JobrRouter.employerInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: RecruitmentScreen(),
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
            state.fullPath ?? '',
            JobrRouter.employeeNavigationLocations,
          ),
          routes: [
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                JobVerifiedScreen.location,
                JobrRouter.employeeInitialroute,
              ),
              icon: JobrIcons.magnifyingGlass,
              name: 'Jobs',
            ),
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                SollicitatiesScreen.location,
                JobrRouter.employeeInitialroute,
              ),
              icon: JobrIcons.paper,
              name: 'Sollicitaties',
            ),
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                ChatScreen.location,
                JobrRouter.employeeInitialroute,
              ),
              icon: JobrIcons.chat,
              name: 'Chat',
            ),
            JobrNavigationItem(
              route: JobrRouter.getRoute(
                ProfileScreen.location,
                JobrRouter.employeeInitialroute,
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
            JobVerifiedScreen.location,
            JobrRouter.employeeInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: JobVerifiedScreen(),
          ),
          routes: [
            GoRoute(
              path: JobDetailScreen.location,
              pageBuilder: (BuildContext context, GoRouterState state) {
                final data = state.extra as Map;
                return buildPageWithSlideUpTransition(
                  context: context,
                  state: state,
                  child: JobDetailScreen(
                    category: data["category"],
                    title: data["title"],
                    image: data["image"],
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: JobrRouter.getRoute(
            JobScreen.location,
            JobrRouter.employeeInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: JobScreen(),
          ),
          routes: [
            GoRoute(
              path: JobDetailScreen.location,
              pageBuilder: (BuildContext context, GoRouterState state) {
                final data = state.extra as Map;
                return buildPageWithSlideUpTransition(
                  context: context,
                  state: state,
                  child: JobDetailScreen(
                    category: data["category"],
                    title: data["title"],
                    image: data["image"],
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: FilterScreenEmployee.employeeRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideUpTransition(
              context: context,
              state: state,
              child: const FilterScreenEmployee(),
            );
          },
          routes: [
            GoRoute(
              path: JobListScreen.location,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(
                  child: JobListScreen(),
                );
              },
            ),
          ],
        ),
        GoRoute(
            path: JobrRouter.getRoute(
              SollicitatiesScreen.location,
              JobrRouter.employeeInitialroute,
            ),
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const NoTransitionPage(
                  child: SollicitatiesScreen(),
                ),
            routes: [
              GoRoute(
                  path: JobInfoScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      NoTransitionPage(
                        child: JobInfoScreen(),
                      ),
                  routes: [
                    GoRoute(
                      path: QuestionPage.location,
                      pageBuilder:
                          (BuildContext context, GoRouterState state) =>
                              NoTransitionPage(
                        child: QuestionPage(),
                      ),
                    ),
                  ]),
            ]),
        GoRoute(
          path: JobrRouter.getRoute(
            ChatScreen.location,
            JobrRouter.employeeInitialroute,
          ),
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: ChatScreen(isEmployeeSide: true),
          ),
        ),
        GoRoute(
          path: ChatPageEmployeeScreen.employeeRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideLeftTransition(
              context: context,
              state: state,
              child: const ChatPageEmployeeScreen(),
            );
          },
        ),
        GoRoute(
          path: ChatRequestScreen.employeeRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideLeftTransition(
              context: context,
              state: state,
              child: const ChatRequestScreen(
                isEmployeeSide: true,
              ),
            );
          },
        ),
        GoRoute(
          path: CreateProfileScreen.employeeRoute,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: CreateProfileScreen(),
          ),
        ),
        GoRoute(
          path: ChatRequestEmployeePageScreen.employeeRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildPageWithSlideLeftTransition(
              context: context,
              state: state,
              child: const ChatRequestEmployeePageScreen(),
            );
          },
        ),
        GoRoute(
            path: ProfileScreen.employeeRoute,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const NoTransitionPage(
                  child: ProfileScreen(),
                ),
            routes: [
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
                    const NoTransitionPage(child: ChooseSectorScreen()),
              ),
              GoRoute(
                path: NewExpereinceScreen.location,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage(child: NewExpereinceScreen()),
              ),
              GoRoute(
                path: MakeAChoiceScreen.location,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage(child: MakeAChoiceScreen()),
              ),
              GoRoute(
                path: CreateNewCompanyScreen.location,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage(child: CreateNewCompanyScreen()),
              ),
              GoRoute(
                path: SettingsScreen.location,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage(child: SettingsScreen()),
              ),
              GoRoute(
                path: ChooseTalentScreen.location,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage(child: ChooseTalentScreen()),
              ),
              GoRoute(
                path: ChooseSkillsScreen.location,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage(child: ChooseSkillsScreen()),
              ),
              GoRoute(
                path: FillChoiceForm.location,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  final String? selectedText = state.extra as String?;
                  return NoTransitionPage(
                    child: FillChoiceForm(selectedText: selectedText),
                  );
                },
              ),
            ]),
        // Add new route for Edit Profile:
      ],
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
