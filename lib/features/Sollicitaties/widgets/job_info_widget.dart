import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/payments/screens/subscription_page.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobInfo extends StatelessWidget {
  JobInfo({super.key});
  final List<String> salarisTabs = [
    'Maaltijdcheques',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Match met jouw vacature",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            height: 22,
                            width: 22,
                            "assets/images/recruteren/jobrAI_suggesties.png",
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          const Text(
                            "90%",
                            style: TextStyle(
                              height: 2,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF3E68),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.32,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        height: 20,
                        width: 20,
                        "assets/images/icons/tick.svg",
                        color: Color(0xFF35BD76),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      const Text(
                        "Alle hard skills matchen",
                        style: TextStyle(
                          fontSize: 14.98,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFE5F6ED),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Koken',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.8,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFE5F6ED),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Klantvriendelijk',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 13.8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            height: 20,
                            width: 20,
                            "assets/images/icons/tick.svg",
                            color: Color(0xFF35BD76),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          const Text(
                            "Alle hard skills matchen",
                            style: TextStyle(
                              fontSize: 14.98,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '⭐ Ervaren',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFEEAE3E),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push(SubscriptionPage.route);
                            },
                            child: SvgPicture.asset(
                              height: 20,
                              width: 20,
                              "assets/images/logos/info.svg",
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Divider(
                    thickness: 1.32,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Space between the two ListTiles
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/images/placeholder-3.png',
                            width: 60, // Adjusted width
                            height: 60, // Adjusted height
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: const Text(
                          "Head of restaurant",
                          style: TextStyle(
                            fontSize: 15.9, // Matches the design size
                            fontWeight: FontWeight
                                .bold, // Matches the bold font in the image
                          ),
                        ),
                        subtitle: const Text(
                          "Spicy Lemon Kortrijk\nNov 2020 - Jul 2023 • 2 jr 8 mnd",
                          style: TextStyle(
                            fontSize:
                                14.1, // Matches the smaller font in the design
                            color: Colors
                                .black54, // Matches the subtle gray color in the design
                            height: 1.5, // Line height for better readability
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Match Percentage Card

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Salaris",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        "Gemiddeld",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color(0xFF999999)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Divider(
                    thickness: 1.32,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "💰 €16/uur",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      Text(
                        " (bruto)",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Color(0xFF000000).withOpacity(0.36)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      for (var skill in salarisTabs)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            skill,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey), // Added border color
                  ),
                  label: Text(
                    "Vacature",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: SvgPicture.asset(
                      'assets/images/logos/info.svg',
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(Colors.grey,
                          BlendMode.srcIn), // Updated to use colorFilter
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                  ),
                  label: Text(
                    "Over dit bedrijf",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: SvgPicture.asset(
                      color: Colors.white,
                      JobrIcons.venueLocation,
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Availability Card
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21), color: Colors.white),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Left side - Profile Image and Text
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            width: 75,
                            height: 75,
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              JobrIcons.placeholder4,
                              fit: BoxFit
                                  .cover, // Ensures the image scales properly
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Barouche',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    color: HexColor.fromHex('#000000'),
                                  ),
                                  overflow: TextOverflow
                                      .ellipsis, // Prevents overflow
                                  maxLines: 1, // Limits text to one line
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '1203 volgers',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          color: HexColor.fromHex('#666666'),
                                        ),
                                        overflow: TextOverflow
                                            .ellipsis, // Prevents overflow
                                        maxLines: 1, // Limits text to one line
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Right side - Button
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      label: Text(
                        "Volgend",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: SvgPicture.asset(
                          color: Colors.white,
                          JobrIcons.tick2,
                          width: 13,
                          height: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '''At Barouche, we've crafted a unique identity centered around our love for Mediterranean cuisine. Our mission is to create a welcoming space where guests can enjoy homemade pita bread and healthy salad bowls.

Our signature pocket breads are baked daily in the Barouche Oven, with sourdough prepared by our pitarists and rested for 24 hours for optimal flavor. Once baked, these delicious pitas are filled with the finest local ingredients, delivering a fresh and flavorful experience.''',
                  style: TextStyle(
                    fontSize: 15.28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          width: 280,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/images/company_image.png',
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
                                'assets/images/images/company_image.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
