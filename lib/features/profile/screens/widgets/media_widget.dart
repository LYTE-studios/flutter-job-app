import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class MediaWidget extends StatelessWidget {
  const MediaWidget({
    super.key,
    this.image,
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      height: 200,
      width: width * .43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: image == null ? theme.colorScheme.primaryContainer : null,
        image: image == null
            ? null
            : DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover,
              ),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      alignment: image == null ? Alignment.center : Alignment.topRight,
      child: image == null
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFC4C4C4),
              ),
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(
                JobrIcons.addIcon,
                width: 30,
                height: 20,
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            )
          // Icon(
          //     CupertinoIcons.plus_circle_fill,
          //     color: TextStyles.unselectedText,
          //     size: 32,
          //   )
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.primaryColor,
              ),
              padding: const EdgeInsets.all(5),
              child: Icon(
                CupertinoIcons.person_fill,
                color: TextStyles.clearText,
                size: 28,
              ),
            ),
    );
  }
}
