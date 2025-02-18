import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';

class FillChoiceForm extends StatefulWidget {
  static const String location = 'fill-choice-form';
static String route = JobrRouter.getRoute(
    '${ProfileScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );
  final String? selectedText; // new field for passed text
  const FillChoiceForm({super.key, this.selectedText});

  @override
  State<FillChoiceForm> createState() => _FillChoiceFormState();
}

class _FillChoiceFormState extends State<FillChoiceForm> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              JobrIcons.close,
              width: 15,
              height: 15,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Jouw antwoord",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Added scrollable container
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#F8F8F8'),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SvgPicture.asset(
                      JobrIcons.blockquote,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.selectedText ?? 'Ik haal mijn energie uit...',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10), // Space between text and input
              // Updated TextFormField container with increased size and cursor adjustments
              Container(
                width: width,
                height: 200, // increased height
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#F8F8F8'),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: TextFormField(
                  maxLines: null,
                  cursorWidth: 2, // increased cursor width
                  cursorHeight: 24, // increased cursor height
                  style: const TextStyle(
                    fontSize: 16, // reasonable font size
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: "Jouw antwoord...",
                    hintStyle: const TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFB7B7B7)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: FilledButton(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(65),
              ),
              backgroundColor: HexColor.fromHex("#FF3E68"),
            ),
            onPressed: () {
              // Handle confirmation action
            },
            child: const Text(
              'Bevestigen',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 17.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
