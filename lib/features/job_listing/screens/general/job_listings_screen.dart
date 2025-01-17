import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/job_listing/screens/create/create_job_listing_general_screen.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';

class JobListingsScreen extends StatelessWidget {
  static const String location = 'vacancies';

  const JobListingsScreen({super.key});

  Widget buildEmtpyState(BuildContext context) {
    return Center(
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
              fontSize: 18, fontWeight: FontWeight.bold), // Increased font size
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          JobrAppbarNavigation(
            appbarTitle: "Mijn vacatures",
            description: "Bekijk al je vacatures en chat met sollicitanten",
            canGoBack: false,
            center: false,
          ),
          Expanded(child: buildEmtpyState(context)),
        ],
      ),
      //  Column(
      //   children: [
      //     // Padding(
      //     //   padding: const EdgeInsets.all(16.0),
      //     //   child: Container(
      //     //     decoration: BoxDecoration(
      //     //       color: Colors.red.shade100.withOpacity(0.4),
      //     //       borderRadius: BorderRadius.circular(30),
      //     //     ),
      //     //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      //     //     child: Row(
      //     //       mainAxisSize: MainAxisSize.min,
      //     //       children: [
      //     //         Icon(Icons.check, color: Colors.red.withOpacity(0.9)),
      //     //         SizedBox(width: 4),
      //     //         Text(
      //     //           'Vacature verwijderd',
      //     //           style: TextStyle(
      //     //             fontSize: 16,
      //     //             fontWeight: FontWeight.bold,
      //     //             color: Colors.red.withOpacity(0.9),
      //     //           ),
      //     //         ),
      //     //       ],
      //     //     ),
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}
