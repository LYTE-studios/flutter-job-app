import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';

import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/create/used_widgets_in_creation.dart';
import 'package:jobr/features/job_listing/widgets/contract_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/widgets/search_function_bottom_sheet.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/input/jobr_dropdown_field.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class CreateJobListingGeneralScreen extends StatefulWidget {
  const CreateJobListingGeneralScreen({super.key});

  static const String location = 'job-listings';

  static String employerRoute = JobrRouter.getRoute(
    '${JobListingsScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<CreateJobListingGeneralScreen> createState() =>
      _CreateJobListingGeneralScreenState();
}

class _CreateJobListingGeneralScreenState
    extends State<CreateJobListingGeneralScreen> {
  // Dropdown selections
  String? _selectedContractType;
  String? _selectedFunction;
  String? _selectedLocation;

  bool get _isButtonEnabled =>
      _selectedContractType != null &&
      _selectedFunction != null &&
      _selectedLocation != null;

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      progress: .2,
      onNavigate: () {
        context.push(CreateJobListingDescriptionScreen.route);
        usedWidgetsInCreation.addAll({
          "Algemeen": [
            JobrDropdownField(
                showTitle: false,
                title: "Contract type",
                selectedValue: _selectedContractType,
                onPressed: () {}),
            JobrDropdownField(
                showTitle: false,
                title: "Functie",
                selectedValue: _selectedFunction,
                onPressed: () {}),
            TextField(
              cursorHeight: 22,
              textAlignVertical:
                  TextAlignVertical.center, // Align text to vertical center
              style: TextStyle(
                fontSize: 16, // Ensure font size consistency
                fontFamily: 'Poppins',
              ),
              enabled: false, // Enable only when _selectedFunction is not null
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.info_outline),
                suffixIconColor: (_selectedFunction == null)
                    ? Colors.grey.shade300
                    : Colors.black38,
                hintStyle: TextStyle(
                  color: (_selectedFunction == null)
                      ? Colors.grey.shade300
                      : Colors.grey.shade400,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
                hintText: 'Interne functietitel',
                filled: true,
                fillColor: (_selectedFunction == null)
                    ? Colors.grey.shade100.withOpacity(0.4)
                    : Colors.grey.shade100,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 17, // Center text vertically
                  horizontal: 15, // Keep horizontal padding
                ),
              ),
            ),
            JobrDropdownField(
                showTitle: false,
                title: "Locatie",
                selectedValue: _selectedLocation,
                onPressed: () {}),
          ]
        });
      },
      isNavigationEnabled: _isButtonEnabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Algemeen",
            style: TextStyles.titleMedium.copyWith(fontSize: 22),
          ),
          Divider(
            thickness: 0.6,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          // Contract Type
          JobrDropdownField(
            title: "Contract type",
            selectedValue: _selectedContractType,
            onPressed: () => ContractTypeBottomSheet(
              onSelected: (String value) {
                setState(() {
                  _selectedContractType = value;
                });
                Navigator.pop(context);
              },
              title: "Kies één of meerdere",
              options: const [
                "Full-time",
                "Half-time",
                "Flexi",
                "Student",
                "Stagair",
                "Freelance",
              ],
            ).showBottomSheet(context: context),
          ),

          // Function
          JobrDropdownField(
            title: "Functie",
            selectedValue: _selectedFunction,
            onPressed: () => SearchFunctionBottomSheet(
              title: "Kies een functie",
              onSelected: (String value) {
                setState(() {
                  _selectedFunction = value;
                });
                Navigator.pop(context);
              },
              options: const [
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
              ],
            ).showBottomSheet(context: context),
          ),
          TextField(
            cursorHeight: 22,
            textAlignVertical:
                TextAlignVertical.center, // Align text to vertical center
            style: TextStyle(
              fontSize: 16, // Ensure font size consistency
              fontFamily: 'Poppins',
            ),
            enabled: _selectedFunction !=
                null, // Enable only when _selectedFunction is not null
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.info_outline),
              suffixIconColor: (_selectedFunction == null)
                  ? Colors.grey.shade300
                  : Colors.black38,
              hintStyle: TextStyle(
                color: (_selectedFunction == null)
                    ? Colors.grey.shade300
                    : Colors.grey.shade400,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
              hintText: 'Interne functietitel',
              filled: true,
              fillColor: (_selectedFunction == null)
                  ? Colors.grey.shade100.withOpacity(0.4)
                  : Colors.grey.shade100,
              contentPadding: EdgeInsets.symmetric(
                vertical: 17, // Center text vertically
                horizontal: 15, // Keep horizontal padding
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          // Container(
          //             height: 56,
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 12, vertical: 12),
          //             decoration: BoxDecoration(
          //               color: selectedValue == null
          //                   ? HexColor.fromHex("#E4E4E4").withOpacity(0.2)
          //                   : HexColor.fromHex("#E4E4E4").withOpacity(0.4),
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   "Interne functietitel",
          //                   style: TextStyles.titleSmall.copyWith(
          //                       fontWeight: FontWeight.w500,
          //                       fontSize: 16.5,
          //                       color: selectedValue == null
          //                           ? const Color(0xff838383).withOpacity(0.3)
          //                           : const Color(0xff838383)
          //                               .withOpacity(0.73)),
          //                 ),
          //                 GestureDetector(
          //                   onTap: onPressed,

          //                   // if (result != null) {
          //                   //   setState(() {
          //                   //     selectedJob = result; // Update the selected job
          //                   //   });
          //                   // }

          //                   child: Icon(
          //                     Icons.info_outline,
          //                     size: 20,
          //                     color: selectedValue == null
          //                         ? const Color(0xffA2A2A2).withOpacity(0.3)
          //                         : const Color(0xff838383).withOpacity(0.73),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),

          // Location
          JobrDropdownField(
            title: "Locatie",
            selectedValue: _selectedLocation,
            // options: ["Op locatie", "Remote"],
            onPressed: () => ContractTypeBottomSheet(
              title: "Kies een contract type",
              options: const ["Op locatie", "Hybride", "Afstandswerk"],
              onSelected: (String value) {
                setState(() {
                  _selectedLocation = value;
                });
                Navigator.pop(context);
              },
            ).showBottomSheet(context: context),
          ),
        ],
      ),
      buttonLabel: 'Naar beschrijving & media',
      secondaryButtonLabel: 'Naar beschrijving ',
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color:
                Colors.grey.shade100, // Background color similar to the image
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Interne functietitel", // Placeholder text
                    hintStyle: TextStyle(
                      color: Colors
                          .grey.shade400, // Light gray color for placeholder
                      fontSize: 16, // Font size
                    ),
                    border: InputBorder.none, // Removes the default border
                  ),
                ),
              ),
              Icon(
                Icons.info_outline, // Info icon
                color: Colors.grey.shade400, // Light gray color for the icon
              ),
            ],
          ),
        ),
      ),
    );
  }
}
