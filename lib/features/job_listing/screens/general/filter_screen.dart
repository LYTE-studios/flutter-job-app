import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/Sollicitaties/recruitment_detail_screen.dart';
import 'package:jobr/features/job_listing/widgets/custom_slider.dart'
    as jobListing; // Add alias
import 'package:jobr/features/job_listing/widgets/gender_toggle_box.dart';
import 'package:jobr/features/jobs/widgets/custom_slider.dart'
    as jobs; // Add alias
import 'package:jobr/features/jobs/widgets/dropdown_menu.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/input/jobr_dropdown_field.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class FilterScreen extends StatefulWidget {
  static const String location = 'filter';

  static String employerRoute = JobrRouter.getRoute(
    '${FilterScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );
  static String employeeRoute = JobrRouter.getRoute(
    '${FilterScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );

  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _ageSliderValue = 23;
  double _distanceSliderValue = 50;
  double werkervaringValue = 1; // Initial value for slider

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
            color: Colors.black,
            height: 15,
            width: 15,
          ),
          onPressed: () {
            Navigator.pop(context); // Pops the screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          bottom: true,
          top: false,
          child: SingleChildScrollView(
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
                          '${_ageSliderValue.round()} jaar',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    jobListing.CustomSlider(
                      value: _ageSliderValue,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: '${_ageSliderValue.round()} jaar',
                      onChanged: (value) {
                        setState(() {
                          _ageSliderValue = value;
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
                      color: Colors.grey.shade200.withOpacity(0.7),
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
                        Image.asset('assets/images/jobs/map.png'),
                        Text(
                          '  ${_distanceSliderValue.round().toInt()} km',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ],
                ),
                jobListing.CustomSlider(
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
                // Show Results Button
                PrimaryButton(
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
              ],
            ),
          ),
        ),
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
            ? Colors.pinkAccent
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

class LanguageSkillsSection extends StatelessWidget {
  const LanguageSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Languages Section
        const Text(
          'Talen',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
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
                    fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Divider(
          thickness: 1,
          color: Colors.grey.shade300,
        ),
        const SizedBox(height: 16),

        // Skills Section
        SkillsSection(), SizedBox(height: 16),
      ],
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Skills Title
        const Text(
          'Skills',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // Skills Button
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20), // Rounded button shape
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Shrink to content size
            children: [
              const Text(
                'Kies skills',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // Add this import
// import 'package:go_router/go_router.dart';
// import 'package:jobr/core/routing/router.dart';
// import 'package:jobr/features/Sollicitaties/recruitment_detail_screen.dart';
// import 'package:jobr/features/jobs/widgets/custom_slider.dart';
// import 'package:jobr/features/jobs/widgets/dropdown_menu.dart';
// import 'package:jobr/ui/theme/jobr_icons.dart';
// import 'package:jobr/ui/theme/padding_sizes.dart';
// import 'package:jobr/ui/widgets/buttons/primary_button.dart';
// import 'package:jobr/ui/widgets/input/jobr_dropdown_field.dart';

// class FilterScreen extends StatefulWidget {
//   static const String location = 'filter';

//   static String employerRoute = JobrRouter.getRoute(
//     '${FilterScreen.location}/$location',
//     JobrRouter.employerInitialroute,
//   );
//   static String employeeRoute = JobrRouter.getRoute(
//     '${FilterScreen.location}/$location',
//     JobrRouter.employeeInitialroute,
//   );

//   const FilterScreen({super.key});

//   @override
//   _FilterScreenState createState() => _FilterScreenState();
// }

// class _FilterScreenState extends State<FilterScreen> {
//   double _sliderValue = 23;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Filters',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//             fontFamily: 'Inter',
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: SvgPicture.asset(
//             'assets/images/icons/cross.svg',
//             color: Colors.black,
//             height: 15,
//             width: 15,
//           ),
//           onPressed: () {
//             Navigator.pop(context); // Pops the screen
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SafeArea(
//           bottom: true,
//           top: false,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               JobrDropdownField(
//                 title: "Contract Type",
//               ),
//               Divider(
//                 color: Colors.grey.shade200,
//               ),
//               const SizedBox(height: 4),
//               JobrDropdownField(
//                 title: "Functie",
//               ),
//               const SizedBox(height: 4),
//               Divider(
//                 color: Colors.grey[200],
//               ),
//               const SizedBox(height: 4),
//               //Si Sector Selection
//               const Text(
//                 'Sector',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               GestureDetector(
//                 onTap: () {
//                   // Handle sector selection
//                 },
//                 child: Container(
//                   height: 80,
//                   width: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     border: Border.all(color: Colors.grey[100]!),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: SvgPicture.asset(
//                       'assets/images/icons/add.svg',
//                       color: Colors.black87,
//                       height: 30,
//                       width: 30,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Divider(
//                 color: Colors.grey[200],
//               ),
//               const SizedBox(height: 4),

//               // Required Experience Dropdown
//               JobrDropdownField(
//                 title: "Benodigde Ervaring",
//               ),
//               const SizedBox(height: 4),
//               // Distance Slider
//               Divider(
//                 color: Colors.grey[200],
//               ),
//               const SizedBox(height: 4),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Afstand',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Image.asset('assets/images/jobs/map.png'),
//                       Text(
//                         '  ${_sliderValue.round().toInt()} km',
//                         style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             fontFamily: 'Poppins'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SliderTheme(
//                 data: SliderTheme.of(context).copyWith(
//                   trackHeight: 6.0,
//                   activeTrackColor: theme.primaryColor,
//                   inactiveTrackColor: Colors.grey[300],
//                   thumbColor: theme.primaryColor, // Inner circle color
//                   overlayColor: theme.primaryColor.withOpacity(0.2),
//                   thumbShape: CustomThumbShape(
//                     // Use custom thumb shape
//                     enabledThumbRadius: 12.0, // Adjust size
//                     borderColor: Colors.white, // White border
//                   ),
//                   overlayShape:
//                       const RoundSliderOverlayShape(overlayRadius: 24.0),
//                 ),
//                 child: Slider(
//                   value: _sliderValue,
//                   min: 0,
//                   max: 100,
//                   divisions: 100,
//                   label: '${_sliderValue.toInt()} km',
//                   onChanged: (value) {
//                     setState(() {
//                       _sliderValue = value;
//                     });
//                   },
//                 ),
//               ),
//               const Spacer(),
//               // Show Results Button
//               PrimaryButton(
//                 buttonText: 'Toon resultaten',
//                 onTap: () {
//                   context.push(
//                     RecruitmentDetailScreen.employerRoute,
//                     extra: {
//                       'category': 'Filter Results',
//                       'title': 'Filter',
//                       'image': 'assets/images/recruteren/vast.png',
//                     },
//                   );
//                 },
//                 buttonColor: theme.primaryColor,
//                 height: 55,
//                 textStyle: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
