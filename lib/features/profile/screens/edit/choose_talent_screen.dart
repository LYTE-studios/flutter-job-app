import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/enums/mastery.dart';
import 'package:jobr/data/models/language.dart';
import 'package:jobr/data/models/language_mastery.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_availability_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_salary_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/create_job_listing_mixin.dart';
import 'package:jobr/features/job_listing/widgets/language_bottom_sheet.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:jobr/ui/theme/jobr_theme.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart'; // Added for CupertinoIcons
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class ChooseTalentScreen extends StatefulWidget {
  const ChooseTalentScreen({super.key});

  static const String location = 'choose-talent';
  static String route = JobrRouter.getRoute(
    '${ProfileScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );

  @override
  State<ChooseTalentScreen> createState() => _ChooseTalentScreenState();
}

class _ChooseTalentScreenState extends State<ChooseTalentScreen> {
  bool _isButtonEnabled = false;
  int selectedRadio = 6;
  List<String> selectedDays = [];
  final Set<LanguageMastery> _selectedlanguages = {};

  @override
  Widget build(BuildContext context) {
    _isButtonEnabled = _selectedlanguages.isNotEmpty;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Mijn talen",
          style: TextStyles.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: true,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: child,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(PaddingSizes.large),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: PaddingSizes.small),
                      // ...existing content...
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Talen",
                            style:
                                TextStyles.titleMedium.copyWith(fontSize: 22),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.3,
                        color: Color(0xff0000000).withOpacity(0.04),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => LanguageBottomSheet(
                          title: "Voeg talen toe",
                          onSelected: (List<Language> value) {
                            setState(() {
                              _selectedlanguages.addAll(
                                value.map(
                                  (e) => LanguageMastery(
                                    language: e,
                                    mastery: Mastery.intermediate,
                                  ),
                                ),
                              );
                            });
                          },
                        ).showPopup(context: context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
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
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_selectedlanguages.isNotEmpty)
                        Column(
                          children: [
                            Divider(
                              thickness: 1.3,
                              color: Color(0xff0000000).withOpacity(0.04),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _selectedlanguages
                                  .map(
                                    (function) => CustomSliderWidget(
                                      mastery: function,
                                      onChanged: (mastery) {
                                        // ...existing code...
                                      },
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
                      // ...existing content...
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSizes.large,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: _isButtonEnabled
                              ? HexColor.fromHex("#FF3E68")
                              : HexColor.fromHex('#DADADA'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(65),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        onPressed: _isButtonEnabled
                            ? () {
                                context.pop();
                              }
                            : () {},
                        child: Text(
                          'Bevestigen',
                          style: const TextStyle(
                            fontSize: 17.5,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSliderWidget extends StatefulWidget {
  final LanguageMastery mastery;
  final VoidCallback onRemove;
  final Function(LanguageMastery) onChanged;

  const CustomSliderWidget({
    super.key,
    required this.mastery,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  double _sliderValue = 0; // Default position: "Gevorderd"

  // Mapping slider value to labels
  final Map<double, String> labels = {
    0: 'Basis',
    1: '    Gevorderd',
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
                widget.mastery.language.name,
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
                  activeTrackColor: Theme.of(context).primaryColor,
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Theme.of(context).primaryColor,
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
                            ? Theme.of(context).primaryColor
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
      ..color = jobrTheme.primaryColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 11, outerCirclePaint); // Outer circle (glow)
    canvas.drawCircle(center, 8, innerCirclePaint); // Inner circle
  }
}
