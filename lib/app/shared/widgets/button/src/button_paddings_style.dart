import 'package:flutter/material.dart';

const _defaultPaddingBetweenElements = 0.0;

class ButtonPaddingsStyle {
  const ButtonPaddingsStyle(
      {this.padding,
      this.paddingBetweenElements = _defaultPaddingBetweenElements});

  final EdgeInsets? padding;
  final double paddingBetweenElements;
}
