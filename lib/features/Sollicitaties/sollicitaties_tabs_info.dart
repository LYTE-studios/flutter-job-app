import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/Sollicitaties/questions.dart';
import 'package:jobr/features/Sollicitaties/recruitment_detail_screen.dart';
import 'package:jobr/features/Sollicitaties/sollicitaties.dart';
import 'package:jobr/features/Sollicitaties/widgets/job_info_widget.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/job_listing/screens/vacatures/delete_vacancy.dart';
import 'package:jobr/features/job_listing/screens/vacatures/widgets/vacancy_info_tabs.dart';
import 'package:jobr/features/profile/screens/company_screen/company_profile.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../ui/theme/jobr_icons.dart';

class JobInfoScreen extends StatefulWidget {
  static const String location = 'job-info';

  const JobInfoScreen({super.key});

  static String route = JobrRouter.getRoute(
    '${SollicitatiesScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );

  @override
  State<JobInfoScreen> createState() => _JobInfoScreenState();
}

class _JobInfoScreenState extends State<JobInfoScreen> {
  List<TabData> tabData = [
    TabData(label: 'Algemeen', icon: JobrIcons.dashboard),
    TabData(
      label: 'Media',
      icon: JobrIcons.location,
    ),
  ];
  int selectedIndex = 0;

  List<Widget> tabs = [
    JobInfo(),
  ];

  // Add the toggle state
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(children: [
        NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/icons/cross.svg',
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                expandedHeight: 200,
                floating: false,
                pinned: true,
                title: innerBoxIsScrolled
                    ? Row(
                        children: [
                          if (innerBoxIsScrolled)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 15),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 4),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/images/profile.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          const Text(
                            "Louis Ottevaere",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : null,
                scrolledUnderElevation: 0,
                elevation: 0,
                backgroundColor: theme.colorScheme.surface,
                clipBehavior: Clip.none,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    clipBehavior: Clip.none, // Allow overflow
                    fit: StackFit.expand,
                    children: [
                      // Modified background image:
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Hero(
                          tag: 'jobInfoBackground',
                          child: GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: 'Dismiss',
                                barrierColor: Colors.black54,
                                pageBuilder: (_, __, ___) => ZoomImageDialog(
                                  tag: 'jobInfoBackground',
                                  imagePath:
                                      'assets/images/images/placeholder-2.png',
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/images/images/placeholder-2.png',
                              fit: BoxFit.cover,
                              height: 180,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      // Modified profile image:
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Hero(
                          tag: 'jobInfoProfile',
                          child: GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: 'Dismiss',
                                barrierColor: Colors.black54,
                                pageBuilder: (_, __, ___) => ZoomImageDialog(
                                  tag: 'jobInfoProfile',
                                  height: 200,
                                  width: 200,
                                  imagePath:
                                      'assets/images/images/placeholder-4.png',
                                ),
                              );
                            },
                            child: Container(
                              width: 135,
                              height: 135,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/images/placeholder-4.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Modified toggle button
                      Positioned(
                        bottom: 10,
                        right: 55,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: SvgIcon(
                              JobrIcons.like_icon_pink,
                              color: isLiked
                                  ? HexColor.fromHex('#FF3E68')
                                  : HexColor.fromHex('#000000')
                                      .withOpacity(0.26),
                              size: 22.68,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 20,
                        child: InkWell(
                          onTap: () {
                            context.push(DeleteVacancyPage.route);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: SvgIcon(
                              JobrIcons.bell,
                              size: 24.68,
                              color:
                                  HexColor.fromHex('#000000').withOpacity(0.26),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const ClampingScrollPhysics(),
            children: [
              const Text(
                "Pitarist",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SvgIcon(
                    JobrIcons.location,
                    size: 16,
                    leaveUnaltered: true,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(width: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Kortrijk",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: HexColor.fromHex('#666666'),
                          ),
                        ),
                        TextSpan(
                          text: " • ",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w900,
                            color: HexColor.fromHex('#D9D9D9'),
                          ),
                        ),
                        TextSpan(
                          text: "0.6km",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                            color: HexColor.fromHex('#666666'),
                          ),
                        ),
                        TextSpan(
                          text: " • ",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w900,
                            color: HexColor.fromHex('#D9D9D9'),
                          ),
                        ),
                        TextSpan(
                          text: "12 kandidaten",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'Inter',
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                            color: HexColor.fromHex('#666666'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  SvgIcon(
                    JobrIcons.briefcase,
                    size: 16,
                    leaveUnaltered: true,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(width: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Op locatie",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " • ",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w900,
                            color: HexColor.fromHex('#D9D9D9'),
                          ),
                        ),
                        TextSpan(
                          text: "Student",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " • ",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w900,
                            color: HexColor.fromHex('#D9D9D9'),
                          ),
                        ),
                        TextSpan(
                          text: "⭐Ervaren",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                            color: HexColor.fromHex('#EEAE3E'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: tabs[selectedIndex],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 52,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: PrimaryButton(
                        borderRadius: 25,
                        buttonText: 'Ik wil deze job',
                        onTap: () {
                          context.push(QuestionPage.employeeRoute,
                              extra: 'Spacex');
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
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: PrimaryButton(
                          suffixIcon: SvgIcon(
                            JobrIcons.uploadIcon,
                            size: 20,
                            color: Colors.black,
                          ),
                          borderRadius: 25,
                          buttonText: 'Delen',
                          onTap: () {
                            Share.share('www.apple.com');
                          },
                          buttonColor: Colors.white,
                          height: 45,
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildStat(String number, String label, String icon) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              icon,
              size: 20,
              color: TextStyles.secondaryText,
            ),
            const SizedBox(width: 6),
            Text(
              number,
              style: TextStyle(
                fontSize: 19,
                fontFamily: 'Inter',
                color: TextStyles.secondaryText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: HexColor.fromHex('#82838C'),
          ),
        ),
      ],
    );
  }
}

class TabData {
  final String label;
  final String icon;

  TabData({required this.label, required this.icon});
}
