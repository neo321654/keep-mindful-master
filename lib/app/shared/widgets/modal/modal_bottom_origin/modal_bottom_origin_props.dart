import 'package:flutter/material.dart';

class ModalBottomOriginProps {
  const ModalBottomOriginProps(
      {this.padding,
      required this.child,
      this.enableInnerScroll = true,
      required this.height});

  final Widget child;
  final double height;
  final EdgeInsets? padding;
  final bool enableInnerScroll;
}
