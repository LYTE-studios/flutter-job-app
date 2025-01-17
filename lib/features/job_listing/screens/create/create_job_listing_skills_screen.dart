import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_availability_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class CreateJobListingSkillsScreen extends StatefulWidget {
  const CreateJobListingSkillsScreen({super.key});

  static const String location = 'job-listing-skills';

  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/${CreateJobListingGeneralScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<CreateJobListingSkillsScreen> createState() =>
      _CreateJobListingSkillsScreenState();
}

class _CreateJobListingSkillsScreenState
    extends State<CreateJobListingSkillsScreen> {
  List<String> selectedSoftSkills = [];
  List<String> selectedHardSkills = [];
  final bool _isButtonEnabled = true;
  double werkervaringValue = 1; // Initial value for slider

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      progress: .4,
      onNavigate: () {
        context.push(CreateJobListingAvailabilityScreen.route);
      },
      isNavigationEnabled: _isButtonEnabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vaardigheden",
            style: TextStyles.titleMedium.copyWith(fontSize: 22),
          ),
          const Divider(
            thickness: 0.6,
          ),
          const SizedBox(height: 16),
          // "Vereiste werkervaring" Card
          _buildWerkervaringCard(),
          const SizedBox(height: 16),

          // Soft Skills
          _buildSkillSection(
              'Soft skills',
              [
                'Leiderschap',
                'Sociaal',
                'Stressbestendig',
                'Flexibel',
                'Creatief',
                'Teamplayer',
                'Zelfstandig',
                'Klantgericht',
                'Oog voor detail',
              ],
              maxSelection: 3,
              isSoftSkills: true),
          const SizedBox(height: 16),

          // Hard Skills
          _buildSkillSection(
              'Hard skills',
              [
                'Grafisch ontwerp',
                'Klantenservice',
                'Hygiëne',
                'Tafelschikking',
                'Barista-vaardigheden',
                'Wijnkennis',
                'Afwas',
                'Tijdmanagement',
              ],
              maxSelection: 3,
              isSoftSkills: false),

          // Bottom Button
        ],
      ),
    );
  }

  Widget _buildWerkervaringCard() {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vereiste werkervaring',
                  style: TextStyles.titleMedium
                      .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                Icon(
                  Icons.info_outline,
                  color: HexColor.fromHex("#A2A2A2"),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                      activeTickMarkColor: Colors.white,
                      inactiveTickMarkColor: Colors.white,
                      activeTrackColor: HexColor.fromHex("#FF3E68"),
                      thumbColor: HexColor.fromHex("#FF3E68"),
                      trackHeight: 10,
                      inactiveTrackColor: Colors.grey[100]),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Slider(
                      value: werkervaringValue,
                      min: 0,
                      secondaryActiveColor: Colors.white,
                      max: 3,
                      divisions: 3,
                      onChanged: (value) {
                        setState(() {
                          werkervaringValue = value;
                        });
                      },
                      // activeColor: Colors.pink,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Geen',
                        style: TextStyles.titleMedium.copyWith(
                            fontSize: 15.63,
                            fontWeight: FontWeight.w600,
                            color: HexColor.fromHex("#8A8989")),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Starter',
                        style: TextStyles.titleMedium.copyWith(
                            fontSize: 15.63, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '⭐Ervaren',
                        style: TextStyles.titleMedium.copyWith(
                            fontSize: 15.63,
                            fontWeight: FontWeight.w600,
                            color: HexColor.fromHex("#F9AA16")),
                      ),
                      Text(
                        '💎Expert',
                        style: TextStyles.titleMedium.copyWith(
                            fontSize: 15.63,
                            fontWeight: FontWeight.w600,
                            color: HexColor.fromHex("#61C5FF")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillSection(String title, List<String> skills,
      {int maxSelection = 3, bool isSoftSkills = true}) {
    List<String> selectedSkills =
        isSoftSkills ? selectedSoftSkills : selectedHardSkills;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.titleMedium
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            Text(
              'Kies er $maxSelection',
              style: TextStyles.titleMedium.copyWith(
                  fontSize: 15.4,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex("#0000003B").withOpacity(0.23)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4,
          runSpacing: 2,
          children: skills.map((skill) {
            return ChoiceChip(
              showCheckmark: false,
              label: Text(skill),
              selected: selectedSkills.contains(skill),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    if (selectedSkills.length < maxSelection) {
                      selectedSkills.add(skill);
                    }
                  } else {
                    selectedSkills.remove(skill);
                  }
                });
              },
              selectedColor: Colors.white,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                fontFamily: 'Inter',
                color: selectedSkills.contains(skill)
                    ? HexColor.fromHex("#FF3E68")
                    : HexColor.fromHex("#A0A0A0"),
                fontWeight: FontWeight.w600,
                fontSize: 15.88,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: selectedSkills.contains(skill)
                      ? HexColor.fromHex("#FF3E68")
                      : HexColor.fromHex("#E8E8E8"),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
