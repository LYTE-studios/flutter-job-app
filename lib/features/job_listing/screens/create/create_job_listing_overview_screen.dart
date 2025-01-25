import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/enums/weekday.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/core/widgets/exception_popup.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_questionnaire_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_salary_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_talent_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/create_job_listing_mixin.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/input/jobr_dropdown_field.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import 'create_job_listing_availability_screen.dart';

class CreateJobListingOverviewScreen extends StatefulWidget {
  const CreateJobListingOverviewScreen({super.key});

  static const String location = 'job-listing-overview';

  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/${CreateJobListingGeneralScreen.location}/${CreateJobListingDescriptionScreen.location}/${CreateJobListingSkillsScreen.location}/${CreateJobListingAvailabilityScreen.location}/${CreateJobListingTalentScreen.location}/${CreateJobListingSalaryScreen.location}/${CreateJobListingVragenlijstScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<CreateJobListingOverviewScreen> createState() =>
      _CreateJobListingOverviewScreenState();
}

class _CreateJobListingOverviewScreenState
    extends State<CreateJobListingOverviewScreen>
    with CreateJobListingMixin, ScreenStateMixin {
  final bool _isButtonEnabled = true;

  List<bool> isSectionExpanded = List.generate(
    usedWidgetsInCreation.keys.length,
    (index) =>
        usedWidgetsInCreation[usedWidgetsInCreation.keys.elementAt(index)]!
            .isNotEmpty,
  );

  Future<void> postVacancy() async {
    setLoading(true);

    try {
      await VacanciesService().createVacancy(vacancy);
      context.pushReplacement(
        JobrRouter.getRoute(
          JobListingsScreen.location,
          JobrRouter.employerInitialroute,
        ),
      );
    } catch (e) {
      setLoading(false);
      ExceptionPopup.show(context, "Er is een fout opgetreden");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      progress: 1.0,
      buttonLabel: 'Bevestig & post vacature',
      onNavigate: postVacancy,
      isNavigationEnabled: _isButtonEnabled,
      loading: loading,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overzicht",
              style: TextStyles.titleMedium.copyWith(fontSize: 22),
            ),
            Divider(
              thickness: 1.3,
              color: Colors.grey.shade300.withOpacity(0.7),
            ),
            const SizedBox(height: 15),
            SafeArea(
              top: false,
              bottom: true,
              minimum: const EdgeInsets.only(bottom: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SelectableSection(
                    title: 'Algemeen',
                    children: [
                      JobrDropdownField(
                        title: "Contract type",
                        selectedValue: vacancy.contractType?.name,
                        onPressed: () {},
                      ),
                      JobrDropdownField(
                        title: "Functie",
                        selectedValue: vacancy.function?.name,
                        onPressed: () {},
                      ),
                      JobrDropdownField(
                        title: "Locatie",
                        selectedValue: vacancy.location?.name,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  _SelectableSection(
                    title: 'Beschikbaarheid',
                    isExpanded: (vacancy.weekDays?.isNotEmpty ?? false) ||
                        vacancy.jobDate != null,
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: vacancy.weekDays?.map((uniqueKey) {
                              String dayLabel = {
                                Weekday.monday: 'M',
                                Weekday.tuesday: 'D',
                                Weekday.wednesday: 'W',
                                Weekday.thursday: 'D',
                                Weekday.friday: 'V',
                                Weekday.saturday: 'Z',
                                Weekday.sunday: 'Z',
                              }[uniqueKey]!;

                              return CircleAvatar(
                                backgroundColor: HexColor.fromHex("#FF3E68"),
                                child: Text(
                                  dayLabel,
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }).toList() ??
                            [],
                      ),
                      if (vacancy.jobDate != null)
                        Text(
                          "Datum: ${vacancy.jobDate!.day}-${vacancy.jobDate!.month}-${vacancy.jobDate!.year}",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      if (vacancy.jobDate != null)
                        Text(
                          "Tijd: ",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                  _SelectableSection(
                    title: 'Talen',
                    isExpanded: vacancy.languages?.isNotEmpty ?? false,
                    children: [
                      vacancy.languages?.isNotEmpty ?? false
                          ? Column(
                              children: [
                                Divider(
                                  thickness: 1.3,
                                  color: Colors.grey.shade300.withOpacity(0.7),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: vacancy.languages
                                          ?.map(
                                            (function) => CustomSliderWidget(
                                              label: function.language.name,
                                              onRemove: () {
                                                setState(() {
                                                  vacancy.languages
                                                      ?.remove(function);
                                                });
                                              },
                                            ),
                                          )
                                          .toList() ??
                                      [],
                                ),
                              ],
                            )
                          : GestureDetector(
                              onTap: () => {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      '+ ',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins'),
                                    ),
                                    Text(
                                      'Voeg talen toe',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                  _SelectableSection(
                    title: 'Salaris',
                    isExpanded: vacancy.salary != null,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [SalaryWidget()],
                        ),
                      ),
                    ],
                  ),
                  _SelectableSection(
                    title: 'Vragenlijst',
                    isExpanded: vacancy.questions?.isNotEmpty ?? false,
                    children: [
                      vacancy.questions?.isNotEmpty ?? false
                          ? Column(
                              children: [
                                Divider(
                                  thickness: 1.3,
                                  color: Colors.grey.shade300.withOpacity(0.7),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: vacancy.questions
                                          ?.map(
                                            (entry) => CustomQuestionBox(
                                              question: entry,
                                              label:
                                                  'Vraag ${(vacancy.questions?.indexOf(entry) ?? 0) + 1}',
                                              onRemove: () {},
                                              controller:
                                                  TextEditingController(),
                                              isEditable: false,
                                              onToggleEditable: () {},
                                            ),
                                          )
                                          .toList() ??
                                      [],
                                ),
                              ],
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      '+ ',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins'),
                                    ),
                                    Text(
                                      'Voeg talen toe',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SelectableSection extends StatefulWidget {
  final String title;
  final List<Widget> children;

  final bool isExpanded;

  const _SelectableSection({
    required this.title,
    required this.children,
    this.isExpanded = true,
  });

  @override
  State<_SelectableSection> createState() => __SelectableSectionState();
}

class __SelectableSectionState extends State<_SelectableSection> {
  late bool isExpanded = widget.isExpanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            ClearInkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyles.titleMedium.copyWith(
                        fontSize: 18,
                        color: isExpanded ? Colors.pinkAccent : Colors.black,
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: isExpanded ? Colors.pinkAccent : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded) ...[
              const SizedBox(height: 10),
              ...widget.children,
            ],
          ],
        ),
      ),
    );
  }
}
