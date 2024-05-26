import 'package:flutter/material.dart';

/// Widget used to create space between other widgets in [Row].
class WidthSpacer extends StatelessWidget {
  const WidthSpacer(this.width, {super.key});

  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
