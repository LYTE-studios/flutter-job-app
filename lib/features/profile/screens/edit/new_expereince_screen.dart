import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';
import '../../../dashboard/base/base_dashboard_screen.dart';
import '../../models/list_model.dart';
import '../../widgets/custom_list_tile.dart';

class NewExpereinceScreen extends StatefulWidget {
  static const String route = '${BaseDashboardScreen.route}/$location';
  static const String location = 'new-experience';
  const NewExpereinceScreen({super.key});

  @override
  State<NewExpereinceScreen> createState() => _NewExpereinceScreenState();
}

class _NewExpereinceScreenState extends State<NewExpereinceScreen> {
  ListData initialExperience = ListData(
    image: 'assets/images/images/image-1.png',
    title: 'Sommelier',
    subTitle: "MAGMA",
    duration: 'Nov 2017 - Feb 2021',
    time: '3 jr 3 mnd',
  );
  TextEditingController companyController = TextEditingController();
  TextEditingController functionController = TextEditingController();

  @override
  void initState() {
    companyController.text = initialExperience.subTitle;
    functionController.text = initialExperience.title;
    super.initState();
  }

  @override
  void dispose() {
    companyController.dispose();
    functionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              JobrIcons.close,
              width: 30,
              height: 30,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Nieuwe ervaring",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: CustomListTile2(
              image: initialExperience.image,
              title: initialExperience.title,
              subTitle: initialExperience.subTitle,
              duration: initialExperience.duration,
              time: initialExperience.time,
              centerImage: true,
            ),
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 20),
          _buildTextField(
            'Bedrijf',
            '',
            controller: companyController,
            suffixIcon: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                JobrIcons.edit,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  theme.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            'Functie',
            '',
            controller: functionController,
            suffixIcon: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                JobrIcons.edit,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  theme.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildPerioudField(
            'Periode',
            '',
            controller: functionController,
            suffixIcon: SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                JobrIcons.calenda,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Center(
          child: SizedBox(
            width: width,
            height: 58,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: theme.primaryColor,
                // shape: RoundedRectangleBorder(),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onPressed: () {},
              child: const Text(
                "Toon resultaten",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
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
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
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
            suffix: suffixIcon,
            prefix: prefixIcon,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPerioudField(
    String label,
    String hint, {
    TextEditingController? controller,
    Widget? suffixIcon,
  }) {
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
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: HexColor.fromHex('#F7F7F7'),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#A4A4A4').withOpacity(.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.only(right: 5),
                width: 52,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: const Text(
                  'Van',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Kies een datum',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: HexColor.fromHex('#BEBEBE'),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 0,
                      ),
                    ),
                  ),
                ),
              ),
              suffixIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: HexColor.fromHex('#F7F7F7'),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#A4A4A4').withOpacity(.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.only(right: 5),
                width: 52,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: const Text(
                  'Tot',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      filled: false,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Kies een datum',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: HexColor.fromHex('#BEBEBE'),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 0,
                      ),
                    ),
                  ),
                ),
              ),
              suffixIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
