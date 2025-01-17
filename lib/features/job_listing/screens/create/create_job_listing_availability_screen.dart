import 'package:flutter/material.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/ui/widgets/buttons/jobr_radio_button.dart';
import 'package:jobr/features/vacatures/vacatures.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class CreateJobListingAvailabilityScreen extends StatefulWidget {
  const CreateJobListingAvailabilityScreen({super.key});

  static const String location = 'job-listing-availability';

  static String route = JobrRouter.getRoute(
    '${VacaturesPage.location}/${CreateJobListingGeneralScreen.location}/${CreateJobListingSkillsScreen.location}/$location',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Nieuwe vacature",
          style: TextStyles.titleMedium,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: HexColor.fromHex("#FF3E68"),
                ),
                height: 6,
                width: MediaQuery.of(context).size.width * 0.35, // 35% width
              ),
              Expanded(
                child: Container(
                  height: 6,
                  color: Colors.grey[300], // Remaining width
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Beschikbaarheid",
              style: TextStyles.titleMedium.copyWith(fontSize: 22),
            ),
            const Divider(
              thickness: 0.3,
            ),
            const SizedBox(height: 15),
            Text(
              "Voor welke dagen zoek je iemand?",
              style: TextStyles.bodyMedium
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 8.0,
              children: [
                ...['M', 'D', 'W', 'D', 'V', 'Z', 'Z'].map((day) {
                  bool isSelected = selectedDays.contains(day);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedDays.remove(day);
                        } else {
                          selectedDays.add(day);
                          selectedRadio = 5;
                        }
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: isSelected
                          ? HexColor.fromHex("#FF3E68")
                          : HexColor.fromHex("#F5F5F5"),
                      child: Text(
                        day,
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
                  JobrRadioButton(
                      value: 0,
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          selectedRadio = 0;
                          selectedDays.clear();
                        });
                      }),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Geen vaste planning",
                    style: TextStyles.titleMedium
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 16.72),
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
                  JobrRadioButton(
                      value: 1,
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          selectedRadio = 1;
                          selectedDays.clear();
                        });
                      }),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    selectedRadio == 1
                        ? "Specifieke datum"
                        : "Eenmalig evenement",
                    style: TextStyles.titleMedium
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 16.72),
                  )
                ],
              ),
            ),
            // RadioListTile(
            //   activeColor: HexColor.fromHex("#FF3E68"),
            //   title: const Text('Geen vaste planning'),
            //   value: 'Geen vaste planning',
            //   groupValue: selectedOption,
            //   onChanged: (value) {
            //     setState(() {
            //       selectedOption = value!;
            //       selectedDays
            //           .clear(); // Clear days when "Geen vaste planning" is selected
            //     });
            //   },
            // ),
            // RadioListTile(
            //   title: Text('Specifieke datum'),
            //   value: 'Specifieke datum',
            //   groupValue: selectedOption,
            //   onChanged: (value) {
            //     setState(() {
            //       selectedOption = value!;

            //     });
            //   },
            // ),
            if (selectedRadio == 1) ...[
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Kies een datum',
                  labelStyle: TextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.16,
                      color: HexColor.fromHex("#000000").withOpacity(0.4)),
                  suffixIcon: Icon(
                    Icons.calendar_month,
                    color: HexColor.fromHex("#8B8B8B"),
                  ),
                  filled: true,
                  fillColor: HexColor.fromHex("#00000008").withOpacity(0.03),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                readOnly: true,
                onTap: () {
                  // Handle date selection
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Kies een tijdstip',
                  labelStyle: TextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.16,
                      color: HexColor.fromHex("#000000").withOpacity(0.4)),
                  suffixIcon: Icon(Icons.timer_outlined,
                      color: HexColor.fromHex("#8B8B8B")),
                  filled: true,
                  fillColor: HexColor.fromHex("#00000008").withOpacity(0.03),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                readOnly: true,
                onTap: () {
                  // Handle time selection
                },
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 58,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _isButtonEnabled
                    ? HexColor.fromHex("#FF3E68")
                    : HexColor.fromHex('#DADADA'),
                shape: RoundedRectangleBorder(
                  borderRadius: _isButtonEnabled
                      ? BorderRadius.circular(65)
                      : BorderRadius.circular(65),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          const CreateJobListingAvailabilityScreen()),
                );
              },
              child: const Text(
                "Naar talen",
                style: TextStyle(
                  fontSize: 17.5,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
