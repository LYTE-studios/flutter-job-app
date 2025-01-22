import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_availability_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_salary_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/widgets/search_function_bottom_sheet.dart';
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
    extends State<CreateJobListingTalentScreen> {
  bool _isButtonEnabled = false;
  int selectedRadio = 6;
  List<String> selectedDays = [];
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final List<String> _selectedFunction = [];

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouter.of(context).state!;
    final Map<String, dynamic> selectedData = state.extra as Map<String, dynamic>;

    _isButtonEnabled = _selectedFunction.isNotEmpty;
    return BaseCreateJobListingScreen(
      progress: .7,
      buttonLabel: 'Naar salaris',
      onNavigate: () {
        selectedData['Talen'] = _selectedFunction.join(', ');
        context.go(CreateJobListingSalaryScreen.route, extra: selectedData);
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
              Text(
                "Overslaan",
                style: TextStyles.titleMedium.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.pink),
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
            onTap: () => SearchFunctionBottomSheet(
              title: "Kies een functie",
              allowMultipleOptionSelection: true,
              onSelected: (String value) {
                setState(() {
                  List<String> parsedValues = value.split(',');
                  for (String val in parsedValues) {
                    val = val.trim();
                    if (!_selectedFunction.contains(val)) {
                      _selectedFunction.add(val);
                      print(val);
                    }
                  }
                });
                Navigator.pop(context);
              },
              options: const [
                "Nederlands",
                "Frans",
                "Duits",
                "Engels",
                "Arabisch",
                "Italiaans",
                "Spaans",
                "Portugees",
                "Turks",
                "Pools",
                "Bulgaars",
                "Russisch",
                "Ontbijtmedewerker",
                "Cateringmanager"
              ],
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
          if (_selectedFunction.isNotEmpty)
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
                  children: _selectedFunction
                      .map(
                        (function) => CustomSliderWidget(
                          label: function,
                          onRemove: () {
                            setState(() {
                              _selectedFunction.remove(function);
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

  const CustomSliderWidget({super.key, required this.label, required this.onRemove});

  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  double _sliderValue = 1; // Default position: "Gevorderd"

  // Mapping slider value to labels
  final Map<double, String> labels = {
    0: 'Basis',
    1: '          Gevorderd',
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
                  divisions: 100, // Smooth sliding (no fixed stops)
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value.roundToDouble();
                    });
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
