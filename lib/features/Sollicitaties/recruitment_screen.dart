import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/chat/screens/employer/chat_page_screen.dart';
import 'package:jobr/features/job_listing/screens/general/filter_screen.dart';
import 'package:jobr/features/Sollicitaties/recruitment_detail_screen.dart';
import 'package:jobr/features/profile/screens/employee_profile_screen_display.dart';
import 'package:jobr/features/profile/screens/widgets/custom_job_card.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/input/jobr_search_bar.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../job_listing/screens/general/jobr_ai_suggestions_screen.dart';

class RecruitmentScreen extends StatefulWidget {
  static const String location = 'sollicitaties';

  const RecruitmentScreen({super.key});

  @override
  State createState() => _RecruitmentScreenState();
}

class _RecruitmentScreenState extends State<RecruitmentScreen> {
  final List<Map<String, String>> jobCards = [
    {
      "description":
          "Ik ben Yassine, 20 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste serv",
      "age": "20",
      "location": "Brussel",
      "userName": "Yassine Vuran",
      "profileImagePath": "assets/images/images/image.png",
      "suggestionPercentage": "74",
      "rating": "4.5",
    },
    {
      "description":
          "Hallo, ik ben Sarah en ik zoek een uitdagende baan in de klantenservice",
      "age": "23",
      "location": "Antwerpen",
      "userName": "Sarah De Vries",
      "profileImagePath": "assets/images/images/image-3.png",
      "suggestionPercentage": "82",
      "rating": "4.5",
    },
    {
      "description":
          "Marketing professional met 2 jaar ervaring in social media management",
      "age": "25",
      "location": "Gent",
      "userName": "Thomas Peeters",
      "profileImagePath": "assets/images/images/image-9.png",
      "suggestionPercentage": "68",
      "rating": "4.5",
    },
    {
      "description": "Ervaren verkoper met passie voor klantenrelaties",
      "age": "28",
      "location": "Leuven",
      "userName": "Lisa Janssens",
      "profileImagePath": "assets/images/images/image-6.png",
      "suggestionPercentage": "79",
      "rating": "4.5",
    },
    {
      "description": "IT specialist zoekend naar nieuwe uitdagingen",
      "age": "24",
      "location": "Hasselt",
      "userName": "Kevin Van Dam",
      "profileImagePath": "assets/images/images/image-7.png",
      "suggestionPercentage": "88",
      "rating": "4.5",
    },
  ];

  final List<Map<String, dynamic>> items = const [
    {
      "text": "Vast",
      "image": "assets/images/recruteren/vast.png",
      "category": "permanent"
    },
    {
      "text": "Studenten",
      "image": "assets/images/recruteren/studenten.png",
      "category": "students"
    },
    {
      "text": "Flexi's",
      "image": "assets/images/recruteren/flexis.png",
      "category": "flexi"
    },
    {
      "text": "Stagairs",
      "image": "assets/images/recruteren/stagairs.png",
      "category": "interns"
    },
    {
      "text": "Freelancers",
      "image": "assets/images/recruteren/freelancers.png",
      "category": "freelancers"
    },
  ];

  final TextEditingController _searchController = TextEditingController();

