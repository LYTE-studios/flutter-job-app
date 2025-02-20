import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:image_picker/image_picker.dart'; // added dependency
import 'dart:io'; // added import

class MediaWidget extends StatefulWidget {
  final String? image;
  const MediaWidget({
    super.key,
    this.image,
  });

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.image;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        width: width * .43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _imagePath == null ? theme.colorScheme.primaryContainer : null,
          image: _imagePath == null
              ? null
              : DecorationImage(
                  image: _imagePath!.startsWith('assets/')
                      ? AssetImage(
                          _imagePath!) // use asset image if path starts with assets/
                      : FileImage(File(_imagePath!))
                          as ImageProvider, // else use file image
                  fit: BoxFit.cover,
                ),
        ),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        alignment: _imagePath == null ? Alignment.center : Alignment.topRight,
        child: _imagePath == null
            ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFC4C4C4),
                ),
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  JobrIcons.addIcon,
                  width: 30,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              )
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
      ),
    );
  }
}
