import 'package:flutter/material.dart';

import '../../../shared.dart';
import 'selectable_item_props.dart';

const _animationDuration = Duration(milliseconds: 100);
const _horizontalPadding = 16.0;
const _verticalPadding = 8.0;
const _borderRadius = 24.0;
const _shadowOffset = Offset(3.0, 3.0);
const _shadowBlurRadius = 8.0;
const _shadowOpacity = 0.6;

class SelectableItem extends StatelessWidget {
  const SelectableItem({required this.props, super.key});

  final SelectableItemProps props;

  void _onPressed() {
    props.onPressed?.call(props.value);
  }

  Gradient _prepareGradient(bool isSelected, ThemeData theme) {
    if (isSelected) {
      final primarySwatch = theme.extension<ColorsExtension>()!.primarySwatch;
      return LinearGradient(
          colors: [primarySwatch!.shade700, primarySwatch.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight);
    }

    return LinearGradient(
        colors: [theme.colorScheme.surface, theme.colorScheme.background]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isSelected = props.value == props.groupValue;

    final textColor =
        isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface;

    return GestureDetector(
      onTap: _onPressed,
      child: AnimatedContainer(
        duration: _animationDuration,
        padding: const EdgeInsets.symmetric(
            horizontal: _horizontalPadding, vertical: _verticalPadding),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: theme.shadowColor.withOpacity(_shadowOpacity),
                  blurRadius: _shadowBlurRadius,
                  offset: _shadowOffset)
            ],
            gradient: _prepareGradient(isSelected, theme),
            borderRadius: BorderRadius.circular(_borderRadius)),
        child: Text(
          props.title,
          style: theme.textTheme.labelLarge?.copyWith(color: textColor),
        ),
      ),
    );
  }
}
