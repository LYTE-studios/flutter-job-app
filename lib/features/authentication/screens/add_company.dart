import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/features/authentication/screens/login_screen.dart';

import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';

class NewCompanyPage extends StatefulWidget {
  static String employerRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employerInitialroute,
  );

  static String employeeRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employeeInitialroute,
  );

  static const String location = 'NewCompanyPage';
  final UserType userType;

  const NewCompanyPage({Key? key, required this.userType}) : super(key: key);

  @override
  _NewCompanyPageState createState() => _NewCompanyPageState();
}

class _NewCompanyPageState extends State<NewCompanyPage> {
  TextEditingController btwController = TextEditingController();
  FocusNode btwFocusNode = FocusNode(); // Add FocusNode to track focus state.
  bool isBtwValid = false;
  bool isBtwFilled = false;

  void gotoMainPage() async {
    try {
      switch (widget.userType) {
        case UserType.employee:
          context.go(
            JobrRouter.getRoute(
              JobScreen.location,
              JobrRouter.employeeInitialroute,
            ),
          );
          break;
        case UserType.employer:
          context.go(
            JobrRouter.getRoute(
              JobListingsScreen.location,
              JobrRouter.employerInitialroute,
            ),
          );
          break;
      }
    } catch (e) {
      return;
    }

    if (widget.userType == UserType.employee) {
      context.go(
        JobrRouter.getRoute(
          JobScreen.location,
          JobrRouter.employeeInitialroute,
        ),
      );
    } else {
      context.go(
        JobrRouter.getRoute(
          JobListingsScreen.location,
          JobrRouter.employerInitialroute,
        ),
      );
    }

    return;
  }

  @override
  void initState() {
    super.initState();
    btwController.addListener(_validateBtwField);
    btwFocusNode.addListener(() {
      setState(() {}); // Update the UI when the focus state changes.
    });
  }

  final RegExp btwRegex = RegExp(r'^BE \d{4}\.\d{3}\.\d{3}$');

  void _validateBtwField() {
    setState(() {
      String text = btwController.text;
      isBtwFilled = text.isNotEmpty;
      isBtwValid = btwRegex.hasMatch(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            JobrIcons.chevronLeftIcon,
            color: Colors.black,
          ),
          onPressed: () {
            gotoMainPage();
          },
        ),
        title: Text(
          'Nieuw bedrijf',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'BTW nummer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    TextFormField(
                      focusNode: btwFocusNode, // Attach FocusNode
                      cursorColor: Colors.pinkAccent.withOpacity(0.5),
                      cursorHeight: 25,
                      controller: btwController,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: btwFocusNode.hasFocus &&
                                  btwController.text.isEmpty
                              ? Colors.pink.withOpacity(0.7)
                              : Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        hintText: 'BE 0000.000.000',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        suffixIcon: isBtwFilled
                            ? Icon(
                                isBtwValid ? Icons.check_circle : Icons.cancel,
                                color: isBtwValid ? Colors.green : Colors.red,
                              )
                            : null,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: btwFocusNode.hasFocus &&
                                    btwController.text.isEmpty
                                ? Colors.red
                                : Colors.grey.shade400,
                            width: 1,
                          ),
                        ),
                        filled: true,
                        fillColor:
                            btwFocusNode.hasFocus && btwController.text.isEmpty
                                ? Colors.red.shade50.withOpacity(0.4)
                                : Colors.grey.shade100,
                      ),
                    ),
                    if (isBtwValid) ...[
                      SizedBox(height: 15),
                      TextField(
                        cursorHeight: 22,
                        textAlignVertical: TextAlignVertical
                            .center, // Align text to vertical center
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          hintText: 'Nude BV',
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 17, // Center text vertically
                            horizontal: 15, // Keep horizontal padding
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 5),
                      child: Text(
                          'We vragen je BTW nummer om te verifiëren dat het gaat om een bestaand bedrijf. Onderstaande gegevens worden dan ook automatisch ingevuld.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Algemene gegevens',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 7),
                            Divider(
                              color: Colors.grey.shade100,
                              thickness: 1,
                            ),
                            buildInputField('Naam', 'bv. Carrefour'),
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Adres',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: buildInputField(null, 'Straatnaam'),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: buildInputField(null, 'Nummer'),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: buildInputField(null, 'Stad'),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: buildInputField(null, 'Postcode'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (!isBtwValid)
                          Positioned.fill(
                            child: ClipRRect(
                              // Rounded corners
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 2.0, sigmaY: 1.5),
                                child: Container(
                                  color: Colors.white
                                      .withOpacity(0.4), // Adjusted color layer
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: PrimaryButton(
                borderRadius: 55,
                onTap: gotoMainPage,
                buttonText: 'Volgende stap',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String? label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Naam',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 5),
        TextFormField(
          cursorHeight: 22, // Match cursor height with font size
          textAlignVertical: TextAlignVertical.center, // Align text vertically
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            hintText: placeholder,
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(
              vertical: 15, // Ensure proper vertical alignment
              horizontal: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    btwController.dispose();
    btwFocusNode.dispose(); // Dispose FocusNode to prevent memory leaks.
    super.dispose();
  }
}
