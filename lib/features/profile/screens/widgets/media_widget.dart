import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MediaWidget extends StatefulWidget {
  final String? image;
  const MediaWidget({Key? key, this.image}) : super(key: key);

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  String? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        if ((widget.image == null || widget.image!.isEmpty) &&
            _selectedImage == null) {
          _pickImage();
        }
      },
      child: Container(
        height: 200,
        width: width * .43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:
              widget.image == null ? theme.colorScheme.primaryContainer : null,
          image: _selectedImage != null ||
                  (widget.image != null && widget.image!.isNotEmpty)
              ? DecorationImage(
                  image: FileImage(File(_selectedImage ?? widget.image!)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        alignment: widget.image == null ? Alignment.center : Alignment.topRight,
        child: _selectedImage != null ||
                (widget.image != null && widget.image!.isNotEmpty)
            ? Container(
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
              )
            : Container(
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
              ),
      ),
    );
  }
}
