import 'package:flutter/material.dart';

import 'src/app_bar_theme.dart';
import 'src/bottom_modal_theme.dart';
import 'src/bottom_navigation_bar_theme.dart';
import 'src/color_scheme.dart';
import 'src/colors.dart';
import 'src/elevated_button_theme.dart';
import 'src/expansion_tile_theme.dart';
import 'src/icon_theme.dart';
import 'src/light_colors_extension.dart';
import 'src/progressbar_theme.dart';
import 'src/slider_theme.dart';
import 'src/switch_theme.dart';
import 'src/text_theme.dart';

class AppTheme {
  AppTheme();

  static ThemeData themeData = ThemeData(
      textTheme: appTextTheme,
      colorScheme: appColorScheme,
      shadowColor: AppColors.grey,
      hintColor: AppColors.silver,
      scaffoldBackgroundColor: appColorScheme.background,
      useMaterial3: true,
      expansionTileTheme: expansionTileThemeData,
      elevatedButtonTheme: elevatedButtonThemeData,
      appBarTheme: appBarTheme,
      bottomNavigationBarTheme: navbarThemeData,
      sliderTheme: sliderThemeData,
      bottomSheetTheme: bottomModalTheme,
      progressIndicatorTheme: progressIndicatorThemeData,
      switchTheme: switchThemeData,
      iconTheme: iconThemeData,
      extensions: [lightColorsExtension]);
}
