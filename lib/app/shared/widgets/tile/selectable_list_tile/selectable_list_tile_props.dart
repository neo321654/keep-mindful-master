import 'package:flutter/material.dart';

const _defaultPadding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0);

class SelectableListTileProps {
  SelectableListTileProps(
      {required this.title,
      this.trailing,
      this.onPressed,
      this.padding = _defaultPadding});

  final String title;
  final Widget? trailing;
  final void Function()? onPressed;
  final EdgeInsets padding;
}
