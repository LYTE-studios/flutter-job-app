import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../widgets/media_widget.dart';

class MediaItemWidget extends StatefulWidget {
  const MediaItemWidget({super.key});

  @override
  State<MediaItemWidget> createState() => _MediaItemWidgetState();
}

class _MediaItemWidgetState extends State<MediaItemWidget> {
  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil().screenWidth;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Foto\'s & videos',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'Voeg foto\'s of video\'s toe van jezelf.',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: width,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                MediaWidget(
                  width: width,
                  image: 'assets/images/images/image.png',
                ),
                MediaWidget(width: width),
                MediaWidget(width: width),
                MediaWidget(width: width),
              ],
            ),
          ),
          Text(
            'Portfolio',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'Voeg hier je portfolio of belangrijke prestaties',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: width,
            height: 170.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: AppColors.whiteShade,
            ),
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.all(10.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.plus_circle_fill,
                  color: AppColors.grey.withOpacity(.6),
                  size: 32.sp,
                ),
                SizedBox(height: 5.h),
                Text(
                  'Voeg PDF, PNG toe',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
