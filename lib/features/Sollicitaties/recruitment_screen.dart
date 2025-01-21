import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/chat/screens/chat_request_screen.dart';
import 'package:jobr/features/job_listing/screens/general/filter_screen.dart';
import 'package:jobr/features/Sollicitaties/recruitment_detail_screen.dart';
import 'package:jobr/features/profile/screens/widgets/custom_job_card.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/input/jobr_search_bar.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../job_listing/screens/general/jobr_ai_suggestions_screen.dart';

class RecruitmentScreen extends StatefulWidget {
  static const String location = 'sollicitaties';

  const RecruitmentScreen({super.key});

  @override
  State createState() => _RecruitmentScreenState();
}

class _RecruitmentScreenState extends State<RecruitmentScreen> {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PaddingSizes.medium,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: PaddingSizes.medium,
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
                  const JobrSearchBar(
                    hintText: 'Zoek op naam, school, andere zaken, ...',
                  ),
                  const SizedBox(
                    height: PaddingSizes.medium,
                  ),
                  _buildGridView(),
                  const SizedBox(
                    height: PaddingSizes.medium,
                  ),
                  _buildFilterRow(theme),
                  const SizedBox(
                    height: PaddingSizes.extraLarge * 1.5,
                  ),
                  _buildJobrAISection(theme),
                ],
              ),
            ),
            Expanded(
              child: _buildJobrAISuggestions(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
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
            const SizedBox(height: 8),
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
    return Row(
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
    );
  }

  Widget _buildJobrAISuggestions() {
    return SizedBox(
      height: 272,
      child: ListView(
        padding: const EdgeInsets.all(
          PaddingSizes.medium,
        ),
        scrollDirection: Axis.horizontal,
        children: List.generate(
          5,
          (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CustomJobCard(
                descriptionPadding: 8,
                isAICard: true,
                description:
                    "Ik ben Yassine, 20 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste serv",
                age: "20",
                buttonColor: HexColor.fromHex('#3976FF'),
                buttonText: "Chat starten",
                onButtonPressed: () {
                  context.push(ChatRequestScreen.employerRoute);
                },
                buttonIcon: JobrIcons.send,
                location: "Brussel",
                userName: "Yassine Vuran",
                profileImagePath: "assets/images/images/image-3.png",
                suggestionPercentage: "74",
                showBottomText: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
