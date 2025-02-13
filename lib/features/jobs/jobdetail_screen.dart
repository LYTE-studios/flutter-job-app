import 'package:flutter/material.dart';
import 'package:jobr/features/jobs/job_listing.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              child: Image.asset(
                height: 20,
                width: 20,
                color: Colors.black,
                "assets/images/recruteren/filter.png",
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
                fontSize: 18,
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
                FilterButton(label: "€ Laag-Hoog"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
