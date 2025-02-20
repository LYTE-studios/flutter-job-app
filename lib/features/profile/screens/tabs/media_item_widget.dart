import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:image_picker/image_picker.dart'; // added dependency
import 'dart:io'; // added dependency

import '../widgets/media_widget.dart';

class MediaItemWidget extends StatefulWidget {
  const MediaItemWidget({super.key});

  @override
  State<MediaItemWidget> createState() => _MediaItemWidgetState();
}

class _MediaItemWidgetState extends State<MediaItemWidget> {
  String? _portfolioImagePath; // added state variable

  Future<void> _pickPortfolioImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _portfolioImagePath = pickedFile.path;
      });
    }
  }

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
          GestureDetector(
            onTap: _pickPortfolioImage, // trigger image picker
            child: Container(
              height: 170,
              width: width,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: theme.colorScheme.primaryContainer,
                image: _portfolioImagePath == null
                    ? null
                    : DecorationImage(
                        image: _portfolioImagePath!.startsWith('assets/')
                            ? AssetImage(_portfolioImagePath!)
                            : FileImage(File(_portfolioImagePath!))
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
              ),
              child: _portfolioImagePath == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFC4C4C4),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: SvgPicture.asset(
                            JobrIcons.addIcon,
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          'Voeg PDF, PNG toe',
                          style: TextStyle(
                            color: Color(0xFFA8A8A8),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
