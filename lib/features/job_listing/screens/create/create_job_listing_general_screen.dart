import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/contract_type.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/data/models/location_type.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';

import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      progress: .2,
      onNavigate: () {
        final selectedData = {
          'Contract type': _selectedContractType,
          'Functie': _selectedFunction,
          'Locatie': _selectedLocation,
        };
        context.go(CreateJobListingDescriptionScreen.route,
            extra: selectedData);
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
            color: Colors.grey[400],
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
