import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/profile/screens/edit/choose_sector_screen.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';

class CreateNewCompanyScreen extends StatefulWidget {
  static const String location = 'create-company';
  static String route = JobrRouter.getRoute(
    '${ProfileScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );
  const CreateNewCompanyScreen({super.key});

  @override
  State<CreateNewCompanyScreen> createState() => _CreateNewCompanyScreenState();
}

class _CreateNewCompanyScreenState extends State<CreateNewCompanyScreen> {
  File? selectedFile;
  File? selectedFile2;
  Sector? selectedSector;

  Future<File?> pickImage() async {
    try {
      // Pick a single file of type image
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        return selectedFile = File(result.files.single.path ?? '');
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              JobrIcons.close,
              width: 15,
              height: 15,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Nieuw bedrijf",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Nieuw bedrijf toevoegen",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Voeg eenvoudig een bedrijf toe met alleen logo, naam en sector, en gebruik het op je profiel!",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(.37)),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 104,
              height: 104,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Container(
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex('#F6F6F6'),
                        border: selectedFile != null
                            ? Border.all(
                                width: 1, color: Colors.black.withOpacity(.3))
                            : null,
                        borderRadius: BorderRadius.circular(17.33),
                        image: selectedFile != null
                            ? DecorationImage(
                                image:
                                    FileImage(selectedFile!) as ImageProvider,
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: IconButton.filled(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            selectedFile != null
                                ? theme.primaryColor
                                : HexColor.fromHex('#A3A3A3')),
                      ),
                      onPressed: () async {
                        final image = await pickImage();
                        if (selectedFile == null) return;
                        setState(() {
                          selectedFile = image;
                        });
                      },
                      icon: selectedFile == null
                          ? SvgPicture.asset(
                              JobrIcons.add,
                              width: 20,
                              height: 20,
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
            _buildTextField('Bedrijfsnaam', 'Hier typen...'),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                text: 'Sector',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                final chosenSector =
                    await context.push(ChooseSectorScreen.route);
                if (chosenSector is Sector) {
                  setState(() {
                    selectedSector = chosenSector;
                  });
                }
              },
              borderRadius: BorderRadius.circular(17.33),
              child: Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#F6F6F6'),
                  border: selectedFile2 != null
                      ? Border.all(
                          width: 1, color: Colors.black.withOpacity(.3))
                      : null,
                  borderRadius: BorderRadius.circular(17.33),
                ),
                alignment: Alignment.center,
                child: selectedSector != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            selectedSector!.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            selectedSector!.name, // for example
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      )
                    : SvgPicture.asset(
                        JobrIcons.addIcon,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(.3),
                          BlendMode.srcIn,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: FilledButton(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(65),
              ),
              backgroundColor: HexColor.fromHex("#FF3E68"),
            ),
            onPressed: () {
              // Handle new company creation
            },
            child: const Text(
              'Nieuw bedrijf toevoegen +',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 17.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: keyboardType,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: HexColor.fromHex('#B7B7B7'),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: HexColor.fromHex('#F7F7F7'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}
