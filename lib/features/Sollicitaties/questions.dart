import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/Sollicitaties/sollicitaties.dart';
import 'package:jobr/features/Sollicitaties/sollicitaties_tabs_info.dart';
import 'package:jobr/features/chat/screens/employer/chat_request_page_screen.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.companyName});
  static const String location = 'questions';

  final String companyName;
  static String employeeRoute = JobrRouter.getRoute(
    '${SollicitatiesScreen.location}/${JobInfoScreen.location}/$location', // changed to "jobs/filter"
    JobrRouter.employeeInitialroute,
  );
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          '',
          style: TextStyle(
            fontSize: 24.2,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            JobrIcons.chevronLeftIcon,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            height: 16,
            width: 16,
          ),
          onPressed: () {
            Navigator.pop(context); // Pops the screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Jouw sollicitatie",
                      style: TextStyles.titleMedium.copyWith(fontSize: 25.91),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Voor we je sollicitatie kunnen finaliseren, heeft ${widget.companyName} nog enkele vragen voor je.',
                      style: TextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.1,
                          fontSize: 14.5,
                          color: HexColor.fromHex("#6D6D6D")),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  QuestionCard()
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 48,
            width: MediaQuery.of(context).size.width * 0.88,
            child: PrimaryButton(
              icon: SvgIcon(
                JobrIcons.send,
                size: 25,
                color: Colors.white,
              ),
              borderRadius: 25,
              buttonText: 'Sollicitatie versturen',
              onTap: () {
                context.push(
                  ChatRequestPageScreen.location,
                );
              },
              buttonColor: HexColor.fromHex('#3A77FF'),
              height: 45,
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  final Map<String, String> selectedAnswers = {
    'question0': 'Ja', // changed key
    'question1': 'Nee', // changed key
  };

  final List<String> questions = [
    "Kan je een plateau dragen met 1 hand?",
    "Vind je het fijn om af te kunnen wisselen tussen bar en de zaal?",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < questions.length; i++)
          _buildQuestion(
            question: questions[i],
            questionId: 'question$i', // changed for unique ID
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildQuestion(
      {required String question, required String questionId}) {
    return SizedBox(
      width: double.infinity, // ensures consistent width
      child: Card(
        color: HexColor.fromHex('#000000').withOpacity(0.03),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#ECECEC'),
                  borderRadius: BorderRadius.circular(10.49),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var answer in ['Ja', 'Nee'])
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAnswers[questionId] = answer;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                            color: selectedAnswers[questionId] == answer
                                ? HexColor.fromHex('#FF3E68')
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(7.34),
                          ),
                          child: Center(
                            child: Text(
                              answer,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: selectedAnswers[questionId] == answer
                                    ? Colors.white
                                    : Colors.grey,
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
        ),
      ),
    );
  }
}
