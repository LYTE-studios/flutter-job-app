import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/jobs/filter.dart';
import 'package:jobr/features/jobs/job_listing.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/features/jobs/widgets/return_arrow.dart';

class JobDetailScreen extends StatelessWidget {
  final String category;
  final String title;
  final String image;

  const JobDetailScreen({
    super.key,
    required this.category,
    required this.title,
    required this.image,
  });

  static const String location = 'category';

  static String employeeRoute = JobrRouter.getRoute(
    '${JobScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                context.push(FilterScreenEmployee.employeeRoute);
              },
              child: Container(
                child: Image.asset(
                  height: 22,
                  width: 22,
                  color: Colors.black,
                  "assets/images/recruteren/filter.png",
                ),
              ),
            ),
          ),
        ],
        leading: const ReturnArrow(),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(image, height: 20, width: 20),
            const SizedBox(width: 3),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterButton(label: "Nieuwste eerst"),
                SizedBox(width: 2),
                FilterButton(label: "€ Laag-Hoog"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
