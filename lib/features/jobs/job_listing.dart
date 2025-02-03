import 'package:flutter/material.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/jobs/filter.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/features/jobs/widgets/job_card.dart';
import 'package:jobr/features/jobs/widgets/return_arrow.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobListScreen extends StatelessWidget {
  static final String location = 'job-list';

  JobListScreen({super.key});

  static String employeeRoute = JobrRouter.getRoute(
    '${JobScreen.location}/${FilterScreenEmployee.location}/$location',
    JobrRouter.employeeInitialroute,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const ReturnArrow(),
        centerTitle: true,
        title: const Text(
          "Zoekresultaten",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              height: 20,
              width: 20,
              color: Colors.black,
              "assets/images/recruteren/filter.png",
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter buttons
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterButton(label: "Nieuwste eerst"),
                FilterButton(label: "€ Laag-Hoog"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Job cards
          Expanded(
            child: ListView.builder(
              itemCount: 1, // Replace with dynamic count
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: JobCard(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;

  const FilterButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 4.0), // Reduce padding around the button
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 2), // Reduce padding inside the button
        decoration: BoxDecoration(
          border: Border.all(
              color: HexColor.fromHex('#FF3E68'), width: 1.3), // Pink border
          borderRadius: BorderRadius.circular(20),
          color: Colors.white, // White background
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: HexColor.fromHex('#FF3E68'),
                fontWeight: FontWeight.w500,
                fontSize: 15.45,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              color: HexColor.fromHex('#FF3E68'),
              size: 25, // Slightly smaller icon
            ),
          ],
        ),
      ),
    );
  }
}
