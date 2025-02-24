import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/chat/screens/employer/chat_page_screen.dart';
import 'package:jobr/features/Sollicitaties/recruitment_screen.dart';
import 'package:jobr/features/job_listing/screens/general/filter_screen.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../ui/theme/jobr_icons.dart';
import '../profile/screens/widgets/custom_job_card.dart';

class RecruitmentDetailScreen extends StatelessWidget {
  final String category;
  final String title;
  final String? image;

  static const String location = 'recruitment/:category';

  static String employerRoute = JobrRouter.getRoute(
    '${RecruitmentScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  RecruitmentDetailScreen({
    super.key,
    required this.category,
    required this.title,
    this.image = '',
  });

  // Sample data list
  final List<Map<String, String>> jobCards = [
    {
      "description":
          "Ik ben Yassine, 20 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste serv",
      "age": "20",
      "location": "Brussel",
      "userName": "Yassine Vuran",
      "profileImagePath": "assets/images/images/image.png",
      "suggestionPercentage": "74",
    },
    {
      "description":
          "Hallo, ik ben Sarah en ik zoek een uitdagende baan in de klantenservice",
      "age": "23",
      "location": "Antwerpen",
      "userName": "Sarah De Vries",
      "profileImagePath": "assets/images/images/image-3.png",
      "suggestionPercentage": "82",
    },
    {
      "description":
          "Marketing professional met 2 jaar ervaring in social media management",
      "age": "25",
      "location": "Gent",
      "userName": "Thomas Peeters",
      "profileImagePath": "assets/images/images/image-9.png",
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
    // Define a constant header height (adjust as necessary)
    const double headerHeight = 70.0;
    return Scaffold(
      appBar: JobrAppbarNavigation(
        trailing: IconButton(
          icon: SvgPicture.asset(
            "assets/images/icons/filter.svg", // Ensure the path is correct and uses .svg extension
            height: 20,
            width: 20,
          ),
          onPressed: () {
            context.push(
              FilterScreen.employerRoute,
            );
          },
        ),
        canGoBack: true,
        appbarTitle: title,
        appBarFontSize: 22,
        prefixIcon: (image != '')
            ? Image.asset(
                image!,
                height: 30,
                width: 30,
                fit: BoxFit.contain,
              )
            : Container(),
      ),
      body: (title == "Sollicitaties")
          ? Stack(
              children: [
                // Scrollable list with top padding to account for header widget and spacing
                ListView(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: HexColor.fromHex('#F5F5F5'),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                width: 45,
                                height: 45,
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  JobrIcons.placeholder1,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Brooklyn',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  Text(
                                    'Gent, Voorstraat',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          PrimaryButton(
                            buttonText: ' 16 ',
                            onTap: () {},
                            height: 39,
                            width: 80,
                            icon: Icon(Icons.people),
                            textColor: Colors.white,
                            buttonColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: PaddingSizes.medium,
                    ),
                    ...jobCards
                        .map(
                          (card) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: PaddingSizes.medium,
                            ),
                            child: CustomJobCard(
                              showLikeButton: (title == 'Sollicitaties'),
                              description: card["description"]!,
                              age: card["age"]!,
                              buttonColor: HexColor.fromHex('#3976FF'),
                              buttonText: "Chat starten",
                              onButtonPressed: () {
                                context.push(ChatPageScreen.employerRoute);
                              },
                              buttonIcon: JobrIcons.send,
                              showBottomText: true,
                              location: card["location"]!,
                              userName: card["userName"]!,
                              profileImagePath: card["profileImagePath"]!,
                              suggestionPercentage:
                                  card["suggestionPercentage"]!,
                            ),
                          ),
                        )
                        .toList(),
                    SafeArea(
                      top: false,
                      bottom: true,
                      child: const SizedBox(),
                    )
                  ],
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.all(16.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: jobCards.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    itemBuilder: (context, index) {
                      final card = jobCards[index];
                      return CustomJobCard(
                        showLikeButton: (title == 'Sollicitaties'),
                        description: card["description"]!,
                        age: card["age"]!,
                        buttonColor: HexColor.fromHex('#3976FF'),
                        buttonText: "Chat starten",
                        onButtonPressed: () {
                          context.push(ChatPageScreen.employerRoute);
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
                ],
              ),
            ),
    );
  }
}
