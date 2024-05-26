import 'package:flutter/material.dart';

import '../../concave_decoration.dart';
import 'selectable_list_tile.dart';

const _borderRadius = 12.0;
const _outerShadowDistance = Offset(10.0, 10.0);
const _outerShadowBlur = 20.0;
const _innerShadowDeph = 10.0;
const _animationDuration = Duration(milliseconds: 100);
const _outerDecorationOpacity = 0.4;

class SelectableListTile extends StatefulWidget {
  const SelectableListTile({required this.props, super.key});

  final SelectableListTileProps props;

  @override
  State<SelectableListTile> createState() => _SelectableListTileState();
}

class _SelectableListTileState extends State<SelectableListTile> {
  bool _isPressed = false;

  void _onPressed(bool isPressed) {
    if (widget.props.onPressed == null) {
      return;
    }

    if (!isPressed) {
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
  Widget build(BuildContext context) {
    final props = widget.props;
    final theme = Theme.of(context);
    final decoration = _buildDecoration(theme);

    final children = <Widget>[
      Expanded(
        child: Text(
          props.title,
          style: theme.textTheme.titleMedium
              ?.copyWith(color: theme.colorScheme.onSurface, height: 1.2),
        ),
      ),
    ];

    if (props.trailing != null) {
      children.add(props.trailing!);
    }

    return Semantics(
      label: props.title,
      excludeSemantics: true,
      child: Listener(
        onPointerUp: (_) => _onPressed(false),
        onPointerDown: (_) => _onPressed(true),
        child: AnimatedContainer(
          padding: widget.props.padding,
          duration: _animationDuration,
          decoration: decoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      ),
    );
  }
}
