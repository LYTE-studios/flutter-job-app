import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/text_styles.dart';

class MediaWidget extends StatelessWidget {
  const MediaWidget({
    super.key,
    this.image,
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width  = MediaQuery.sizeOf(context).width;
    return Container(
      height: 200,
      width: width * .44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: image == null ? theme.colorScheme.surface : null,
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
          ? Icon(
              CupertinoIcons.plus_circle_fill,
              color: TextStyles.unselectedText,
              size: 32,
            )
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.primaryColor,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                CupertinoIcons.person_fill,
                color: TextStyles.clearText,
              ),
            ),
    );
  }
}
