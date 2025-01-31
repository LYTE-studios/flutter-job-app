import 'package:flutter/material.dart';

mixin BottomSheetMixin on Widget {
  Future<dynamic> showPopup({
    required BuildContext context,
  }) async {
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
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => this,
    );
  }
}
