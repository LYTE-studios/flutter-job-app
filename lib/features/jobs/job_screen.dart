import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/job_listing/screens/general/jobr_ai_suggestions_screen.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:jobr/ui/widgets/input/jobr_search_bar.dart';

class JobScreen extends StatefulWidget {
  static const String location = 'jobs';

  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  final List<Map<String, dynamic>> items = const [
    {
      "text": "Horeca",
      "image": "assets/images/jobs/Food Bar.png",
      "category": "permanent"
    },
    {
      "text": "Winkel",
      "image": "assets/images/jobs/Shopping Basket.png",
      "category": "students"
    },
    {
      "text": "Event",
      "image": "assets/images/jobs/Star grey.png",
      "category": "flexi"
    },
    {
      "text": "Telecom",
      "image": "assets/images/jobs/Phone grey.png",
      "category": "interns"
    },
    {
      "text": "Zorg",
      "image": "assets/images/jobs/Doctors Bag grey.png",
      "category": "freelancers"
    },
    {
      "text": "IT",
      "image": "assets/images/jobs/iMac grey.png",
      "category": "freelancers"
    },
    {
      "text": "Auto",
      "image": "assets/images/jobs/Car grey.png",
      "category": "freelancers"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const JobrAppbarNavigation(appbarTitle: "Vind jouw job"),
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const JobrSearchBar(
              hintText: "Zoek een bedrijf, functie...",
            ),
            const SizedBox(height: 14),
            _buildGridView(),
            const SizedBox(height: 10),
            _buildFilterRow(theme),
            const SizedBox(height: 20),
            _buildJobrAISection(theme),
            const SizedBox(height: 5),
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
      onTap: index >= 2
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
          color:
              index >= 2 ? Colors.black12.withOpacity(0.01) : Colors.grey[100],
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
                  color: (index >= 2) ? Colors.grey[500] : Colors.black,
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
        );
        // Push to FilterScreen
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              color: Colors.grey[400],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobrAISuggestions() {
    return Stack(
      clipBehavior: Clip.none, // Allow overflow
      children: [
        // Scrollable cards
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(5, (index) {
              return Container(
                width: 300,
                // Fixed width for uniformity
                height: 230,
                // Fixed height for uniformity
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100], // Light background color
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vervolledig je profiel om gebruik\nte maken van onze AI \nmatchmaking",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400], // Muted text color
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        // Navigate to the profile screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: BorderSide(
                          color: Colors.grey[200]!, // Set boundary color
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        "Ga naar profiel",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        // Static "Sector binnenkort beschikbaar" container
        Positioned(
          bottom: -20, // Move the container lower to show the button properly
          left: 40, // Adjust left position for smaller width
          right: 50, // Adjust right position for smaller width
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 7), // Adjust padding
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sector binnenkort beschikbaar ",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
                SvgPicture.asset(
                  'assets/images/icons/bell.svg',
                  color: Colors.pinkAccent,
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
