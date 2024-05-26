import 'dart:math' as math;

import 'package:flutter/material.dart';

const _radius = 20.0;
const _strokeWidth = 3.0;
const _extend = 50.0;
const _arcSize = Size.square(_radius);

class ViewFinderPainter extends CustomPainter {
  const ViewFinderPainter({required this.strokeColor});

  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rectWidth = size.width;

    final path = Path();
    for (var i = 0; i < 4; i++) {
      final l = i & 1 == 0;
      final t = i & 2 == 0;
      path
        ..moveTo(l ? 0 : rectWidth, t ? _extend : rectWidth - _extend)
        ..arcTo(
            Offset(l ? 0 : rectWidth - _arcSize.width,
                    t ? 0 : rectWidth - _arcSize.width) &
                _arcSize,
            l ? math.pi : math.pi * 2,
            l == t ? math.pi / 2 : -math.pi / 2,
            false)
        ..lineTo(l ? _extend : rectWidth - _extend, t ? 0 : rectWidth);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = strokeColor
        ..strokeWidth = _strokeWidth
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
