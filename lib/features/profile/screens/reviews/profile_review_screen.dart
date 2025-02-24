import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/chat/screens/employer/chat_page_screen.dart';
import 'package:jobr/features/Sollicitaties/recruitment_screen.dart';
import 'package:jobr/features/job_listing/screens/general/filter_screen.dart';
import 'package:jobr/features/profile/screens/employee_profile_screen_display.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:jobr/features/profile/screens/widgets/custom_job_card.dart';
import 'package:jobr/features/profile/screens/widgets/qr_code_widget.dart';
import 'package:jobr/features/profile/screens/widgets/review_card.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:flutter/services.dart';

class DisplayProfileReviews extends StatelessWidget {
  static const String location = 'profile_reviews';

  static String employeeRoute = JobrRouter.getRoute(
    '${ProfileScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );

  DisplayProfileReviews({
    super.key,
  });
  final Map<String, String> profilecard = {
    "description":
        "Ik ben Yassine, 20 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste serv",
    "category": "Horeca",
    "location": "Brussel",
    "userName": "Yassine Vuran",
    "profileImagePath": "assets/images/images/image.png",
    "suggestionPercentage": "74",
    "rating": "4.5",
    "role": "Keuken medewerker",
    "time_period": "2md geleden",
    "betrouwbaarheidRating": "4.0",
    "werkKwaliteit": "4.2",
    "professioneleAttitude": "4.3",
    "werklust": "4.5",
    "communicatie": "4.1",
  };
  // Sample data list
  final List<Map<String, String>> reviewCards = [
    {
      "description":
          "Ik ben Yassine, 20 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste serv",
      "category": "Horeca",
      "location": "Brussel",
      "userName": "Yassine Vuran",
      "profileImagePath": "assets/images/images/image.png",
      "suggestionPercentage": "74",
      "rating": "4.5",
      "role": "Keuken medewerker",
      "time_period": "2md geleden",
      "betrouwbaarheidRating": "4.0",
      "werkKwaliteit": "4.2",
      "professioneleAttitude": "4.3",
      "werklust": "4.5",
      "communicatie": "4.1",
    },
    {
      "description":
          "Hallo, ik ben Sarah en ik zoek een uitdagende baan in de klantenservice",
      "category": "Freelancers",
      "location": "Antwerpen",
      "userName": "Sarah De Vries",
      "profileImagePath": "assets/images/images/image-3.png",
      "suggestionPercentage": "82",
      "rating": "4.5",
      "role": "Keuken medewerker",
      "time_period": "2md geleden",
      "betrouwbaarheidRating": "4.1",
      "werkKwaliteit": "4.0",
      "professioneleAttitude": "4.2",
      "werklust": "4.3",
      "communicatie": "4.0",
    },
    {
      "description": "",
      "category": "Keuken medewerker",
      "location": "Gent",
      "userName": "Thomas Peeters",
      "profileImagePath": "assets/images/images/image-9.png",
      "suggestionPercentage": "68",
      "rating": "4.5",
      "role": "Keuken medewerker",
      "time_period": "2md geleden",
      "betrouwbaarheidRating": "4.2",
      "werkKwaliteit": "4.4",
      "professioneleAttitude": "4.3",
      "werklust": "4.2",
      "communicatie": "4.5",
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
        appbarTitle: 'Mijn reviews',
        appBarFontSize: 22,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: HexColor.fromHex('#F6F6F6'),
                ),
                padding: const EdgeInsets.all(12),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nodig bedrijven uit om je een review te geven!',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: HexColor.fromHex('#000000'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          PrimaryButton(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            buttonText: 'Mijn QR',
                            onTap: () {
                              _showQrCodeDialog(context, profilecard);
                            },
                            height: 39,
                            width: 110,
                            borderRadius: 55,
                            suffixIcon: SvgPicture.asset(JobrIcons.qrcode),
                            textColor: Colors.white,
                            buttonColor: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          PrimaryButton(
                            buttonText: 'Kopieer link',
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: 'www.lytestudios.com'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        JobrIcons.link,
                                        height: 20,
                                        width: 20,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Link gekopieerd naar klembord!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 16),
                                ),
                              );
                            },
                            height: 39,
                            width: 140,
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF656565)),
                            borderRadius: 55,
                            suffixIcon: SvgPicture.asset(JobrIcons.link),
                            buttonColor: Color(0xFFEAEAEA),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Mijn reviews',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: HexColor.fromHex('#000000'),
                          ),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviewCards.length,
                        separatorBuilder: (context, index) => const Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        itemBuilder: (context, index) {
                          final card = reviewCards[index];
                          return ReviewCard(
                            rating: double.parse(card["rating"]!),
                            description: card["description"]!,
                            category: card["category"]!,
                            location: card["location"]!,
                            userName: card["userName"]!,
                            profileImagePath: card["profileImagePath"]!,
                            role: card["role"]!,
                            timePeriod: card["time_period"]!,
                            onIconTap: () => _showReviewDialog(context, card),
                            // betrouwbaarheidRating:
                            //     double.parse(card["betrouwbaarheidRating"]!),
                            // werkKwaliteit: double.parse(card["werkKwaliteit"]!),
                            // professioneleAttitude:
                            //     double.parse(card["professioneleAttitude"]!),
                            // werklust: double.parse(card["werklust"]!),
                            // communicatie: double.parse(card["communicatie"]!),
                          );
                        },
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

  void _showQrCodeDialog(BuildContext context, Map<String, String> card) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // added for left alignment
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage(card["profileImagePath"]!),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // added for left alignment
                                children: [
                                  Text(
                                    'Algemene score',
                                    textAlign: TextAlign.left,
                                    maxLines: 8,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        StarRating(
                                            rating:
                                                double.parse(card["rating"]!)),
                                        const SizedBox(width: 6),
                                        GestureDetector(
                                          child: SvgPicture.asset(
                                            "assets/images/logos/info.svg",
                                            height: 20,
                                            width: 20,
                                            color: HexColor.fromHex('#B9B8B8'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 24,
                          thickness: 1,
                          color: const Color(0xFF000000).withOpacity(0.08),
                        ),
                        QrCodeWidget(
                          cardData: profilecard,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 5,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/icons/cross.svg',
                        color: Color(0xFF000000).withOpacity(0.23),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showReviewDialog(BuildContext context, Map<String, String> card) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // added for left alignment
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage(card["profileImagePath"]!),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // added for left alignment
                                children: [
                                  Text(
                                    'Algemene score',
                                    textAlign: TextAlign.left,
                                    maxLines: 8,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: const Color(0XffFFD400),
                                          size: 24,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          card["rating"]!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 24,
                          thickness: 1,
                          color: const Color(0xFF000000).withOpacity(0.08),
                        ),
                        const SizedBox(height: 10),
                        _buildRatingRow('Betrouwbaarheid',
                            double.parse(card["betrouwbaarheidRating"]!)),
                        _buildRatingRow('Werk kwaliteit',
                            double.parse(card["werkKwaliteit"]!)),
                        _buildRatingRow('Professionele attitude',
                            double.parse(card["professioneleAttitude"]!)),
                        _buildRatingRow(
                            'Werklust', double.parse(card["werklust"]!)),
                        _buildRatingRow('Communicatie',
                            double.parse(card["communicatie"]!)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 5,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/icons/cross.svg',
                        color: Color(0xFF000000).withOpacity(0.23),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRatingRow(String title, double rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: HexColor.fromHex('#000000'),
            ),
          ),
          StarRating(rating: rating)
        ],
      ),
    );
  }
}
