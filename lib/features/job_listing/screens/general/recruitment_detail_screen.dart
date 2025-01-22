import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/chat/screens/chat_request_screen.dart';
import 'package:jobr/features/job_listing/screens/general/recruitment_screen.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';
import '../../../profile/screens/widgets/custom_job_card.dart';

class RecruitmentDetailScreen extends StatelessWidget {
  final String category;
  final String title;
  final String image;

  static const String location = 'recruitment/:category';

  static String employerRoute = JobrRouter.getRoute(
    '${RecruitmentScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  RecruitmentDetailScreen({
    super.key,
    required this.category,
    required this.title,
    required this.image,
  });

  // Sample data list
  final List<Map<String, String>> jobCards = [
    {
      "description":
          "Ik ben Yassine, 20 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste serv",
      "age": "20",
      "location": "Brussel",
      "userName": "Yassine Vuran",
      "profileImagePath": "assets/images/images/image-3.png",
      "suggestionPercentage": "74",
    },
    {
      "description":
          "Hallo, ik ben Sarah en ik zoek een uitdagende baan in de klantenservice",
      "age": "23",
      "location": "Antwerpen",
      "userName": "Sarah De Vries",
      "profileImagePath": "assets/images/images/image-4.png",
      "suggestionPercentage": "82",
    },
    {
      "description":
          "Marketing professional met 2 jaar ervaring in social media management",
      "age": "25",
      "location": "Gent",
      "userName": "Thomas Peeters",
      "profileImagePath": "assets/images/images/image-4.png",
      "suggestionPercentage": "68",
    },
    {
      "description": "Ervaren verkoper met passie voor klantenrelaties",
      "age": "28",
      "location": "Leuven",
      "userName": "Lisa Janssens",
      "profileImagePath": "assets/images/images/image-6.png",
      "suggestionPercentage": "79",
    },
    {
      "description": "IT specialist zoekend naar nieuwe uitdagingen",
      "age": "24",
      "location": "Hasselt",
      "userName": "Kevin Van Dam",
      "profileImagePath": "assets/images/images/image-7.png",
      "suggestionPercentage": "88",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JobrAppbarNavigation(
        canGoBack: true,
        appbarTitle: title,
        icon: Image.asset(
          image,
          height: 30,
          width: 30,
          fit: BoxFit.contain,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        itemCount: jobCards.length,
        separatorBuilder: (context, index) => const Divider(
          height: 10,
          color: Colors.transparent,
        ),
        itemBuilder: (context, index) {
          final card = jobCards[index];
          return CustomJobCard(
            description: card["description"]!,
            age: card["age"]!,
            buttonColor: HexColor.fromHex('#3976FF'),
            buttonText: "Chat starten",
            onButtonPressed: () {
              context.push(ChatRequestScreen.employerRoute);
            },
            buttonIcon: JobrIcons.send,
            showBottomText: true,
            location: card["location"]!,
            userName: card["userName"]!,
            profileImagePath: card["profileImagePath"]!,
            suggestionPercentage: card["suggestionPercentage"]!,
          );
        },
      ),
    );
  }
}
