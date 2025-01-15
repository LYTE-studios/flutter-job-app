import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

import '../../../ui/theme/jobr_icons.dart';
import 'job_application_questions_screen.dart';
import 'widgets/custom_list_tile.dart';

class JobDetailsScreen extends StatefulWidget {
  static const String route = '/$location';
  static const String location = 'job-details';
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
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
                        'assets/images/images/placeholder-2.png',
                        fit: BoxFit.cover,
                        height: 180,
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 10,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 107,
                          height: 107,
                          decoration: BoxDecoration(
                            color: HexColor.fromHex('#F7F7F7'),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/images/placeholder-4.png',
                            fit: BoxFit.cover,
                            height: 74,
                            width: 74,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            JobrIcons.close,
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 10,
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            JobrIcons.heart,
                            width: 26,
                            height: 28,
                            colorFilter: ColorFilter.mode(
                              HexColor.fromHex('#FF0000'),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 20),
                          SvgPicture.asset(
                            JobrIcons.bellTwo,
                            width: 25,
                            height: 27,
                          ),
                        ],
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
            const SizedBox(height: 10),
            const Text(
              "Pitarist",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
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
                        color: HexColor.fromHex('#666666'),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                Container(
                  width: 7.43,
                  height: 7.43,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex('#D9D9D9'),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "0.6km",
                  style: TextStyle(
                    fontSize: 15.36,
                    color: HexColor.fromHex('#666666'),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 7.43,
                  height: 7.43,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex('#D9D9D9'),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "12 kandidaten",
                  style: TextStyle(
                    fontSize: 15.36,
                    decoration: TextDecoration.underline,
                    color: HexColor.fromHex('#666666'),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Row(
                  children: [
                    SvgIcon(
                      JobrIcons.briefcase,
                      size: 16,
                      leaveUnaltered: true,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Op locatie",
                      style: TextStyle(
                        fontSize: 14.37,
                        color: HexColor.fromHex('#191919'),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                Container(
                  width: 7.43,
                  height: 7.43,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex('#D9D9D9'),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Student",
                  style: TextStyle(
                    fontSize: 14.37,
                    color: HexColor.fromHex('#191919'),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 7.43,
                  height: 7.43,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex('#D9D9D9'),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "⭐ Ervaren",
                  style: TextStyle(
                    fontSize: 15.09,
                    color: HexColor.fromHex('#EEAE3E'),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: HexColor.fromHex('#F2F2F2'),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Match met jouw vacature',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.09,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            JobrIcons.midStars,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              HexColor.fromHex('#FF3E68'),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '90%',
                            style: TextStyle(
                              color: HexColor.fromHex('#FF3E68'),
                              fontWeight: FontWeight.w600,
                              fontSize: 16.19,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: HexColor.fromHex('#999999').withOpacity(.45),
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.checkmark_circle_fill,
                        color: HexColor.fromHex('#35BD76'),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Maaltijdcheques',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.98,
                          color: HexColor.fromHex(
                            '#000000',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex('#E5F6ED'),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Koken',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.54,
                              color: HexColor.fromHex('#191919')),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex('#E5F6ED'),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Klantvriendelijk',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.54,
                            color: HexColor.fromHex('#191919'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Vereiste werkervaring',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.09,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '⭐ Ervaren',
                            style: TextStyle(
                              color: HexColor.fromHex('#EEAE3E'),
                              fontWeight: FontWeight.w600,
                              fontSize: 15.09,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            CupertinoIcons.info,
                            color: HexColor.fromHex('#919191'),
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: HexColor.fromHex('#999999').withOpacity(.45),
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  const CustomListTile(
                    image: 'assets/images/images/placeholder-3.png',
                    title: 'Head of restaurant',
                    subTitle: 'Spicy Lemon Kortrijk',
                    duration: 'Nov 2020 - Dec 2021',
                    time: '1 jr 1 mnd',
                    edit: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: HexColor.fromHex('#F2F2F2'),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Salaris',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.09,
                        ),
                      ),
                      Text(
                        'Gemiddeld',
                        style: TextStyle(
                          color: HexColor.fromHex('#999999'),
                          fontWeight: FontWeight.w600,
                          fontSize: 15.09,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: HexColor.fromHex('#999999').withOpacity(.45),
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: '💰',
                      style: const TextStyle(
                        fontSize: 19.17,
                        fontWeight: FontWeight.w600,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '€16/uur',
                          style: TextStyle(
                            fontSize: 19.17,
                            color: HexColor.fromHex('#000000'),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ' (bruto)',
                          style: TextStyle(
                            fontSize: 13,
                            color: HexColor.fromHex('#000000').withOpacity(.36),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#F6F6F6'),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Maaltijdcheques',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.54,
                          color: HexColor.fromHex('#191919')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        color: theme.colorScheme.surface,
        elevation: 10,
        shadowColor: HexColor.fromHex('#DDDFE540'),
        child: Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    context.push(JobApplicationQuestionsScreen.route);
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: HexColor.fromHex('#3A77FF')),
                  child: const Text(
                    'Ik wil deze job',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.3,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor.fromHex('#FFFFFF'),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                ),
                label: Text(
                  'Delen',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: HexColor.fromHex('#191919'),
                    fontSize: 17.31,
                    fontFamily: 'Inter',
                  ),
                ),
                iconAlignment: IconAlignment.end,
                icon: SvgPicture.asset(
                  JobrIcons.share,
                  width: 15,
                  height: 19,
                  colorFilter: ColorFilter.mode(
                    HexColor.fromHex('#191919'),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
