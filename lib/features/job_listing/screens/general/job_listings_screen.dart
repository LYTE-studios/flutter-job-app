import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/vacancy.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/vacatures/widgets/vacature_card.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:jobr/ui/widgets/navigation/jobr_loading_switcher.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class JobListingsScreen extends StatefulWidget {
  static const String location = 'vacancies';

  static String employerRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employerInitialroute,
  );

  const JobListingsScreen({super.key});

  @override
  State<JobListingsScreen> createState() => _JobListingsScreenState();
}

class _JobListingsScreenState extends State<JobListingsScreen>
    with ScreenStateMixin {
  List<Vacancy> vacancies = [];

  @override
  Future<void> loadData() async {
    vacancies = await VacanciesService().getVacancies();

    setState(() {
      vacancies = vacancies;
    });
  }

  Widget buildEmtpyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            context.push(
              CreateJobListingGeneralScreen.employerRoute,
              extra: Vacancy(),
            );
            // Action for "Nieuwe vacature" button
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30, // Increased icon size
          ),
          label: const Text(
            'Nieuwe vacature',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold), // Increased font size
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.pink[500],
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ), // Increased padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton.icon(
          onPressed: () {
            AccountsService().logout();
            // Action for "Nieuwe vacature" button
          },
          label: const Text(
            'Logout',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold), // Increased font size
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.pink[500],
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ), // Increased padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          JobrAppbarNavigation(
            appbarTitle: "Mijn vacatures",
            description: "Bekijk al je vacatures en chat met sollicitanten",
            canGoBack: false,
            trailing: vacancies.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                          CreateJobListingGeneralScreen.employerRoute,
                          extra: Vacancy(),
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/images/icons/add_outlined.svg',
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
            center: false,
          ),
          Expanded(
            child: JobrLoadingSwitcher(
              loading: loading,
              child: vacancies.isEmpty
                  ? buildEmtpyState(context)
                  : RefreshIndicator(
                      onRefresh: () async {
                        setLoading(true);
                        await loadData();
                        setLoading(false);
                      },
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: PaddingSizes.large,
                        ),
                        children: vacancies
                            .map(
                              (vacancy) => VacatureCard(),
                            )
                            .toList(),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
