import 'package:flutter/material.dart';

import 'color_scheme.dart';
import 'colors.dart';

const _borderRadius = 24.0;

BottomSheetThemeData bottomModalTheme = BottomSheetThemeData(
  backgroundColor: appColorScheme.background,
  surfaceTintColor: Colors.transparent,
  modalBarrierColor: AppColors.carbonGrey.withOpacity(0.2),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(_borderRadius),
      topRight: Radius.circular(_borderRadius),
    ),
  ),
);
