import 'package:flutter/material.dart';

const _defaultIconSize = 24.0;

class ButtonIconStyle {
  const ButtonIconStyle(
      {this.primaryColor,
      this.secondaryColor,
      this.disabledColor,
      this.iconSize = _defaultIconSize});

  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? disabledColor;
  final double iconSize;
}
