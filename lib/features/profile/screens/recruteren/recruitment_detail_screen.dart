import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';
import '../widgets/custom_job_card.dart';

class RecruitmentDetailScreen extends StatelessWidget {
  final String category;
  final String title;
  final String image;

  RecruitmentDetailScreen(
      {super.key,
      required this.category,
      required this.title,
      required this.image});

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Image.asset(
                    height: 15,
                    width: 15,
                    "assets/images/icons/cross_icon.png",
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    image,
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
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
              buttonIcon: JobrIcons.send,
              showBottomText: true,
              location: card["location"]!,
              userName: card["userName"]!,
              onButtonPressed: () {},
              profileImagePath: card["profileImagePath"]!,
              suggestionPercentage: card["suggestionPercentage"]!,
            );
          },
        ),
      ),
    );
  }
}
