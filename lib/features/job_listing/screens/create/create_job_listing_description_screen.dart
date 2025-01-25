import 'package:flutter/material.dart';
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
      showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          backgroundColor: Colors.black,
          builder: (context) => BottomSheetContent(
                label: 'Opgelet',
                description:
                    "Gelieve eerst de vorige beschrijving in te vullen.",
              ));

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
    void _navigateToSkillsScreen() {
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
      // usedWidgetsInCreation.addAll({
      //   "Beschrijving": [
      //     Column(
      //       children: [
      //         Row(
      //           children: [
      //             Text(
      //               "Je job als Barista",
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             Text(
      //               '*',
      //               style: TextStyle(
      //                 color: Colors.red,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(height: 8),
      //         Text(
      //           mainDescriptionController.text,
      //           style: TextStyle(
      //             fontSize: 15,
      //             color: Colors.black,
      //           ),
      //         ),
      //         Column(
      //           children: options.asMap().entries.map((entry) {
      //             int index = entry.key;
      //             String title = entry.value['title']!;
      //             String description = entry.value['description']!;
      //             return Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 8.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   // Title
      //                   GestureDetector(
      //                     onTap: () => toggleExpansion(index),
      //                     child: Text(
      //                       title,
      //                       style: const TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(height: 8),
      //                   // Expandable description with ellipsis
      //                   if (description.isNotEmpty) ...[
      //                     // If description exists, show full description
      //                     if (!isExpanded[index]) ...[
      //                       Text(
      //                         description,
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.grey.shade500,
      //                         ),
      //                         overflow: TextOverflow.ellipsis,
      //                       ),
      //                     ],
      //                     // Show the full description when expanded
      //                     if (isExpanded[index]) ...[
      //                       Text(
      //                         description,
      //                         style: TextStyle(
      //                           fontSize: 16,
      //                           color: Colors.grey.shade600,
      //                         ),
      //                       ),
      //                       const SizedBox(height: 16),
      //                     ],
      //                   ] else ...[
      //                     // If description doesn't exist, show text field
      //                     if (!isExpanded[index]) ...[
      //                       TextField(
      //                         controller: descriptionControllers[index],
      //                         onChanged: (value) {
      //                           // Update only if the value is different to avoid constant rebuilds
      //                           if (options[index]['description'] != value) {
      //                             options[index]['description'] = value;
      //                           }
      //                         },
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.black,
      //                         ),
      //                         decoration: InputDecoration(
      //                           hintText: 'Hier typen...',
      //                           hintStyle: TextStyle(
      //                             color: Colors.grey.shade400,
      //                             fontSize: 14.5,
      //                           ),
      //                           border: InputBorder.none, // No border
      //                         ),
      //                         maxLines: null, // Allow multi-line input
      //                         textInputAction: TextInputAction.done,
      //                         onSubmitted: (_) => _navigateToSkillsScreen(),
      //                       ),
      //                       const SizedBox(height: 16),
      //                     ],
      //                   ],
      //                   (index != options.length - 1)
      //                       ? Column(
      //                           children: [
      //                             SizedBox(
      //                               height: 6,
      //                             ),
      //                             Divider(
      //                               color: Colors.grey[200],
      //                               thickness: 2,
      //                             ),
      //                           ],
      //                         )
      //                       : Container(),
      //                 ],
      //               ),
      //             );
      //           }).toList(),
      //         ),
      //       ],
      //     ),
      //   ]
      // });

//      context.push(CreateJobListingSkillsScreen.route);
      // usedWidgetsInCreation.addAll({
      //   "Beschrijving": [
      //     Column(
      //       children: [
      //         Row(
      //           children: [
      //             Text(
      //               "Je job als Barista",
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             Text(
      //               '*',
      //               style: TextStyle(
      //                 color: Colors.red,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(height: 8),
      //         Row(
      //           children: [
      //             Text(
      //               mainDescriptionController.text,
      //               style: TextStyle(
      //                 fontSize: 15,
      //                 color: Colors.black,
      //               ),
      //               textAlign: TextAlign.left,
      //             ),
      //           ],
      //         ),
      //         Column(
      //           children: options.asMap().entries.map((entry) {
      //             int index = entry.key;
      //             String title = entry.value['title']!;
      //             String description = entry.value['description']!;
      //             return Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 8.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Divider(
      //                     color: Colors.grey[200],
      //                     thickness: 2,
      //                   ),
      //                   // Title
      //                   GestureDetector(
      //                     onTap: () => toggleExpansion(index),
      //                     child: Text(
      //                       title,
      //                       style: const TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(height: 8),
      //                   // Expandable description with ellipsis
      //                   if (description.isNotEmpty) ...[
      //                     // If description exists, show full description
      //                     if (!isExpanded[index]) ...[
      //                       Text(
      //                         description,
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.grey.shade500,
      //                         ),
      //                         overflow: TextOverflow.ellipsis,
      //                       ),
      //                     ],
      //                     // Show the full description when expanded
      //                     if (isExpanded[index]) ...[
      //                       Text(
      //                         description,
      //                         style: TextStyle(
      //                           fontSize: 16,
      //                           color: Colors.grey.shade600,
      //                         ),
      //                       ),
      //                       const SizedBox(height: 16),
      //                     ],
      //                   ] else ...[
      //                     // If description doesn't exist, show text field
      //                     if (!isExpanded[index]) ...[
      //                       TextField(
      //                         controller: descriptionControllers[index],
      //                         onChanged: (value) {
      //                           // Update only if the value is different to avoid constant rebuilds
      //                           if (options[index]['description'] != value) {
      //                             options[index]['description'] = value;
      //                           }
      //                         },
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.black,
      //                         ),
      //                         decoration: InputDecoration(
      //                           hintText: 'Hier typen...',
      //                           hintStyle: TextStyle(
      //                             color: Colors.grey.shade400,
      //                             fontSize: 14.5,
      //                           ),
      //                           border: InputBorder.none, // No border
      //                         ),
      //                         maxLines: null, // Allow multi-line input
      //                         textInputAction: TextInputAction.done,
      //                         onSubmitted: (_) => _navigateToSkillsScreen(),
      //                       ),
      //                       const SizedBox(height: 16),
      //                     ],
      //                   ],
      //                   (index != options.length - 1)
      //                       ? Column(
      //                           children: [
      //                             SizedBox(
      //                               height: 6,
      //                             ),
      //                             Divider(
      //                               color: Colors.grey[200],
      //                               thickness: 2,
      //                             ),
      //                           ],
      //                         )
      //                       : Container(),
      //                 ],
      //               ),
      //             );
      //           }).toList(),
      //         ),
      //       ],
      //     ),
      //   ]
      // });
    }

    return BaseCreateJobListingScreen(
      progress: 0.3,
      onNavigate: _navigateToSkillsScreen,
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
                    const Row(
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
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (!isMainDescriptionExpanded &&
                        mainDescriptionController.text.isEmpty)
                      Text(
                        "Uit wat bestaat de takenlijst, wat houdt de \njob juist in, ...",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade500,
                        ),
                      )
                    else if (!isMainDescriptionLocked)
                      TextField(
                        controller: mainDescriptionController,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Uit wat bestaat de takenlijst, wat houdt de \njob juist in, ...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14.5,
                          ),
                          border: InputBorder.none, // No border
                        ),
                        maxLines: null, // Allow multi-line input
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _navigateToSkillsScreen(),
                      )
                    else
                      Text(
                        (mainDescriptionController.text.isNotEmpty ||
                                mainDescriptionController.text != '')
                            ? mainDescriptionController.text
                            : 'Uit wat bestaat de takenlijst, wat houdt de \njob juist in, ...',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    const SizedBox(height: 16),
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
                                // Title
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
                                const SizedBox(height: 6),
                                // Expandable description with ellipsis
                                if (description.isNotEmpty) ...[
                                  // If description exists, show full description
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
                                  // Show the full description when expanded
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
                                  // If description doesn't exist, show text field
                                  if (!isExpanded[index]) ...[
                                    TextField(
                                      controller: descriptionControllers[index],
                                      onChanged: (value) {
                                        // Update only if the value is different to avoid constant rebuilds
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
                                          color: Colors.grey.shade400,
                                          fontSize: 14.5,
                                        ),
                                        border: InputBorder.none, // No border
                                      ),
                                      maxLines: null, // Allow multi-line input
                                      textInputAction: TextInputAction.done,
                                      onSubmitted: (_) =>
                                          _navigateToSkillsScreen(),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ],
                                (index != options.length - 1)
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 6,
                                          ),
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
                    SizedBox(
                      height: 6,
                    ),
                    // Button to add new option
                    GestureDetector(
                      onTap: showOptionsBottomSheet,
                      child: const Text(
                        '+ Kies onderwerp',
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.5),
                      ),
                    ),
                  ],
                ),
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
