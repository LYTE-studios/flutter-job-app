import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/features/profile/screens/company_screen/settings.dart';
import 'package:jobr/features/profile/screens/tabs/general_item_widget.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

class CompanyProfileScreen extends StatefulWidget {
  static const String location = 'company-profile';

  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = const [
    GeneralItemsWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200,
                  floating: false,
                  pinned: true,
                  title: innerBoxIsScrolled
                      ? const Text(
                          "Brooklyn Kortrijk",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inter',
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
                                image: AssetImage(
                                    'assets/images/images/image-b.png'),
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
                      clipBehavior: Clip.none,
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
                                    'assets/images/images/image-b.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          right: 50,
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
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            icon: SvgPicture.asset(
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
                        Positioned(
                          bottom: 30,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              // Add your settings action here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsScreen()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: SvgIcon(
                                JobrIcons.settings1,
                                size: 18.68,
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
                  "Brooklyn Kortrijk",
                  style: TextStyle(
                      fontSize: 23.43,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "wwww.brooklyn.be",
                      style: TextStyle(
                        fontSize: 17.01,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                        color: TextStyles.brooklyn,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SvgIcon(
                      JobrIcons.web,
                      size: 11.72,
                      leaveUnaltered: true,
                      color: TextStyles.brooklyn,
                    ),
                  ],
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
                        fontSize: 15.36,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: TextStyles.selectedText,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SvgIcon(
                      JobrIcons.dot,
                      size: 5.43,
                      leaveUnaltered: true,
                      color: TextStyles.selectedText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "2-10 werknemers",
                      style: TextStyle(
                        fontSize: 15.36,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: TextStyles.selectedText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SvgIcon(
                      JobrIcons.instagram,
                      size: 27.86,
                      color: TextStyles.selectedText,
                    ),
                    const SizedBox(width: 16),
                    SvgIcon(
                      JobrIcons.tiktok,
                      size: 27.86,
                      color: TextStyles.disabledText,
                    ),
                    const SizedBox(width: 16),
                    SvgIcon(
                      JobrIcons.facebook,
                      size: 27.86,
                      color: TextStyles.disabledText,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Multibrandstore & Webshop. Brooklyn, da's een mix van merken en heel veel broeken. Dat laatste nemen we als broekspeciaalzaak wel heel serieus. Kom zeker eens langs om het zelf te zeggen.",
                  style: TextStyle(
                    fontSize: 15.28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: TextStyles.disabledText,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: TextStyles.darkGray,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Gemiddelde reactietijd ",
                        style: TextStyle(
                            fontSize: 15.2,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          SvgIcon(
                            JobrIcons.message1,
                            size: 16,
                            color: TextStyles.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "12 uur",
                            style: TextStyle(
                              color: TextStyles.green,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        width: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/images/bg_image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ...List.generate(
                        5,
                        (index) => Container(
                          margin: const EdgeInsets.only(right: 16),
                          width: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/images/bg_image.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/images/Frame-m.png',
                      // Replace with the actual map image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )));
  }
}
