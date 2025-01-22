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
  List<bool> isSectionExpanded = List.filled(7, false); // Track expansion state

  void toggleSection(int index) {
    setState(() {
      isSectionExpanded[index] = !isSectionExpanded[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouter.of(context).state!;
    final Map<String, dynamic> selectedData =
        state.extra as Map<String, dynamic>;

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
                _buildSection(
                  index: 0,
                  title: "Algemeen",
                  contentWidget: selectedData['Algemeen'] != null
                      ? _buildGeneralContent(selectedData['Algemeen'] as Map<String, String>)
                      : Text('Geen algemene gegevens beschikbaar'),
                ),
                _buildSection(
                  index: 1,
                  title: "Beschrijving",
                  contentWidget: Text(selectedData['Beschrijving'] ?? 'Geen beschrijving beschikbaar'),
                ),
                _buildSection(
                  index: 2,
                  title: "Vaardigheden",
                  contentWidget: _buildSkillsContent(selectedData['Vaardigheden']?.split(', ') ?? []),
                ),
                _buildSection(
                  index: 3,
                  title: "Beschikbaarheid",
                  contentWidget: _buildAvailabilityContent(selectedData['Beschikbaarheid']?.split(', ') ?? []),
                ),
                _buildSection(
                  index: 4,
                  title: "Talen",
                  contentWidget: _buildLanguagesContent(selectedData['Talen']?.split(', ') ?? []),
                ),
                _buildSection(
                  index: 5,
                  title: "Salaris",
                  contentWidget: Text(selectedData['Salaris'] ?? 'Geen salaris beschikbaar'),
                ),
                _buildSection(
                  index: 6,
                  title: "Vragenlijst",
                  contentWidget: _buildQuestionsContent(selectedData['Vragenlijst']?.split(', ') ?? []),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required int index,
    required String title,
    required Widget contentWidget,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => toggleSection(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: contentWidget,
          ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildGeneralContent(Map<String, String> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries.map((entry) {
        return Row(
          children: [
            Text(
              '${entry.key}: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(entry.value),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSkillsContent(List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skills.map((skill) {
        return Text(skill);
      }).toList(),
    );
  }

  Widget _buildAvailabilityContent(List<String> days) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: days.map((day) {
        return Text(day);
      }).toList(),
    );
  }

  Widget _buildLanguagesContent(List<String> languages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: languages.map((language) {
        return Text(language);
      }).toList(),
    );
  }

  Widget _buildQuestionsContent(List<String> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: questions.map((question) {
        return Text(question);
      }).toList(),
    );
  }
}
