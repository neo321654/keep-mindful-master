import 'dart:ui';

const _defaultDotRadius = 3.0;
const _defaultDuration = Duration(milliseconds: 1000);
const _defaultSize = Size(44.0, 44.0);
const _defaultNumberOfCircles = 10;

class CircleProgressbarProps {
  const CircleProgressbarProps({
    this.color,
    this.dotRadius = _defaultDotRadius,
    this.duration = _defaultDuration,
    this.numberOfCircles = _defaultNumberOfCircles,
    this.size = _defaultSize,
  });
  final Color? color;
  final double dotRadius;
  final Duration duration;
  final int numberOfCircles;
  final Size size;
}
