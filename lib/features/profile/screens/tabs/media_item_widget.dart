import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';

import '../widgets/media_widget.dart';

class MediaItemWidget extends StatefulWidget {
  const MediaItemWidget({super.key});

  @override
  State<MediaItemWidget> createState() => _MediaItemWidgetState();
}

class _MediaItemWidgetState extends State<MediaItemWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    double width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Foto\'s & videos',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Voeg foto\'s of video\'s toe van jezelf.',
            style: TextStyle(
              color: TextStyles.unselectedText,
              fontSize: 16,
              fontFamily: 'Poppins',
              letterSpacing: 0.25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: width,
            child: const Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                MediaWidget(
                  image: 'assets/images/images/image.png',
                ),
                MediaWidget(),
                MediaWidget(),
                MediaWidget(),
              ],
            ),
          ),
          const Text(
            'Portfolio',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Voeg hier je portfolio of belangrijke prestaties',
            style: TextStyle(
              color: TextStyles.unselectedText,
              fontSize: 16,
              fontFamily: 'Poppins',
              letterSpacing: 0.15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.colorScheme.primaryContainer,
            ),
            width: width,
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFC4C4C4),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(
                    JobrIcons.addIcon,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Voeg PDF, PNG toe',
                  style: TextStyle(
                    color: Color(0xFFA8A8A8),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
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
