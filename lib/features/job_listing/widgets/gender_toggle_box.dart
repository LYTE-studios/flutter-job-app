import 'package:flutter/material.dart';

class GenderToggleBox extends StatefulWidget {
  const GenderToggleBox({super.key});

  @override
  _GenderToggleBoxState createState() => _GenderToggleBoxState();
}

class _GenderToggleBoxState extends State<GenderToggleBox> {
  String selectedGender = 'Man'; // Default selection

  @override
  Widget build(BuildContext context) {
    final List<String> options = ['Man', 'Vrouw', 'Geen voorkeur'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment(
                selectedGender == 'Vrouw'
                    ? -0.2
                    : options.indexOf(selectedGender) /
                            (options.length - 1) *
                            2 -
                        1,
                0),
            child: Container(
              width: _getWidthForOption(selectedGender),
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: options.map((option) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGender = option; // Update selected option
                  });
                },
                child: Container(
                  width: _getWidthForOption(option),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: option == selectedGender
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  double _getWidthForOption(String option) {
    switch (option) {
      case 'Man':
        return 70;
      case 'Vrouw':
        return 80;
      case 'Geen voorkeur':
        return 120;
      default:
        return 50;
    }
  }
}
