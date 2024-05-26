import 'package:flutter/material.dart';

const _defaultBorderRadius = 4.0;

class DecoratedCheckIconProps {
  const DecoratedCheckIconProps(
      {this.shape = BoxShape.rectangle,
      this.borderRadius = _defaultBorderRadius});

  final BoxShape shape;
  final double borderRadius;
}
