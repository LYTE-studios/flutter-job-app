import 'package:flutter/material.dart';

mixin BottomSheetMixin on StatelessWidget {
  Future<dynamic> showBottomSheet({
    required BuildContext context,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: build,
    );
  }
}
