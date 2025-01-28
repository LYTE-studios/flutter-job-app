import 'package:flutter/material.dart';

class CustomSliderWithTwoThumbs extends StatelessWidget {
  final RangeValues values;
  final double min;
  final double max;
  final int divisions;
  final String? startLabel;
  final String? endLabel;
  final ValueChanged<RangeValues> onChanged;
  final Color activeColor;
  final Color inactiveColor;

  const CustomSliderWithTwoThumbs({
    super.key,
    required this.values,
    required this.min,
    required this.max,
    required this.divisions,
    this.startLabel,
    this.endLabel,
    required this.onChanged,
    this.activeColor = Colors.pinkAccent,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 10.0,
        activeTrackColor: theme.primaryColor,
        inactiveTrackColor: Colors.grey[200],
        thumbColor: theme.primaryColor,
        overlayColor: theme.primaryColor.withAlpha(50),
        rangeThumbShape: CustomRangeThumbShape(
          enabledThumbRadius: 13,
          borderColor: Colors.white,
        ),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
        rangeTrackShape: CustomRangeTrackShape(
          leftExtension: 10.0,
          rightExtension: 10.0,
        ),
      ),
      child: RangeSlider(
        values: values,
        min: min,
        max: max,
        divisions: divisions,
        labels: RangeLabels(
          startLabel ?? '${values.start.round()}',
          endLabel ?? '${values.end.round()}',
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class CustomRangeThumbShape extends RangeSliderThumbShape {
  final double enabledThumbRadius;
  final Color borderColor;

  CustomRangeThumbShape({
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
    bool isEnabled = true,
    bool isOnTop = false,
    bool isPressed = false,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isStart,
  }) {
    final Canvas canvas = context.canvas;

    final Paint outerCircle = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill;

    final Paint innerCircle = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, enabledThumbRadius, outerCircle);
    canvas.drawCircle(center, enabledThumbRadius - 4, innerCircle);
  }
}

class CustomRangeTrackShape extends RangeSliderTrackShape {
  final double leftExtension;
  final double rightExtension;

  CustomRangeTrackShape({
    this.leftExtension = 0.0,
    this.rightExtension = 0.0,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx + leftExtension;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth =
        parentBox.size.width - leftExtension - rightExtension;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset startThumbCenter,
    required Offset endThumbCenter,
    bool isEnabled = true,
    bool isDiscrete = false,
    required TextDirection textDirection,
    double additionalActiveTrackHeight = 0,
  }) {
    if (!isEnabled) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint activePaint = Paint()..color = sliderTheme.activeTrackColor!;
    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!;

    final double trackRadius = trackRect.height / 2;

    context.canvas.drawRRect(
      RRect.fromLTRBR(
        trackRect.left,
        trackRect.top,
        startThumbCenter.dx,
        trackRect.bottom,
        Radius.circular(trackRadius),
      ),
      inactivePaint,
    );

    context.canvas.drawRRect(
      RRect.fromLTRBR(
        startThumbCenter.dx,
        trackRect.top,
        endThumbCenter.dx,
        trackRect.bottom,
        Radius.circular(trackRadius),
      ),
      activePaint,
    );

    context.canvas.drawRRect(
      RRect.fromLTRBR(
        endThumbCenter.dx,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,
        Radius.circular(trackRadius),
      ),
      inactivePaint,
    );
  }
}
