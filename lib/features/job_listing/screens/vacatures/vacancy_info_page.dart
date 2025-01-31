import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/Sollicitaties/recruitment_detail_screen.dart';
import 'package:jobr/features/job_listing/screens/general/job_listings_screen.dart';
import 'package:jobr/features/job_listing/screens/vacatures/delete_vacancy.dart';
import 'package:jobr/features/job_listing/screens/vacatures/widgets/vacancy_info_tabs.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

import '../../../../ui/theme/jobr_icons.dart';

class VacancyInfoScreen extends StatefulWidget {
  static const String location = 'vacancy-info';

  const VacancyInfoScreen({super.key});

  static String route = JobrRouter.getRoute(
    '${JobListingsScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  @override
  State<VacancyInfoScreen> createState() => _VacancyInfoScreenState();
}

class _VacancyInfoScreenState extends State<VacancyInfoScreen> {
  List<TabData> tabData = [
    TabData(label: 'Algemeen', icon: JobrIcons.dashboard),
    TabData(label: 'Media', icon: JobrIcons.chat),
  ];
  int selectedIndex = 0;

  List<Widget> tabs = [
    VacancyInfoTab(),
  ];

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
                        'assets/images/icons/back-arrow.svg',
                        color: Colors.grey,
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
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/images/profile_image.png',
                          fit: BoxFit.cover,
                          height: 180,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
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
                                'assets/images/logos/brooklyn_kortrijk.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 70,
                        child: InkWell(
                          onTap: () {
                            // Add your settings action here
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: SvgIcon(
                              JobrIcons.edit,
                              size: 20.68,
                              color: Colors.grey[700],
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
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: SvgIcon(
                              JobrIcons.delete_icon,
                              size: 20.68,
                              color: Colors.white,
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
                "Winkel medewerker",
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
                  const Text(
                    "Gent • 44km • 36 kandidaten",
                    style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
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
                  const Text(
                    "Op locatie • Full-time • Enige ervaring vereist",
                    style: TextStyle(
                        fontSize: 14.3,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
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
                        icon: SvgIcon(
                          JobrIcons.people,
                          size: 20,
                          color: Colors.white,
                        ),
                        buttonText: 'Bekijk kandidaten',
                        onTap: () {
                          context.push(
                            RecruitmentDetailScreen.employerRoute,
                            extra: {
                              'category': '',
                              'title': 'Sollicitaties',
                              "image": "",
                            },
                          );
                        },
                        buttonColor: Theme.of(context).primaryColor,
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
                            context.push(DeleteVacancyPage.route);
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
