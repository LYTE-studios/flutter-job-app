import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';

typedef Branch = (
  String? image,
  String title,
  String description,
  bool isSelected,
);

class NewBranchScreen extends StatefulWidget {
  const NewBranchScreen({super.key});

  @override
  State<NewBranchScreen> createState() => _NewBranchScreenState();
}

class _NewBranchScreenState extends State<NewBranchScreen> {
  List<Branch> branches = [
    (
      JobrIcons.placeholder1,
      'Nieuwe vestiging heeft hetzelfde bedrijfsprofiel',
      'Vestiging met hetzelfde logo, banner, bio, ... \nJe hoeft enkel het vestigingsadres in te geven.',
      true,
    ),
    (
      null,
      'Nieuwe vestiging heeft een ander bedrijfsprofiel',
      'Vestiging met een ander logo, producten, ...',
      false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              JobrIcons.backArrow,
              width: 21,
              height: 21,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Nieuwe vestiging",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 10),
                  ...branches.map(
                    (branch) {
                      return SelectableBranchWidget(
                        branch: branch,
                        width: width,
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 58,
              width: width,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
                child: const Text(
                  'Volgende stap',
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
}

class SelectableBranchWidget extends StatelessWidget {
  const SelectableBranchWidget({
    super.key,
    required this.width,
    required this.branch,
  });

  final double width;
  final Branch branch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: HexColor.fromHex('#F5F5F5'),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 18),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: width,
            height: 111,
            child: Stack(
              clipBehavior: Clip.none, // Allow overflow
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 89,
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#E4E4E4').withOpacity(.5),
                      borderRadius: BorderRadius.circular(16.24),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: Container(
                    width: 67.7,
                    height: 67.7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: HexColor.fromHex('#F5F5F5'),
                        width: 3.16,
                      ),
                      color: HexColor.fromHex('#E4E4E4'),
                    ),
                    alignment: (branch.$1 != null) ? null : Alignment.center,
                    child: (branch.$1 != null)
                        ? Image.asset(
                            branch.$1!,
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(
                            JobrIcons.camera,
                            width: 27,
                            height: 27,
                            colorFilter: ColorFilter.mode(
                              HexColor.fromHex('#AEADAD'),
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              if (branch.$4)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.primaryColor.withOpacity(.3),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.primaryColor,
                    ),
                  ),
                )
              else
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor.fromHex('#E4E4E4'),
                  ),
                ),
              const SizedBox(width: 10),
              SizedBox(
                width: width * .6,
                child: Text(
                  branch.$2,
                  style: TextStyle(
                    fontSize: 15.74,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: HexColor.fromHex('#000000'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            branch.$3,
            style: TextStyle(
              fontSize: 13.61,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: HexColor.fromHex('#A5A5A5'),
            ),
          ),
        ],
      ),
    );
  }
}
