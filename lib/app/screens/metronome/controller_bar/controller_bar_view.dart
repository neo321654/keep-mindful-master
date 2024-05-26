import 'package:flutter/material.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../l10n/app_loc_extension.dart';
import '../../../shared/shared.dart';
import 'controller_bar_props.dart';

const _borderRadius = 80.0;
const _blurRadius = 20.0;
const _shadowDistance = Offset(10.0, 10.0);
const _horizontalPadding = 24.0;
const _verticalPadding = 12.0;
const _paddingBetweenButtons = 28.0;

class ControllerBar extends StatelessWidget {
  const ControllerBar({required this.props, super.key});

  final ControllerBarProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;
    return DecoratedBox(
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: [
            BoxShadow(
              blurRadius: _blurRadius,
              color: theme.shadowColor.withOpacity(0.6),
              offset: _shadowDistance,
            ),
            BoxShadow(
              blurRadius: _blurRadius,
              color: theme.colorScheme.shadow,
              offset: -_shadowDistance,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: _horizontalPadding, vertical: _verticalPadding),
        child: SeparatedRow(
          mainAxisSize: MainAxisSize.min,
          separatorBuilder: (_, __) =>
              const WidthSpacer(_paddingBetweenButtons),
          children: [
            Button(
              props: ButtonProps(
                semanticsLabel: loc.previousSemanticsLabel,
                onPressed: props.onPreviousPressed,
                leftIcon: Assets.icons.chevronLeft,
                buttonStyle: ButtonStyles.byType(
                  theme,
                  ButtonType.circleIconMedium,
                ),
              ),
            ),
            Button(
              props: ButtonProps(
                semanticsLabel: loc.playPauseSemanticsLabel,
                onPressed: props.onStartPressed,
                leftIcon: props.isActive
                    ? Assets.icons.neoPause
                    : Assets.icons.neoPlay,
                buttonStyle: ButtonStyles.byType(
                  theme,
                  ButtonType.circleIconLarge,
                ),
              ),
            ),
            Button(
              props: ButtonProps(
                semanticsLabel: loc.nextSemanticsLabel,
                onPressed: props.onNextPressed,
                leftIcon: Assets.icons.chevronRight,
                buttonStyle: ButtonStyles.byType(
                  theme,
                  ButtonType.circleIconMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
