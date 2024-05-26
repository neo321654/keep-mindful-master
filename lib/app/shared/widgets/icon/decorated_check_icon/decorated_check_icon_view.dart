import 'package:flutter/material.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../themes/themes.dart';
import 'decorated_check_icon_props.dart';

const _iconPadding = 2.0;

class DecoratedCheckIcon extends StatelessWidget {
  const DecoratedCheckIcon({required this.props, super.key});

  final DecoratedCheckIconProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorsExtension = theme.extension<ColorsExtension>()!;

    final gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          colorsExtension.primarySwatch!.shade200,
          colorsExtension.primarySwatch!.shade800
        ]);

    final borderRadius = props.shape == BoxShape.rectangle
        ? BorderRadius.circular(props.borderRadius)
        : null;

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: props.shape,
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(_iconPadding),
        child: Assets.icons.checkMark.svg(
          colorFilter:
              ColorFilter.mode(theme.colorScheme.onPrimary, BlendMode.srcIn),
        ),
      ),
    );
  }
}
