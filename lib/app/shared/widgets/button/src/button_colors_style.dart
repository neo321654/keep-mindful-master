import 'package:flutter/material.dart';

import '../../../themes/themes.dart';

const _defaultShadowColors = [AppColors.grey, Colors.white];

class ButtonColorsStyle {
  const ButtonColorsStyle(
      {this.backgroundColor,
      this.borderColor,
      this.shadowColors = _defaultShadowColors});

  final Color? backgroundColor;
  final Color? borderColor;
  final List<Color> shadowColors;
}
