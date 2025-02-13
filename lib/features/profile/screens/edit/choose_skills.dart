import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class ChooseSkillsScreen extends StatefulWidget {
  const ChooseSkillsScreen({super.key});

  static const String location = 'choose-skills';
  static String route = JobrRouter.getRoute(
    location,
    JobrRouter.employeeInitialroute,
  );

  @override
  State<ChooseSkillsScreen> createState() => _ChooseSkillsScreenState();
}

class _ChooseSkillsScreenState extends State<ChooseSkillsScreen> {
  final List<String> creatiefSkillsOne = [
    '🎨 Kunst',
    '💃 Dansen',
    '✍️ Design',
    '💄 Make-up',
    '📷 Content creation',
    '🎤 Zingen',
    '📝 Schrijven',
  ];
  final List<String> creatiefSkillsTwo = [
    '🎧 Muziek',
    '👩‍🍳 Koken',
    '💻 Programmeren',
    '🎬 Filmen',
    '⚽ Voetbal',
    '🏀 Basketbal',
    '🎸 Gitaarspelen',
  ];

  List<String> selectedCreatiefOne = [];
  List<String> selectedCreatiefTwo = [];

  void toggleSkillOne(String skill) {
    setState(() {
      if (selectedCreatiefOne.contains(skill)) {
        selectedCreatiefOne.remove(skill);
      } else if (selectedCreatiefOne.length < 5) {
        selectedCreatiefOne.add(skill);
      }
    });
  }

  void toggleSkillTwo(String skill) {
    setState(() {
      if (selectedCreatiefTwo.contains(skill)) {
        selectedCreatiefTwo.remove(skill);
      } else if (selectedCreatiefTwo.length < 5) {
        selectedCreatiefTwo.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled =
        (selectedCreatiefOne.length + selectedCreatiefTwo.length) >= 5;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Mijn hard skills",
          style: TextStyles.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(PaddingSizes.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kies minimaal 5 skills',
                      style: TextStyle(
                        color: Color(0xFF6D6D6D),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Display selected skills again
                    if (selectedCreatiefOne.isNotEmpty ||
                        selectedCreatiefTwo.isNotEmpty) ...[
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          ...selectedCreatiefOne.map(
                            (skill) => Container(
                              decoration: BoxDecoration(
                                color: HexColor.fromHex('#191919'),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    skill,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      selectedCreatiefOne.remove(skill);
                                    }),
                                    child: SvgPicture.asset(
                                      JobrIcons.close,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                      width: 12,
                                      height: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ...selectedCreatiefTwo.map(
                            (skill) => Container(
                              decoration: BoxDecoration(
                                color: HexColor.fromHex('#191919'),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    skill,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      selectedCreatiefTwo.remove(skill);
                                    }),
                                    child: SvgPicture.asset(
                                      JobrIcons.close,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                      width: 12,
                                      height: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Divider(
                        thickness: 1.3,
                        color: Color(0xFF0000000).withOpacity(0.04),
                      ),
                      const SizedBox(height: 6),
                    ],

                    // First Creatief Section
                    Text("Creatief", style: TextStyles.titleMedium),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: creatiefSkillsOne.map((skill) {
                        final isSelected = selectedCreatiefOne.contains(skill);
                        return GestureDetector(
                          onTap: () => toggleSkillOne(skill),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? HexColor.fromHex('#191919')
                                  : Colors.white,
                              border: Border.all(
                                  width: 1.5,
                                  color: HexColor.fromHex('#191919')),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              skill,
                              style: TextStyle(
                                fontSize: 15,
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Second Creatief Section
                    Text("Creatief", style: TextStyles.titleMedium),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: creatiefSkillsTwo.map((skill) {
                        final isSelected = selectedCreatiefTwo.contains(skill);
                        return GestureDetector(
                          onTap: () => toggleSkillTwo(skill),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? HexColor.fromHex('#191919')
                                  : Colors.white,
                              border: Border.all(
                                  width: 1.5,
                                  color: HexColor.fromHex('#191919')),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              skill,
                              style: TextStyle(
                                fontSize: 15,
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: PaddingSizes.large),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: isButtonEnabled
                            ? HexColor.fromHex("#FF3E68")
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(65),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: isButtonEnabled
                          ? () {
                              // Handle confirmation action
                              context.pop();
                            }
                          : null,
                      child: const Text(
                        'Bevestigen',
                        style: TextStyle(
                          fontSize: 17.5,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
