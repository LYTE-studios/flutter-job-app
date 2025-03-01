import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/job_listing/screens/general/jobr_ai_suggestions_screen.dart';
import 'package:jobr/features/jobs/jobdetail_screen.dart';
import 'package:jobr/features/profile/screens/edit/choose_sector_screen.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:jobr/ui/widgets/input/jobr_search_bar.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:jobr/features/jobs/filter.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

class JobVerifiedScreen extends StatefulWidget {
  static const String location = 'jobs';

  const JobVerifiedScreen({super.key});

  @override
  State<JobVerifiedScreen> createState() => _JobVerifiedScreenState();
}

class _JobVerifiedScreenState extends State<JobVerifiedScreen> {
  // Add a controller for the search text field:
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> jobCards = [
    {
      "isLiked": "true",
      "backgroundImagePath": "assets/images/recruteren/bekeken.png",
      "location": "Kortrijk",
      "jobType": "Bekeken",
      "salaryText": "€15/uur",
      "companyLogoPath": "assets/images/recruteren/logo1.png",
      "jobTitle": "Kassa medewerker",
      "companyName": "Brooklyn Kortrijk",
      "suggestionPercentage": "98%",
      "suggestionIconPath": "assets/images/recruteren/jobrAI_suggesties.png",
      "isSalaryTextBlack": "true",
    },
    {
      "backgroundImagePath": "assets/images/recruteren/bekeken.png",
      "location": "Kortrijk",
      "jobType": "Bekeken",
      "salaryText": "€15/uur",
      "companyLogoPath": "assets/images/recruteren/logo1.png",
      "jobTitle": "Kassa medewerker",
      "companyName": "Brooklyn Kortrijk",
      "suggestionPercentage": "98%",
      "suggestionIconPath": "assets/images/recruteren/jobrAI_suggesties.png",
      "isSalaryTextBlack": "true",
    },
    {
      "backgroundImagePath": "assets/images/recruteren/0,80.png",
      "location": "Kortrijk",
      "jobType": "0,80km",
      "salaryText": "n.v.t",
      "companyLogoPath": "assets/images/recruteren/logo2.png",
      "jobTitle": "Team leader",
      "companyName": "Barouche",
      "suggestionPercentage": "85%",
      "suggestionIconPath": "assets/images/recruteren/jobrAI_suggesties.png",
      "isJobTypeTextBlack": "true",
    },
    {
      "backgroundImagePath": "assets/images/recruteren/2,32.png",
      "location": "Kortrijk",
      "jobType": "2,32km",
      "salaryText": "Barema",
      "companyLogoPath": "assets/images/recruteren/logo3.png",
      "jobTitle": "Head of restaurant",
      "companyName": "Spicy Lemon",
      "suggestionPercentage": "79%",
      "suggestionIconPath": "assets/images/recruteren/jobrAI_suggesties.png",
      "isJobTypeTextBlack": "true",
    },
    {
      "backgroundImagePath": "assets/images/recruteren/7,99.png",
      "location": "Gent",
      "jobType": "7,99km",
      "salaryText": "€14.50/uur",
      "companyLogoPath": "assets/images/recruteren/logo4.png",
      "jobTitle": "Winkel medewerker",
      "companyName": "Carrefour Express K...",
      "suggestionPercentage": "67%",
      "suggestionIconPath": "assets/images/recruteren/jobrAI_suggesties.png",
      "isSalaryTextBlack": "true",
      "isJobTypeTextBlack": "true",
    },
  ];

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

  // Added state variable for like status
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // Removed const to allow dynamic values
      appBar: JobrAppbarNavigation(
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
        appbarTitle: "Vind jouw job",
        center: false, // Added to match JobScreen
      ),
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          // Added for vertical scrolling
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingSizes.medium * 1.5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Replace the JobrSearchBar with a TypeAheadField:
                TypeAheadField<Map<String, String>>(
                  suggestionsCallback: (pattern) async {
                    return jobCards.where((company) {
                      final companyName =
                          company["companyName"]?.toLowerCase() ?? "";
                      return companyName.contains(pattern.toLowerCase());
                    }).toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Image.asset(
                        suggestion["companyLogoPath"]!,
                        height: 21,
                        width: 21,
                      ),
                      title: Text(
                        suggestion["companyName"]!,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: TextStyles.labelSmall.fontSize,
                          fontWeight: TextStyles.labelSmall.fontWeight,
                          color: TextStyles.labelSmall.color,
                        ),
                      ),
                    );
                  },
                  onSelected: (Map<String, String> suggestion) {
                    _searchController.text = suggestion["companyName"]!;
                    // Optionally refresh the view based on the selection.
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
                            hintText: 'Zoek een bedrijf, functie...',
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
                const SizedBox(height: 14),
                _buildGridView(),
                const SizedBox(height: 10),
                _buildFilterRow(theme),
                const SizedBox(height: 23),
                _buildJobrAISection(theme),
                const SizedBox(height: 20),
                _buildJobrAISuggestions(),
                const SizedBox(height: 15),
              ],
            ),
          ),
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
          ? () {
              context.push(ChooseSectorScreen.route, extra: true);
            }
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
                height: 36,
                width: 36,
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
    return PrimaryButton(
      onTap: () {
        context.push(FilterScreenEmployee.employeeRoute);
      },
      suffixIcon: Image.asset(
        height: 23,
        width: 23,
        "assets/images/recruteren/filter.png",
      ),
      height: 50,
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
              height: 23,
              width: 23,
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
              fontSize: 16.55,
              fontWeight: FontWeight.w600,
              color: theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobrAISuggestions() {
    return Transform.scale(
      scaleX: 1.1,
      scaleY: 1.1,
      child: Transform.translate(
        offset: const Offset((PaddingSizes.medium * 1.5), 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildJobCard(),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildJobCard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height * 0.27,
      // Adjust card width as needed
      padding: const EdgeInsets.all(18),
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
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
              children: [
                const TextSpan(
                  text: 'goed bij je, dankzij je ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: 'horeca-ervaring ',
                  style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                      fontWeight: FontWeight.w500),
                ),
                const TextSpan(
                  text: 'en sterke ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: 'klantgerichtheid.',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      letterSpacing: 0.2),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Job Title and Suggestion Percentage
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 53, // double the radius for the container width
                  height: 55, // double the radius for the container height
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Kurkumama group',
                      style: TextStyle(color: Colors.grey, fontSize: 16.79),
                    ),
                  ],
                ),
                const Spacer(),
                // Suggestion Percentage
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        height: 20,
                        width: 20,
                        "assets/images/recruteren/jobrAI_suggesties.png",
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '98%',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
