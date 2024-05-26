import 'package:flutter/material.dart';

import '../slider_custom_shape.dart';
import '../slider_thumb_shape.dart';
import 'color_scheme.dart';
import 'colors.dart';
import 'light_colors_extension.dart';

SliderThemeData sliderThemeData = SliderThemeData(
  inactiveTrackColor: AppColors.grey.withOpacity(0.2),
  overlayColor: appColorScheme.inversePrimary,
  thumbShape: const SliderThumbShape(
      colors: [Colors.white, AppColors.grey],
      thumbColor: AppColors.whiteSmoke,
      elevationColor: AppColors.grey),
  trackHeight: 16.0,
  overlayShape: SliderComponentShape.noOverlay,
  tickMarkShape: SliderTickMarkShape.noTickMark,
  trackShape: SliderCustomShape(activeTrackGradientColors: [
    lightColorsExtension.primarySwatch!.shade200,
    lightColorsExtension.primarySwatch!.shade600
  ]),
);
