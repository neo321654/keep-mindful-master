import 'package:flutter/material.dart';

import '../concave_decoration.dart';
import '../icon/icon.dart';
import 'check_box_props.dart';

const _chekMarkSize = 20.0;
const _padding = 4.0;
const _borderRadius = 4.0;
const _animationDuration = Duration(milliseconds: 50);
const _tapTargetSize = 48.0;
const _concaveDepth = 5.0;

class CheckBox extends StatefulWidget {
  const CheckBox({required this.props, super.key});

  final CheckBoxProps props;

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curvedAnimation;

  void _animateSelection(bool isSelected) {
    if (isSelected) {
      _animationController.forward();
      return;
    }
    _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: _animationDuration,
        value: widget.props.isSelected ? 1.0 : 0.0);
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(covariant CheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.props.isSelected != oldWidget.props.isSelected) {
      _animateSelection(widget.props.isSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.props.onPressed,
      child: SizedBox(
        height: _tapTargetSize,
        width: _tapTargetSize,
        child: Center(
          child: DecoratedBox(
            decoration: ConcaveDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_borderRadius)),
                depth: _concaveDepth,
                colors: [
                  theme.colorScheme.shadow,
                  theme.shadowColor,
                ]),
            child: Padding(
              padding: const EdgeInsets.all(_padding),
              child: SizedBox(
                height: _chekMarkSize,
                width: _chekMarkSize,
                child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (_, __) {
                      return Opacity(
                        opacity: _curvedAnimation.value,
                        child: Transform.scale(
                          scale: _curvedAnimation.value,
                          child: const DecoratedCheckIcon(
                            props: DecoratedCheckIconProps(),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
