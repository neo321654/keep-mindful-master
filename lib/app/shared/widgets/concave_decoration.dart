import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ConcaveDecoration extends Decoration {
  const ConcaveDecoration({
    required this.shape,
    this.depth = 0.0,
    this.colors = const [Colors.black87, Colors.white],
    this.opacity = 1.0,
  }) : assert(colors.length == 2, 'Provide two colors');

  final ShapeBorder? shape;
  final double depth;
  final List<Color?> colors;
  final double opacity;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _ConcaveDecorationPainter(shape, depth, colors, opacity);

  @override
  EdgeInsetsGeometry get padding => shape?.dimensions ?? EdgeInsets.zero;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is ConcaveDecoration) {
      t = Curves.easeInOut.transform(t);
      return ConcaveDecoration(
        shape: ShapeBorder.lerp(a.shape, shape, t),
        depth: ui.lerpDouble(a.depth, depth, t) ?? 0.0,
        colors: [
          Color.lerp(a.colors[0], colors[0], t),
          Color.lerp(a.colors[1], colors[1], t),
        ],
        opacity: ui.lerpDouble(a.opacity, opacity, t) ?? 0.0,
      );
    }
    return null;
  }
}

class _ConcaveDecorationPainter extends BoxPainter {
  _ConcaveDecorationPainter(this.shape, this.depth, this.colors, this.opacity) {
    if (depth > 0) {
      colors = [
        colors.last,
        colors.first,
      ];
    } else {
      depth = -depth;
    }
    colors = [
      colors.first?.withOpacity(opacity),
      colors.last?.withOpacity(opacity),
    ];
  }
  ShapeBorder? shape;
  double depth;
  List<Color?> colors;
  double opacity;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    if (shape == null || colors.first == null || colors.last == null) {
      canvas.restore();
      return;
    }

    final shapePath = shape!.getOuterPath(offset & configuration.size!);
    final rect = shapePath.getBounds();

    final delta = 16 / rect.longestSide;
    final stops = [0.5 - delta, 0.5 + delta];

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(rect.inflate(depth * 2))
      ..addPath(shapePath, Offset.zero);
    canvas.save();
    canvas.clipPath(shapePath);
    final paint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, depth);
    final clipSize = rect.size.aspectRatio > 1
        ? Size(rect.width, rect.height / 2)
        : Size(rect.width / 2, rect.height);
    for (final alignment in [Alignment.topLeft, Alignment.bottomRight]) {
      final shaderRect =
          alignment.inscribe(Size.square(rect.longestSide), rect);
      paint.shader = ui.Gradient.linear(shaderRect.topLeft,
          shaderRect.bottomRight, colors.map((e) => e!).toList(), stops);

      canvas.save();
      canvas.clipRect(alignment.inscribe(clipSize, rect));
      canvas.drawPath(path, paint);
      canvas.restore();
    }

    canvas.restore();
  }
}
