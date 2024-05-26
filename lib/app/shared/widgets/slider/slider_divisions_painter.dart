import 'package:flutter/material.dart';

const _maxColorOpacity = 0.5;
const _minColorOpacity = 0.5;

class SliderDivisionsPainter extends CustomPainter {
  const SliderDivisionsPainter(
      {this.divisions = 11,
      this.dividerColor = Colors.black,
      this.dividerWidth = 2.0});

  final int divisions;
  final Color dividerColor;
  final double dividerWidth;

  double _computeHeight({required int pos, required double maxHeight}) {
    final dividerType = pos % 4;
    switch (dividerType) {
      case 0:
        return maxHeight;
      case 1:
      case 3:
        return maxHeight * 2 / 3;
      case 2:
        return maxHeight / 2;
      default:
        return 0.0;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final spaceBetweenDivisions = width / (divisions - 1);

    for (int pos = 0; pos < divisions; pos++) {
      final startX = pos * spaceBetweenDivisions;
      const startY = 0.0;
      final endX = startX + dividerWidth;
      final endY = _computeHeight(pos: pos, maxHeight: height);

      final rect = Rect.fromLTRB(startX, startY, endX, endY);

      final roundedRect = RRect.fromLTRBR(
          startX, startY, endX, endY, const Radius.circular(5.0));

      final gradient = LinearGradient(colors: [
        dividerColor.withOpacity(_maxColorOpacity),
        dividerColor.withOpacity(_minColorOpacity)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

      final paint = Paint()..shader = gradient.createShader(rect);

      canvas.drawRRect(roundedRect, paint);
    }
  }

  @override
  bool shouldRepaint(SliderDivisionsPainter oldDelegate) {
    return divisions != oldDelegate.divisions;
  }
}
