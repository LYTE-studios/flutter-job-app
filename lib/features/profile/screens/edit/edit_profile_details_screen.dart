import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/job_listing/widgets/status_type_bottomsheet.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Added import for File
import 'package:jobr/features/profile/screens/widgets/text_field_settings.dart'; // New import
import 'package:jobr/features/profile/screens/company/select_location_page.dart'; // New import for location selection
import 'package:jobr/ui/widgets/buttons/primary_button.dart'; // New import
import 'package:flutter/scheduler.dart'; // NEW import

import '../../../../core/utils/input_formatters.dart';
import '../../../../ui/theme/jobr_icons.dart';
import '../../../../ui/theme/text_styles.dart';

class EditProfileDetailsScreen extends StatefulWidget {
  static const String location = 'edit-profile';

  static String route = JobrRouter.getRoute(
    '${ProfileScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );

  const EditProfileDetailsScreen({super.key});

  @override
  State<EditProfileDetailsScreen> createState() =>
      _EditProfileDetailsScreenState();
}

class _EditProfileDetailsScreenState extends State<EditProfileDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  String backgroundImage = 'assets/images/images/image-4.png';
  String profileImage = 'assets/images/images/profile.png';

  Future<void> _pickImage(bool isBackground) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isBackground) {
          backgroundImage = pickedFile.path;
        } else {
          profileImage = pickedFile.path;
        }
      });
    }
  }

  @override
  void initState() {
    locationController.text = 'Kies locatie';

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    dobController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 210,
                  floating: false,
                  pinned: true,
                  title: innerBoxIsScrolled
                      ? const Text(
                          "Louis Ottevaere",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : null,
                  scrolledUnderElevation: 0,
                  elevation: 0,
                  leading: Center(
                    child: InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          JobrIcons.backArrow,
                          width: 19,
                          height: 19,
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: theme.colorScheme.surface,
                  clipBehavior: Clip.none,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      clipBehavior: Clip.none, // Allow overflow
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: backgroundImage.startsWith('assets/')
                              ? Image.asset(
                                  backgroundImage,
                                  fit: BoxFit.cover,
                                  height: 180,
                                )
                              : Image.file(
                                  File(backgroundImage),
                                  fit: BoxFit.cover,
                                  height: 180,
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 10,
                          child: SizedBox(
                            width: 140,
                            height: 140,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    width: 140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4,
                                      ),
                                      image: DecorationImage(
                                        image:
                                            profileImage.startsWith('assets/')
                                                ? AssetImage(profileImage)
                                                : FileImage(File(profileImage))
                                                    as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton.filled(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          theme.primaryColor),
                                      padding: const WidgetStatePropertyAll(
                                        EdgeInsets.all(10),
                                      ),
                                    ),
                                    onPressed: () => _pickImage(false),
                                    padding: const EdgeInsets.all(5),
                                    icon: SvgPicture.asset(
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
                        ),
                        Positioned(
                          top: 120,
                          right: 10,
                          child: IconButton(
                            onPressed: () => _pickImage(true),
                            style: IconButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                            ),
                            icon: SvgPicture.asset(
                              JobrIcons.edit,
                              width: 21.68,
                              height: 21.68,
                              colorFilter: ColorFilter.mode(
                                TextStyles.clearText,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const ClampingScrollPhysics(),
              children: [
                const SizedBox(height: 15),
                // Replaced _buildTextField calls with TextFieldSettings
                TextFieldSettings(
                  inputTextStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF919191),
                  ),
                  label: 'Naam en voornaam',
                  hintText: 'Naam en voornaam',
                  controller: nameController,
                  readOnly: false,
                ),
                const SizedBox(height: 10),
                TextFieldSettings(
                  inputTextStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF919191),
                  ),
                  label: 'Email',
                  hintText: 'Email',
                  controller: emailController,
                  readOnly: false,
                ),
                const SizedBox(height: 10),
                TextFieldSettings(
                  inputTextStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  label: 'Telefoon',
                  hintText: 'Telefoon',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+]+')),
                    PhoneNumberFormatter(),
                  ],
                  readOnly: false,
                  color: Colors.black,
                ),

                const SizedBox(height: 10),

                // Replaced custom location row with SelectionButton
                SelectionButton(
                  label: 'Statuut',
                  hintText: 'Student',
                  controller: statusController,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      'Aanpassen',
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () {
                    StatusTypeBottomSheet(
                      title: "Kies een bedrijf",
                      onSelected: (statusType) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            statusController.text = statusType.name;
                          });
                        });
                      },
                    ).showPopup(context: context);
                  },
                ),
                const SizedBox(height: 10),
                // Replaced custom location row with SelectionButton
                SelectionButton(
                  label: 'Locatie',
                  hintText: 'Kies locatie',
                  controller: locationController,
                  prefixIcon: SvgPicture.asset(
                    JobrIcons.location,
                    width: 12,
                    colorFilter: ColorFilter.mode(
                      theme.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectLocationPage()),
                    ).then((value) {
                      if (value != null) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            locationController.text = value.toString();
                          });
                        });
                      }
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFieldSettings(
                  inputTextStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF919191),
                  ),
                  label: 'Geboorte-datum',
                  hintText: 'Geboorte-datum',
                  controller: dobController,
                  readOnly: false,
                ),
                const SizedBox(height: 10),
                TextFieldSettings(
                  inputTextStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  label: 'Bio',
                  hintText: 'Schrijf bio',
                  controller: bioController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  color: Colors.black,
                  readOnly: false,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: PrimaryButton(
                onTap: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    context.pop();
                  });
                },
                buttonText: 'Save',
                buttonColor: HexColor.fromHex("#FF3E68"),
                height: 58,
                borderRadius: 60,
                width: MediaQuery.of(context).size.width * 0.88,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectionButton extends StatefulWidget {
  const SelectionButton(
      {super.key,
      required this.label,
      required this.controller,
      this.color,
      this.hintText = 'Kies locatie',
      this.hintTextStyle = const TextStyle(
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        color: Color(0xFF919191),
      ),
      this.leading,
      this.onTap,
      this.prefixIcon});
  final Widget? prefixIcon;
  final Widget? leading;
  final String label;
  final TextEditingController controller;

  final Color? color;
  final TextStyle hintTextStyle;
  final String hintText;
  final GestureTapCallback? onTap;

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    bool isLocationSelected =
        widget.label == 'Locatie' && widget.controller.text != widget.hintText;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            widget.label.padRight(12),
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: HexColor.fromHex('#565656'),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: widget.onTap,
            child: isLocationSelected
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IntrinsicWidth(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black.withOpacity(.06),
                                  ),
                                ),
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.prefixIcon != null)
                                  SvgPicture.asset(
                                    JobrIcons.location,
                                    width: 12,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    widget.controller.text,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15.36,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.05,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (widget.leading != null) widget.leading!,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black.withOpacity(.06),
                      )
                    ],
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black.withOpacity(.06),
                        ),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        if (widget.prefixIcon != null) widget.prefixIcon!,
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.controller.text.isEmpty
                                ? widget.hintText
                                : widget.controller.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: widget.controller.text.isEmpty
                                ? widget.hintTextStyle
                                : const TextStyle(
                                    fontSize: 15.36,
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0.05,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                        if (widget.leading != null) widget.leading!,
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
