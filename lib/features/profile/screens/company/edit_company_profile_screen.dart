import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/data/models/employee_type.dart';
import 'package:jobr/data/models/sector_type.dart';
import 'package:jobr/features/job_listing/widgets/employee_type_bottom_sheet.dart';
import 'package:jobr/features/job_listing/widgets/sector_type_bottom_sheet.dart';
import 'package:jobr/features/profile/screens/company/select_location_page.dart';
import 'package:jobr/features/profile/screens/company_screen/company_venue_profile.dart';
import 'package:jobr/features/profile/screens/widgets/media_widget.dart';
import 'package:jobr/features/profile/screens/widgets/selection_text_field.dart';
import 'package:jobr/features/profile/screens/widgets/text_field_settings.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../../ui/theme/jobr_icons.dart';
import 'new_branch_screen.dart';

typedef BadgeIcons = (String icon, String name);

class EditCompanyProfileScreen extends StatefulWidget {
  static const String route = '/$location';
  static const String location = 'edit-company-profile';
  const EditCompanyProfileScreen({super.key});

  @override
  State<EditCompanyProfileScreen> createState() =>
      _EditCompanyProfileScreenState();
}

class _EditCompanyProfileScreenState extends State<EditCompanyProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController employee1Controller = TextEditingController();
  TextEditingController employee2Controller = TextEditingController();
  TextEditingController numberOfBranches = TextEditingController();

  TextEditingController bioController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final hintTextStyle = TextStyle(
    fontSize: 16,
    letterSpacing: 0.05,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  String? facebookUsername;

  File? bannerImage;
  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  final Map<String, String> selectedAnswers = {
    'question1': 'Ja',
    'question2': 'Nee',
  };

  Future<void> _pickImage(bool isBanner) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isBanner) {
          bannerImage = File(pickedFile.path);
        } else {
          profileImage = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        setState(() {
          facebookUsername = userData['name'];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logged in as $facebookUsername')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${result.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void initState() {
    // nameController.text = 'Bedrijfsnaam';
    // websiteController.text = 'https://jouw-website.com';
    // employeeController.text = 'Kies locatie';
    // sectorController.text = 'Maak een keuze';
    locationController.text = 'Kies locatie';
    // bioController.text = 'Schrijf een biografie';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    websiteController.dispose();
    employee1Controller.dispose();
    employee2Controller.dispose();
    numberOfBranches.dispose();
    bioController.dispose();
    sectorController.dispose();
    locationController.dispose();
    super.dispose();
  }

  List<BadgeIcons> badges = [
    (JobrIcons.facebook, 'Facebook'),
    (JobrIcons.tiktok, 'Tiktok'),
    (JobrIcons.instagram, 'Instagram'),
  ];

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
                  title: null,
                  scrolledUnderElevation: 0,
                  elevation: 0,
                  automaticallyImplyLeading: false,
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
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                image: bannerImage != null
                                    ? DecorationImage(
                                        image: FileImage(bannerImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                color: HexColor.fromHex('#E4E4E4')
                                    .withOpacity(.5)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 10,
                          child: GestureDetector(
                            onTap: () => _pickImage(false),
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                image: profileImage != null
                                    ? DecorationImage(
                                        image: FileImage(profileImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5.64,
                                ),
                                color: HexColor.fromHex('#E4E4E4'),
                              ),
                              alignment: Alignment.center,
                              child: profileImage == null
                                  ? SvgPicture.asset(
                                      JobrIcons.camera,
                                      width: 42,
                                      height: 42,
                                      colorFilter: ColorFilter.mode(
                                        HexColor.fromHex('#AEADAD'),
                                        BlendMode.srcIn,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 130,
                          right: 10,
                          child: InkWell(
                            onTap: () => _pickImage(true),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 50.9,
                              height: 40,
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                JobrIcons.edit,
                                width: 16.95,
                                height: 16.95,
                                colorFilter: ColorFilter.mode(
                                  HexColor.fromHex('#FFFFFF'),
                                  BlendMode.srcIn,
                                ),
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
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ...badges.map(
                      (badge) => GestureDetector(
                        onTap:
                            badge.$2 == 'Facebook' ? _loginWithFacebook : null,
                        child: FittedBox(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(63),
                              color:
                                  HexColor.fromHex('#E4E4E4').withOpacity(.5),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SvgPicture.asset(
                                  badge.$1,
                                  width: 22,
                                  height: 22,
                                  colorFilter: ColorFilter.mode(
                                    HexColor.fromHex('#616161'),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  badge.$2 == 'Facebook' &&
                                          facebookUsername != null
                                      ? facebookUsername!
                                      : badge.$2,
                                  style: TextStyle(
                                    fontSize: 15.2,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: HexColor.fromHex('#616161'),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  JobrIcons.addIcon,
                                  width: 14,
                                  colorFilter: ColorFilter.mode(
                                    HexColor.fromHex('#77747473'),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(64),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const NewBranchScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(63),
                      color: theme.primaryColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Vestiging toevoegen',
                          style: TextStyle(
                            fontSize: 15.2,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: HexColor.fromHex('#FFFFFF'),
                          ),
                        ),
                        Icon(
                          CupertinoIcons.add,
                          color: HexColor.fromHex('#FFFFFF'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    context.push(CompanyVenueProfile.employerRoute);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: HexColor.fromHex('#F5F5F5'),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              width: 45,
                              height: 45,
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                JobrIcons.placeholder1,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Brooklyn',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    color: HexColor.fromHex('#000000'),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      JobrIcons.location,
                                      width: 12,
                                      colorFilter: ColorFilter.mode(
                                        theme.primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Gent, Voorstraat',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: HexColor.fromHex('#666666'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: const Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      MediaWidget(),
                      MediaWidget(),
                    ],
                  ),
                ),
                TextFieldSettings(
                    label: 'Bedrijfsnaam',
                    hintText: 'Bedrijfsnaam',
                    controller: nameController,
                    readOnly: false),
                const SizedBox(height: 10),
                TextFieldSettings(
                  label: 'Website',
                  hintText: 'https://jouw-website.com',
                  controller: websiteController,
                  readOnly: false,
                ),
                const SizedBox(height: 10),
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
                SelectionButton(
                  label: 'Werknemers',
                  controller: employee1Controller,
                  hintText: 'Aantal ',
                  hintTextStyle: hintTextStyle,
                  prefixIcon: null,
                  onTap: () => EmployeeTypeBottomSheet(
                    title: "Kies een functie",
                    onSelected: (EmployeeType value) {
                      setState(() {
                        employee1Controller.text = value.name;
                      });
                    },
                  ).showBottomSheet(context: context),
                ),
                const SizedBox(height: 10),
                TextFieldSettings(
                  label: 'Bio',
                  hintText: 'Schrijf een biografie',
                  controller: bioController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  color: Colors.black,
                  readOnly: false,
                ),
                const SizedBox(height: 10),
                TextFieldSettings(
                    label: 'Aantal vestigingen',
                    controller: numberOfBranches,
                    readOnly: false,
                    hintText: 'Aantal',
                    keyboardType: TextInputType.phone,
                    hintTextStyle: hintTextStyle),
                const SizedBox(height: 10),
                SelectionButton(
                  label: 'Sector',
                  hintText: 'Maak een keuze',
                  controller: sectorController,
                  hintTextStyle: hintTextStyle,
                  onTap: () => SectorTypeBottomSheet(
                    onSelected: (SectorType value) {
                      setState(() {
                        sectorController.text = value.name;
                      });
                    },
                    title: "Kies één of meerdere",
                  ).showBottomSheet(context: context),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 101,
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Interne opleiding',
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
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black.withOpacity(.06),
                              ),
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 4),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (var answer in ['Ja', 'Nee'])
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedAnswers['question1'] =
                                                answer;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: selectedAnswers[
                                                        'question1'] ==
                                                    answer
                                                ? HexColor.fromHex("#FF3E68")
                                                : Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            answer,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: selectedAnswers[
                                                          'question1'] ==
                                                      answer
                                                  ? Colors.white
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: InkWell(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#E5E5EA'),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  JobrIcons.close,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    HexColor.fromHex('#8E8E93'),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: PrimaryButton(
                buttonColor: HexColor.fromHex("#FF3E68"),
                height: 58,
                borderRadius: 60,
                width: MediaQuery.of(context).size.width * 0.88,
                onTap: () {
                  context.pop();
                },
                buttonText: 'Save',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
