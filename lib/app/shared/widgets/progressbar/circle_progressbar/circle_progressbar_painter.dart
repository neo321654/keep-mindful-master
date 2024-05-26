import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircleProgressbarPainter extends CustomPainter {
  CircleProgressbarPainter(
      this.animation, this.numDots, this.dotRadius, this.dotColor)
      : super(repaint: animation);

  final Animation<double> animation;
  final int numDots;
  final double dotRadius;
  final Color dotColor;

  @override
  void paint(Canvas canvas, Size size) {
    final distance = size.shortestSide / 2 - dotRadius;
    for (int i = 0; i < numDots; i++) {
      final paint = Paint()
        ..color =
            dotColor.withOpacity(1.0 - (animation.value + 1 - i / numDots) % 1);
      final center = size.center(Offset.zero) +
          Offset.fromDirection(2 * math.pi * i / numDots, distance);
      canvas.drawCircle(center, dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CircleProgressbarPainter oldDelegate) => false;
}
