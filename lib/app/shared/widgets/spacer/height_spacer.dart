import 'package:flutter/material.dart';

/// Widget used to create space between other widgets in [Column].
class HeightSpacer extends StatelessWidget {
  const HeightSpacer(this.height, {super.key});

  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
