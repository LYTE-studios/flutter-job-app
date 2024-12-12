import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/fonts.dart';
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
    double width = ScreenUtil().screenWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColors.whiteShade,
            borderRadius: BorderRadius.circular(10.r),
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
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.grey,
                          size: 24.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: AppColors.grey,
                          size: 28.sp,
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
                      SizedBox(height: 10.h),
                      Divider(
                        color: AppColors.black.withOpacity(.3),
                      ),
                      SizedBox(height: 10.h),
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
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: width,
                  height: 72.r,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(.1)),
                    child: Text(
                      'Toevoegen',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColors.whiteShade,
            borderRadius: BorderRadius.circular(10.r),
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
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.grey,
                          size: 24.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: AppColors.grey,
                          size: 28.sp,
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
                      SizedBox(height: 10.h),
                      Divider(
                        color: AppColors.black.withOpacity(.3),
                      ),
                      SizedBox(height: 10.h),
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
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: width,
                  height: 72.r,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(.1)),
                    child: Text(
                      'Toevoegen',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColors.whiteShade,
            borderRadius: BorderRadius.circular(10.r),
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
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.grey,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Wrap(
                children: [
                  ...skills.map(
                    (skill) => Container(
                      margin: EdgeInsets.all(5.r),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.all(10.r),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.white,
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
        SizedBox(height: 20.h),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColors.whiteShade,
            borderRadius: BorderRadius.circular(10.r),
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
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.grey,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                'Engels, Italiaans',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColors.whiteShade,
            borderRadius: BorderRadius.circular(10.r),
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
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.grey,
                          size: 24.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: AppColors.grey,
                          size: 28.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              SvgPicture.asset(
                JobrIcons.blockquote,
              ),
              SizedBox(height: 5.h),
              Text(
                'Ik haal mijn energie uit...',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
              Text(
                'Ik sport heel veel en ik vind het leuk om uit te gaan.',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
              SizedBox(height: 20.h),
              SvgPicture.asset(
                JobrIcons.blockquote,
              ),
              SizedBox(height: 5.h),
              Text(
                'Mijn favoriete boek is...',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
              Text(
                'Hier typen...',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
