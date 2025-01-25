import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:jobr/features/job_listing/screens/create/shared/create_job_listing_mixin.dart';
import 'package:jobr/features/job_listing/widgets/contract_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/job_listing/widgets/salary_unit_bottom_sheet.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/input/jobr_dropdown_field.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

// Static state storage for persistence
class AppState {
  static bool isToggleOn = false;
  static String selectedUnit = 'Per maand';
  static bool isRadioSelected = false;
  static List<String> selectedSoftSkills = [];
  static List<String> selectedHardSkills = [];
}

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
    extends State<CreateJobListingSalaryScreen> with CreateJobListingMixin {
  final bool _isButtonEnabled = true;

  Widget _buildSkillSection(String title, List<String> skills,
      {int maxSelection = 3, bool isSoftSkills = true}) {
    List<String> selectedSkills = isSoftSkills
        ? AppState.selectedSoftSkills
        : AppState.selectedHardSkills;

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
              selectedColor: AppState.isToggleOn
                  ? HexColor.fromHex("#FF3E68")
                  : Colors.white,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                fontFamily: 'Poppins',
                color: selectedSkills.contains(skill)
                    ? AppState.isToggleOn
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    // usedWidgetsInCreation.remove('Salaris');
  }

  SalaryWidget salaryWidget = const SalaryWidget();

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      progress: .8,
      buttonLabel: 'Naar vragenlijst',
      onNavigate: () {
        vacancy.salary = null;

        context.push(CreateJobListingVragenlijstScreen.route, extra: vacancy);

        //context.push(CreateJobListingVragenlijstScreen.route);
        // usedWidgetsInCreation.addAll({
        //   'Salaris': [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 1.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [salaryWidget],
        //       ),
        //     ),
        //   ]
        // });
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
            color: const Color.fromARGB(255, 50, 34, 34).withOpacity(0.7),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [salaryWidget],
            ),
          )
        ],
      ),
    );
  }
}

class SalaryWidget extends StatefulWidget {
  const SalaryWidget({Key? key}) : super(key: key);

  @override
  _SalaryWidgetState createState() => _SalaryWidgetState();
}

class _SalaryWidgetState extends State<SalaryWidget> {
  bool get isToggleOn => AppState.isToggleOn;
  set isToggleOn(bool value) => AppState.isToggleOn = value;

  Widget _buildSkillSection(String title, List<String> skills,
      {int maxSelection = 3, bool isSoftSkills = true}) {
    List<String> selectedSkills = isSoftSkills
        ? AppState.selectedSoftSkills
        : AppState.selectedHardSkills;

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
//               selectedColor: Colors.white,
              selectedColor: AppState.isToggleOn
                  ? HexColor.fromHex("#FF3E68")
                  : Colors.white,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                fontFamily: 'Poppins',
                color: selectedSkills.contains(skill)
//                     ? HexColor.fromHex("#FF3E68")

                    ? AppState.isToggleOn
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            );
          }).toList(),
        ),
      ],
    );
  }

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
              const Text(
                'Weergeven op vacature',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                ),
              ),
              Switch(
                value: isToggleOn,
                onChanged: (value) {
                  setState(() {
                    isToggleOn = value;
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
        if (AppState.isToggleOn) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 7.0),
                  child: CustomInputField(),
                ),
              ),
              const SizedBox(width: 10),
              JobrDropdownField(
                title: "Salary Unit",
                hintText: AppState.selectedUnit,
                selectedValue: AppState.selectedUnit,
                showTitle: false,
                showWijzigenText: false,
                showDropdownMenu: true,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.black54,
                ),
                onPressed: () => SalaryUnitTypeBottomSheet(
                  title: "Kies een salaris type",
                  onSelected: (String value) {
                    setState(() {
                      AppState.selectedUnit = value;
                    });
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
                    AppState.isRadioSelected = !AppState.isRadioSelected;
                  });
                },
                child: SvgPicture.asset(
                  AppState.isRadioSelected
                      ? 'assets/images/icons/radio_filled.svg'
                      : 'assets/images/icons/radio_empty.svg',
                  height: 24,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Volgens barema',
                style: TextStyle(
                  fontSize: 16.72,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 20),
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
}

class CustomInputField extends StatelessWidget {
  const CustomInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 22,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SvgPicture.asset(
            'assets/images/icons/euro.svg',
            height: 18,
            width: 20,
            colorFilter: const ColorFilter.mode(
              Colors.black87,
              BlendMode.srcIn,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 30,
          minHeight: 30,
        ),
        hintText: 'Bruto loon',
        hintStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey[400],
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        filled: true,
        fillColor: HexColor.fromHex("#E4E4E4").withOpacity(0.3),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.5,
          horizontal: 12.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
