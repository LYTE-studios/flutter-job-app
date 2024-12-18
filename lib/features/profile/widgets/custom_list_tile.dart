import 'package:flutter/material.dart';
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
          fit: BoxFit.contain,
          width: 57,
          height: 57,
        ),
        const SizedBox(width: 10),
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
              style:  TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
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
                    fontWeight: FontWeight.w600,
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
                      fontWeight: FontWeight.w600,
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
