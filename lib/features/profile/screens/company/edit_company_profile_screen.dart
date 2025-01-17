import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

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
  TextEditingController employeeController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    nameController.text = 'Bedrijfsnaam';
    websiteController.text = 'https://jouw-website.com';
    employeeController.text = 'Kies een aantal';
    sectorController.text = 'Maak een keuze';
    locationController.text = 'Kies locatie';
    bioController.text = 'Schrijf een biografie';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    websiteController.dispose();
    employeeController.dispose();
    bioController.dispose();
    sectorController.dispose();
    locationController.dispose();
    super.dispose();
  }

  List<BadgeIcons> badges = [
    (JobrIcons.facebook, 'Toevoegen'),
    (JobrIcons.tiktok, 'Toevoegen'),
    (JobrIcons.instagram, 'Toevoegen'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                            color: HexColor.fromHex('#E4E4E4').withOpacity(.5)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5.64,
                          ),
                          color: HexColor.fromHex('#E4E4E4'),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          JobrIcons.camera,
                          width: 42,
                          height: 42,
                          colorFilter: ColorFilter.mode(
                            HexColor.fromHex('#AEADAD'),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      right: 10,
                      child: InkWell(
                        onTap: () {},
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: HexColor.fromHex('#E5E5EA'),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            JobrIcons.close,
                            width: 22,
                            height: 22,
                            colorFilter: ColorFilter.mode(
                              HexColor.fromHex('#8E8E93'),
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
                  (badge) => FittedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(63),
                        color: HexColor.fromHex('#E4E4E4').withOpacity(.5),
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
                            badge.$2,
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
              ],
            ),
            const SizedBox(height: 15),
            InkWell(
              borderRadius: BorderRadius.circular(63),
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
            Container(
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
            const SizedBox(height: 10),
            _buildTextField('Bedrijfsnaam', nameController),
            const SizedBox(height: 10),
            _buildTextField('Website', websiteController),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 87,
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Locatie',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: HexColor.fromHex('#565656'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black.withOpacity(.2),
                        ),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: FittedBox(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: Row(
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
                              locationController.text,
                              style: const TextStyle(
                                fontSize: 15.36,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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
            const SizedBox(height: 10),
            _buildTextField(
              'Werknemers',
              employeeController,
              readOnly: false,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Bio',
              bioController,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              color: Colors.black,
              readOnly: true,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Sector',
              sectorController,
              readOnly: false,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Werknemers',
              employeeController,
              readOnly: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = true,
    int? maxLines,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 101,
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: HexColor.fromHex('#565656'),
            ),
          ),
        ),
        const SizedBox(width: 10),
        if (readOnly)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(.2),
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: maxLines != null && maxLines == 3
                  ? const EdgeInsets.only(top: 10, bottom: 40)
                  : const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                controller.text,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: HexColor.fromHex('#919191'),
                ),
              ),
            ),
          )
        else
          Expanded(
            child: TextFormField(
              keyboardType: keyboardType,
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: color ?? HexColor.fromHex('#000000'),
              ),
              inputFormatters: inputFormatters,
              readOnly: readOnly,
              maxLines: maxLines,
              decoration: InputDecoration(
                filled: false,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(.2),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 0,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(.2),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
