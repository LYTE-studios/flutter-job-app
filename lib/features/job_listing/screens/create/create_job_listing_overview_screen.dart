import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/input/jobr_dropdown_field.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:intl/intl.dart';

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

  // List<bool> isSectionExpanded = List.generate(
  //   // usedWidgetsInCreation.keys.length,
  //   // (index) =>
  //   //     usedWidgetsInCreation[usedWidgetsInCreation.keys.elementAt(index)]!
  //   //         .isNotEmpty,
  // );

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

  // New helper method for formatting date and time.
  String formatDateTime(DateTime date, TimeOfDay time) {
    final formattedDate = DateFormat('d MMM yyyy').format(date);
    final formattedTime =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return '$formattedDate om $formattedTime';
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
                    title: 'Beschrijving',
                    isExpanded: vacancy.descriptions?.isNotEmpty ?? false,
                    children: [
                      vacancy.descriptions?.isNotEmpty ?? false
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header as in the description screen
                                Row(
                                  children: [
                                    Text(
                                      "Je job als Barista",
                                      style: TextStyles.titleMedium.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      '*',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Replace undefined vacancy.mainDescription:
                                // Use first description's text if available, otherwise an empty string.
                                Text(
                                  vacancy.descriptions!.isNotEmpty
                                      ? vacancy.descriptions!.first.description
                                      : "",
                                  style: TextStyles.bodyMedium
                                      .copyWith(fontSize: 15),
                                ),
                                const SizedBox(height: 16),
                                // Mimic the AnimatedSwitcher from the description screen
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (child, animation) =>
                                      FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                  child: Column(
                                    key: ValueKey<int>(
                                        vacancy.descriptions!.length),
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: vacancy.descriptions!
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int index = entry.key;
                                      final desc = entry.value;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              color: Colors.grey.shade300
                                                  .withOpacity(
                                                      0.7), // updated call
                                              thickness: 1.3,
                                            ),
                                            const SizedBox(height: 6),
                                            // Display description option title
                                            Text(
                                              desc.question.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            // Display description option text
                                            Text(
                                              desc.description,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            if (index !=
                                                vacancy.descriptions!.length -
                                                    1)
                                              const SizedBox(height: 6),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Divider(
                                  color: Colors.grey.shade300
                                      .withOpacity(0.7), // updated call
                                  thickness: 1.3,
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
                                      ),
                                    ),
                                    Text(
                                      'Voeg beschrijving toe',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: TextField(
                                    readOnly: true,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      filled: false,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: formatDateTime(
                                          vacancy.jobDate!,
                                          TimeOfDay.fromDateTime(
                                              vacancy.jobDate!)),
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset(
                                  JobrIcons.calendar,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ],
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
                                              mastery: function,
                                              onChanged: (mastery) {
                                                // setState(() {
                                                //   vacancy.languages
                                                //       ?.remove(function);
                                                //   vacancy.languages
                                                //       ?.add(mastery);
                                                // });
                                              },
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
                                      ),
                                    ),
                                    Text(
                                      'Voeg talen toe',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
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
                                          ?.where((question) =>
                                              question.trim().isNotEmpty)
                                          .toList()
                                          ?.asMap()
                                          .entries
                                          .map(
                                            (entry) => CustomQuestionBox(
                                              question: entry.value,
                                              label: 'Vraag ${entry.key + 1}',
                                              onRemove: () {},
                                              controller: TextEditingController(
                                                  text: entry.value),
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
                                      ),
                                    ),
                                    Text(
                                      'Voeg talen toe',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey,
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
                        color: isExpanded
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                      ),
                    ),
                    Icon(
                      !isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: isExpanded
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
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
