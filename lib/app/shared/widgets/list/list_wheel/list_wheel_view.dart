import 'package:flutter/material.dart';

import '../../spacer/spacer.dart';
import 'list_wheel_props.dart';

const _borderRadius = 12.0;
const _shadowDistance = Offset(10.0, 10.0);
const _shadowBlur = 20.0;
const _gradientStopsVertical = [0.0, 0.35, 0.65, 1.0];
const _gradientStopsHorizontal = [0.0, 0.47, 0.52, 1.0];
const _containerHeightVertical = 320.0;
const _containerWidthVertical = 80.0;
const _containerHeightHorizontal = 57.0;
const _containerWidthHorizontal = 230.0;
const _itemSizeVertical = 50.0;
const _itemSizeHorizontal = 50.0;
const _spaceBetweenItemsVertical = 0.9;
const _spaceBetweenItemsHorizontal = 1.0;
const _titleBottomSpaceVertical = 24.0;
const _titleBottomSpaceHorizontal = 12.0;
const _shadowOpacity = 0.6;
const _horizontalPadding = EdgeInsets.symmetric(horizontal: 15.0);

class ListWheel extends StatelessWidget {
  const ListWheel({required this.props, super.key});

  final ListWheelProps props;

  void _onChanged(int pos) {
    props.onChanged?.call(pos);
  }

  List<Widget> _generateItems(ThemeData theme) {
    final textStyle = theme.textTheme.displayMedium?.copyWith(
        color: theme.colorScheme.onSurface, fontWeight: FontWeight.w300);
    if (props.direction == Axis.vertical) {
      return List.generate(
        props.count,
        (pos) {
          final value = props.startFromZero ? pos : pos + 1;
          return Text(
            value < 10 ? '0$value' : '$value',
            style: textStyle,
          );
        },
      );
    }

    return List.generate(
      props.count,
      (pos) {
        final value = props.startFromZero ? pos : pos + 1;
        return RotatedBox(
          quarterTurns: 1,
          child: Text(
            '$value',
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  TextStyle? _getLabelStyle(ThemeData theme) {
    final bool isVertical = props.direction == Axis.vertical;

    if (isVertical) {
      return theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w300, color: theme.colorScheme.onBackground);
    }

    return theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w300, color: theme.colorScheme.onBackground);
  }

  Gradient? _getGradient(ThemeData theme) {
    final bool isVertical = props.direction == Axis.vertical;

    final backgroundColor = theme.colorScheme.surface;

    final colors = [
      backgroundColor,
      backgroundColor.withOpacity(0.0),
      backgroundColor.withOpacity(0.0),
      backgroundColor
    ];

    if (isVertical) {
      return LinearGradient(
        colors: colors,
        stops: _gradientStopsVertical,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
    return LinearGradient(
      colors: colors,
      stops: _gradientStopsHorizontal,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final borderRadius = BorderRadius.circular(_borderRadius);

    final bool isVertical = props.direction == Axis.vertical;

    final items = _generateItems(theme);

    return Semantics(
      excludeSemantics: true,
      label: props.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            props.title,
            style: _getLabelStyle(theme),
          ),
          HeightSpacer(isVertical
              ? _titleBottomSpaceVertical
              : _titleBottomSpaceHorizontal),
          Container(
            padding: isVertical ? null : _horizontalPadding,
            height: isVertical
                ? _containerHeightVertical
                : _containerHeightHorizontal,
            width: isVertical
                ? _containerWidthVertical
                : _containerWidthHorizontal,
            foregroundDecoration: BoxDecoration(
              gradient: _getGradient(theme),
              borderRadius: borderRadius,
            ),
            decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: borderRadius,
                boxShadow: [
                  BoxShadow(
                    blurRadius: _shadowBlur,
                    color: theme.shadowColor.withOpacity(_shadowOpacity),
                    offset: _shadowDistance,
                  ),
                  BoxShadow(
                    blurRadius: _shadowBlur,
                    color: theme.colorScheme.shadow,
                    offset: -_shadowDistance,
                  ),
                ]),
            child: IgnorePointer(
              ignoring: !props.enabled,
              child: RotatedBox(
                quarterTurns: isVertical ? 0 : -1,
                child: ListWheelScrollView.useDelegate(
                  key: Key('${props.title}_wheel'.toLowerCase()),
                  controller: props.controller,
                  squeeze: isVertical
                      ? _spaceBetweenItemsVertical
                      : _spaceBetweenItemsHorizontal,
                  itemExtent:
                      isVertical ? _itemSizeVertical : _itemSizeHorizontal,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate:
                      ListWheelChildLoopingListDelegate(children: items),
                  onSelectedItemChanged: _onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
