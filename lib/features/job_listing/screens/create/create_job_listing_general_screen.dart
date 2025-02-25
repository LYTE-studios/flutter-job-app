import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/contract_type.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/data/models/location_type.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';

import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/create_job_listing_mixin.dart';
import 'package:jobr/features/job_listing/widgets/bottom_info_snack_bar.dart';
import 'package:jobr/features/job_listing/widgets/contract_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/widgets/function_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/widgets/location_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/input/jobr_dropdown_field.dart';
import 'package:lyte_studios_flutter_ui/mixins/screen_state_mixin.dart';

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
    extends State<CreateJobListingGeneralScreen>
    with CreateJobListingMixin, ScreenStateMixin {
  // Update: Use list for contract types
  List<ContractType> _selectedContractTypes = [];
  FunctionType? _selectedFunction;
  LocationType? _selectedLocation;

  bool get _isButtonEnabled =>
      _selectedContractTypes.isNotEmpty &&
      _selectedFunction != null &&
      _selectedLocation != null;

  @override
  Future<void> loadData() async {
    VacanciesService service = VacanciesService();

    await service.getContractTypes();
    await service.getFunctionTypes();
    await service.getLocationTypes();

    await super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      progress: .2,
      onNavigate: () {
        vacancy.contractType = _selectedContractTypes.first;
        vacancy.function = _selectedFunction;
        vacancy.location = _selectedLocation;

        context.push(CreateJobListingDescriptionScreen.route, extra: vacancy);

//        context.push(CreateJobListingDescriptionScreen.route);
        // usedWidgetsInCreation.addAll({
        //   "Algemeen": [
        //     JobrDropdownField(
        //       showTitle: false,
        //       title: "Contract type",
        //       selectedValue: _selectedContractType?.name,
        //       onPressed: () {},
        //     ),
        //     JobrDropdownField(
        //         showTitle: false,
        //         title: "Functie",
        //         selectedValue: _selectedFunction?.name,
        //         onPressed: () {}),
        //     JobrDropdownField(
        //         showTitle: false,
        //         title: "Locatie",
        //         selectedValue: _selectedLocation?.name,
        //         onPressed: () {}),
        //   ]
        // });
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
            color: const Color.fromRGBO(224, 224, 224, 1),
          ),
          const SizedBox(height: 16),
          // Contract Type
          JobrDropdownField(
            title: "Contract type",
            selectedValue: _selectedContractTypes.length > 2
                ? '${_selectedContractTypes.take(2).map((ct) => ct.name).join(', ')} + ${_selectedContractTypes.length - 2} more'
                : _selectedContractTypes.map((ct) => ct.name).join(', '),
            onPressed: () => ContractTypeBottomSheet(
              onSelected: (List<ContractType> values) {
                setState(() {
                  _selectedContractTypes = values;
                });
              },
              title: "Kies één of meerdere",
            ).showPopup(context: context),
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
            ).showPopup(context: context),
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
                  showInfoDialog(
                    context,
                    'Als Barista zorg je samen met je team voor het creëren van de perfecte koffie-ervaring voor onze klanten. Je bereidt zorgvuldig verschillende koffiespecialiteiten, adviseert klanten over hun keuzes, en zorgt ervoor dat de werkomgeving aangenaam en efficiënt is. Daarnaast draag je bij aan de gastvrijheid en sfeer die in lijn zijn met de hoge standaard van onze vestiging.',
                    'Interne functietitel',
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
  const CustomTextField({super.key});

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
