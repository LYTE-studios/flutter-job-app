import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/features/dashboard/base/base_dashboard_screen.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

import '../../../ui/theme/jobr_icons.dart';
import 'tabs/general_item_widget.dart';
import 'tabs/media_item_widget.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '${BaseDashboardScreen.route}/$location';
  static const String location = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<TabData> tabData = [
    TabData(label: 'Algemeen', icon: JobrIcons.dashboard),
    TabData(label: 'Media', icon: JobrIcons.chat),
  ];
  int selectedIndex = 0;

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
              expandedHeight: 300,
              floating: false,
              pinned: true,
              title: innerBoxIsScrolled
                  ? Text(
                      "Louis Ottevaere",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : null,
              scrolledUnderElevation: 0,
              elevation: 0,
              leading: innerBoxIsScrolled
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/images/profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : null,
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
                        'assets/images/images/image-4.png',
                        fit: BoxFit.cover,
                        height: 280,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: Container(
                        width: 123,
                        height: 123,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/images/profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      right: 10,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                        ),
                        label: Text(
                          "Aanpassen",
                          style: TextStyle(
                            color: TextStyles.clearText,
                            fontSize: 16,
                          ),
                        ),
                        icon: Icon(
                          Icons.edit,
                          color: TextStyles.clearText,
                          size: 24,
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: const ClampingScrollPhysics(),
          children: [
            Text(
              "Louis Ottevaere",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "louisottevaere@gmail.com",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: TextStyles.unselectedText,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SvgIcon(
                  JobrIcons.location,
                  size: 16,
                  leaveUnaltered: true,
                  color: theme.primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  "Kortrijk",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Ik ben Louis, 30 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste service geven.",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStat("36", "sollicitaties", JobrIcons.jobApplications),
                Container(
                  width: 1,
                  height: 70,
                  color: theme.colorScheme.primaryContainer,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                ),
                _buildStat("12", "sessies", JobrIcons.phone),
                Container(
                  width: 1,
                  height: 70,
                  color: theme.colorScheme.primaryContainer,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                ),
                _buildStat("22", "verzoeken", JobrIcons.chat),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: List.generate(
                tabData.length,
                (index) => Container(
                  margin: EdgeInsets.only(right: 20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedIndex == index
                          ? theme.primaryColor
                          : TextStyles.clearText,
                      side: BorderSide(
                        color: selectedIndex == index
                            ? theme.primaryColor
                            : TextStyles.unselectedText,
                      ),
                    ),
                    label: Text(
                      tabData[index].label,
                      style: TextStyle(
                        color: selectedIndex == index
                            ? TextStyles.clearText
                            : TextStyles.unselectedText,
                        fontSize: 16,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      tabData[index].icon,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        selectedIndex == index
                            ? TextStyles.clearText
                            : TextStyles.unselectedText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
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
          children: [
            SvgIcon(
              icon,
              size: 16,
              leaveUnaltered: true,
              color: TextStyles.mainText,
            ),
            SizedBox(width: 5),
            Text(
              number,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: TextStyles.unselectedText,
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
