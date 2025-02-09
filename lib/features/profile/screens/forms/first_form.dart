import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_list_picker.dart';

class FirstForm extends StatefulWidget {
  const FirstForm({
    super.key,
    required this.width,
    this.onFormValidityChanged,
  });

  final double width;
  final ValueChanged<bool>? onFormValidityChanged;

  @override
  State<FirstForm> createState() => _FirstFormState();
}

class _FirstFormState extends State<FirstForm> {
  String? selectedGender;
  String? status;
  bool _isValid = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  void _validateForm() {
    bool valid = _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        selectedGender != null &&
        status != null;
    if (valid != _isValid) {
      setState(() {
        _isValid = valid;
      });
      widget.onFormValidityChanged?.call(valid);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 20),
        _buildTextField(
          'Naam',
          'Vul je naam in',
          controller: _nameController,
          onChanged: (value) => _validateForm(),
        ),
        const SizedBox(height: 20),
        _buildInlineCupertinoDatePicker(widget.width),
        const SizedBox(height: 20),
        _buildDropdownField(
          'Geslacht',
          selectedGender ?? 'Kies een optie',
          context,
          options: const ['Mannelijk', 'Vrouwelijk'],
          onOptionSelected: (selectedOption) {
            setState(() {
              selectedGender = selectedOption;
            });
            _validateForm();
          },
        ),
        const SizedBox(height: 20),
        _buildDropdownField(
          'Statuut',
          status ?? 'Kies een statuut',
          context,
          options: const ['Student', 'Freelancer', 'Part-time', 'Full-time'],
          onOptionSelected: (selectedOption) {
            setState(() {
              status = selectedOption;
            });
            _validateForm();
          },
        ),
        const SizedBox(height: 20),
        _buildTextField(
          'Email',
          'voorbeeld@mail.com',
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          onChanged: (value) => _validateForm(),
        ),
        const SizedBox(height: 20),
        _buildTextField(
          'Telefoonnummer',
          '0400 00 00 00',
          keyboardType: TextInputType.phone,
          controller: _phoneController,
          onChanged: (value) => _validateForm(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    String hint,
    BuildContext context, {
    required List<String> options,
    required ValueChanged<String> onOptionSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 18,
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
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext sheetContext) {
                // use separate context
                return CustomListPicker(
                  hint: hint,
                  options: options,
                  onOptionSelected: (selectedOption) {
                    onOptionSelected(selectedOption);
                  },
                );
              },
            );
          },
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
              color: HexColor.fromHex('#F7F7F7'),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  hint,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.47),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SvgPicture.asset(
                  JobrIcons.chevronDown,
                  width: 10,
                  height: 10,
                ),
              ],
            ),
          ),
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
      {TextInputType keyboardType = TextInputType.text,
      TextEditingController? controller,
      ValueChanged<String>? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 16.23,
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
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                color: HexColor.fromHex('#B7B7B7'),
                fontSize: 18.2,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500),
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
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}
