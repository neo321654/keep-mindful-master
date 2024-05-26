import 'package:flutter/material.dart';

const _defaultBorderRadius = 24.0;

class InputShapeStyle {
  const InputShapeStyle(
      {this.border,
      this.enabledBorder,
      this.focusedBorder,
      this.errorBorder,
      this.boderRadius = _defaultBorderRadius,
      this.enableShadow = true,
      this.focusedErrorBorder});

  final bool enableShadow;
  final double boderRadius;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
}
