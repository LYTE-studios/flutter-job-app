import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/question.dart';
import 'package:jobr/data/models/vacancy_description.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_skills_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/create_job_listing_mixin.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/job_listing/widgets/bottom_info_snack_bar.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class CreateJobListingDescriptionScreen extends StatefulWidget {
  const CreateJobListingDescriptionScreen({super.key});

  static const String location = 'job-listing-description';
  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/${CreateJobListingGeneralScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<CreateJobListingDescriptionScreen> createState() =>
      _CreateJobListingDescriptionScreenState();
}

class _CreateJobListingDescriptionScreenState
    extends State<CreateJobListingDescriptionScreen>
    with CreateJobListingMixin {
  List<Map<String, String>> options = [];
  List<bool> isExpanded = [];
  List<TextEditingController> descriptionControllers = [];

  bool mandatoryTextFieldFilled = false;
  bool isMainDescriptionExpanded = false;
  bool isMainDescriptionLocked = false;
  final TextEditingController mainDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    mainDescriptionController.addListener(() {
      setState(() {
        mandatoryTextFieldFilled = mainDescriptionController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    mainDescriptionController.dispose();
    super.dispose();
  }

  void addOption(String title) {
    if (options.isNotEmpty && options.last['description']!.isEmpty) {
      showInfoDialog(
        context,
        "Gelieve eerst de vorige beschrijving in te vullen.",
        'Opgelet',
      );

      return;
    }
    setState(() {
      options.add({'title': title, 'description': ''});
      isExpanded.add(false); // Initially, no option is expanded
      descriptionControllers.add(TextEditingController());
    });
  }

  void updateDescription(int index, String description) {
    setState(() {
      options[index]['description'] = description;
    });
  }

  void toggleExpansion(int index) {
    setState(() {
      isExpanded[index] = !isExpanded[index]; // Toggle expansion state
    });
  }

  void showOptionsBottomSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return const OptionsBottomSheet();
      },
    );

    if (result != null && result.isNotEmpty) {
      addOption(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    void navigateToSkillsScreen() {
      vacancy.descriptions = options
          .map(
            (e) => VacancyDescription(
              question: Question(
                  id: e['question_id'] as int?, name: e['title'] ?? ''),
              description: e['description'] ?? '',
            ),
          )
          .toList();

      context.push(CreateJobListingSkillsScreen.route, extra: vacancy);
    }

    return BaseCreateJobListingScreen(
      progress: 0.3,
      onNavigate: navigateToSkillsScreen,
      isNavigationEnabled: mandatoryTextFieldFilled,
      buttonLabel: "Naar vaardigheden",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Beschrijving",
              style: TextStyles.titleMedium.copyWith(fontSize: 22),
            ),
            Text(
              "Schrijf een inleidende jobbeschrijving en kies \nextra onderwerpen.",
              style: TextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.1,
                  fontFamily: 'Poppins',
                  fontSize: 14.5,
                  color: HexColor.fromHex("#6D6D6D")),
            ),
            SizedBox(
              height: 6,
            ),
            SizedBox(
              height: 10,
              child: Divider(
                thickness: 1.5,
                color: Colors.grey.shade200.withOpacity(0.7),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (!isMainDescriptionExpanded) {
                    isMainDescriptionExpanded = true;
                  } else if (!isMainDescriptionLocked) {
                    isMainDescriptionLocked = true;
                  } else if (isMainDescriptionLocked) {
                    isMainDescriptionLocked = false;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#F7F7F7"),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Je job als Barista",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: mainDescriptionController,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      maxLength: 156,
                      buildCounter: (BuildContext context,
                          {required int currentLength,
                          required bool isFocused,
                          int? maxLength}) {
                        return Text(
                          '$currentLength/$maxLength',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        hintText:
                            'Uit wat bestaat de takenlijst, wat houdt de \njob juist in, ...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TaskList(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#F7F7F7"),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kies onderwerpen",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    child: Column(
                      key: ValueKey<int>(options.length),
                      children: options.asMap().entries.map((entry) {
                        int index = entry.key;
                        String title = entry.value['title']!;
                        String description = entry.value['description']!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                color: Colors.grey[200],
                                thickness: 2,
                              ),
                              SizedBox(height: 6),
                              GestureDetector(
                                onTap: () => toggleExpansion(index),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (description.isNotEmpty) ...[
                                if (!isExpanded[index]) ...[
                                  Text(
                                    description,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                                if (isExpanded[index]) ...[
                                  Text(
                                    description,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ] else ...[
                                if (!isExpanded[index]) ...[
                                  TextField(
                                    controller: descriptionControllers[index],
                                    onChanged: (value) {
                                      if (options[index]['description'] !=
                                          value) {
                                        options[index]['description'] = value;
                                      }
                                    },
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Hier typen...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    maxLines: null,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) =>
                                        navigateToSkillsScreen(),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ],
                              (index != options.length - 1)
                                  ? Column(
                                      children: [
                                        SizedBox(height: 6),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    color: Colors.grey[200],
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: showOptionsBottomSheet,
                      child: Text(
                        'Kies onderwerp',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 19.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      "Een uitkomst is vereist voor deze job",
      "Een diploma/opleiding is vereist voor deze job",
      "Je haalt energie uit...",
      "Je prioriteiten zijn...",
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                size: 29,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 60,
            ),
            Center(
              child: Text(
                "Kies onderwerp",
                style: TextStyles.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      options[index],
                      style: TextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.5,
                      ),
                    ),
                    onTap: () => Navigator.pop(context, options[index]),
                  ),
                  Divider(
                    color: Colors.grey[200],
                    thickness: 1,
                  )
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  // List to store tasks
  List<String> tasks = ["De afwas doen", "De afwas doen", "De afwas doen"];
  // Controller for adding new tasks
  final TextEditingController _newTaskController = TextEditingController();

  @override
  void dispose() {
    _newTaskController.dispose();
    super.dispose();
  }

  // Function to delete a task
  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Function to add a new task
  void _addTask() {
    if (_newTaskController.text.isNotEmpty) {
      setState(() {
        tasks.add(_newTaskController.text);
        _newTaskController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HexColor.fromHex("#F7F7F7"), // Background color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jouw takenpakket",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // Build task list dynamically
          ...tasks.asMap().entries.map((entry) {
            int index = entry.key;
            String task = entry.value;
            return _buildTaskItem(task, index);
          }).toList(),
          // Add a new task input field
          _buildNewTaskInput(),
        ],
      ),
    );
  }

  Widget _buildNewTaskInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: HexColor.fromHex('#F3F3F3'),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _newTaskController,
                decoration: InputDecoration(
                  fillColor: HexColor.fromHex('#F3F3F3'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  hintText: "Voeg een nieuwe taak toe...",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
                onSubmitted: (_) => _addTask(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _addTask,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String taskText, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: HexColor.fromHex('#F3F3F3'),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: TextEditingController(text: taskText),
                onChanged: (value) {
                  // Update the task text when edited
                  setState(() {
                    tasks[index] = value;
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () => _deleteTask(index),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: HexColor.fromHex('#F62C2C'),
                        ),
                        child: SvgPicture.asset(
                          JobrIcons.close,
                          width: 11,
                          height: 12,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  fillColor: HexColor.fromHex('#F3F3F3'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
