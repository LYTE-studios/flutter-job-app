import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/contract_type.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/features/job_listing/widgets/contract_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/widgets/custom_slider.dart';
import 'package:jobr/features/job_listing/widgets/function_type_bottom_sheet.dart';
import 'package:jobr/features/jobs/job_listing.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/features/jobs/widgets/custom_slider.dart';
import 'package:jobr/features/jobs/widgets/dropdown_menu.dart';
import 'package:jobr/features/profile/screens/edit/choose_sector_screen.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/input/jobr_dropdown_field.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class FilterScreenEmployee extends StatefulWidget {
  const FilterScreenEmployee({super.key});
  static const String location = 'filter';

  static String employeeRoute = JobrRouter.getRoute(
    '${JobScreen.location}/$location', // changed to "jobs/filter"
    JobrRouter.employeeInitialroute,
  );
  @override
  _FilterScreenEmployeeState createState() => _FilterScreenEmployeeState();
}

class _FilterScreenEmployeeState extends State<FilterScreenEmployee> {
  double _distanceSliderValue = 23;
  // Dropdown selections
  ContractType? _selectedContractType;
  FunctionType? _selectedFunction;
  // Added state to hold the selected sector.
  Sector? _selectedSector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Filters',
          style: TextStyle(
            fontSize: 24.2,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/icons/cross.svg',
            color: Colors.black,
            height: 15,
            width: 15,
          ),
          onPressed: () {
            Navigator.pop(context); // Pops the screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JobrDropdownField(
                showstar: false,
                hintText: 'Maak een keuze',
                title: "Contract type",
                selectedValue: _selectedContractType?.name,
                onPressed: () => ContractTypeBottomSheet(
                  onSelected: (List<ContractType> values) {
                    setState(() {
                      _selectedContractType =
                          values.isNotEmpty ? values.first : null;
                    });
                  },
                  title: "Kies één of meerdere",
                ).showPopup(context: context),
              ),
              Divider(
                color: HexColor.fromHex('#DCDCDC').withOpacity(0.45),
              ),
              const SizedBox(height: 4),

              // Function
              JobrDropdownField(
                title: "Functie",
                hintText: 'Maak een keuze',
                showstar: false,
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
              Divider(
                color: HexColor.fromHex('#DCDCDC').withOpacity(0.45),
              ),
              const SizedBox(height: 4),
              //Si Sector Selection
              const Text(
                'Sector',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () async {
                  final chosenSector =
                      await context.push(ChooseSectorScreen.route);
                  if (chosenSector is Sector) {
                    setState(() {
                      _selectedSector = chosenSector;
                    });
                  }
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex('#F3F3F3'),
                    border: Border.all(color: Colors.grey[100]!),
                    borderRadius: BorderRadius.circular(12.49),
                  ),
                  alignment: Alignment.center,
                  child: _selectedSector != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                _selectedSector!.image,
                                width: 40,
                                height: 40,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _selectedSector!.name,
                                style: const TextStyle(
                                  fontSize: 14.47,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/icons/add.svg',
                              color: HexColor.fromHex('#979797'),
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Divider(
                color: HexColor.fromHex('#DCDCDC').withOpacity(0.45),
              ),
              const SizedBox(height: 4),
              JobrDropdownField(
                hintText: 'Maak een keuze',
                title: "Benodigde ervaring",
                showstar: false,
                selectedValue: _selectedFunction?.name,
                onPressed: () => FunctionTypeBottomSheet(
                  showTitle: true,
                  title: "Benodigde ervaring",
                  onSelected: (FunctionType value) {
                    setState(() {
                      _selectedFunction = value;
                    });
                  },
                ).showPopup(context: context),
              ),

              // Required Experience Dropdown
              const SizedBox(height: 4),
              // Distance Slider
              Divider(
                color: HexColor.fromHex('#DCDCDC').withOpacity(0.45),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Afstand',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/map.svg',
                        color: Colors.black,
                        height: 8,
                        width: 8,
                      ),
                      Text(
                        '  ${_distanceSliderValue.round().toInt()} km',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CustomSlider(
                value: _distanceSliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: '${_distanceSliderValue.round()} km',
                onChanged: (value) {
                  setState(() {
                    _distanceSliderValue = value;
                  });
                },
              ),
              // Show Results Button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    buttonText: 'Toon resultaten',
                    onTap: () {
                      context.push(
                        JobListScreen.employeeRoute,
                      );
                    },
                    buttonColor: Theme.of(context).primaryColor,
                    height: 55,
                    borderRadius: 50,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
