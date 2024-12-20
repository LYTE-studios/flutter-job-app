import 'package:flutter/material.dart';
import 'package:jobr/features/jobs/widgets/job_card.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context); // Pops the screen
          },
        ),
        centerTitle: true,
        title: const Text(
          "Zoekresultaten",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              child: Image.asset(
                height: 25,
                width: 25,
                color: Colors.black,
                "assets/images/recruteren/filter.png",
              ),
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
      padding: const EdgeInsets.all(4.0), // Reduce padding around the button
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 1), // Reduce padding inside the button
        decoration: BoxDecoration(
          border: Border.all(color: Colors.pink, width: 1.3), // Pink border
          borderRadius: BorderRadius.circular(20),
          color: Colors.white, // White background
        ),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.pink,
              size: 24, // Slightly smaller icon
            ),
          ],
        ),
      ),
    );
  }
}
