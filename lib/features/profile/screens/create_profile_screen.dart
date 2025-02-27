import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/jobs/job_screen.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../ui/theme/jobr_icons.dart';
import 'forms/first_form.dart';
import 'forms/second_form.dart';

class CreateProfileScreen extends StatefulWidget {
  static const String location = 'create-profile';

  static String employeeRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employeeInitialroute,
  );

  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  int currentForm = 0;
  bool _isFirstFormValid = false; // track if first form is filled
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: currentForm == 1
            ? IconButton(
                onPressed: () {
                  controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: SvgPicture.asset(
                  JobrIcons.backArrow,
                  width: 21,
                  height: 21,
                ),
              )
            : null, // no icon for first form
        centerTitle: true,
        title: const Text(
          "Profiel maken",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              currentForm == 0
                  ? 'Algemene gegevens'
                  : 'Voeg een profielfoto toe',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            Divider(thickness: 1.48, color: Colors.grey[100]),
            Flexible(
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    currentForm = value;
                  });
                },
                controller: controller,
                children: [
                  FirstForm(
                    width: width,
                    onFormValidityChanged: (isValid) {
                      setState(() {
                        _isFirstFormValid = isValid;
                      });
                    },
                  ),
                  SecondForm(
                    width: width,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Center(
          child: SizedBox(
            width: width,
            height: 58,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: currentForm == 0
                    ? (_isFirstFormValid
                        ? theme.primaryColor
                        : HexColor.fromHex('#DADADA'))
                    : theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onPressed: () {
                if (currentForm == 0) {
                  if (_isFirstFormValid) {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                } else {
                  context.pushReplacement(
                    JobrRouter.getRoute(
                      JobScreen.location,
                      JobrRouter.employeeInitialroute,
                    ),
                  );
                }
              },
              child: const Text(
                "Toon resultaten",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
