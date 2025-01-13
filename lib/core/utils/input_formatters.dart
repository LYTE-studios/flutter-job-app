import 'package:flutter/services.dart';

/// A custom text input formatter for phone numbers.
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-digit characters from the input
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit the input to 15 characters
    if (digitsOnly.length > 15) {
      digitsOnly = digitsOnly.substring(0, 15);
    }

    // Use StringBuffer for efficient string concatenation
    StringBuffer formattedBuffer = StringBuffer();

    if (digitsOnly.isNotEmpty) {
      if (digitsOnly.startsWith('0')) {
        // Format local numbers starting with '0'
        formattedBuffer.write('0');
        if (digitsOnly.length > 1) {
          formattedBuffer.write(
              ' ${digitsOnly.substring(1, digitsOnly.length >= 4 ? 4 : digitsOnly.length)}');
        }
        if (digitsOnly.length >= 4) {
          formattedBuffer.write(
              ' ${digitsOnly.substring(4, digitsOnly.length >= 7 ? 7 : digitsOnly.length)}');
        }
        if (digitsOnly.length > 7) {
          formattedBuffer.write(' ${digitsOnly.substring(7)}');
        }
      } else if (digitsOnly.startsWith('234')) {
        // Format international numbers starting with '234'
        formattedBuffer.write('+234');
        if (digitsOnly.length > 3) {
          formattedBuffer.write(
              ' ${digitsOnly.substring(3, digitsOnly.length >= 6 ? 6 : digitsOnly.length)}');
        }
        if (digitsOnly.length >= 6) {
          formattedBuffer.write(
              ' ${digitsOnly.substring(6, digitsOnly.length >= 9 ? 9 : digitsOnly.length)}');
        }
        if (digitsOnly.length > 9) {
          formattedBuffer.write(' ${digitsOnly.substring(9)}');
        }
      } else if (digitsOnly.startsWith('32')) {
        // Format international numbers starting with '32'
        formattedBuffer.write('+32');
        if (digitsOnly.length > 2) {
          formattedBuffer.write(
              ' ${digitsOnly.substring(2, digitsOnly.length >= 5 ? 5 : digitsOnly.length)}');
        }
        if (digitsOnly.length >= 5) {
          formattedBuffer.write(
              ' ${digitsOnly.substring(5, digitsOnly.length >= 8 ? 8 : digitsOnly.length)}');
        }
        if (digitsOnly.length > 8) {
          formattedBuffer.write(' ${digitsOnly.substring(8)}');
        }
      } else {
        // Handle any other case or invalid format
        formattedBuffer.write(digitsOnly); // Just show as it is for invalid cases
      }
    }

    // Return the formatted value
    return TextEditingValue(
      text: formattedBuffer.toString(),
      selection: TextSelection.collapsed(offset: formattedBuffer.length),
    );
  }
}