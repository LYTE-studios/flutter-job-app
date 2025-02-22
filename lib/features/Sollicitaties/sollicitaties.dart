import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/Sollicitaties/widgets/job_cards.dart';
import 'package:jobr/features/jobs/jobdetail_screen.dart';
import 'package:jobr/features/jobs/widgets/job_card.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class SollicitatiesScreen extends StatefulWidget {
  static const String location = 'sollicitaties';

  const SollicitatiesScreen({super.key});

  @override
  State createState() => _SollicitatiesScreenState();
}

class _SollicitatiesScreenState extends State<SollicitatiesScreen> {
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
  ];

  // New state variable for toggle
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: JobrAppbarNavigation(
        appbarTitle: "Mijn sollicitaties",
        center: false,
        // Updated trailing icon to toggle on tap
        trailing: InkWell(
          onTap: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
          child: SvgPicture.asset(
            isLiked
                ? 'assets/images/icons/like_icon-pink.svg'
                : 'assets/images/icons/like_icon_grey.svg',
            width: 20,
            height: 20,
          ),
        ),
      ),
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(
                  height: 8), // Reduced spacing between grid and cards

              _buildGridView(),
              const SizedBox(
                  height: 14), // Reduced spacing between grid and cards
              const JobCardSollicitaties(
                backgroundImagePath: 'assets/images/recruteren/bekeken.png',
                location: 'Kortrijk',
                jobType: 'Bekeken',
                salaryText: '€15/uur',
                companyLogoPath: 'assets/images/recruteren/logo1.png',
                jobTitle: 'Kassa medewerker',
                companyName: 'Brooklyn Kortrijk',
                suggestionPercentage: '98%',
                suggestionIconPath:
                    'assets/images/recruteren/jobrAI_suggesties.png',
                isSalaryTextBlack: true,
              ),
              const JobCardSollicitaties(
                backgroundImagePath: 'assets/images/recruteren/0,80.png',
                location: 'Kortrijk',
                jobType: '0,80km',
                salaryText: 'n.v.t',
                companyLogoPath: 'assets/images/recruteren/logo2.png',
                jobTitle: 'Team leader',
                companyName: 'Barouche',
                suggestionPercentage: '85%',
                suggestionIconPath:
                    'assets/images/recruteren/jobrAI_suggesties.png',
                isJobTypeTextBlack: true,
              ),
              const JobCardSollicitaties(
                backgroundImagePath: 'assets/images/recruteren/2,32.png',
                location: 'Kortrijk',
                jobType: '2,32km',
                salaryText: 'Barema',
                companyLogoPath: 'assets/images/recruteren/logo3.png',
                jobTitle: 'Head of restaurant',
                companyName: 'Spicy Lemon',
                suggestionPercentage: '79%',
                suggestionIconPath:
                    'assets/images/recruteren/jobrAI_suggesties.png',
                isJobTypeTextBlack: true,
              ),
              const JobCardSollicitaties(
                backgroundImagePath: 'assets/images/recruteren/7,99.png',
                location: 'Gent',
                jobType: '7,99km',
                salaryText: '€14.50/uur',
                companyLogoPath: 'assets/images/recruteren/logo4.png',
                jobTitle: 'Winkel medewerker',
                companyName: 'Carrefour Express K...',
                suggestionPercentage: '67%',
                suggestionIconPath:
                    'assets/images/recruteren/jobrAI_suggesties.png',
                isSalaryTextBlack: true,
                isJobTypeTextBlack: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int crossAxisCount = constraints.maxWidth > 400 ? 5 : 4;
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true, // Added to constrain the height
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildGridItem(items[index], index: index);
          },
        );
      },
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item, {required index}) {
    return GestureDetector(
      onTap: index >= 7
          ? () {}
          : () {
              context.push(
                JobDetailScreen.employeeRoute,
                extra: {
                  'category': item["category"],
                  'title': item["text"],
                  'image': item["image"],
                },
              );
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
}
