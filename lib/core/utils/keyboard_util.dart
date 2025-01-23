import 'package:flutter/services.dart';

class KeyboardUtil {
  static void close() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
