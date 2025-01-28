import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/language.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_availability_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_salary_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/create_job_listing_mixin.dart';
import 'package:jobr/features/job_listing/widgets/language_bottom_sheet.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';

class CreateJobListingTalentScreen extends StatefulWidget {
  const CreateJobListingTalentScreen({super.key});

  static const String location = 'job-listing-talent';

  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/${CreateJobListingGeneralScreen.location}/${CreateJobListingDescriptionScreen.location}/${CreateJobListingSkillsScreen.location}/${CreateJobListingAvailabilityScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<CreateJobListingTalentScreen> createState() =>
      _CreateJobListingTalentScreenState();
}

class _CreateJobListingTalentScreenState
    extends State<CreateJobListingTalentScreen> with CreateJobListingMixin {
  bool _isButtonEnabled = false;
  int selectedRadio = 6;
  List<String> selectedDays = [];
  final List<Language> _selectedlanguages = [];

  @override
  Widget build(BuildContext context) {
    _isButtonEnabled = _selectedlanguages.isNotEmpty;
    return BaseCreateJobListingScreen(
      progress: .7,
      buttonLabel: 'Naar salaris',
      onNavigate: () {
        context.push(CreateJobListingSalaryScreen.route, extra: vacancy);

//         context.push(CreateJobListingSalaryScreen.route);
        // usedWidgetsInCreation.addAll({
        //   "Talen": [
        //     _selectedFunction.isNotEmpty
        //         ? Column(
        //             children: [
        //               Divider(
        //                 thickness: 1.3,
        //                 color: Colors.grey.shade300.withOpacity(0.7),
        //               ),
        //               SizedBox(
        //                 height: 8,
        //               ),
        //               Wrap(
        //                 spacing: 8,
        //                 runSpacing: 8,
        //                 children: _selectedFunction
        //                     .map(
        //                       (function) => CustomSliderWidget(
        //                         label: function,
        //                         onRemove: () {

        //                         },
        //                       ),
        //                     )
        //                     .toList(),
        //               ),
        //             ],
        //           )
        //         : GestureDetector(
        //             onTap: () => {},
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 color: Colors.grey.shade100,
        //                 borderRadius: BorderRadius.circular(12),
        //               ),
        //               padding: const EdgeInsets.symmetric(
        //                   vertical: 10, horizontal: 16),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: const [
        //                   Text(
        //                     '+ ',
        //                     style: TextStyle(
        //                         fontSize: 24,
        //                         color: Colors.grey,
        //                         fontWeight: FontWeight.w500,
        //                         fontFamily: 'Poppins'),
        //                   ),
        //                   Text(
        //                     'Voeg talen toe',
        //                     style: TextStyle(
        //                         fontSize: 17,
        //                         color: Colors.grey,
        //                         fontWeight: FontWeight.w500,
        //                         fontFamily: 'Poppins'),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //   ],
        // });
      },
      isNavigationEnabled: _isButtonEnabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Talen",
                style: TextStyles.titleMedium.copyWith(fontSize: 22),
              ),
              TextButton(
                onPressed: () => context.push(
                  CreateJobListingSalaryScreen.route,
                  extra: vacancy,
                ),
                child: Text(
                  "Overslaan",
                  style: TextStyles.titleMedium.copyWith(
                      fontSize: 17.21,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      color: Color(0xffFF3E68)),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1.3,
            color: Colors.grey.shade300.withOpacity(0.7),
          ),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () => LanguageBottomSheet(
              title: "Voeg talen toe",
              onSelected: (Language value) {
                setState(() {
                  _selectedlanguages.add(value);
                });
              },
            ).showBottomSheet(context: context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    '+ ',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                  Text(
                    'Voeg talen toe',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          if (_selectedlanguages.isNotEmpty)
            Column(
              children: [
                Divider(
                  thickness: 1.3,
                  color: Colors.grey.shade300.withOpacity(0.7),
                ),
                SizedBox(
                  height: 8,
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedlanguages
                      .map(
                        (function) => CustomSliderWidget(
                          label: function.name,
                          onRemove: () {
                            setState(() {
                              _selectedlanguages.remove(function);
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class CustomSliderWidget extends StatefulWidget {
  final String label;
  final VoidCallback onRemove;

  const CustomSliderWidget(
      {super.key, required this.label, required this.onRemove});

  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  double _sliderValue = 1; // Default position: "Gevorderd"

  // Mapping slider value to labels
  final Map<double, String> labels = {
    0: 'Basis',
    1: 'Gevorderd',
    2: 'Moedertaal',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              GestureDetector(
                onTap: widget.onRemove,
                child: Icon(Icons.close, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.pink,
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Colors.pink,
                  thumbShape: _CustomThumbShape(), // Custom thumb shape
                  trackHeight: 6,
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                ),
                child: Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 2,
                  divisions: null, // Make slider continuous
                  onChanged: (value) {
                    final newValue = value.roundToDouble();
                    if (_sliderValue != newValue) {
                      setState(() {
                        _sliderValue = newValue;
                      });
                      HapticFeedback.lightImpact();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: labels.entries.map((entry) {
                    return Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 16,
                        color: (_sliderValue - entry.key).abs() < 0.5
                            ? Colors.pink
                            : Colors.black,
                        fontWeight: (_sliderValue - entry.key).abs() < 0.5
                            ? FontWeight.bold
                            : FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom thumb shape with an outer radius
class _CustomThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(24, 24); // Outer size of the thumb
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double textScaleFactor,
    required double value,
  }) {
    final Canvas canvas = context.canvas;

    // Outer circle
    final Paint outerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Inner circle
    final Paint innerCirclePaint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 11, outerCirclePaint); // Outer circle (glow)
    canvas.drawCircle(center, 8, innerCirclePaint); // Inner circle
  }
}
