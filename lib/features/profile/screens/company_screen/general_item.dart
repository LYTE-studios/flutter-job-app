import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/features/profile/screens/widgets/custom_list_tile.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';
import '../../models/list_model.dart';

class GeneralItems extends StatefulWidget {
  const GeneralItems({
    super.key,
  });

  @override
  State<GeneralItems> createState() => _GeneralItemsWidgetState();
}

class _GeneralItemsWidgetState extends State<GeneralItems> {
  List<ListData> experience = [
    ListData(
      image: 'assets/images/images/image-7.png',
      title: 'Head of restaurant',
      subTitle: "Kurkumama group",
      duration: 'Nov 2017 - Jul 2024',
      time: '6 jr 8 mnd',
    ),
    ListData(
      image: 'assets/images/images/image-8.png',
      title: 'Co-Founder',
      subTitle: "Spicy Lemon",
      duration: 'Nov 2017 - Feb 2021',
      time: '3 jr 3 mnd',
    ),
    ListData(
      image: 'assets/images/images/image-1.png',
      title: 'Stage - Sommelier',
      subTitle: "MAGMA",
      duration: 'Nov 2017 - Feb 2021',
      time: '3 jr 3 mnd',
    ),
  ];
  List<ListData> education = [
    ListData(
      image: 'assets/images/images/image-6.png',
      title: 'BCH, Architecture',
      subTitle: "Universiteit Gent",
      duration: 'Okt 2014 - Jun 2017',
      time: '2 jr 8 mnd',
    ),
    ListData(
      image: 'assets/images/images/image-2.png',
      title: 'Guldensporencollege',
      subTitle: "Guldensporencollege",
      duration: 'Nov 2008 - Jun 2014',
      time: '3 jr 3 mnd',
    ),
    ListData(
      image: 'assets/images/images/image 7.png',
      title: 'Sommelier',
      subTitle: "Master Sommeliers",
      duration: 'Certificaat',
    ),
  ];

  List<String> skills = ['📝 Schrijven', '📷 Content creation', '💄 Make-up'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Ervaring',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        JobrIcons.edit,
                        width: 17,
                        height: 17,
                        colorFilter: ColorFilter.mode(
                          HexColor.fromHex('#A4A4A4'),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        JobrIcons.add,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          HexColor.fromHex('#A4A4A4'),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (experience.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: experience.length,
                  separatorBuilder: (context, index) => Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.black.withOpacity(0.07),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  itemBuilder: (context, index) => CustomListTile(
                    image: experience[index].image,
                    title: experience[index].title,
                    subTitle: experience[index].subTitle,
                    duration: experience[index].duration,
                    time: experience[index].time,
                  ),
                )
              else ...[
                const Text(
                  'Laat zien voor welke functies en bij welke bedrijven je ervaring hebt',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 72,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.primaryColor.withOpacity(.1),
                    ),
                    child: Text(
                      'Toevoegen',
                      style: TextStyle(
                        fontSize: 15,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Onderwijs & certificaten',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        JobrIcons.edit,
                        width: 17,
                        height: 17,
                        colorFilter: ColorFilter.mode(
                          HexColor.fromHex('#A4A4A4'),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        JobrIcons.add,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          HexColor.fromHex('#A4A4A4'),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (education.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: education.length,
                  separatorBuilder: (context, index) => Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Divider(
                        color: Colors.black.withOpacity(0.07),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  itemBuilder: (context, index) => CustomListTile(
                    image: education[index].image,
                    title: education[index].title,
                    subTitle: education[index].subTitle,
                    duration: education[index].duration,
                    time: education[index].time,
                  ),
                )
              else ...[
                const Text(
                  'Laat zien voor welke functies en bij welke bedrijven je ervaring hebt',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 72,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                        backgroundColor: theme.primaryColor.withOpacity(.1)),
                    child: Text(
                      'Toevoegen',
                      style: TextStyle(
                        fontSize: 15,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Mijn skills',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        JobrIcons.edit,
                        width: 17,
                        height: 17,
                        colorFilter: ColorFilter.mode(
                          HexColor.fromHex('#A4A4A4'),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  ...skills.map(
                    (skill) => Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: HexColor.fromHex('#191919'),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 15,
                          color: TextStyles.clearText,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Talen',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        JobrIcons.edit,
                        width: 17,
                        height: 17,
                        colorFilter: ColorFilter.mode(
                          HexColor.fromHex('#A4A4A4'),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Engels, Italiaans',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Meer over mezelf',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        JobrIcons.edit,
                        width: 17,
                        height: 17,
                        colorFilter: ColorFilter.mode(
                          HexColor.fromHex('#A4A4A4'),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        JobrIcons.add,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          HexColor.fromHex('#A4A4A4'),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SvgPicture.asset(
                JobrIcons.blockquote,
              ),
              const SizedBox(height: 5),
              const Text(
                'Ik haal mijn energie uit...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Inter',
                ),
              ),
              Text(
                'Ik sport heel veel en ik vind het leuk om uit te gaan.',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex('#00000000').withOpacity(.6),
                ),
              ),
              const SizedBox(height: 20),
              SvgPicture.asset(
                JobrIcons.blockquote,
              ),
              const SizedBox(height: 5),
              const Text(
                'Mijn favoriete boek is...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Inter',
                ),
              ),
              Text(
                'Hier typen...',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex('#00000000').withOpacity(.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
