import 'package:flutter/cupertino.dart';

import '../../../core/constants/colors.dart';

class MediaWidget extends StatelessWidget {
  const MediaWidget({
    super.key,
    this.image,
  });

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: image == null ? AppColors.whiteShade : null,
        image: image == null
            ? null
            : DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover,
              ),
      ),
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(10),
      alignment: image == null ? Alignment.center : Alignment.topRight,
      child: image == null
          ? Icon(
              CupertinoIcons.plus_circle_fill,
              color: AppColors.grey.withOpacity(.6),
              size: 32,
            )
          : Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              padding: EdgeInsets.all(10),
              child: const Icon(
                CupertinoIcons.person_fill,
                color: AppColors.white,
              ),
            ),
    );
  }
}
