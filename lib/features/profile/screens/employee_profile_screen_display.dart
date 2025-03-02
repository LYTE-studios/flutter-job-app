import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/chat/screens/employer/chat_page_screen.dart';
import 'package:jobr/features/payments/screens/subscription_page.dart';
import 'package:jobr/features/profile/screens/company_screen/company_profile.dart';
import 'package:jobr/features/profile/screens/reviews/employee_reviews.dart';
import 'package:jobr/features/profile/screens/tabs/employee_profile_tab.dart';
import 'package:jobr/features/profile/screens/tabs/media_item_widget.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

import '../../../../ui/theme/jobr_icons.dart';

class EmployProfileDisplayScreen extends StatefulWidget {
  static const String location = 'employee-profile';

  const EmployProfileDisplayScreen({super.key});

  static String employerRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employerInitialroute,
  );

  @override
  State<EmployProfileDisplayScreen> createState() =>
      _EmployProfileDisplayScreenState();
}

class _EmployProfileDisplayScreenState
    extends State<EmployProfileDisplayScreen> {
  List<TabData> tabData = [
    TabData(label: 'Algemeen', icon: JobrIcons.dashboard),
    TabData(label: 'Media', icon: JobrIcons.chat),
  ];
  int selectedIndex = 0;

  List<Widget> tabs = const [
    EmployeeProfileTab(),
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
                  padding: const EdgeInsets.all(11.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/icons/back-arrow.svg',
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
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Hero(
                          tag: 'profileBackground',
                          child: GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: 'Dismiss',
                                barrierColor: Colors.black54,
                                pageBuilder: (_, __, ___) => ZoomImageDialog(
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  tag: 'profileBackground',
                                  imagePath: 'assets/images/images/image-4.png',
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/images/images/image-4.png',
                              fit: BoxFit.cover,
                              height: 180,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Hero(
                          tag: 'profileLogo',
                          child: GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: 'Dismiss',
                                barrierColor: Colors.black54,
                                pageBuilder: (_, __, ___) => ZoomImageDialog(
                                    height: 200,
                                    width: 200,
                                    tag: 'profileLogo',
                                    imagePath:
                                        'assets/images/images/profile.png'),
                              );
                            },
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/images/profile.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 190,
                        right: 25,
                        child: Text(
                          '143x bekeken',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
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
                "Louis Ottevaere",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                ),
              ),
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
                    "Kortrijk",
                    style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              // const SizedBox(height: 14),
              // CustomStarRating(
              //   rating: 3.5,
              //   onIconTap: () {
              //     context.push(EmployeeReviewsDisplayScreen.employerRoute);
              //   },
              //   containerBackgroundColor:
              //       HexColor.fromHex('#F0F0F0').withOpacity(0.24),
              //   borderColor: HexColor.fromHex('#EDEDED').withOpacity(0.36),
              // ),
              // SizedBox(
              //   height: 14,
              // ),
              Row(
                children: [
                  SvgIcon(
                    JobrIcons.magnifyingGlassDotted,
                    size: 16,
                    leaveUnaltered: true,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Full-time",
                    style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Padding(
                padding: EdgeInsets.only(
                  right: 12,
                ),
                child: Text(
                  "Ik ben Louis, 30 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste service geven.",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
              ),
              const SizedBox(height: 24),
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
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 52,
                width: MediaQuery.of(context).size.width * 0.8,
                child: FilledButton(
                  onPressed: () {
                    context.push(ChatPageScreen.employerRoute);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFF3976FF),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon(
                        JobrIcons.send,
                        size: 30,
                        color: Colors.white,
                      ),
                      const Text(
                        'Chat starten',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
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

class CustomStarRating extends StatelessWidget {
  final double rating;
  final int totalStars;
  final double size;
  // New parameters
  final VoidCallback? onIconTap;
  final Color containerBackgroundColor;
  final Color borderColor;

  const CustomStarRating({
    Key? key,
    required this.rating,
    this.totalStars = 5,
    this.size = 24.0,
    this.onIconTap,
    this.containerBackgroundColor =
        const Color(0xFFF0F0F0), // Default: use your desired color (example)
    this.borderColor =
        const Color(0xFFEDEDED), // Default: use your desired color (example)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            color: containerBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: -4,
                children: List.generate(totalStars, (index) {
                  if (rating >= index + 1) {
                    return Icon(Icons.star_rounded,
                        size: size, color: const Color(0xFFFFD400));
                  } else if (rating > index) {
                    final double fraction = rating - index;
                    return Stack(
                      children: [
                        Icon(Icons.star_rounded,
                            size: size, color: const Color(0xFFD9D9D9)),
                        ClipRect(
                          clipper: _StarClipper(fraction),
                          child: Icon(Icons.star_rounded,
                              size: size, color: const Color(0xFFFFD400)),
                        ),
                      ],
                    );
                  } else {
                    return Icon(Icons.star_rounded,
                        size: size, color: const Color(0xFFD9D9D9));
                  }
                }),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onIconTap,
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
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double fraction;
  _StarClipper(this.fraction);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * fraction, size.height);
  }

  @override
  bool shouldReclip(covariant _StarClipper oldClipper) {
    return oldClipper.fraction != fraction;
  }
}
