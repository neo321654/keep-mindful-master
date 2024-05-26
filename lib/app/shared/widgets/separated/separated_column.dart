import 'package:flutter/material.dart';

import 'separator_mixin.dart';

class SeparatedColumn extends StatelessWidget with SeparatorMixin {
  const SeparatedColumn(
      {super.key,
      required this.children,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.textDirection,
      this.verticalDirection = VerticalDirection.down,
      this.textBaseline,
      required this.separatorBuilder});

  final MainAxisAlignment mainAxisAlignment;
  final List<Widget> children;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final Widget Function(BuildContext context, int pos) separatorBuilder;
  final TextBaseline? textBaseline;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: separateWidgets(context, children, separatorBuilder),
    );
  }
}
