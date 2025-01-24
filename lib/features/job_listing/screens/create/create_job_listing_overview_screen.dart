import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_questionnaire_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_salary_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_talent_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/features/job_listing/screens/create/used_widgets_in_creation.dart';

import 'create_job_listing_availability_screen.dart';

class CreateJobListingOverviewScreen extends StatefulWidget {
  const CreateJobListingOverviewScreen({super.key});

  static const String location = 'job-listing-overview';

  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/${CreateJobListingGeneralScreen.location}/${CreateJobListingDescriptionScreen.location}/${CreateJobListingSkillsScreen.location}/${CreateJobListingAvailabilityScreen.location}/${CreateJobListingTalentScreen.location}/${CreateJobListingSalaryScreen.location}/${CreateJobListingVragenlijstScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<CreateJobListingOverviewScreen> createState() =>
      _CreateJobListingOverviewScreenState();
}

class _CreateJobListingOverviewScreenState
    extends State<CreateJobListingOverviewScreen> {
  final bool _isButtonEnabled = true;
  List<bool> isSectionExpanded = List.generate(
    usedWidgetsInCreation.keys.length,
    (_) => false,
  );

  void toggleSection(int index) {
    setState(() {
      isSectionExpanded[index] = !isSectionExpanded[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      progress: 1.0,
      buttonLabel: 'Bevestig & post vacature',
      onNavigate: () {
        context.go(
          JobrRouter.getRoute(
            JobListingsScreen.location,
            JobrRouter.employerInitialroute,
          ),
        );
      },
      isNavigationEnabled: _isButtonEnabled,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overzicht",
              style: TextStyles.titleMedium.copyWith(fontSize: 22),
            ),
            Divider(
              thickness: 1.3,
              color: Colors.grey.shade300.withOpacity(0.7),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    List.generate(usedWidgetsInCreation.keys.length, (index) {
                  String title = usedWidgetsInCreation.keys.elementAt(index);
                  return buildSection(title, index);
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => toggleSection(index),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyles.titleMedium.copyWith(
                      fontSize: 18,
                      color: isSectionExpanded[index]
                          ? Colors.pinkAccent
                          : Colors.black,
                    ),
                  ),
                  Icon(
                    isSectionExpanded[index]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: isSectionExpanded[index]
                        ? Colors.pinkAccent
                        : Colors.grey,
                  ),
                ],
              ),
            ),
            if (isSectionExpanded[index]) ...[
              const SizedBox(height: 10),
              buildSectionContent(index),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildSectionContent(int index) {
    String key = usedWidgetsInCreation.keys.elementAt(index);
    List<Widget> widgets = usedWidgetsInCreation[key]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widgets,
      ],
    );
  }
}
