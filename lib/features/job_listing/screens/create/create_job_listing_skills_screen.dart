import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_availability_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/create_job_listing_mixin.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:flutter/services.dart'; // For HapticFeedback.

class CreateJobListingSkillsScreen extends StatefulWidget {
  const CreateJobListingSkillsScreen({super.key});

  static const String location = 'job-listing-skills';

  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/${CreateJobListingGeneralScreen.location}/${CreateJobListingDescriptionScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<CreateJobListingSkillsScreen> createState() =>
      _CreateJobListingSkillsScreenState();
}

class _CreateJobListingSkillsScreenState
    extends State<CreateJobListingSkillsScreen> with CreateJobListingMixin {
  List<String> selectedSoftSkills = [];
  List<String> selectedHardSkills = [];
  double werkervaringValue = 1; // Initial value for slider
  bool showSoftWarning = false;
  bool showHardWarning = false;

  bool get _isButtonEnabled =>
      selectedSoftSkills.length >= 3 && selectedHardSkills.length >= 3;

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      buttonLabel: 'Naar beschikbaarheid',
      progress: .4,
      onNavigate: () {
        if (!_isButtonEnabled) {
          setState(() {
            showSoftWarning = selectedSoftSkills.length < 3;
            showHardWarning = selectedHardSkills.length < 3;
          });
        } else {
          // vacancy.skills = [...vacancy.softSkills, vacancy.hardSkills];

          context.push(
            CreateJobListingAvailabilityScreen.route,
            extra: vacancy,
          );
          // usedWidgetsInCreation.addAll({
          //   'Vaardigheden': [
          //     _buildWerkervaringCard(
          //         cardColor: Colors.grey.shade100.withOpacity(0.7)),
          //     _buildSkillSection('Soft skills', selectedSoftSkills,
          //         maxSelection: 0,
          //         isSoftSkills: true,
          //         showSelectionText: false),
          //     _buildSkillSection('Hard skills', selectedHardSkills,
          //         maxSelection: 0,
          //         isSoftSkills: true,
          //         showSelectionText: false),
          //   ]
          // });
        }
      },
      isNavigationEnabled: _isButtonEnabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vaardigheden",
            style: TextStyles.titleMedium.copyWith(fontSize: 22),
          ),
          SizedBox(
            height: 4,
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade200.withOpacity(0.7),
          ),
          const SizedBox(height: 6),
          // "Vereiste werkervaring" Card
          _buildWerkervaringCard(),
          const SizedBox(height: 4),

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
          const SizedBox(height: 10),

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

