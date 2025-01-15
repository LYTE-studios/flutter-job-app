import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';

import 'package:jobr/features/job_listing/skills_page.dart';
import 'package:jobr/features/job_listing/widgets/bottom_sheet_widget.dart';
import 'package:jobr/features/job_listing/widgets/bottom_sheet_with_search.dart';
import 'package:jobr/features/vacatures/vacatures.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widget/common_appbar_navigation.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class GeneralJobListingScreen extends StatefulWidget {
  const GeneralJobListingScreen({super.key});

  static const String location = 'job-listings';

  static String employerRoute = JobrRouter.getRoute(
    '${VacaturesPage.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<GeneralJobListingScreen> createState() =>
      _GeneralJobListingScreenState();
}

class _GeneralJobListingScreenState extends State<GeneralJobListingScreen> {
  // Dropdown selections
  String? _selectedContractType;
  String? _selectedFunction;
  String? _selectedLocation;
  double progressBarWidth = 200;

  bool get _isButtonEnabled =>
      _selectedContractType != null &&
      _selectedFunction != null &&
      _selectedLocation != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            CupertinoIcons.back,
          ),
        ),
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
                width: MediaQuery.of(context).size.width * 0.2, // 20% width
              ),
              Expanded(
                child: Container(
                  height: 6,
                  color: Colors.grey[300], // Remaining 80% width
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
              "Algemeen",
              style: TextStyles.titleMedium.copyWith(fontSize: 22),
            ),
            const Divider(
              thickness: 0.6,
            ),
            const SizedBox(height: 16),

            // Contract Type
            buildDropdownSection(
              title: "Contract type",
              selectedValue: _selectedContractType,
              onPressed: () => bottomSheet(
                context: context,
                title: "Kies één of meerdere",
                options: [
                  "Full-time",
                  "Half-time",
                  "Flexi",
                  "Student",
                  "Stagair",
                  "Freelance",
                ],
                onSelected: (String value) {
                  setState(() {
                    _selectedContractType = value;
                  });
                  Navigator.pop(context);
                },
              ),
              interneFunctie: false,
            ),

            // Function
            buildDropdownSection(
              title: "Functie",
              selectedValue: _selectedFunction,
              onPressed: () => bottomSheetWithsearch(
                  context: context,
                  title: "Kies een functie",
                  onSelected: (String value) {
                    setState(() {
                      _selectedFunction = value;
                    });
                    Navigator.pop(context);
                  },
                  options: [
                    "All-round",
                    "Zaal",
                    "Bar",
                    "Keuken",
                    "Management",
                    "Back-office",
                    "Financieel",
                    "Hygiëne",
                    "Afwasser",
                    "Sommelier",
                    "Barista",
                    "Ober/Serveerster",
                    "Cateringmanagement",
                  ]),
              interneFunctie: true,
            ),

            // Location
            buildDropdownSection(
                title: "Locatie",
                selectedValue: _selectedLocation,
                // options: ["Op locatie", "Remote"],
                onPressed: () => bottomSheet(
                      context: context,
                      title: "Kies een contract type",
                      options: ["Op locatie", "Hybride", "Afstandswerk"],
                      onSelected: (String value) {
                        setState(() {
                          _selectedLocation = value;
                        });
                        Navigator.pop(context);
                      },
                    ),
                interneFunctie: false),

            const Spacer(),

            // Bottom Button
            // ElevatedButton(
            //   onPressed: _isButtonEnabled ? () {} : null,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: _isButtonEnabled
            //         ? HexColor.fromHex("#FF3E68")
            //         : Colors.grey[300],
            //     minimumSize: const Size(double.infinity, 54),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            //   child: Text(
            //     "Naar beschrijving",
            //     style: TextStyle(
            //       color: _isButtonEnabled ? Colors.white : Colors.black38,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),

            Padding(
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
                      context.push(
                        JobListingSkillsScreen.route,
                      );
                    },
                    child: Text(
                      _isButtonEnabled
                          ? "Naar beschrijving"
                          : "Naar beschrijving & media",
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  // Reusable dropdown section with 'Wijzigen' logic
  Widget buildDropdownSection({
    required String title,
    String? selectedValue,
    // required List<String> options,
    required VoidCallback onPressed,
    required bool interneFunctie,
    String? ifSelectedValue,
    List<String>? ifOptions,
    ValueChanged<String?>? ifOnChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: title,
                style: TextStyles.titleMedium.copyWith(fontSize: 16.5),
                children: [
              TextSpan(
                  text: "*",
                  style: TextStyles.titleMedium.copyWith(
                      fontSize: 16.5, color: HexColor.fromHex("#FF3F3F")))
            ])),
        const SizedBox(height: 8),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: HexColor.fromHex("#E4E4E4").withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedValue ?? "Kies een optie",
                style: TextStyles.titleSmall.copyWith(
                    fontSize: 16.5,
                    color:
                        selectedValue == null ? Colors.black45 : Colors.black),
              ),
              GestureDetector(
                onTap: onPressed,
                child: selectedValue == null
                    ? const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.black45,
                          size: 18,
                        ))
                    : Text(
                        "Wijzigen",
                        style: TextStyles.titleSmall.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: HexColor.fromHex("#FF3E68"),
                        ),
                      ),
              ),
            ],
          ),
        ),
        interneFunctie
            ? Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedValue == null
                          ? HexColor.fromHex("#E4E4E4").withOpacity(0.2)
                          : HexColor.fromHex("#E4E4E4").withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Interne functietitel",
                          style: TextStyles.titleSmall.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.5,
                              color: selectedValue == null
                                  ? const Color(0xff838383).withOpacity(0.3)
                                  : const Color(0xff838383).withOpacity(0.73)),
                        ),
                        GestureDetector(
                          onTap: onPressed,

                          // if (result != null) {
                          //   setState(() {
                          //     selectedJob = result; // Update the selected job
                          //   });
                          // }

                          child: Icon(
                            Icons.info_outline,
                            size: 20,
                            color: selectedValue == null
                                ? const Color(0xffA2A2A2).withOpacity(0.3)
                                : const Color(0xff838383).withOpacity(0.73),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 16),
      ],
    );
  }

  // Dropdown Dialog to show options
  void showDropdownDialog(
    BuildContext context,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return ListTile(
                title: Text(option),
                onTap: () {
                  onChanged(option);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
