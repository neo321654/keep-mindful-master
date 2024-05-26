import 'package:flutter/material.dart';

import '../../shared.dart';
import 'swither_thumb.dart';

const _borderRadius = 24.0;
const _height = 32.0;
const _width = 72.0;
const _animationDuration = Duration(milliseconds: 100);
const _deph = 3.0;
const _gesturePadding = 8.0;
const _shadowOpacity = 0.6;
const _switcherThumbPadding = 0.2;

class Switcher extends StatefulWidget {
  const Switcher({required this.props, super.key});

  final SwitcherProps props;

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Alignment> _alignmentTween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: _animationDuration,
        value: widget.props.value ? 1.0 : 0.0);

    _alignmentTween =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void didUpdateWidget(covariant Switcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.props.value != oldWidget.props.value) {
      _animate(widget.props.value);
    }
  }

  void _animate(bool isPressed) {
    if (isPressed) {
      _animationController.forward();
      return;
    }
    _animationController.reverse();
  }

  void _onPressed() {
    if (widget.props.onChange == null) {
      return;
    }
    final isSelected = widget.props.value;
    widget.props.onChange?.call(!isSelected);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final primarySwatch = theme.extension<ColorsExtension>()!.primarySwatch;

    final borderRadius = BorderRadius.circular(_borderRadius);

    final backgroundColorAnimation =
        ColorTween(end: primarySwatch!.shade300).animate(_animationController);

    final firstShadowColor =
        ColorTween(begin: theme.colorScheme.shadow, end: primarySwatch.shade100)
            .animate(_animationController);
    final secondShadowColor = ColorTween(
            begin: theme.shadowColor.withOpacity(_shadowOpacity),
            end: primarySwatch.shade900)
        .animate(_animationController);

    return GestureDetector(
      onTap: _onPressed,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: _gesturePadding),
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: backgroundColorAnimation.value,
                ),
                child: DecoratedBox(
                  decoration: ConcaveDecoration(
                    shape: RoundedRectangleBorder(borderRadius: borderRadius),
                    depth: _deph,
                    colors: [
                      firstShadowColor.value ?? theme.colorScheme.background,
                      secondShadowColor.value ?? theme.colorScheme.background
                    ],
                  ),
                  child: SizedBox(
                    height: _height,
                    width: _width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: _switcherThumbPadding),
                      child: Align(
                        alignment: _alignmentTween.value,
                        child: const SwitcherThumb(),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
