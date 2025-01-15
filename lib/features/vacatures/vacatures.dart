import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';

class VacaturesPage extends StatelessWidget {
  static const String location = 'vacancies';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // Remove AppBar height
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mijn vacatures',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Bekijk al je vacatures en chat met sollicitanten',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push(
                    CreateJobListingGeneralScreen.employerRoute,
                  );
                  // Action for "Nieuwe vacature" button
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30, // Increased icon size
                ),
                label: Text(
                  'Nieuwe vacature',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold), // Increased font size
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.pink[500],
                  padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8), // Increased padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade100.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, color: Colors.red.withOpacity(0.9)),
                    SizedBox(width: 4),
                    Text(
                      'Vacature verwijderd',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
