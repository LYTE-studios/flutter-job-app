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
    Widget content = Row(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16.5,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w500,
                            color:
                                HexColor.fromHex('#00000000').withOpacity(.6),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (edit)
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: HexColor.fromHex('#F62C2C'),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        JobrIcons.close,
                        width: 11,
                        height: 12,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                ],
              ),
              Wrap(
                spacing: 5,
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
                      margin: const EdgeInsets.only(right: 4, left: 4, top: 8),
                      constraints: BoxConstraints(
                          minWidth: 4, minHeight: 4, maxHeight: 4, maxWidth: 4),
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
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: edit
            ? HexColor.fromHex('#D9D9D9').withOpacity(0.31)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: HexColor.fromHex('#00000000'),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: content,
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
                    margin: const EdgeInsets.all(8),
                    constraints: BoxConstraints(
                        minWidth: 4, minHeight: 4, maxHeight: 4, maxWidth: 4),
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
