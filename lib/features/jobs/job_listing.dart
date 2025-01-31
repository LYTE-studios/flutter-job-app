import 'package:flutter/material.dart';
import 'package:jobr/features/jobs/widgets/job_card.dart';
import 'package:jobr/features/jobs/widgets/return_arrow.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

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
            horizontal: 8, vertical: 1), // Reduce padding inside the button
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).primaryColor, width: 1.3), // Pink border
          borderRadius: BorderRadius.circular(20),
          color: Colors.white, // White background
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).primaryColor,
              size: 25, // Slightly smaller icon
            ),
          ],
        ),
      ),
    );
  }
}
