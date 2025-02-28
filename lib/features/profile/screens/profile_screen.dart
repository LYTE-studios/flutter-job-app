import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/profile/screens/availability_screen.dart';
import 'package:jobr/features/profile/screens/company_screen/company_profile.dart';
import 'package:jobr/features/profile/screens/company_screen/settings_screen.dart';
import 'package:jobr/features/profile/screens/edit/edit_profile_details_screen.dart';
import 'package:jobr/features/profile/screens/employee_profile_screen_display.dart';
import 'package:jobr/features/profile/screens/reviews/employee_reviews.dart';
import 'package:jobr/features/profile/screens/reviews/profile_review_screen.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

import '../../../ui/theme/jobr_icons.dart';
import 'tabs/general_item_widget.dart';
import 'tabs/media_item_widget.dart';

class ProfileScreen extends StatefulWidget {
  static const String location = 'profile';

  const ProfileScreen({super.key});

  static String employeeRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employeeInitialroute,
  );

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<TabData> tabData = [
    TabData(label: 'Algemeen', icon: JobrIcons.dashboard),
    TabData(label: 'Media', icon: JobrIcons.camera),
  ];
  int selectedIndex = 0;
  List<String> selectedDays = ['V', 'Z1']; // using 'Z1' for Saturday

  // Add a local dayData list that maps ID to label
  final List<Map<String, String>> dayData = [
    {'id': 'M', 'label': 'M'},
    {'id': 'D1', 'label': 'D'},
    {'id': 'W', 'label': 'W'},
    {'id': 'D2', 'label': 'D'},
    {'id': 'V', 'label': 'V'},
    {'id': 'Z1', 'label': 'Z'},
    {'id': 'Z2', 'label': 'Z'},
  ];

  List<Widget> tabs = const [
    GeneralItemsWidget(),
    MediaItemWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              // leading: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: CircleAvatar(
              //     backgroundColor: Colors.white,
              //     child: IconButton(
              //       icon: SvgPicture.asset(
              //         'assets/images/icons/back-arrow.svg',
              //         color: Colors.grey,
              //       ),
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //     ),
              //   ),
              // ),
              expandedHeight: 200,
              floating: false,
              pinned: true,
              title: innerBoxIsScrolled
                  ? Row(
                      children: [
                        if (innerBoxIsScrolled)
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 15),
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
                                imagePath: 'assets/images/images/profile.png',
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
                                    'assets/images/images/profile.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 166,
                      right: 60,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.push(EditProfileDetailsScreen.route);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                        ),
                        label: Text(
                          "Aanpassen",
                          style: TextStyle(
                            color: TextStyles.clearText,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: SvgPicture.asset(
                            JobrIcons.edit,
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              TextStyles.clearText,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          // Add your settings action here
                          context.push(SettingsScreen.route);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade100,
                          ),
                          child: SvgIcon(
                            JobrIcons.settings1,
                            size: 20.68,
                            color: TextStyles.disabledText,
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
              "Louis Ottevaere",
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "louisottevaere@gmail.com",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6F717C),
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
                  "Kortrijk",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            CustomStarRating(
              rating: 3.5,
              onIconTap: () {
                context.push(DisplayProfileReviews.employeeRoute);
              },
              containerBackgroundColor:
                  HexColor.fromHex('#F0F0F0').withOpacity(0.24),
              borderColor: HexColor.fromHex('#EDEDED').withOpacity(0.36),
            ),

            const SizedBox(height: 22),
            const Padding(
              padding: EdgeInsets.only(
                right: 12,
              ),
              child: Text(
                '''Ik ben Louis, 30 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste
service geven.''',
                style: TextStyle(
                    fontSize: 15.28,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A4C53)),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PaddingSizes.small,
              ),
              child: Row(
                children: [
                  _buildStat("36", "sollicitaties", JobrIcons.jobApplications),
                  SizedBox(
                    height: 46,
                    child: VerticalDivider(
                      thickness: 1.5,
                      width: 42,
                      color: HexColor.fromHex('#F0F1F3'),
                    ),
                  ),
                  _buildStat("12", "sessies", JobrIcons.phone),
                  SizedBox(
                    height: 46,
                    child: VerticalDivider(
                      thickness: 1.5,
                      width: 42,
                      color: HexColor.fromHex('#F0F1F3'),
                    ),
                  ),
                  _buildStat("22", "verzoeken", JobrIcons.chat),
                ],
              ),
            ),
            const SizedBox(height: 27),

            // Availability Card
            GestureDetector(
              onTap: () async {
                final updated = await context.push(
                  AvailabilityScreen.employeeRoute,
                  extra: selectedDays,
                );
                if (updated != null) {
                  setState(() => selectedDays = updated as List<String>);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF2F2F2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Card(
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Beschikbaarheid",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Divider(
                          color: HexColor.fromHex('#F0F1F3'),
                          thickness: 1,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Iterate over dayData instead of hard-coded letters
                            for (var day in dayData)
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor:
                                      selectedDays.contains(day['id']!)
                                          ? Colors.red.shade100
                                              .withAlpha((255 * 0.5).toInt())
                                          : const Color(0xFFF5F5F5),
                                  child: Text(
                                    day['label']!,
                                    style: TextStyle(
                                      color: selectedDays.contains(day['id']!)
                                          ? Colors.red
                                          : const Color(0xFFCECECE),
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(
                tabData.length,
                (index) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: FilledButton.icon(
                    onPressed: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: selectedIndex == index
                          ? theme.primaryColor
                          : TextStyles.clearText,
                      side: BorderSide(
                        width: 1.5,
                        color: selectedIndex == index
                            ? theme.primaryColor
                            : Color(0xFF494A54).withOpacity(0.2),
                      ),
                    ),
                    label: Text(
                      tabData[index].label,
                      style: TextStyle(
                        color: selectedIndex == index
                            ? TextStyles.clearText
                            : Color(0xFF494A54).withOpacity(0.4),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                        fontSize: 16,
                      ),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: SvgPicture.asset(
                        tabData[index].icon,
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          selectedIndex == index
                              ? TextStyles.clearText
                              : Color(0xFF494A54).withOpacity(0.4),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: tabs[selectedIndex],
            ),
          ],
        ),
      ),
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
