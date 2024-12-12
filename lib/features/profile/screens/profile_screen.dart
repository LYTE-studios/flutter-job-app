import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../ui/theme/jobr_icons.dart';
import 'tabs/general_item_widget.dart';
import 'tabs/media_item_widget.dart';

class ProfileScreen extends StatefulWidget {
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.h,
              floating: false,
              pinned: true,
              title: innerBoxIsScrolled
                  ? Text(
                      "Louis Ottevaere",
                      style: TextStyle(
                        fontSize: 18.sp,
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
                        width: 70.r,
                        height: 70.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4.r),
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/images/profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : null,
              backgroundColor: AppColors.white,
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
                        height: 280.h,
                      ),
                    ),
                    Positioned(
                      bottom: 0.r,
                      left: 10,
                      child: Container(
                        width: 123.r,
                        height: 123.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4.r),
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/images/profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 25.r,
                      right: 10.r,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        label: Text(
                          "Aanpassen",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.white,
                          size: 24.sp,
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
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          physics: const ClampingScrollPhysics(),
          children: [
            Text(
              "Louis Ottevaere",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "louisottevaere@gmail.com",
              style: TextStyle(
                fontSize: 17.sp,
                fontFamily: AppFonts.primaryFont,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SvgIcon(
                  JobrIcons.location,
                  size: 16.sp,
                  leaveUnaltered: true,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  "Kortrijk",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Ik ben Louis, 30 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste service geven.",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStat("36", "sollicitaties", JobrIcons.jobApplications),
                Container(
                  width: 1.r,
                  height: 70.h,
                  color: AppColors.grey.withOpacity(.6),
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                ),
                _buildStat("12", "sessies", JobrIcons.phone),
                Container(
                  width: 1.r,
                  height: 70.h,
                  color: AppColors.grey.withOpacity(.6),
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                ),
                _buildStat("22", "verzoeken", JobrIcons.chat),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: List.generate(
                tabData.length,
                (index) => Container(
                  margin: EdgeInsets.only(right: 20.r),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: selectedIndex == index
                            ? AppColors.primaryColor
                            : AppColors.white,
                        side: BorderSide(
                          color: selectedIndex == index
                              ? AppColors.primaryColor
                              : AppColors.grey,
                        )),
                    label: Text(
                      tabData[index].label,
                      style: TextStyle(
                        color: selectedIndex == index
                            ? AppColors.white
                            : AppColors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      tabData[index].icon,
                      width: 16.sp,
                      height: 16.sp,
                      colorFilter: ColorFilter.mode(
                          selectedIndex == index
                              ? AppColors.white
                              : AppColors.grey,
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
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
              size: 16.sp,
              leaveUnaltered: true,
              color: AppColors.black,
            ),
            SizedBox(width: 5.w),
            Text(
              number,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
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