  Future<List<Map<String, String>>> _fetchEmployeeSuggestions(
      String pattern) async {
    return jobCards.where((employee) {
      final name = employee["userName"]?.toLowerCase() ?? "";
      return name.contains(pattern.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.surface,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingSizes.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  top: true,
                  bottom: false,
                  child: const SizedBox(
                    height: PaddingSizes.medium,
                  ),
                ),
                const Text(
                  'Recruteren',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: PaddingSizes.extraSmall,
                ),
                TypeAheadField<Map<String, String>>(
                  suggestionsCallback: (pattern) async {
                    return await _fetchEmployeeSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          suggestion["profileImagePath"]!,
                          height: 21,
                          width: 21,
                        ),
                      ),
                      title: Text(
                        suggestion["userName"]!,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: TextStyles.labelSmall.fontSize,
                          fontWeight: TextStyles.labelSmall.fontWeight,
                          color: TextStyles.labelSmall.color,
                        ),
                      ),
                    );
                  },
                  onSelected: (Map<String, String> suggestion) async {
                    _searchController.text = suggestion["userName"]!;
                  },
                  builder: (context, controller, focusNode) {
                    _searchController.addListener(() {
                      if (_searchController.text != controller.text) {
                        controller.text = _searchController.text;
                      }
                    });
                    return Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex('#D9D9D9').withAlpha(51),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          cursorHeight: 20,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: TextStyles.labelSmall.fontSize,
                            fontWeight: TextStyles.labelSmall.fontWeight,
                            color: TextStyles.labelSmall.color,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Zoek een werknemer',
                            hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: TextStyles.labelSmall.fontSize,
                              fontWeight: TextStyles.labelSmall.fontWeight,
                              color: TextStyles.labelSmall.color,
                            ).copyWith(
                              color: HexColor.fromHex('#000000').withAlpha(84),
                            ),
                            border: InputBorder.none,
                            prefixIcon: Container(
                              width: 40,
                              height: double.infinity,
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: SvgIcon(
                                  JobrIcons.magnifyingGlass,
                                  size: 21,
                                  color: HexColor.fromHex('#999999'),
                                ),
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                          onChanged: (text) {
                            _searchController.text = text;
                          },
                        ),
                      ),
                    );
                  },
                ),
                _buildGridView(),
                const SizedBox(
                  height: PaddingSizes.medium,
                ),
                _buildFilterRow(theme),
                const SizedBox(
                  height: PaddingSizes.extraLarge,
                ),
                _buildJobrAISection(theme),
                const SizedBox(
                  height: PaddingSizes.medium,
                ),
              ],
            ),
          ),
          _buildJobrAISuggestions(),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: PaddingSizes.medium),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 10,
        childAspectRatio: 1.4,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildGridItem(items[index]);
      },
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        context.push(
          RecruitmentDetailScreen.employerRoute,
          extra: {
            'category': item["category"],
            'title': item["text"],
            'image': item["image"],
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: HexColor.fromHex('#F3F3F3'),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                height: 36,
                width: 36,
                item["image"]!,
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                item["text"]!,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRow(ThemeData theme) {
    return PrimaryButton(
      onTap: () {
        context.push(FilterScreen.employerRoute);
      },
      suffixIcon: Image.asset(
        height: 20,
        width: 20,
        "assets/images/recruteren/filter.png",
      ),
      buttonText: "Zoek met filters",
    );
  }

  Widget _buildJobrAISection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PaddingSizes.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                height: 20,
                width: 20,
                "assets/images/recruteren/jobrAI_suggesties.png",
              ),
              const SizedBox(width: 6),
              Text(
                "Jobr-AI suggesties",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => context.push(JobrAiSuggestionsScreen.employerRoute),
            child: Text(
              "Bekijk alle",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobrAISuggestions() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 350),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .37,
        child: ListView(
          padding: const EdgeInsets.all(
            PaddingSizes.large,
          ),
          scrollDirection: Axis.horizontal,
          children: List.generate(
            5,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: ClearInkWell(
                    onTap: () {
                      context.push(EmployProfileDisplayScreen.employerRoute);
                    },
                    child: CustomJobCard(
                      height: double.infinity,
                      descriptionPadding: 8,
                      isAICard: true,
                      description:
                          "Ik ben Yassine, 20 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste serv",
                      age: "20",
                      buttonColor: HexColor.fromHex('#3976FF'),
                      buttonText: "Chat starten",
                      onButtonPressed: () {
                        context.push(ChatPageScreen.employerRoute);
                      },
                      buttonIcon: JobrIcons.send,
                      location: "Brussel",
                      userName: "Yassine Vuran",
                      profileImagePath: "assets/images/images/image-3.png",
                      suggestionPercentage: "74",
                      showBottomText: false,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
