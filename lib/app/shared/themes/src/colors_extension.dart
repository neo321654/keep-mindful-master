import 'package:flutter/material.dart';

import '../../utils/color_swatch_utils.dart';

class ColorsExtension extends ThemeExtension<ColorsExtension> {
  const ColorsExtension({required this.primarySwatch});

  final MaterialColor? primarySwatch;

  @override
  ThemeExtension<ColorsExtension> copyWith({MaterialColor? primarySwatch}) {
    return ColorsExtension(primarySwatch: primarySwatch ?? this.primarySwatch);
  }

  @override
  ThemeExtension<ColorsExtension> lerp(
      covariant ThemeExtension<ColorsExtension>? other, double t) {
    if (other is! ColorsExtension) {
      return this;
    }

    return ColorsExtension(
      primarySwatch: ColorSwatchUtils.lerpMaterialColor(
          primarySwatch, other.primarySwatch, t),
    );
  }

  @override
  String toString() => 'ColorsExtension('
      '{primarySwatch: $primarySwatch})';
}
