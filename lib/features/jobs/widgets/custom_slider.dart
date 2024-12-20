import 'package:flutter/material.dart';

class CustomThumbShape extends RoundSliderThumbShape {
  final double enabledThumbRadius;
  final Color borderColor;

  CustomThumbShape(
      {this.enabledThumbRadius = 14.0, this.borderColor = Colors.white});

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Draw outer border
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // Border thickness

    // Draw inner circle (thumb)
    final Paint fillPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    // Draw the white border
    canvas.drawCircle(center, enabledThumbRadius, borderPaint);

    // Draw the thumb
    canvas.drawCircle(center, enabledThumbRadius - 2, fillPaint);
  }
}
