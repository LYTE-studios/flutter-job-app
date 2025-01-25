import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_talent_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/create/used_widgets_in_creation.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/job_listing/widgets/custom_time_picker.dart';
import 'package:jobr/features/job_listing/widgets/date_picker.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:intl/intl.dart'; // Import for DateFormat

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
  bool _isButtonEnabled = true;
  int selectedRadio = 6;
  List<String> selectedDays = [];
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      progress: .6,
      buttonLabel: 'Naar talen',
      onNavigate: () {
        context.push(CreateJobListingTalentScreen.route);
        usedWidgetsInCreation.addAll({
          'Beschikbaarheid': [
            Wrap(
              spacing: 8.0,
              children: selectedDays.map((uniqueKey) {
                String dayLabel = {
                  'M': 'M',
                  'D1': 'D',
                  'W': 'W',
                  'D2': 'D',
                  'V': 'V',
                  'Z1': 'Z',
                  'Z2': 'Z',
                }[uniqueKey]!;
                return CircleAvatar(
                  backgroundColor: HexColor.fromHex("#FF3E68"),
                  child: Text(
                    dayLabel,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
            ),
            if (selectedDate != null)
              Text(
                "Datum: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            if (selectedTime != null)
              Text(
                "Tijd: ${selectedTime!.format(context)}",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
          ]
        });
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
                        height: 24,
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
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        selectedRadio == 1
                            ? 'assets/images/icons/radio_filled.svg'
                            : 'assets/images/icons/radio_empty.svg',
                        height: 24,
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
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: 20, color: Colors.grey.withOpacity(0.9)),
                    readOnly: true,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (context) {
                          return CustomDatePickerBottomSheet(
                            startDate: DateTime.now(),
                            endDate: DateTime.now().add(Duration(days: 365)),
                            onDateSelected: (pickedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                                _dateController.text =
                                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
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
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: 20,
                        color:
                            Colors.grey.withOpacity(0.9)), // Update font size
                    readOnly: true,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (context) => CustomTimePickerBottomSheet(
                          initialTime: TimeOfDay.now(),
                          onTimeSelected: (selectedTime) {
                            setState(() {
                              _timeController.text =
                                  selectedTime.format(context);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}
