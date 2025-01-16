import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';

class ChooseCompanyScreen extends StatefulWidget {
  static const String location = 'choose-company';

  const ChooseCompanyScreen({super.key});

  @override
  State<ChooseCompanyScreen> createState() => _ChooseCompanyScreenState();
}

class _ChooseCompanyScreenState extends State<ChooseCompanyScreen> {
  List<String> companyNames = [
    'Brunata',
    'Synovo',
    'Terracon',
    'Foodlogica',
    'Cargocast',
    'Aquabyte',
    'Fortive',
    'Serica Energy',
    'Plantronics',
    'Exotec',
    'Infarm',
    'Oberon',
    'Greentomy',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          "Kies een bedrijf",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(width, 41),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Zoek een bedrijf',
                hintStyle: TextStyle(
                  color: HexColor.fromHex('#B7B7B7'),
                  fontSize: 16,
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
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: HexColor.fromHex('#B7B7B7'),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView.builder(
                itemCount: companyNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      companyNames[index],
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 20,
              child: SizedBox(
                height: 58,
                child: FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                  ),
                  icon: SvgPicture.asset(
                    JobrIcons.addIcon,
                    width: 15,
                    height: 15,
                    colorFilter: ColorFilter.mode(
                      HexColor.fromHex('#FFFFFF'),
                      BlendMode.srcIn,
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  label: const Text(
                    'Nieuw bedrijf toevoegen',
                    style: TextStyle(
                      fontSize: 17.5,
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
