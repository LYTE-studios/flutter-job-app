import 'package:flutter/material.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:jobr/features/job_listing/screens/create/shared/base_create_job_listing_screen.dart';

class AvailabilityScreen extends StatefulWidget {
  static const String location = 'availability';

  static String employeeRoute = JobrRouter.getRoute(
    '${ProfileScreen.location}/$location', // changed to "jobs/filter"
    JobrRouter.employeeInitialroute,
  );
  final List<String> initialDays; // now contains IDs

  const AvailabilityScreen({Key? key, required this.initialDays})
      : super(key: key);

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  late List<String> selectedDays;
  final List<Map<String, String>> dayData = [
    {'id': 'M', 'label': 'M'},
    {'id': 'D1', 'label': 'D'},
    {'id': 'W', 'label': 'W'},
    {'id': 'D2', 'label': 'D'},
    {'id': 'V', 'label': 'V'},
    {'id': 'Z1', 'label': 'Z'},
    {'id': 'Z2', 'label': 'Z'},
  ];

  @override
  void initState() {
    super.initState();
    // Directly assign the received IDs instead of mapping from labels
    selectedDays = List.from(widget.initialDays);
  }

  List<String> _getSelectedLabels() {
    List<String> labels = [];
    for (var day in dayData) {
      if (selectedDays.contains(day['id']!) && !labels.contains(day['label'])) {
        labels.add(day['label']!);
      }
    }
    return labels;
  }

  @override
  Widget build(BuildContext context) {
    return BaseCreateJobListingScreen(
      title: 'Beschikbaarheid',
      showProgressBar: false,
      buttonLabel: 'Opslaan',
      isNavigationEnabled: true,
      onNavigate: () => Navigator.pop(context, selectedDays),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Voor welke dagen zoek je iemand?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (var dayMap in dayData)
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedDays.contains(dayMap['id'])
                          ? selectedDays.remove(dayMap['id'])
                          : selectedDays.add(dayMap['id']!);
                    });
                  },
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: selectedDays.contains(dayMap['id'])
                        ? Colors.red[100]
                        : const Color(0xFFF5F5F5),
                    child: Text(
                      dayMap['label']!,
                      style: TextStyle(
                        color: selectedDays.contains(dayMap['id'])
                            ? Colors.red
                            : const Color(0xFFCECECE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
