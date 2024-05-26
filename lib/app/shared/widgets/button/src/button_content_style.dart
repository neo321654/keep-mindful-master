import 'package:flutter/material.dart';

import 'button_icon_style.dart';

class ButtonContentStyle {
  const ButtonContentStyle({
    this.iconStyle = const ButtonIconStyle(),
    this.titleStyle,
    this.disabledTitleStyle,
    this.subtitleStyle,
    this.disabledSubtitleStyle,
    this.contentAlignment = MainAxisAlignment.center,
    this.contentExpand = false,
  });

  final ButtonIconStyle iconStyle;
  final TextStyle? titleStyle;
  final TextStyle? disabledTitleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? disabledSubtitleStyle;
  final MainAxisAlignment contentAlignment;
  final bool contentExpand;
}
