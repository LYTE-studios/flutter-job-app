
import 'package:flutter/material.dart';
import 'package:jobr/features/job_listing/availability_page.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<String> selectedSoftSkills = [];
  List<String> selectedHardSkills = [];
  final bool  _isButtonEnabled = true;
  double werkervaringValue = 1; // Initial value for slider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Nieuwe vacature",
          style: TextStyles.titleMedium,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: HexColor.fromHex("#FF3E68"),
                ),
                height: 6,
                width: MediaQuery.of(context).size.width * 0.35, // 35% width
              ),
              Expanded(
                child: Container(
                  height: 6,
                  color: Colors.grey[300], // Remaining width
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Vaardigheden",
                  style: TextStyles.titleMedium.copyWith(fontSize: 22),
                ),
                const Divider(
                  thickness: 0.6,
                ),
                const SizedBox(height: 16),
                // "Vereiste werkervaring" Card
                _buildWerkervaringCard(),
                const SizedBox(height: 16),

                // Soft Skills
                _buildSkillSection(
                    'Soft skills',
                    [
                      'Leiderschap',
                      'Sociaal',
                      'Stressbestendig',
                      'Flexibel',
                      'Creatief',
                      'Teamplayer',
                      'Zelfstandig',
                      'Klantgericht',
                      'Oog voor detail',
                    ],
                    maxSelection: 3,
                    isSoftSkills: true),
                const SizedBox(height: 16),

                // Hard Skills
                _buildSkillSection(
                    'Hard skills',
                    [
                      'Grafisch ontwerp',
                      'Klantenservice',
                      'Hygiëne',
                      'Tafelschikking',
                      'Barista-vaardigheden',
                      'Wijnkennis',
                      'Afwas',
                      'Tijdmanagement',
                    ],
                    maxSelection: 3,
                    isSoftSkills: false),

                // Bottom Button
                
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:BottomAppBar(
        color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 58,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: _isButtonEnabled
                          ? HexColor.fromHex("#FF3E68")
                          : HexColor.fromHex('#DADADA'),
                      shape: RoundedRectangleBorder(
                        borderRadius: _isButtonEnabled
                            ? BorderRadius.circular(65)
                            : BorderRadius.circular(65),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {
                       Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => const AvailabilityPage()),
  );

                    },
                    child: const Text(
                      
                           "Naar beschikbaarheid"
                          ,
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
    );
  }

  Widget _buildWerkervaringCard() {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Vereiste werkervaring',
                  style: TextStyles.titleMedium.copyWith(fontSize: 17,fontWeight: FontWeight.w700),
                ),
                Icon(
                  Icons.info_outline,
                  color: HexColor.fromHex("#A2A2A2"),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                      activeTickMarkColor: Colors.white,
                      inactiveTickMarkColor: Colors.white,
                      activeTrackColor: HexColor.fromHex("#FF3E68"),
                      thumbColor: HexColor.fromHex("#FF3E68"),
                      trackHeight: 10,
                      inactiveTrackColor: Colors.grey[100]),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Slider(
                      value: werkervaringValue,
                      min: 0,
                      secondaryActiveColor: Colors.white,
                      max: 3,
                      divisions: 3,
                      onChanged: (value) {
                        setState(() {
                          werkervaringValue = value;
                        });
                      },
                      // activeColor: Colors.pink,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Geen',style: TextStyles.titleMedium.copyWith(fontSize: 15.63,fontWeight: FontWeight.w600,color: HexColor.fromHex("#8A8989")),),
                      const SizedBox(width: 8),
                      Text('Starter',style: TextStyles.titleMedium.copyWith(fontSize: 15.63,fontWeight: FontWeight.w600),),
                      
                      Text('⭐Ervaren',style: TextStyles.titleMedium.copyWith(fontSize: 15.63,fontWeight: FontWeight.w600,color: HexColor.fromHex("#F9AA16")),),
                      
                      Text('💎Expert',style: TextStyles.titleMedium.copyWith(fontSize: 15.63,fontWeight: FontWeight.w600,color: HexColor.fromHex("#61C5FF")),),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillSection(String title, List<String> skills,
      {int maxSelection = 3, bool isSoftSkills = true}) {
    List<String> selectedSkills =
        isSoftSkills ? selectedSoftSkills : selectedHardSkills;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style:TextStyles.titleMedium.copyWith(fontSize: 17,fontWeight: FontWeight.w700),
            ),
            Text(
              'Kies er $maxSelection',
              style: TextStyles.titleMedium.copyWith(fontSize: 15.4,fontWeight: FontWeight.w600,color: HexColor.fromHex("#0000003B").withOpacity(0.23)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
        
          spacing: 4,
          runSpacing: 2,
          children: skills.map((skill) {
            return ChoiceChip(
            
            showCheckmark: false,
              label: Text(skill),
              selected: selectedSkills.contains(skill),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    if (selectedSkills.length < maxSelection) {
                      selectedSkills.add(skill);
                    }
                  } else {
                    selectedSkills.remove(skill);
                  }
                });
              },
              selectedColor: Colors.white,
            backgroundColor: Colors.white,
              labelStyle: TextStyle(
              fontFamily: 'Inter',
                color: selectedSkills.contains(skill)
                    ? HexColor.fromHex("#FF3E68")
                    : HexColor.fromHex("#A0A0A0"),
                fontWeight: FontWeight.w600,
                fontSize: 15.88,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: selectedSkills.contains(skill)
                      ? HexColor.fromHex("#FF3E68")
                      : HexColor.fromHex("#E8E8E8"),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
