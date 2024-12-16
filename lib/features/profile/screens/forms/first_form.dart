import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../widgets/custom_date_picker.dart';

class FirstForm extends StatelessWidget {
  const FirstForm({
    super.key,
    required this.width,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildTextField('Naam', 'Vul je naam in'),
        const SizedBox(height: 20),
        _buildInlineCupertinoDatePicker(width),
        const SizedBox(height: 20),
        _buildDropdownField('Geslacht', 'Kies een optie'),
        const SizedBox(height: 20),
        _buildTextField('Email', 'voorbeeld@mail.com',
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 20),
        _buildTextField('Telefoonnummer', '0400 00 00 00',
            keyboardType: TextInputType.phone),
      ],
    );
  }

  Widget _buildDropdownField(String label, String hint) {
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: HexColor.fromHex('#F7F7F7'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
          ),
          hint: Text(
            hint,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 16,
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Mannelijk', child: Text('Mannelijk')),
            DropdownMenuItem(value: 'Vrouwelijk', child: Text('Vrouwelijk')),
          ],
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          dropdownColor: Colors.white,
          onChanged: (value) {
            // Handle dropdown selection here
          },
        ),
      ],
    );
  }

  Widget _buildInlineCupertinoDatePicker(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Geboortedatum',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            children: [
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
        SizedBox(
          width: width,
          height: 110,
          child: const CustomDatePicker(),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint,
      {TextInputType keyboardType = TextInputType.text}) {
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
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
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
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}
