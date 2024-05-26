import 'package:flutter/material.dart';

import 'color_scheme.dart';
import 'text_theme.dart';

// TODO: refactor to NavigationBar https://api.flutter.dev/flutter/material/NavigationBar-class.html
BottomNavigationBarThemeData navbarThemeData = BottomNavigationBarThemeData(
  enableFeedback: true,
  showUnselectedLabels: true,
  showSelectedLabels: true,
  selectedItemColor: appColorScheme.primary,
  unselectedItemColor: appColorScheme.inverseSurface,
  unselectedIconTheme: IconThemeData(color: appColorScheme.inverseSurface),
  selectedIconTheme: IconThemeData(color: appColorScheme.primary),
  backgroundColor: appColorScheme.onPrimary,
  selectedLabelStyle:
      appTextTheme.labelMedium!.copyWith(color: appColorScheme.primary),
  unselectedLabelStyle:
      appTextTheme.labelMedium!.copyWith(color: appColorScheme.inverseSurface),
);
