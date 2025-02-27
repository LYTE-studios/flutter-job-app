import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
// Add alias
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class SkillsInfoScreen extends StatefulWidget {
  static const String location = 'skills-info';

  static String employerRoute = JobrRouter.getRoute(
    '${SkillsInfoScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  static String employeeRoute = JobrRouter.getRoute(
    '$location',
    JobrRouter.employeeInitialroute,
  );
  const SkillsInfoScreen({super.key});

  @override
  State<SkillsInfoScreen> createState() => _SkillsInfoScreenState();
}

class _SkillsInfoScreenState extends State<SkillsInfoScreen> {
  final Map<List<String>, Color> items = {
    ['Geen', 'Geen ervaring']: HexColor.fromHex("#8A8989"),
    ['Starter', '0-1 jaar ervaring']: HexColor.fromHex("#000000"),
    ['⭐Ervaren', '1-3 jaar ervaring']: HexColor.fromHex("#F9AA16"),
    ['💎Expert', '>3 jaar ervaring']: HexColor.fromHex("#61C5FF"),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/icons/cross.svg',
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            height: 15,
            width: 15,
          ),
          onPressed: () {
            context.pop(context); // Pops the screen
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hoe werken de Jobr skill levels?',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ontdek in één oogopslag hoeveel ervaring iemand heeft op basis van hun werkervaring en skills.',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: items.entries.map((entry) {
                      return SkillCard(
                        label: entry.key[0],
                        subLabel: entry.key[1],
                        labelTextStyle: TextStyle(
                          color: entry.value, // Light grey text color
                          fontSize: 15.63, // Increase font size if selected
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: PrimaryButton(
              buttonText: '💡 Aha, top!',
              borderRadius: 30,
              onTap: () {
                context.pop(context);
              },
              buttonColor: theme.primaryColor,
              height: 55,
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final String label;
  final String subLabel;
  final TextStyle subLabelTextStyle = TextStyle(
    color: Colors.grey.shade500, // Light grey text color
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
  );

  final TextStyle labelTextStyle;

  SkillCard(
      {required this.label,
      required this.subLabel,
      this.labelTextStyle = const TextStyle(
        color: Color(0xFF9E9E9E), // Light grey text color
        fontSize: 15.63, // Increase font size if selected
        fontWeight: FontWeight.w600,
      ),
      super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Colors.grey.shade300, // Light grey border color
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 14.0,
                  width: 150.0,
                  color: Colors.grey.shade200, // Light grey color for the bar
                ),
                Text(
                  label,
                  style: labelTextStyle,
                ),
              ],
            ),
            SizedBox(height: 8.0), // Space between the top bar and the line
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.0,
            ),
            SizedBox(height: 8.0), // Space between the line and the content
            Row(
              children: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200, // Light grey background
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                SizedBox(width: 12.0), // Space between the square and text bars
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14.0,
                        width: MediaQuery.of(context).size.width,
                        color: Colors
                            .grey.shade200, // Light grey color for the bar
                      ),
                      SizedBox(height: 6.0), // Space between the bars
                      Container(
                        height: 14.0,
                        width: 300.0,
                        color: Colors
                            .grey.shade200, // Light grey color for the bar
                      ),
                      SizedBox(height: 6.0), // Space between the bars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 14.0,
                            width: 100.0,
                            color: Colors
                                .grey.shade200, // Light grey color for the bar
                          ),
// Space between the bar and text
                          Text(
                            '• $subLabel',
                            style: subLabelTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
