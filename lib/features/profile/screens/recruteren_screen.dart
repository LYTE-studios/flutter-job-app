import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/dashboard/base/base_dashboard_screen.dart';
import 'package:jobr/features/profile/screens/widgets/custom_job_card.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/widget/common_appbar_navigation.dart';
import 'package:jobr/ui/widget/common_search_bar.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import 'recruteren/jobr_ai_suggestions_screen.dart';

class RecruterenScreen extends StatefulWidget {
  static const String route = '${BaseDashboardScreen.route}/$location';
  static const String location = 'sollicitaties';

  const RecruterenScreen({super.key});

  @override
  State createState() => _RecruterenScreenState();
}

class _RecruterenScreenState extends State<RecruterenScreen> {
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
      appBar: const CommonAppbarNavigation(appbarTitle: "Recruteren"),
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CommonSearchBar(
              hintText: 'Zoek op naam, school, andere zaken, ...',
            ),
            _buildGridView(),
            _buildFilterRow(theme),
            const SizedBox(height: 20),
            _buildJobrAISection(theme),
            _buildJobrAISuggestions(),
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
          '/recruitment/${item["category"]}',
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Zoek met filters ",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            Image.asset(
              height: 20,
              width: 20,
              "assets/images/recruteren/filter.png",
            ),
          ],
        ),
      ),
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
          onTap: () => context.push(JobrAiSuggestionsScreen.route),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CustomJobCard(
              description:
                  "Ik ben Yassine, 20 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste serv",
              age: "20",
              buttonColor: HexColor.fromHex('#3976FF'),
              buttonText: "Chat starten",
              buttonIcon: JobrIcons.send,
              location: "Brussel",
              userName: "Yassine Vuran",
              onButtonPressed: () {},
              profileImagePath: "assets/images/images/image-3.png",
              suggestionPercentage: "74",
              showBottomText: false,
            ),
          );
        }),
      ),
    );
  }
}
