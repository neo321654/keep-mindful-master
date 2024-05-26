import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../shared/shared.dart';
import 'alarm_item_props.dart';

const _borderRadius = 12.0;
const _outerShadowDistance = Offset(10.0, 10.0);
const _outerShadowBlur = 20.0;
const _innerShadowDeph = 10.0;
const _animationDuration = Duration(milliseconds: 100);
const _outerDecorationOpacity = 0.4;
const _containerPadding =
    EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0);
const _paddingBetweenElements = 10.0;

class AlarmItem extends StatefulWidget {
  const AlarmItem({required this.props, super.key});

  final AlarmItemProps props;

  @override
  State<AlarmItem> createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  bool _isPressed = false;
  bool _isActive = false;

  void _onPressed(bool isPressed, [bool cancelledOnTap = false]) {
    if (widget.props.onPressed == null) {
      return;
    }

    if (!isPressed && !cancelledOnTap) {
      widget.props.onPressed!.call();
    }

    setState(() {
      _isPressed = isPressed;
    });
  }

  Decoration _buildInnerDecorationShape(List<Color> shadowColors) {
    return ConcaveDecoration(
      depth: _innerShadowDeph,
      colors: shadowColors.reversed.toList(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
    );
  }

  Decoration _buildOuterDecorationShape(
      ThemeData theme, List<Color> shadowColors) {
    final borderRadius = BorderRadius.circular(_borderRadius);

    return BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            blurRadius: _outerShadowBlur,
            color: shadowColors.first,
            offset: _outerShadowDistance,
          ),
          BoxShadow(
            blurRadius: _outerShadowBlur,
            color: shadowColors.last,
            offset: -_outerShadowDistance,
          ),
        ]);
  }

  Decoration? _buildDecoration(ThemeData theme) {
    final props = widget.props;

    final shadowColors = [
      theme.shadowColor.withOpacity(_outerDecorationOpacity),
      theme.colorScheme.shadow
    ];

    final outerDecoration = _buildOuterDecorationShape(theme, shadowColors);

    if (props.onPressed == null) {
      return outerDecoration;
    }

    final innerDecoration = _buildInnerDecorationShape(shadowColors);

    return _isPressed ? innerDecoration : outerDecoration;
  }

  @override
  void initState() {
    super.initState();
    _isActive = widget.props.isActive;
  }

  @override
  void didUpdateWidget(covariant AlarmItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.props.isActive != oldWidget.props.isActive) {
      setState(() {
        _isActive = widget.props.isActive;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final props = widget.props;
    final theme = Theme.of(context);
    final decoration = _buildDecoration(theme);

    final time = DateFormat.Hm(Localizations.localeOf(context).languageCode)
        .format(props.time);

    return GestureDetector(
      onTapDown: (_) => _onPressed(true),
      onTapUp: (_) => _onPressed(false),
      onTapCancel: () => _onPressed(false, true),
      child: AnimatedContainer(
        padding: _containerPadding,
        duration: _animationDuration,
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    props.name,
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w300),
                  ),
                  const HeightSpacer(_paddingBetweenElements),
                  Text(
                    time,
                    style: theme.textTheme.displayMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            const WidthSpacer(_paddingBetweenElements),
            Switcher(
              props: SwitcherProps(
                  onChange: props.onActivatePressed, value: _isActive),
            ),
          ],
        ),
      ),
    );
  }
}
