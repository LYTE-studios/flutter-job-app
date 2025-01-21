import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_talent_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/ui/widgets/buttons/jobr_radio_button.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class CreateJobListingAvailabilityScreen extends StatefulWidget {
  const CreateJobListingAvailabilityScreen({super.key});

  static const String location = 'job-listing-availability';

  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/${CreateJobListingGeneralScreen.location}/${CreateJobListingDescriptionScreen.location}/${CreateJobListingSkillsScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<CreateJobListingAvailabilityScreen> createState() =>
      _CreateJobListingAvailabilityScreenState();
}

class _CreateJobListingAvailabilityScreenState
    extends State<CreateJobListingAvailabilityScreen> {
  final bool _isButtonEnabled = true;
  int selectedRadio = 6;
  List<String> selectedDays = [];
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      progress: .6,
      buttonLabel: 'Naar talen',
      onNavigate: () {
        context.push(CreateJobListingTalentScreen.route);
      },
      isNavigationEnabled: _isButtonEnabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Beschikbaarheid",
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
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Voor welke dagen zoek je iemand?",
                    style: TextStyles.bodyMedium.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8.0,
                  children: [
                    ...{
                      'M': 'M',
                      'D1': 'D',
                      'W': 'W',
                      'D2': 'D',
                      'V': 'V',
                      'Z1': 'Z',
                      'Z2': 'Z',
                    }.entries.map((entry) {
                      String uniqueKey = entry.key; // Unique key (e.g., D1, D2)
                      String dayLabel =
                          entry.value; // Display label (e.g., D, Z)
                      bool isSelected = selectedDays.contains(uniqueKey);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedDays.remove(uniqueKey);
                            } else {
                              selectedDays.add(uniqueKey);
                              selectedRadio = 5;
                            }
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: isSelected
                              ? HexColor.fromHex("#FF3E68")
                              : HexColor.fromHex("#F5F5F5"),
                          child: Text(
                            dayLabel,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : HexColor.fromHex("#BEBEBE"),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRadio = 0;
                      selectedDays.clear();
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        selectedRadio == 0
                            ? 'assets/images/icons/radio_filled.svg'
                            : 'assets/images/icons/radio_empty.svg',
                        height: selectedRadio == 0 ? 24 + 10 : 24,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Geen vaste planning",
                        style: TextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.72,
                            color: Colors.black.withOpacity(0.7)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRadio = 1;
                      selectedDays.clear();
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        selectedRadio == 1
                            ? 'assets/images/icons/radio_filled.svg'
                            : 'assets/images/icons/radio_empty.svg',
                        height: selectedRadio == 1 ? 24 + 10 : 24,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        selectedRadio == 1
                            ? "Specifieke datum"
                            : "Eenmalig evenement",
                        style: TextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.72,
                            color: Colors.black.withOpacity(0.7)),
                      )
                    ],
                  ),
                ),
                if (selectedRadio == 1) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: 'Kies een datum',
                        labelStyle: TextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.16,
                          color: HexColor.fromHex("#000000").withOpacity(0.4),
                        ),
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: HexColor.fromHex("#8B8B8B"),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        filled: true,
                        fillColor:
                            HexColor.fromHex("#00000008").withOpacity(0.03),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                      ),
                      style: TextStyle(
                          fontSize: 20, color: Colors.grey.withOpacity(0.9)),
                      readOnly: true,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                datePickerTheme: const DatePickerThemeData(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                textTheme: const TextTheme(
                                  titleLarge: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  bodyMedium: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                                colorScheme: const ColorScheme.light(
                                  primary:
                                      Colors.pink, // Header background color
                                  onPrimary: Colors.white, // Header text color
                                  onSurface: Colors.black, // Body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Colors.white, // Button text color
                                    backgroundColor:
                                        Colors.pink, // Button background color
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _dateController.text =
                                "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                          });
                        }
                      }),
                  const SizedBox(height: 8),
                  TextFormField(
                      controller: _timeController,
                      decoration: InputDecoration(
                        labelText: 'Kies een tijdstip',
                        labelStyle: TextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.16,
                          color: HexColor.fromHex("#000000").withOpacity(0.4),
                        ),
                        suffixIcon: Icon(
                          Icons.timer_outlined,
                          color: HexColor.fromHex("#8B8B8B"),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        filled: true,
                        fillColor:
                            HexColor.fromHex("#00000008").withOpacity(0.03),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          color:
                              Colors.grey.withOpacity(0.9)), // Update font size
                      readOnly: true,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                timePickerTheme: const TimePickerThemeData(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  dialHandColor: Colors.pink,
                                  hourMinuteTextColor: Colors.black,
                                  dayPeriodTextColor: Colors.black,
                                ),
                                textTheme: const TextTheme(
                                  titleLarge: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  bodyMedium: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                                colorScheme: const ColorScheme.light(
                                  primary:
                                      Colors.pink, // Header background color
                                  onPrimary: Colors.white, // Header text color
                                  onSurface: Colors.black, // Body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Colors.white, // Button text color
                                    backgroundColor:
                                        Colors.pink, // Button background color
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedTime != null) {
                          setState(() {
                            _timeController.text = pickedTime.format(context);
                          });
                        }
                      }),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}
