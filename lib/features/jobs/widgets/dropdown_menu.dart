import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String hintText;

  const CustomDropdown({super.key, required this.items, required this.hintText});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50], // Light grey background
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(
            widget.hintText,
            style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
                fontFamily: 'Poppins'),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey[600],
            size: 25,
          ),
          isExpanded: true, // Full width
          style: const TextStyle(color: Colors.black),
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
          },
        ),
      ),
    );
  }
}
