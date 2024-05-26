import 'package:flutter/material.dart';

const _defaultShadowDistance = Offset(10.0, 10.0);
const _defaultShadowBlur = 20.0;
const _defaultBorderRadius = 10.0;
const _defaultInnerShadowDeph = 10.0;

class ButtonShapeStyle {
  const ButtonShapeStyle(
      {this.shape = BoxShape.rectangle,
      this.shadowDistance = _defaultShadowDistance,
      this.shadowBlurRadius = _defaultShadowBlur,
      this.borderRadius = _defaultBorderRadius,
      this.innerShadowDeph = _defaultInnerShadowDeph});

  final double borderRadius;
  final BoxShape shape;
  final Offset shadowDistance;
  final double shadowBlurRadius;
  final double innerShadowDeph;
}
