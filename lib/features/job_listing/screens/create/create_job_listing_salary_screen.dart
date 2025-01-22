import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/contract_type.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_availability_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_questionnaire_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_talent_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/widgets/contract_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/input/jobr_dropdown_field.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class CreateJobListingSalaryScreen extends StatefulWidget {
  const CreateJobListingSalaryScreen({super.key});

  static const String location = 'job-listing-salary';

  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/${CreateJobListingGeneralScreen.location}/${CreateJobListingDescriptionScreen.location}/${CreateJobListingSkillsScreen.location}/${CreateJobListingAvailabilityScreen.location}/${CreateJobListingTalentScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<CreateJobListingSalaryScreen> createState() =>
      _CreateJobListingSalaryScreenState();
}

class _CreateJobListingSalaryScreenState
    extends State<CreateJobListingSalaryScreen> {
  final bool _isButtonEnabled = true;
  int selectedRadio = 6;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouter.of(context).state!;
    final Map<String, dynamic> selectedData =
        state.extra as Map<String, dynamic>;

    return BaseCreateJobListingScreen(
      progress: .8,
      buttonLabel: 'Naar vragenlijst',
      onNavigate: () {
        selectedData['Salaris'] = '€2000 per maand'; // Example salary
        context.go(CreateJobListingVragenlijstScreen.route,
            extra: selectedData);
      },
      isNavigationEnabled: _isButtonEnabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Salaris",
            style: TextStyles.titleMedium.copyWith(fontSize: 22),
          ),
          Divider(
            thickness: 1.3,
            color: Colors.grey.shade200.withOpacity(0.7),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SalaryWidget()],
            ),
          )
        ],
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 22,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SvgPicture.asset(
            'assets/images/icons/euro.svg', // Path to your euro.svg file
            height: 18,
            width: 20,
            color: Colors.black87, // Adjust the icon color if needed
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 30,
          minHeight: 30,
        ),
        hintText: 'Bruto loon',
        hintStyle: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins'),
        filled: true,
        fillColor: Colors.grey.shade100, // Light grey background
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 12.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none, // No visible border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.transparent, // Subtle border on focus
            width: 1.0,
          ),
        ),
      ),
    );
  }
}

class SalaryWidget extends StatefulWidget {
  const SalaryWidget({super.key});

  @override
  _SalaryWidgetState createState() => _SalaryWidgetState();
}

class _SalaryWidgetState extends State<SalaryWidget> {
  bool _isToggleOn = false;
  ContractType? _selectedUnit; // Default value
  bool _isRadioSelected = false; // New state for radio button
  List<String> selectedSoftSkills = []; // Define selectedSoftSkills
  List<String> selectedHardSkills = []; // Define selectedHardSkills

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weergeven op vacature',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                ),
              ),
              Switch(
                value: _isToggleOn,
                onChanged: (value) {
                  setState(() {
                    _isToggleOn = value;
                  });
                },
                activeColor: Colors.white, // Thumb color when ON
                activeTrackColor: Colors.pink, // Track color when ON
                inactiveThumbColor: Colors.white, // Thumb color when OFF
                inactiveTrackColor: Colors.grey.shade400
                    .withOpacity(0.6), // Track color when OFF
                thumbColor: WidgetStateProperty.all(Colors.white),
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Icon(Icons.circle,
                          size: 24.0,
                          color: Colors.white); // Increased thumb size
                    }
                    return Icon(Icons.circle,
                        size: 24.0,
                        color: Colors.white); // Increased thumb size
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Divider(
          thickness: 1.3,
          color: Colors.grey.shade200.withOpacity(0.7),
        ),
        const SizedBox(height: 4),
        if (_isToggleOn) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(child: CustomInputField()),
              const SizedBox(width: 10),
              JobrDropdownField(
                title: "Locatie",
                showTitle: false,
                showWijzigenText: false,
                // selectedValue: con,
                showDropdownMenu: true,
                onPressed: () => ContractTypeBottomSheet(
                  title: "Kies een contract type",
                  onSelected: (ContractType contractType) {
                    setState(() {
                      // _selectedUnit = value;
                    });
                    Navigator.pop(context);
                  },
                ).showBottomSheet(context: context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isRadioSelected = !_isRadioSelected;
                  });
                },
                child: SvgPicture.asset(
                  _isRadioSelected
                      ? 'assets/images/icons/radio_filled.svg'
                      : 'assets/images/icons/radio_empty.svg',
                  height: _isRadioSelected ? 24.0 + 6 : 24,
                  width: 24.0,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Volgens barema',
                style: TextStyle(
                    fontSize: 16.72,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
        SizedBox(
          height: 20,
        ),
        _buildSkillSection(
          'Extra’s',
          [
            "GSM",
            "GSM-abonnement",
            "Laptop",
            "Fietsplan",
            "Sportabonnement",
            "Reiskostvergoeding",
            "Opleiding"
          ],
          maxSelection: 7,
          isSoftSkills: false,
        ),
      ],
    );
  }

  Widget _buildSkillSection(String title, List<String> skills,
      {int maxSelection = 3, bool isSoftSkills = true}) {
    List<String> selectedSkills =
        isSoftSkills ? selectedSoftSkills : selectedHardSkills;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.titleMedium
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: -3,
          children: skills.map((skill) {
            return ChoiceChip(
              showCheckmark: false,
              label: Text(skill),
              selected: selectedSkills.contains(skill),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    if (selectedSkills.length < maxSelection) {
                      selectedSkills.add(skill);
                    }
                  } else {
                    selectedSkills.remove(skill);
                  }
                });
              },
              selectedColor:
                  _isToggleOn ? HexColor.fromHex("#FF3E68") : Colors.white,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                fontFamily: 'Poppins',
                color: selectedSkills.contains(skill)
                    ? _isToggleOn
                        ? Colors.white
                        : HexColor.fromHex("#FF3E68")
                    : HexColor.fromHex("#A0A0A0"),
                fontWeight: FontWeight.w500,
                fontSize: 15.88,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  width: selectedSkills.contains(skill) ? 1.6 : 1,
                  color: selectedSkills.contains(skill)
                      ? HexColor.fromHex("#FF3E68")
                      : HexColor.fromHex("#E8E8E8"),
                ),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4), // Adjusted padding
            );
          }).toList(),
        ),
      ],
    );
  }

  void showContractTypeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: ['per maand', 'per jaar', 'per uur']
              .map(
                (option) => ListTile(
                  title: Text(option),
                  onTap: () {
                    setState(() {
                      // _selectedUnit = option;
                    });
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }
}
