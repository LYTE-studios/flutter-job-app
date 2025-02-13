import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/profile/screens/recruteren/jobr_ai_suggestions_screen.dart';
import 'package:jobr/ui/widget/common_appbar_navigation.dart';
import 'package:jobr/ui/widget/common_search_bar.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobVerifiedScreen extends StatefulWidget {
  static const String location = 'jobs';

  const JobVerifiedScreen({super.key});

  @override
  State<JobVerifiedScreen> createState() => _JobVerifiedScreenState();
}

class _JobVerifiedScreenState extends State<JobVerifiedScreen> {
  final List<Map<String, dynamic>> items = const [
    {
      "text": "Horeca",
      "image": "assets/images/jobs/Food Bar.png",
      "category": "permanent"
    },
    {
      "text": "Tech/ICT",
      "image": "assets/images/jobs/Shopping Basket.png",
      "category": "students"
    },
    {
      "text": "Event",
      "image": "assets/images/jobs/Star.png",
      "category": "flexi"
    },
    {
      "text": "Telecom",
      "image": "assets/images/jobs/Phone.png",
      "category": "interns"
    },
    {
      "text": "Zorg",
      "image": "assets/images/jobs/DoctorsBag.png",
      "category": "freelancers"
    },
    {
      "text": "IT",
      "image": "assets/images/jobs/iMac.png",
      "category": "freelancers"
    },
    {
      "text": "Auto",
      "image": "assets/images/jobs/Car.png",
      "category": "freelancers"
    },
    {
      "text": "Meer",
      "image": "assets/images/jobs/Vector.png",
      "category": "freelancers"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CommonAppbarNavigation(
        appbarTitle: "Vind jouw job",
      ),
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CommonSearchBar(
              hintText: "Zoek een bedrijf, functie...",
            ),
            const SizedBox(height: 14),
            _buildGridView(),
            const SizedBox(height: 10),
            _buildFilterRow(theme),
            const SizedBox(height: 20),
            _buildJobrAISection(theme),
            const SizedBox(height: 10),
            _buildJobrAISuggestions(),
            const SizedBox(height: 15),
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
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildGridItem(items[index], index: index);
      },
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item, {required index}) {
    return GestureDetector(
      onTap: index >= 7
          ? () {}
          : () {
              context.push(
                '/jobs/${item["category"]}',
                extra: {
                  'category': item["category"],
                  'title': item["text"],
                  'image': item["image"],
                },
              );
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                height: 30,
                width: 30,
                item["image"]!,
              ),
            ),
            const SizedBox(height: 5),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                item["text"]!,
                style: TextStyle(
                  color: index < 7 ? Colors.black : Colors.grey[500],
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
    return GestureDetector(
      onTap: () {
        context.push(
          '/jobs/filters',
        ); // Push to FilterScreen
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Zoek met filters ",
              style: TextStyle(
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
                fontSize: 16,
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
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.pink.withOpacity(0.8),
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
            padding: const EdgeInsets.only(right: 12),
            child: _buildJobCard(),
          );
        }),
      ),
    );
  }

  Widget _buildJobCard() {
    return Container(
      width: 300,
      height: 240,
      // Adjust card width as needed
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100], // Light background color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Rich Text Description
          RichText(
            text: TextSpan(
              text: 'Op basis van je profiel past deze barman-vacature',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              children: [
                const TextSpan(
                  text: 'goed bij je, dankzij je ',
                ),
                TextSpan(
                  text: 'horeca-ervaring ',
                  style: TextStyle(
                      color: Colors.pink.withOpacity(0.8),
                      fontWeight: FontWeight.w500),
                ),
                const TextSpan(
                  text: 'en sterke ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: 'klantgerichtheid.',
                  style: TextStyle(
                      color: Colors.pink.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 70),
          // Job Title and Suggestion Percentage
          Row(
            children: [
              // Profile Image
              Container(
                width: 50, // double the radius for the container width
                height: 50, // double the radius for the container height
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 10,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Image.asset(
                      'assets/images/jobs/sample_image.png'), // Replace with actual path
                ),
              ),
              const SizedBox(width: 12),
              // Job Title and Group
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bartender',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Kurkumama group',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              const Spacer(),
              // Suggestion Percentage
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.pinkAccent, width: 2),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      height: 20,
                      width: 20,
                      "assets/images/recruteren/jobrAI_suggesties.png",
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '98%',
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
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
