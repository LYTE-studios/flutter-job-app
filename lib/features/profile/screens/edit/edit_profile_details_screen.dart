import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../core/utils/input_formatters.dart';
import '../../../../ui/theme/jobr_icons.dart';
import '../../../../ui/theme/text_styles.dart';
import '../../../dashboard/base/base_dashboard_screen.dart';

class EditProfileDetailsScreen extends StatefulWidget {
  static const String route = '${BaseEmployeeDashboard.route}/$location';
  static const String location = 'edit-profile';
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

  @override
  void initState() {
    nameController.text = 'Louis Ottevaere';
    emailController.text = 'louisottevaere@gmail.com';
    phoneController.text = '+32472181414';
    dobController.text = '30 jaar';
    locationController.text = 'Kies locatie';
    bioController.text =
        'Multibrandstores & Webshop. Brooklyn, da’s een mix van merken en heel veel broeken. Dat laatste nemen we als broekenspecialist au sérieux met een jeans assortiment om ‘u’ tegen te zeggen.';
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
                      child: Image.asset(
                        'assets/images/images/image-4.png',
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
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/images/profile.png'),
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
                                onPressed: () {},
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
                        onPressed: () {},
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
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Wijzigingen opslaan',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
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
            _buildTextField('Naam en voornaam', nameController),
            const SizedBox(height: 10),
            _buildTextField('Email', emailController),
            const SizedBox(height: 10),
            _buildTextField(
              'Telefoon',
              phoneController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                PhoneNumberFormatter(),
              ],
              keyboardType: TextInputType.phone,
              readOnly: false,
              color: Colors.black,
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
            _buildTextField('Geboorte-datum', dobController),
            const SizedBox(height: 10),
            _buildTextField(
              'Bio',
              bioController,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              color: Colors.black,
              readOnly: false,
            ),
            const SizedBox(height: 10),
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
          width: 87,
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.text,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: HexColor.fromHex('#919191'),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    CupertinoIcons.info,
                    color: HexColor.fromHex('#919191'),
                    size: 18,
                  )
                ],
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
                color: color ?? HexColor.fromHex('#919191'),
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
