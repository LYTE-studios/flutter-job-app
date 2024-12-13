import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/text_styles.dart';

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
          width: 100,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subTitle,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 14,
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