  Widget _buildWerkervaringCard({Color cardColor = Colors.white}) {
    return Card(
      color: cardColor,
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
            Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.white,
                    activeTrackColor: HexColor.fromHex("#FF3E68"),
                    inactiveTrackColor: Colors.grey[100],
                    trackHeight: 10,
                    thumbShape: _CustomThumbShape(radius: 14),
                    trackShape: _CustomTrackShape(), // Custom track shape
                  ),
                  child: Slider(
                    value: werkervaringValue,
                    min: 0,
                    max: 3,
                    divisions: 3,
                    onChanged: (value) {
                      if (value != werkervaringValue) {
                        HapticFeedback.lightImpact();
                      }
                      setState(() {
                        werkervaringValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLabel('Geen', 0),
                      _buildLabel('   Starter', 1),
                      _buildLabel('⭐Ervaren', 2),
                      _buildLabel('💎Expert', 3),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade200.withOpacity(0.7),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, double value) {
    final bool isSelected = werkervaringValue == value;

    // Map labels to their original colors
    final Map<String, Color> labelColors = {
      'Geen': HexColor.fromHex("#8A8989"),
      'Starter': HexColor.fromHex("#000000"),
      '⭐Ervaren': HexColor.fromHex("#F9AA16"),
      '💎Expert': HexColor.fromHex("#61C5FF"),
    };

    return Text(
      text,
      style: TextStyles.titleMedium.copyWith(
        fontSize: isSelected ? 18.0 : 15.63, // Increase font size if selected
        fontWeight: FontWeight.w600,
        color: labelColors[text], // Use mapped color for each label
      ),
    );
  }

  Widget _buildSkillSection(String title, List<String> skills,
      {int maxSelection = 3,
      bool isSoftSkills = true,
      bool showSelectionText = true}) {
    List<String> selectedSkills =
        isSoftSkills ? selectedSoftSkills : selectedHardSkills;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Text(
                title,
                style: TextStyles.titleMedium
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                color: Colors.pink,
                onPressed: () {
                  // You could show more info here or a dialog.
                },
              )
            ]),
            if (showSelectionText)
              Text(
                'Kies er $maxSelection',
                style: TextStyles.titleMedium.copyWith(
                  color: (isSoftSkills && showSoftWarning) ||
                          (!isSoftSkills && showHardWarning)
                      ? Colors.pink
                      : HexColor.fromHex("#0000003B").withOpacity(0.23),
                  fontSize: 15.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: -7,
          children: skills.map((skill) {
            return ChoiceChip(
              showCheckmark: false,
              label: Text(skill),
              selected: selectedSkills.contains(skill),
              pressElevation: 100, // Remove grey click effect
              onSelected: (selected) {
                HapticFeedback.lightImpact();
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
              selectedColor: Colors.transparent,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                fontFamily: 'Poppins',
                color: selectedSkills.contains(skill)
                    ? HexColor.fromHex("#FF3E68")
                    : HexColor.fromHex("#A0A0A0"),
                fontWeight: FontWeight.w500,
                fontSize: 15.88,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  width: selectedSkills.contains(skill) ? 1.6 : 1,
                  color: selectedSkills.contains(skill)
                      ? HexColor.fromHex("#FF3E68")
                      : HexColor.fromHex("#E8E8E8"),
                ),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4), // Adjusted padding
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  final double radius; // Thumb radius

  _CustomThumbShape({this.radius = 12});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size(radius * 2, radius * 2);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Paint outerCircle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint innerCircle = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    // Draw the outer circle
    context.canvas.drawCircle(center, radius, outerCircle);
    // Draw the inner circle
    context.canvas.drawCircle(center, radius - 4, innerCircle);
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    Offset? secondaryOffset,
    required Offset thumbCenter,
    bool isEnabled = true,
    bool isDiscrete = false,
    required TextDirection textDirection,
    double additionalActiveTrackHeight = 0,
  }) {
    final double trackHeight = 10.0; // Increased height for thicker track
    final double leftExtension =
        24.0; // Pink bar extension before the first flag
    final double rightExtension =
        24.0; // Grey bar extension after the last point

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint activeTrackPaint = Paint()
      ..color = sliderTheme.activeTrackColor!;
    final Paint inactiveTrackPaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!;

    // Adjust active and inactive track rects
    final RRect activeTrackRRect = RRect.fromLTRBR(
      trackRect.left - leftExtension,
      trackRect.top - (trackHeight - trackRect.height) / 2,
      thumbCenter.dx,
      trackRect.bottom + (trackHeight - trackRect.height) / 2,
      Radius.circular(trackHeight / 2), // Rounded edges
    );

    final RRect inactiveTrackRRect = RRect.fromLTRBR(
      thumbCenter.dx,
      trackRect.top - (trackHeight - trackRect.height) / 2,
      trackRect.right + rightExtension,
      trackRect.bottom + (trackHeight - trackRect.height) / 2,
      Radius.circular(trackHeight / 2), // Rounded edges
    );

    // Paint the active track
    context.canvas.drawRRect(activeTrackRRect, activeTrackPaint);

    // Paint the inactive track
    context.canvas.drawRRect(inactiveTrackRRect, inactiveTrackPaint);
  }
}
