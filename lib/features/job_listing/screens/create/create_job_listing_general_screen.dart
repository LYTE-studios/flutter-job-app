import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/contract_type.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/data/models/location_type.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';

import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/create/used_widgets_in_creation.dart';
import 'package:jobr/features/job_listing/widgets/contract_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/widgets/function_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/widgets/location_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/widgets/search_function_bottom_sheet.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/input/jobr_dropdown_field.dart';

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
  ContractType? _selectedContractType;
  FunctionType? _selectedFunction;
  LocationType? _selectedLocation;

  bool get _isButtonEnabled =>
      _selectedContractType != null &&
      _selectedFunction != null &&
      _selectedLocation != null;

  initState() {
    usedWidgetsInCreation.clear();
  }

  Widget _buildBottomSheetContent(BuildContext context,
      {required String description, required String label}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.info,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              // Navigate to a new screen or perform your desired action
              Navigator.pop(context);
            },
            child: const Text(
              "Learn More",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

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
              selectedValue: _selectedContractType?.name,
              onPressed: () {},
            ),
            JobrDropdownField(
                title: "Functie",
                selectedValue: _selectedFunction?.name,
                onPressed: () {}),
            JobrDropdownField(
                title: "Locatie",
                selectedValue: _selectedLocation?.name,
                onPressed: () {}),
          ]
        });
      },
      isNavigationEnabled: _isButtonEnabled,
      buttonLabel: 'Naar beschrijving & media',
      secondaryButtonLabel: 'Naar beschrijving ',
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
            selectedValue: _selectedContractType?.name,
            onPressed: () => ContractTypeBottomSheet(
              onSelected: (ContractType value) {
                setState(() {
                  _selectedContractType = value;
                });
              },
              title: "Kies één of meerdere",
            ).showBottomSheet(context: context),
          ),

          // Function
          JobrDropdownField(
            title: "Functie",
            selectedValue: _selectedFunction?.name,
            onPressed: () => FunctionTypeBottomSheet(
              title: "Kies een functie",
              onSelected: (FunctionType value) {
                setState(() {
                  _selectedFunction = value;
                });
              },
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
              suffixIcon: IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    backgroundColor: Colors.black,
                    builder: (context) => _buildBottomSheetContent(context,
                        label: 'Interne functietitel',
                        description:
                            'Geef hier een duidelijke naam voor de functie of rol binnen het bedrijf'),
                  );
                },
              ),
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
            selectedValue: _selectedLocation?.name,
            onPressed: () => LocationTypeBottomSheet(
              title: "Kies een locatie",
              onSelected: (LocationType value) {
                setState(() {
                  _selectedLocation = value;
                });
              },
            ).showBottomSheet(context: context),
          ),
        ],
      ),
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
