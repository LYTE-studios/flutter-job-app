import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_availability_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_description_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_overview_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_salary_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_talent_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/create/used_widgets_in_creation.dart';

import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';

class CreateJobListingVragenlijstScreen extends StatefulWidget {
  const CreateJobListingVragenlijstScreen({super.key});

  static const String location = 'job-listing-vragenlijst';

  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/${CreateJobListingGeneralScreen.location}/${CreateJobListingDescriptionScreen.location}/${CreateJobListingSkillsScreen.location}/${CreateJobListingAvailabilityScreen.location}/${CreateJobListingTalentScreen.location}/${CreateJobListingSalaryScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<CreateJobListingVragenlijstScreen> createState() =>
      _CreateJobListingVragenlijstScreenState();
}

class _CreateJobListingVragenlijstScreenState
    extends State<CreateJobListingVragenlijstScreen> {
  final bool _isButtonEnabled = true;
  int selectedRadio = 6;
  List<String> selectedDays = [];
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  List<String> selectedQuestions = [];
  List<TextEditingController> questionControllers = [];
  List<bool> isEditable = [];

  void addQuestionField() {
    setState(() {
      selectedQuestions.add('');
      questionControllers.add(TextEditingController());
      isEditable.add(true);
    });
  }

  void toggleEditable(int index) {
    setState(() {
      isEditable[index] = !isEditable[index];
    });
  }
  @override
  Widget build(BuildContext context) {
    
  Function onNavigate() {
    return () {
        context.push(CreateJobListingOverviewScreen.route);
        usedWidgetsInCreation.addAll({
          'Vragenlijst': [
            selectedQuestions.isNotEmpty
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
                        children: selectedQuestions
                            .asMap()
                            .entries
                            .map(
                              (entry) => CustomQuestionBox(
                                question: entry.value,
                                label: 'Vraag ${entry.key + 1}',
                                onRemove: () {
                                  setState(() {
                                    selectedQuestions.removeAt(entry.key);
                                    questionControllers.removeAt(entry.key);
                                    isEditable.removeAt(entry.key);
                                  });
                                },
                                controller: questionControllers[entry.key],
                                isEditable: isEditable[entry.key],
                                onToggleEditable: () =>
                                    toggleEditable(entry.key),
                              ),
                            )
                            .toList(),
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
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                  ),
          ]
        });
      };
  }


    return BaseCreateJobListingScreen(
      progress: .9,
      buttonLabel: 'Naar overzicht',
      onNavigate: onNavigate,
      isNavigationEnabled: _isButtonEnabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Vragenlijst",
                style: TextStyles.titleMedium.copyWith(fontSize: 22),
              ),
              TextButton(
                onPressed: onNavigate
,                child: Text(
                  "Overslaan",
                  style: TextStyles.titleMedium.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      color: Colors.pink),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              'Deze vragenlijst verschijnt pas voor kandidaten wanneer ze solliciteren via de app',
              style: TextStyle(color: Colors.black45, fontSize: 14.5),
            ),
          ),
          Divider(
            thickness: 1.3,
            color: Colors.grey.shade300.withOpacity(0.7),
          ),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: addQuestionField,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '+ ',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                  Text(
                    'Voeg talen toe',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          if (selectedQuestions.isNotEmpty)
            Column(
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
                  children: selectedQuestions
                      .asMap()
                      .entries
                      .map(
                        (entry) => CustomQuestionBox(
                          question: entry.value,
                          label: 'Vraag ${entry.key + 1}',
                          onRemove: () {
                            setState(() {
                              selectedQuestions.removeAt(entry.key);
                              questionControllers.removeAt(entry.key);
                              isEditable.removeAt(entry.key);
                            });
                          },
                          controller: questionControllers[entry.key],
                          isEditable: isEditable[entry.key],
                          onToggleEditable: () => toggleEditable(entry.key),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class CustomQuestionBox extends StatefulWidget {
  final String label;
  final String question;
  final VoidCallback onRemove;
  final TextEditingController controller;
  final bool isEditable;
  final VoidCallback onToggleEditable;

  const CustomQuestionBox({
    super.key,
    required this.label,
    required this.onRemove,
    required this.question,
    required this.controller,
    required this.isEditable,
    required this.onToggleEditable,
  });

  @override
  _CustomQuestionBoxState createState() => _CustomQuestionBoxState();
}

class _CustomQuestionBoxState extends State<CustomQuestionBox> {
  final double _sliderValue = 1; // Default position: "Gevorderd"

  // Mapping slider value to labels
  final Map<double, String> labels = {
    0: 'Basis',
    1: '          Gevorderd',
    2: 'Moedertaal',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: widget.onToggleEditable,
                child: Text(
                  widget.label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.5,
                      color: Colors.pinkAccent),
                ),
              ),
              GestureDetector(
                onTap: widget.onRemove,
                child: Icon(Icons.close, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              Divider(
                thickness: 1.3,
                color: Colors.grey.shade300.withOpacity(0.7),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: widget.isEditable
                    ? TextField(
                        controller: widget.controller,
                        cursorHeight: 24,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                        },
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: 'Typ een ja/nee vraag..',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        maxLines: null,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.controller.text,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
