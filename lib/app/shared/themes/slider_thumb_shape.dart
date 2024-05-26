import 'package:flutter/material.dart';

const _defaultThumbRadius = 13.0;
const _gradientRadius = 1.9;
const _gradientStops = [0.5, 0.8];
const _defaultElevation = 3.0;
// TODO: Change location of file
class SliderThumbShape extends SliderComponentShape {
  const SliderThumbShape(
      {this.radius = _defaultThumbRadius,
      this.elevationColor = Colors.black,
      required this.colors,
      required this.thumbColor,
      this.elevation = _defaultElevation});

  final double radius;
  final double elevation;
  final List<Color> colors;
  final Color thumbColor;
  final Color elevationColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final gradient = RadialGradient(
        center: Alignment.topLeft,
        radius: _gradientRadius,
        colors: colors,
        stops: _gradientStops);

    final canvas = context.canvas;

    final thumbPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    final elevationPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    final thumbPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient
          .createShader(Rect.fromCircle(center: center, radius: radius));

    final elevationPaint = Paint()
      ..color = elevationColor
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, elevation);

    canvas.drawPath(elevationPath, elevationPaint);

    canvas.drawPath(thumbPath, thumbPaint);
  }
}
