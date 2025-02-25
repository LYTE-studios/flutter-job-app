import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/data/models/vacancy.dart';
import 'package:jobr/features/Sollicitaties/recruitment_detail_screen.dart';
import 'package:jobr/features/chat/screens/chat_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_overview_screen.dart';
import 'package:jobr/features/job_listing/screens/vacatures/vacancy_info_page.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

class VacatureCard extends StatelessWidget {
  final Vacancy vacancy;

  const VacatureCard({super.key, required this.vacancy});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(VacancyInfoScreen.route);
      },
      child: Card(
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0, // Set elevation to 0 to remove shadow
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/images/images/kortrijk.png',
                // Replace with your image URL
                fit: BoxFit.cover,
                height: 130,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location and Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 4),
                          SvgIcon(
                            'assets/images/icons/location.svg',
                            color: Theme.of(context).primaryColor,
                            size: 17,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Kortrijk",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            " •",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[300],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            " 0,60km",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Job Title and Subtitle
                  Row(
                    children: [
                      // Logo
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blue,
                        child: Image.asset(
                            'assets/images/logos/brooklyn_kortrijk.png'),
                      ),
                      SizedBox(width: 12),
                      // Title and Subtitle
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kassa medewerker",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            "Brooklyn Kortrijk",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: PrimaryButton(
                          icon: SvgIcon(
                            'assets/images/icons/edit.svg',
                            color: Colors.grey,
                            size: 16,
                          ),
                          width: double.infinity,
                          buttonText: 'Aanpassen',
                          onTap: () {
                            context.push(
                              CreateJobListingOverviewScreen.route,
                              extra: Vacancy(),
                            );
                          },
                          borderRadius: 32,
                          height: 40,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          textColor: Colors.grey,
                          buttonColor: Colors.grey.shade200,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: PrimaryButton(
                          buttonText: ' 16 ',
                          onTap: () {
                            context.push(
                              RecruitmentDetailScreen.employerRoute,
                              extra: {
                                'category': '',
                                'title': 'Sollicitaties',
                                "image": "",
                              },
                            );
                          },
                          height: 39,
                          width: 80,
                          icon: Icon(Icons.people),
                          textColor: Colors.white,
                          buttonColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
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
