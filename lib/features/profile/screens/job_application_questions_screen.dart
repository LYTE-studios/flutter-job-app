import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../ui/theme/jobr_icons.dart';
import '../../dashboard/base/base_dashboard_screen.dart';

class JobApplicationQuestionsScreen extends StatefulWidget {
  static const String route = '${BaseEmployeeDashboard.route}/$location';
  static const String location = 'job-application-questions';
  const JobApplicationQuestionsScreen({super.key});

  @override
  State<JobApplicationQuestionsScreen> createState() =>
      _JobApplicationQuestionsScreenState();
}

class _JobApplicationQuestionsScreenState
    extends State<JobApplicationQuestionsScreen> {
  List<String> questionOne = ['Ja', 'Nee'];
  int selectedAnswerQuestionOne = 0;
  List<String> questionTwo = ['Ja', 'Nee'];
  int selectedAnswerQuestionTwo = 1;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              JobrIcons.backArrow,
              width: 21,
              height: 21,
            ),
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        children: [
          const Text(
            "Jouw sollicitatie",
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Voor we je sollicitatie kunnen finaliseren, heeft Barouche nog enkele vragen voor je.",
            style: TextStyle(
              fontSize: 14.5,
              fontFamily: 'Inter',
              color: HexColor.fromHex('#6D6D6D'),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: HexColor.fromHex('#00000000').withOpacity(.03),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Kan je een plateau dragen met 1 hand?",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                FittedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#ECECEC'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        questionOne.length,
                        (index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedAnswerQuestionOne = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.84, vertical: 5.25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.34),
                              color: selectedAnswerQuestionOne == index
                                  ? theme.primaryColor
                                  : null,
                            ),
                            child: Text(
                              questionOne[index],
                              style: TextStyle(
                                fontSize: 16.79,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: selectedAnswerQuestionOne == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: HexColor.fromHex('#00000000').withOpacity(.03),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Vind je het fijn om af te kunnen wisselen tussen bar en de zaal?",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                FittedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#ECECEC'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        questionTwo.length,
                        (index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedAnswerQuestionTwo = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.84, vertical: 5.25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.34),
                              color: selectedAnswerQuestionTwo == index
                                  ? theme.primaryColor
                                  : null,
                            ),
                            child: Text(
                              questionTwo[index],
                              style: TextStyle(
                                fontSize: 16.79,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: selectedAnswerQuestionTwo == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        color: theme.colorScheme.surface,
        elevation: 10,
        shadowColor: HexColor.fromHex('#DDDFE540'),
        child: Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 50,
                child: FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      backgroundColor: HexColor.fromHex('#3A77FF')),
                  icon: SvgPicture.asset(
                    JobrIcons.plane,
                    width: 15,
                    height: 19,
                    colorFilter: ColorFilter.mode(
                      HexColor.fromHex('#FFFFFF'),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: const Text(
                    'Sollicitatie versturen',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.3,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
