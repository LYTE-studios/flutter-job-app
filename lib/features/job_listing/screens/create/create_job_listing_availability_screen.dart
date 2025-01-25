import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/enums/weekday.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_talent_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/create_job_listing_mixin.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/job_listing/widgets/date_time_picker.dart';
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
    extends State<CreateJobListingAvailabilityScreen>
    with CreateJobListingMixin {
  int selectedRadio = 6;
  List<Weekday> selectedDays = [];

  final TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime = TimeOfDay.now();

  String toVisibleDay(Weekday day) {
    return {
      Weekday.monday: 'M',
      Weekday.tuesday: 'D',
      Weekday.wednesday: 'W',
      Weekday.thursday: 'D',
      Weekday.friday: 'V',
      Weekday.saturday: 'Z',
      Weekday.sunday: 'Z',
    }[day]!;
  }

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      progress: .6,
      buttonLabel: 'Naar talen',
      onNavigate: () {
        vacancy.weekDays = selectedDays;
        vacancy.jobDate = selectedDate;

        context.push(CreateJobListingTalentScreen.route, extra: vacancy);
      },
      isNavigationEnabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Beschikbaarheid",
            style: TextStyles.titleMedium.copyWith(fontSize: 22),
          ),
          Divider(
            thickness: 1.3,
            color: Colors.grey.shade300.withAlpha(179),
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
                        color: Colors.black.withAlpha(179)),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8.0,
                  children: [
                    ...Weekday.values.map((entry) {
                      String dayLabel = toVisibleDay(entry);
                      bool isSelected = selectedDays.contains(entry);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedDays.remove(entry);
                            } else {
                              selectedDays.add(entry);
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
                            color: Colors.black.withAlpha(179)),
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
                            color: Colors.black.withAlpha(179)),
                      )
                    ],
                  ),
                ),
                if (selectedRadio == 1) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Kies een datum & tijdstip',
                      labelStyle: TextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.16,
                        color: HexColor.fromHex("#000000").withAlpha(102),
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: HexColor.fromHex("#8B8B8B"),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      filled: true,
                      fillColor: HexColor.fromHex("#00000008").withAlpha(8),
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
                        fontSize: 20, color: Colors.grey.withAlpha(230)),
                    readOnly: true,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (context) => SizedBox(
                          // height: MediaQuery.of(context).size.height * 0.55,
                          child: CustomDateTimePicker(
                            onDateTimeSelected: (date, time) {
                              setState(() {
                                selectedDate = date;
                                selectedTime = time;
                                final formattedDate =
                                    DateFormat('d MMM yyyy').format(date);
                                final formattedTime =
                                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                _dateController.text =
                                    '$formattedDate om $formattedTime';
                              });
                              Navigator.pop(context);
                            },
                          ),
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
