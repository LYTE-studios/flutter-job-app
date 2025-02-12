import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.duration,
    this.time,
    this.centerImage = false,
    this.edit = false,
  });

  final String image;
  final String title;
  final String subTitle;
  final String duration;
  final String? time;
  final bool centerImage;
  final bool edit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width = MediaQuery.sizeOf(context).width;
    return Row(
      crossAxisAlignment:
          centerImage ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image,
            fit: BoxFit.contain,
            width: 57,
            height: 57,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          // Wrap the Column with Expanded
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16.5,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.4,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: HexColor.fromHex('#00000000').withOpacity(.6),
                        ),
                      ),
                    ],
                  ),
                  if (edit)
                    Container(
                        // padding: const EdgeInsets.all(5),
                        // decoration: BoxDecoration(
                        //   shape: BoxShape.circle,
                        //   color: HexColor.fromHex('#F62C2C'),
                        // ),
                        // alignment: Alignment.center,
                        // child: SvgPicture.asset(
                        //   JobrIcons.close,
                        //   width: 18,
                        //   height: 18,
                        //   colorFilter: const ColorFilter.mode(
                        //     Colors.white,
                        //     BlendMode.srcIn,
                        //   ),
                        // ),
                        ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: TextStyles.unselectedText,
                    ),
                  ),
                  if (time != null) ...[
                    Container(
                      margin: const EdgeInsets.all(7),
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: TextStyles.unselectedText,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      time ?? '',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: TextStyles.unselectedText,
                      ),
                    ),
                  ]
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListTile2 extends StatelessWidget {
  const CustomListTile2({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.duration,
    this.time,
    this.centerImage = false,
  });

  final String image;
  final String title;
  final String subTitle;
  final String duration;
  final String? time;
  final bool centerImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          centerImage ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          image,
          fit: BoxFit.contain,
          width: 61,
          height: 61,
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.5,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: HexColor.fromHex('#00000000').withOpacity(.6),
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: TextStyles.unselectedText,
                  ),
                ),
                if (time != null) ...[
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: TextStyles.unselectedText,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    time ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: TextStyles.unselectedText,
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
