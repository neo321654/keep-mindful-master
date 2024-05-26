import 'package:flutter/material.dart';

class ColorSwatchUtils {
  const ColorSwatchUtils._();

  static MaterialColor createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (final strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static MaterialColor? lerpMaterialColor(
      MaterialColor? a, MaterialColor? b, double t) {
    if (identical(a, b)) {
      return a;
    }

    Map<int, Color> swatch = {};

    if (b == null) {
      swatch = _materialColorSwatch(a!).map((int key, Color color) =>
          MapEntry<int, Color>(key, Color.lerp(color, null, t)!));
    } else {
      if (a == null) {
        swatch = _materialColorSwatch(b).map((int key, Color color) =>
            MapEntry<int, Color>(key, Color.lerp(null, color, t)!));
      } else {
        swatch = _materialColorSwatch(a).map((int key, Color color) =>
            MapEntry<int, Color>(key, Color.lerp(color, b[key], t)!));
      }
    }
    return MaterialColor(Color.lerp(a, b, t)!.value, swatch);
  }

  static Map<int, Color> _materialColorSwatch(MaterialColor materialColor) {
    final Map<int, Color> swatch = {};

    swatch[50] = materialColor.shade50;
    swatch[100] = materialColor.shade100;
    swatch[200] = materialColor.shade200;
    swatch[300] = materialColor.shade300;
    swatch[400] = materialColor.shade400;
    swatch[500] = materialColor.shade500;
    swatch[600] = materialColor.shade600;
    swatch[700] = materialColor.shade700;
    swatch[800] = materialColor.shade800;
    swatch[900] = materialColor.shade900;

    return swatch;
  }
}
