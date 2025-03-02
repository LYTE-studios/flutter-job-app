import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class CommonContainers extends StatelessWidget {
  final List<String> hardSkill = ['Fashion', 'Stockbeheer', 'Kassa', 'Verkoop'];
  final List<String> salarisTabs = ['Maaltijdcheques', 'Wagen', 'GSM'];

  CommonContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hard Skills Container
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Card(
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Benodigde hard skills",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Divider(
                    thickness: 1.32,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      for (var skill in hardSkill)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            skill,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
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
        ),

        const SizedBox(height: 16),
        // Salary Container
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Card(
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
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
                      // const Text(
                      //   "Bovengemiddeld",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 15,
                      //       color: Color(0xFF35BD76)),
                      // ),
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
                        "💰 €2500/maand",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black),
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
                            color: Colors.grey.shade200,
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
        ),
      ],
    );
  }
}

class VacancyInfoTab extends StatelessWidget {
  VacancyInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Removed the hard skills and salary containers as they're now in CommonContainers

          // Company Info Container
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
                              JobrIcons.placeholder1,
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
                                  'Brooklyn Kortrijk',
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
                                        '874 volgers',
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
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        side:
                            BorderSide(color: Colors.grey.shade200, width: 1.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Aanpassen',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis, // Prevents overflow
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '''Multibrandstores & Webshop. Brooklyn, da's een mix van merken en heel veel broeken. Dat laatste nemen we als broekenspecialist au sérieux met een jeans assortiment om 'u' tegen te zeggen.

Multibrandstores & Webshop. Brooklyn, da's een mix van merken en heel veel broeken. Dat laatste nemen we als broekenspecialist au sérieux met een jeans assortiment om 'u' tegen te zeggen.''',
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
