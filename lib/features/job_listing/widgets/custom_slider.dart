import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String label;
  final ValueChanged<double> onChanged;
  final Color? activeColor;
  final Color inactiveColor;

  const CustomSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.label,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 10.0, // Custom track height for more width
        activeTrackColor: theme.primaryColor,
        inactiveTrackColor: Colors.grey[200],
        thumbColor: theme.primaryColor,
        overlayColor: theme.primaryColor.withOpacity(0.2),
        thumbShape: CustomThumbShape(
          enabledThumbRadius: 13, // Custom thumb radius
          borderColor: Colors.white, // White border
        ),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
        trackShape: CustomTrackShape(
          leftExtension: 10.0,
          rightExtension: 10.0,
        ), // Use a custom track shape
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorColor: theme.primaryColor,
        valueIndicatorTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        label: label,
        onChanged: onChanged,
      ),
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  final double enabledThumbRadius;
  final Color borderColor;

  CustomThumbShape({
    this.enabledThumbRadius = 12.0,
    this.borderColor = Colors.white,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(enabledThumbRadius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    // White border circle
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Background white fill
    final Paint backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Inner colored circle
    final Paint innerCirclePaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    // Draw order: white background, colored inner circle, white border
    context.canvas.drawCircle(center, enabledThumbRadius, backgroundPaint);
    context.canvas.drawCircle(center, enabledThumbRadius - 3, innerCirclePaint);
    context.canvas.drawCircle(center, enabledThumbRadius, borderPaint);
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  final double leftExtension;
  final double rightExtension;

  CustomTrackShape({this.leftExtension = 0.0, this.rightExtension = 0.0});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    Offset? secondaryOffset,
    required Offset thumbCenter,
    bool isEnabled = true,
    bool isDiscrete = false,
    required TextDirection textDirection,
    double additionalActiveTrackHeight = 0,
  }) {
    final double trackHeight = 9.0; // Increased height for thicker track

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint activeTrackPaint = Paint()
      ..color = sliderTheme.activeTrackColor!;
    final Paint inactiveTrackPaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!;

    // Adjust active and inactive track rects
    final RRect activeTrackRRect = RRect.fromLTRBR(
      trackRect.left - leftExtension,
      trackRect.top - (trackHeight - trackRect.height) / 2,
      thumbCenter.dx,
      trackRect.bottom + (trackHeight - trackRect.height) / 2,
      Radius.circular(trackHeight / 2), // Rounded edges
    );

    final RRect inactiveTrackRRect = RRect.fromLTRBR(
      thumbCenter.dx,
      trackRect.top - (trackHeight - trackRect.height) / 2,
      trackRect.right + rightExtension,
      trackRect.bottom + (trackHeight - trackRect.height) / 2,
      Radius.circular(trackHeight / 2), // Rounded edges
    );

    // Paint the active track
    context.canvas.drawRRect(activeTrackRRect, activeTrackPaint);

    // Paint the inactive track
    context.canvas.drawRRect(inactiveTrackRRect, inactiveTrackPaint);
  }
}
