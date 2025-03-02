import 'package:flutter/material.dart';

class CustomPlanCardBorder extends ShapeBorder {
  final String plan;
  CustomPlanCardBorder(this.plan);

  @override
  EdgeInsetsGeometry get dimensions =>
      const EdgeInsets.only(left: 10, top: 2, right: 2, bottom: 2);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(RRect.fromRectAndCorners(
        rect,
        topLeft: const Radius.circular(12),
        bottomLeft: const Radius.circular(12),
      ));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final Paint leftPaint = Paint()
      ..color = plan == 'Starter'
          ? const Color(0xFF888181)
          : plan.contains('Local')
              ? const Color(0xFFAA5FE8)
              : plan == 'Scale'
                  ? const Color(0xFF23FBFF)
                  : Colors.black
      ..style = PaintingStyle.fill; // Changed to fill for container

    final Paint sidePaint = Paint()
      ..color = const Color(0xFFF3F3F3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double radius = 12.0;

    // Draw right and bottom borders
    final Path path = Path()
      ..moveTo(rect.left + radius, rect.top) // Start after top-left arc
      ..lineTo(rect.right - radius, rect.top)
      ..arcToPoint(
        Offset(rect.right, rect.top + radius),
        radius: const Radius.circular(radius),
        clockwise: true,
      )
      ..lineTo(rect.right, rect.bottom - radius)
      ..arcToPoint(
        Offset(rect.right - radius, rect.bottom),
        radius: const Radius.circular(radius),
        clockwise: true,
      )
      ..lineTo(rect.left + radius, rect.bottom); // Stop before bottom-left arc

    canvas.drawPath(path, sidePaint);

    // Updated left border container with rounded outer corners
    final double borderWidth = 10.0;
    final Rect leftRect =
        Rect.fromLTWH(rect.left, rect.top, borderWidth, rect.height);
    final RRect leftRRect = RRect.fromRectAndCorners(
      leftRect,
      topLeft: const Radius.circular(radius),
      bottomLeft: const Radius.circular(radius),
    );
    canvas.drawRRect(leftRRect, leftPaint);
  }

  @override
  ShapeBorder scale(double t) {
    return CustomPlanCardBorder(plan);
  }
}
