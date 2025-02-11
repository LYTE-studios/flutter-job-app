import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/chat/screens/employer/chat_page_screen.dart';
import 'package:jobr/features/Sollicitaties/recruitment_screen.dart';
import 'package:jobr/features/profile/screens/widgets/custom_job_card.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobrAiSuggestionsScreen extends StatelessWidget {
  static const String location = 'ai-suggestions';

  static String employerRoute = JobrRouter.getRoute(
    '${RecruitmentScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  const JobrAiSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> jobSuggestions = [
      {
        "userName": "Louis Ottevaere",
        "location": "Antwerpen",
        "age": "30",
        "description":
            "Ik ben Louis, 30 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste service geven.",
        "profileImagePath": "assets/images/images/image.png",
        "suggestionPercentage": "90",
      },
      {
        "userName": "Yassine Vuran",
        "location": "Brussel",
        "age": "20",
        "description":
            "Ik ben Yassine, 20 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste service geven.",
        "profileImagePath": "assets/images/images/image-3.png",
        "suggestionPercentage": "74",
      },
      {
        "userName": "Laurence Van Meerhaege",
        "location": "Kortrijk",
        "age": "29",
        "description":
            "Ik ben Laurence, 29 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste service geven.",
        "profileImagePath": "assets/images/images/image-9.png",
        "suggestionPercentage": "88",
      },
    ];

    return Scaffold(
      appBar: const JobrAppbarNavigation(
        appbarTitle: 'Jobr-AI suggesties',
        canGoBack: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        separatorBuilder: (context, index) => const Divider(
          height: 10,
          color: Colors.transparent,
        ),
        itemCount: jobSuggestions.length,
        itemBuilder: (context, index) {
          final suggestion = jobSuggestions[index];
          return CustomJobCard(
            userName: suggestion["userName"]!,
            location: suggestion["location"]!,
            age: suggestion["age"]!,
            description: suggestion["description"]!,
            profileImagePath: suggestion["profileImagePath"]!,
            suggestionPercentage: suggestion["suggestionPercentage"]!,
            buttonColor: HexColor.fromHex('#3976FF'),
            buttonText: "Chat starten",
            onButtonPressed: () {
              context.push(ChatPageScreen.employerRoute);
            },
            descriptionPadding: 15,
            buttonIcon: JobrIcons.send,
            showBottomText: true,
          );
        },
      ),
    );
  }
}
