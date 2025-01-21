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
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: options.map((option) {
          final bool isSelected = option == selectedGender;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedGender = option; // Update selected option
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? Colors.pinkAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
