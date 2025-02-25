import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin BottomSheetMixin on Widget {
  Future<dynamic> showPopup({
    required BuildContext context,
  }) async {
    if (Platform.isIOS) {
      return Navigator.of(context).push(
        CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => this,
        ),
      );
    }
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => this,
      ),
    );
  }

  Future<dynamic> showBottomSheet({
    required BuildContext context,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => this,
      );
    }

    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      useRootNavigator: true,
      isScrollControlled: true, // Allow for a full-screen height bottom sheet
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => this,
    );
  }
}
