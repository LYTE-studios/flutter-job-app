import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../dashboard/base/base_dashboard_screen.dart';
import 'forms/first_form.dart';
import 'forms/second_form.dart';

class CreateProfileScreen extends StatefulWidget {
  static const String route = '${BaseDashboardScreen.route}/$location';
  static const String location = 'create-profile';
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  int currentForm = 0;
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
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
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 20),
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
                  ),
                  SecondForm(
                    width: width,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: width,
              height: 58,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: currentForm == 1
                      ? theme.primaryColor
                      : HexColor.fromHex('#DADADA'),
                ),
                onPressed: () {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text(
                  "Toon resultaten",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
