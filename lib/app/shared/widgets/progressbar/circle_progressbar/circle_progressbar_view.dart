import 'package:flutter/material.dart';

import 'circle_progressbar_painter.dart';
import 'circle_progressbar_props.dart';

class CircleProgressbar extends StatefulWidget {
  const CircleProgressbar({
    required this.props,
    super.key,
  });

  final CircleProgressbarProps props;

  @override
  State<CircleProgressbar> createState() =>
      _DottedCircleProgressIndicatorState();
}

class _DottedCircleProgressIndicatorState extends State<CircleProgressbar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: widget.props.duration);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final props = widget.props;
    final dotsColor = props.color ?? theme.colorScheme.onSurface;
    return CustomPaint(
      painter: CircleProgressbarPainter(_animationController,
          props.numberOfCircles, props.dotRadius, dotsColor),
      child: SizedBox.fromSize(size: widget.props.size),
    );
  }
}
