import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

import '../../../../ui/theme/jobr_icons.dart';

class SecondForm extends StatefulWidget {
  final double width;

  const SecondForm({super.key, required this.width});

  @override
  State<SecondForm> createState() => _SecondFormState();
}

class _SecondFormState extends State<SecondForm> {
  File? selectedFile;

  Future<void> pickImage() async {
    try {
      // Pick a single file of type image
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          selectedFile = File(result.files.single.path ?? '');
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking file: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        SizedBox(
          width: 188,
          height: 188,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#F7F7F7'),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                width: 188,
                height: 188,
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(width: 8, color: Colors.white),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: selectedFile != null
                          ? FileImage(selectedFile!) as ImageProvider
                          : const AssetImage(
                                  'assets/images/images/placeholder.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 5,
                child: IconButton.filled(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(theme.primaryColor),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.all(10),
                    ),
                  ),
                  onPressed: () {
                    pickImage();
                  },
                  padding: const EdgeInsets.all(5),
                  icon: selectedFile == null
                      ? SvgPicture.asset(
                          JobrIcons.addIcon,
                          width: 21,
                          height: 21,
                          colorFilter: ColorFilter.mode(
                            HexColor.fromHex('#FFFFFF'),
                            BlendMode.srcIn,
                          ),
                        )
                      : SvgPicture.asset(
                          JobrIcons.edit,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            HexColor.fromHex('#FFFFFF'),
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Louis Ottevaere",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SvgIcon(
        //       JobrIcons.location,
        //       size: 16,
        //       leaveUnaltered: true,
        //       color: theme.primaryColor,
        //     ),
        //     const SizedBox(width: 4),
        //     const Text(
        //       "Kortrijk",
        //       style: TextStyle(
        //         fontSize: 17,
        //         fontFamily: 'Inter',
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
