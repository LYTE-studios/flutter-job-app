import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/job_listing/screens/vacatures/vacancy_info_page.dart';

class DeleteVacancyPage extends StatelessWidget {
  static const String location = 'delete-vacancy';

  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/${VacancyInfoScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  const DeleteVacancyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/images/icons/cross.svg',
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Vacature verwijderen',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(height: 20),
              buildListTile(
                context,
                title: RichText(
                  text: TextSpan(
                    text: 'Ik heb ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'via Jobr',
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 16),
                      ),
                      TextSpan(
                        text: ' iemand gevonden voor deze vacature',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              buildDivider(),
              buildListTile(
                context,
                title: Text(
                  'Ik vind niemand voor deze vacature via Jobr',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
              buildDivider(),
              buildListTile(
                context,
                title: Text(
                  'Deze vacature is niet meer nodig',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
              buildDivider(),
              buildListTile(
                context,
                title: Text(
                  'Geen van bovenstaande',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
              buildDivider(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildListTile(BuildContext context, {required Widget title}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 17),
      title: title,
      trailing: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Icon(
          Icons.chevron_right,
          color: Colors.red.withOpacity(0.7),
          size: 30,
        ),
      ),
      onTap: () {
        _showDeleteDialog(context);
      },
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(height: 1, color: Colors.grey[100]),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Ben je zeker dat je deze \nvacature wilt verwijderen?',
                          textAlign: TextAlign.center,
                          maxLines: 8,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 29.0),
                          child: Text(
                            'Verwijderen is een permanente actie '
                            'en kan niet worden teruggedraaid',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Handle delete action
                            context.pop();
                            context.go(JobListingsScreen.employerRoute);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 14),
                          ),
                          child: Text(
                            'Vacature verwijderen',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/icons/cross.svg',
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
