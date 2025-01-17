import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';

typedef BadgeIcons = (String icon, String name, bool selected);

class EditCompanyProfileScreenTwo extends StatefulWidget {
  static const String route = '/$location';
  static const String location = 'edit-company-profile-two';
  const EditCompanyProfileScreenTwo({super.key});

  @override
  State<EditCompanyProfileScreenTwo> createState() =>
      _EditCompanyProfileScreenTwoState();
}

class _EditCompanyProfileScreenTwoState
    extends State<EditCompanyProfileScreenTwo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController employeeController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    nameController.text = 'Brooklyn';
    websiteController.text = 'www.brooklyn.be';
    employeeController.text = '2-10 werknemers';
    sectorController.text = 'Retail';
    locationController.text = 'Kies locatie';
    bioController.text =
        'Multibrandstores & Webshop. Brooklyn, da’s een mix van merken en heel veel broeken. Dat laatste nemen we als broekenspecialist au sérieux met een jeans assortiment om ‘u’ tegen te zeggen.';
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
    (JobrIcons.facebook, 'Toevoegen', false),
    (JobrIcons.tiktok, 'Toevoegen', false),
    (JobrIcons.instagram, '@brooklyn.be', false),
  ];

  List<String> internalTraining = ['Ja', 'Nee'];
  int selectedInternalTraining = 0;
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
              children: List.generate(badges.length, (index) {
                final badge = badges[index];
                return FittedBox(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        badges[index] = (
                          badges[index].$1,
                          badges[index].$2,
                          !badges[index].$3
                        );
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(63),
                        color: badge.$3
                            ? theme.primaryColor.withOpacity(.1)
                            : HexColor.fromHex('#E4E4E4').withOpacity(.5),
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
                              badge.$3
                                  ? theme.primaryColor
                                  : HexColor.fromHex('#616161'),
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
                              color: badge.$3
                                  ? theme.primaryColor
                                  : HexColor.fromHex('#616161'),
                            ),
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset(
                            badge.$3 ? JobrIcons.close : JobrIcons.addIcon,
                            width: badge.$3 ? 18 : 14,
                            colorFilter: ColorFilter.mode(
                              badge.$3
                                  ? theme.primaryColor
                                  : HexColor.fromHex('#77747473'),
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Bedrijfsnaam',
              nameController,
              readOnly: false,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Sector',
              sectorController,
              readOnly: false,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Website',
              websiteController,
              readOnly: false,
            ),
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
                            horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: theme.primaryColor,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              JobrIcons.location,
                              width: 12,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              locationController.text,
                              style: const TextStyle(
                                fontSize: 15.36,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
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
              readOnly: false,
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
                      child: Row(
                        children: List.generate(
                          internalTraining.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedInternalTraining = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17.84, vertical: 5.25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.34),
                                color: selectedInternalTraining == index
                                    ? theme.primaryColor
                                    : null,
                              ),
                              child: Text(
                                internalTraining[index],
                                style: TextStyle(
                                  fontSize: 16.79,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  color: selectedInternalTraining == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 58,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
                child: const Text(
                  'Maak nieuwe vestiging',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
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
