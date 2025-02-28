import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/language.dart';
import 'package:jobr/features/Sollicitaties/recruitment_detail_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_talent_screen.dart';
import 'package:jobr/features/job_listing/widgets/custom_slider.dart';
import 'package:jobr/features/job_listing/widgets/custom_slider_with_two_thumbs.dart';
import 'package:jobr/features/job_listing/widgets/gender_toggle_box.dart';
import 'package:jobr/features/job_listing/widgets/language_bottom_sheet.dart';
import 'package:jobr/features/profile/screens/edit/choose_skills.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
// Add alias
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:jobr/data/enums/mastery.dart'; // added
import 'package:jobr/data/models/language_mastery.dart'; // added (if not already imported)

class FilterScreen extends StatefulWidget {
  static const String location = 'filter';

  static String employerRoute = JobrRouter.getRoute(
    '${FilterScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _distanceSliderValue = 50;
  double werkervaringValue = 1;
  RangeValues _ageRange = const RangeValues(15, 35);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Filters',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/icons/cross.svg',
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            height: 15,
            width: 15,
          ),
          onPressed: () {
            Navigator.pop(context); // Pops the screen
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Geslacht',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),

                  GenderToggleBox(),
                  const SizedBox(height: 12),

                  Divider(
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Leeftijd',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${_ageRange.start.round()} - ${_ageRange.end.round()} jaar',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      CustomSliderWithTwoThumbs(
                        values: _ageRange,
                        min: 15,
                        max: 80,
                        divisions: 47,
                        onChanged: (RangeValues values) {
                          setState(() {
                            _ageRange = values;
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Minimale ervaring',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          activeTickMarkColor: Colors.white,
                          inactiveTickMarkColor: Colors.white,
                          activeTrackColor: HexColor.fromHex("#FF3E68"),
                          inactiveTrackColor: Colors.grey[200],
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
                            setState(() {
                              werkervaringValue = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildLabel('Geen', 0),
                            _buildLabel('   Starter', 1),
                            _buildLabel('  Ervaren', 2),
                            _buildLabel('  Expert', 3),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Divider(
                        thickness: 1.5,
                        color: Colors.grey.shade200.withAlpha(178),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LanguageSkillsSection(),
                        // Other widgets...
                      ],
                    ),
                  ),

                  // Required Experience Dropdown
                  // Distance Slider
                  Divider(
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Afstand',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/icons/map.svg',
                            color: Colors.black,
                            height: 8,
                            width: 8,
                          ),
                          Text(
                            '  18 - 35 km',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomSlider(
                    value: _distanceSliderValue,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${_distanceSliderValue.round()} km',
                    onChanged: (value) {
                      setState(() {
                        _distanceSliderValue = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: PrimaryButton(
              buttonText: 'Toon resultaten',
              borderRadius: 30,
              onTap: () {
                context.push(
                  RecruitmentDetailScreen.employerRoute,
                  extra: {
                    'category': 'Filter Results',
                    'title': 'Filter',
                    'image': 'assets/images/recruteren/vast.png',
                  },
                );
              },
              buttonColor: theme.primaryColor,
              height: 55,
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, double value) {
    final bool isSelected = werkervaringValue == value;

    // Map labels to their original colors
    final Map<String, Color> labelColors = {
      'Geen': HexColor.fromHex("#000000"),
      'Starter': HexColor.fromHex("#000000"),
      '⭐Ervaren': HexColor.fromHex("#000000"),
      '💎Expert': HexColor.fromHex("#000000"),
    };

    return Text(
      text,
      style: TextStyles.titleMedium.copyWith(
        fontSize: isSelected ? 18.0 : 15.63, // Increase font size if selected
        fontWeight: FontWeight.w600,
        color: isSelected
            ? Theme.of(context).primaryColor
            : labelColors[text], // Use mapped color for each label
      ),
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

class LanguageSkillsSection extends StatefulWidget {
  const LanguageSkillsSection({super.key});

  @override
  State<LanguageSkillsSection> createState() => _LanguageSkillsSectionState();
}

class _LanguageSkillsSectionState extends State<LanguageSkillsSection> {
  // Changed from List<Language> to List<LanguageMastery> for consistency with the create talent screen
  final List<LanguageMastery> _selectedLanguages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Talen',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => LanguageBottomSheet(
            title: "Voeg talen toe",
            onSelected: (List<Language> value) {
              setState(() {
                // Convert Language to LanguageMastery with default mastery
                _selectedLanguages.addAll(value.map((lang) => LanguageMastery(
                    language: lang, mastery: Mastery.intermediate)));
              });
            },
          ).showPopup(context: context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '+ Kies een taal',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Replace Chips with CustomSliderWidget cards:
        if (_selectedLanguages.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedLanguages
                .map((langMastery) => CustomSliderWidget(
                      mastery: langMastery,
                      onChanged: (updatedMastery) {
                        setState(() {
                          final index = _selectedLanguages.indexOf(langMastery);
                          if (index != -1) {
                            _selectedLanguages[index] = updatedMastery;
                          }
                        });
                      },
                      onRemove: () {
                        setState(() {
                          _selectedLanguages.remove(langMastery);
                        });
                      },
                    ))
                .toList(),
          ),
        ],
        const SizedBox(height: 16),
        Divider(
          thickness: 1,
          color: Colors.grey.shade300,
        ),
        const SizedBox(height: 16),
        // ...existing code for SkillsSection...
        SkillsSection(),
        SizedBox(height: 16),
      ],
    );
  }
}

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  // Changed from List<Language> to List<String>
  final List<String> _selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          // Convert to async to capture result from ChooseSkillsScreen
          onTap: () async {
            final result = await context.push(ChooseSkillsScreen.employerRoute);
            if (result != null && result is List<String>) {
              setState(() {
                _selectedSkills.clear();
                _selectedSkills.addAll(result);
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Kies skills',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.add,
                  color: Colors.grey.shade500,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (_selectedSkills.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _selectedSkills
                .map(
                  (skill) => GestureDetector(
                    onTap: () => setState(() {
                      _selectedSkills.remove(skill);
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor.fromHex('#191919'),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            skill,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset(
                            JobrIcons.close,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 12,
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
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
    final double trackHeight = 9.0; // Increased height for thicker track
    final double leftExtension =
        14.0; // Pink bar extension before the first flag
    final double rightExtension =
        14.0; // Grey bar extension after the last point

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
