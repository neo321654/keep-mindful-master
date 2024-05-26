import 'package:flutter/material.dart';

import 'expandable_panel_props.dart';

const _borderRadius = 12.0;
const _outerShadowDistance = Offset(10.0, 10.0);
const _outerShadowBlur = 20.0;
const _outerDecorationOpacity = 0.4;

class ExpandablePanel extends StatelessWidget {
  const ExpandablePanel({required this.props, super.key});

  final ExpandablePanelProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final title = Text(
      props.title,
      style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurface, fontWeight: FontWeight.w300),
    );

    final body = Text(
      props.body,
      style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface, fontWeight: FontWeight.w300),
    );

    final borderRadius = BorderRadius.circular(_borderRadius);

    return DecoratedBox(
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              blurRadius: _outerShadowBlur,
              color: theme.shadowColor.withOpacity(_outerDecorationOpacity),
              offset: _outerShadowDistance,
            ),
            BoxShadow(
              blurRadius: _outerShadowBlur,
              color: theme.colorScheme.shadow,
              offset: -_outerShadowDistance,
            ),
          ]),
      child: Theme(
        data: theme.copyWith(splashColor: Colors.transparent),
        child: ExpansionTile(
          title: title,
          backgroundColor: theme.colorScheme.surface,
          children: [body],
        ),
      ),
    );
  }
}
