import 'package:flutter/material.dart';

import 'color_scheme.dart';

SwitchThemeData switchThemeData = SwitchThemeData(
    trackOutlineColor:
        MaterialStateProperty.all(appColorScheme.tertiaryContainer),
    thumbColor: MaterialStateProperty.all(appColorScheme.inverseSurface),
    trackColor: MaterialStateProperty.all(appColorScheme.tertiaryContainer),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap);
