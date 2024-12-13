import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/ui/theme/text_styles.dart';

import '../../../../ui/theme/jobr_icons.dart';
import '../../models/list_model.dart';
import '../../widgets/custom_list_tile.dart';

class GeneralItemsWidget extends StatefulWidget {
  const GeneralItemsWidget({
    super.key,
  });

  @override
  State<GeneralItemsWidget> createState() => _GeneralItemsWidgetState();
}

class _GeneralItemsWidgetState extends State<GeneralItemsWidget> {
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
          padding: EdgeInsets.all(10),
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
                  Text(
                    'Ervaring',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: TextStyles.unselectedText,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: TextStyles.unselectedText,
                          size: 28,
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
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.black.withOpacity(0.07),
                      ),
                      SizedBox(height: 10),
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
                Text(
                  'Laat zien voor welke functies en bij welke bedrijven je ervaring hebt',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
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
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(10),
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
                  Text(
                    'Onderwijs & certificaten',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: TextStyles.unselectedText,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: TextStyles.unselectedText,
                          size: 28,
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
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.black.withOpacity(0.07),
                      ),
                      SizedBox(height: 10),
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
                Text(
                  'Laat zien voor welke functies en bij welke bedrijven je ervaring hebt',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
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
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(10),
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
                  Text(
                    'Mijn skills',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: TextStyles.unselectedText,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                children: [
                  ...skills.map(
                    (skill) => Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: TextStyles.mainText,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 15,
                          color: TextStyles.clearText,
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
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(10),
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
                  Text(
                    'Talen',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: TextStyles.unselectedText,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Engels, Italiaans',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(10),
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
                  Text(
                    'Meer over mezelf',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: TextStyles.unselectedText,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: TextStyles.unselectedText,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              SvgPicture.asset(
                JobrIcons.blockquote,
              ),
              SizedBox(height: 5),
              Text(
                'Ik haal mijn energie uit...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Ik sport heel veel en ik vind het leuk om uit te gaan.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              SvgPicture.asset(
                JobrIcons.blockquote,
              ),
              SizedBox(height: 5),
              Text(
                'Mijn favoriete boek is...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Hier typen...',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
