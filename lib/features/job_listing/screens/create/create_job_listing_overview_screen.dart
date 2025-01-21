import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_availability_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_questionnaire_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_salary_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_talent_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/ui/widgets/buttons/jobr_radio_button.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

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
  int selectedRadio = 6;
  List<String> selectedDays = [];
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  List<bool> isSectionExpanded = List.generate(7, (_) => false);

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
        context.push(CreateJobListingSkillsScreen.route);
      },
      isNavigationEnabled: _isButtonEnabled,
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
              children: [
                buildSection("Algemeen", 0),
                buildSection("Beschrijving", 1),
                buildSection("Vaardigheden", 2),
                buildSection("Beschikbaarheid", 3),
                buildSection("Talen", 4),
                buildSection("Salaris", 5),
                buildSection("Vragenlijst", 6),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSection(String title, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => toggleSection(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyles.titleMedium.copyWith(fontSize: 18),
                ),
                Icon(
                  isSectionExpanded[index]
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        if (isSectionExpanded[index])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: buildSectionContent(index),
          ),
      ],
    );
  }

  Widget buildSectionContent(int index) {
    switch (index) {
      case 0:
        return Text("Algemene informatie hier...");
      case 1:
        return Text("Beschrijving hier...");
      case 2:
        return Text("Vaardigheden hier...");
      case 3:
        return Text("Beschikbaarheid hier...");
      case 4:
        return Text("Talen hier...");
      case 5:
        return Text("Salaris hier...");
      case 6:
        return Text("Vragenlijst hier...");
      default:
        return Container();
    }
  }
}
