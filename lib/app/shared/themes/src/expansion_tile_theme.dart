import 'package:flutter/material.dart';

import '../../shared.dart';

const _borderRadius = 12.0;
const _paddingSmall = 8.0;
const _paddingMedium = 16.0;
const _paddingLarge = 24.0;

final ExpansionTileThemeData expansionTileThemeData = ExpansionTileThemeData(
    backgroundColor: appColorScheme.surface,
    iconColor: appColorScheme.onSurface,
    collapsedIconColor: appColorScheme.onSurface,
    tilePadding: const EdgeInsets.fromLTRB(
        _paddingLarge, _paddingSmall, _paddingLarge, _paddingSmall),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
    ),
    childrenPadding: const EdgeInsets.fromLTRB(
        _paddingLarge, _paddingSmall, _paddingLarge, _paddingMedium));
