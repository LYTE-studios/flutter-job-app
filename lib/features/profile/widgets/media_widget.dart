
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';

class MediaWidget extends StatelessWidget {
  const MediaWidget({
    super.key,
    required this.width,
    this.image,
  });

  final double width;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.44,
      height: 300.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: image == null ? AppColors.whiteShade : null,
        image: image == null
            ? null
            : DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover,
              ),
      ),
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(10.r),
      alignment: image == null ? Alignment.center : Alignment.topRight,
      child: image == null
          ? Icon(
              CupertinoIcons.plus_circle_fill,
              color: AppColors.grey.withOpacity(.6),
              size: 32.sp,
            )
          : Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              padding: EdgeInsets.all(10.r),
              child: const Icon(
                CupertinoIcons.person_fill,
                color: AppColors.white,
              ),
            ),
    );
  }
}
