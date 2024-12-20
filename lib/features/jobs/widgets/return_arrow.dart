import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReturnArrow extends StatelessWidget {
  const ReturnArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.keyboard_arrow_left,
          size: 27,
        ),
        onPressed: () {
          context.pop();
        });
  }
}
