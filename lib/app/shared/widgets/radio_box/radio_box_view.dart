import 'package:flutter/material.dart';

import '../concave_decoration.dart';
import '../icon/icon.dart';
import 'radio_box_props.dart';

const _chekMarkSize = 20.0;
const _padding = 4.0;
const _animationDuration = Duration(milliseconds: 50);
const _tapTargetSize = 48.0;
const _concaveDepth = 5.0;

class RadioBox<T> extends StatefulWidget {
  const RadioBox({required this.props, super.key});

  final RadioBoxProps<T> props;

  @override
  State<RadioBox> createState() => _RadioBoxState<T>();
}

class _RadioBoxState<T> extends State<RadioBox>
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
    final props = widget.props;

    _animationController = AnimationController(
        vsync: this,
        duration: _animationDuration,
        value: props.value == props.groupValue ? 1.0 : 0.0);
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RadioBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.props.groupValue != oldWidget.props.groupValue) {
      final newProps = widget.props;
      _animateSelection(newProps.value == newProps.groupValue);
    }
  }

  void _onPressed() {
    final props = widget.props as RadioBoxProps<T>;
    props.onPressed?.call(props.value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onPressed,
      child: SizedBox(
        height: _tapTargetSize,
        width: _tapTargetSize,
        child: Center(
          child: DecoratedBox(
            decoration: ConcaveDecoration(
                shape: const CircleBorder(),
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
                            props:
                                DecoratedCheckIconProps(shape: BoxShape.circle),
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
