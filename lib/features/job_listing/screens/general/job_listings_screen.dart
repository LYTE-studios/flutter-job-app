import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/data/models/vacancy.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/Sollicitaties/widgets/job_cards.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/jobs/widgets/job_card.dart';
import 'package:jobr/features/profile/screens/widgets/custom_job_card.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class JobListingsScreen extends StatefulWidget {
  static const String location = 'vacancies';

  const JobListingsScreen({super.key});

  @override
  State<JobListingsScreen> createState() => _JobListingsScreenState();
}

class _JobListingsScreenState extends State<JobListingsScreen>
    with ScreenStateMixin {
  List<Vacancy> vacancies = [];

  @override
  Future<void> loadData() async {
    // vacancies = await VacanciesService().getVacancies();

    setState(() {
      vacancies = [
        Vacancy(
          employer: 1,
          title: 'Barista',
          contractType: 1,
          functionId: 1,
          skills: [],
          weekDay: "W",
          salary: 0,
          description: 'Some job',
          languages: [],
          questions: [],
        ),
      ];
    });
  }

  Widget buildEmtpyState(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          context.push(
            CreateJobListingGeneralScreen.employerRoute,
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
              fontSize: 18, fontWeight: FontWeight.bold), // Increased font size
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const JobrAppbarNavigation(
            appbarTitle: "Mijn vacatures",
            description: "Bekijk al je vacatures en chat met sollicitanten",
            canGoBack: false,
            center: false,
          ),
          Expanded(
            child: true ?? vacancies.isEmpty
                ? buildEmtpyState(context)
                : ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: PaddingSizes.large,
                    ),
                    children: vacancies
                        .map(
                          (vacancy) => JobCard(),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
      //  Column(
      //   children: [
      //     // Padding(
      //     //   padding: const EdgeInsets.all(16.0),
      //     //   child: Container(
      //     //     decoration: BoxDecoration(
      //     //       color: Colors.red.shade100.withOpacity(0.4),
      //     //       borderRadius: BorderRadius.circular(30),
      //     //     ),
      //     //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      //     //     child: Row(
      //     //       mainAxisSize: MainAxisSize.min,
      //     //       children: [
      //     //         Icon(Icons.check, color: Colors.red.withOpacity(0.9)),
      //     //         SizedBox(width: 4),
      //     //         Text(
      //     //           'Vacature verwijderd',
      //     //           style: TextStyle(
      //     //             fontSize: 16,
      //     //             fontWeight: FontWeight.bold,
      //     //             color: Colors.red.withOpacity(0.9),
      //     //           ),
      //     //         ),
      //     //       ],
      //     //     ),
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}
