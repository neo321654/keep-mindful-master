import 'package:flutter/material.dart';

import 'color_scheme.dart';
import 'text_theme.dart';

const _defaultTitleSpacing = 10.0;

AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: appColorScheme.surface,
  iconTheme: IconThemeData(color: appColorScheme.onSurface),
  foregroundColor: appColorScheme.onSurface,
  centerTitle: true,
  titleSpacing: _defaultTitleSpacing,
  scrolledUnderElevation: 0.0,
  titleTextStyle: appTextTheme.titleLarge?.copyWith(
    color: appColorScheme.onSurface,
  ),
);
