import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.duration,
    this.time,
  });

  final String image;
  final String title;
  final String subTitle;
  final String duration;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          image,
          width: 120,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                if (time != null) ...[
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    time ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ]
              ],
            )
          ],
        ),
      ],
    );
  }
}
