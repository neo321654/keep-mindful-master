import 'package:flutter/material.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../l10n/app_loc_extension.dart';
import '../../button/button.dart';
import '../../separated/separated.dart';
import '../../spacer/spacer.dart';
import 'time_actions_bar_props.dart';

const _borderRadius = 80.0;
const _blurRadius = 20.0;
const _shadowDistance = Offset(10.0, 10.0);
const _horizontalPadding = 18.0;
const _verticalPadding = 8.0;
const _paddingBetweenButtons = 28.0;

class TimeActionsBar extends StatelessWidget {
  const TimeActionsBar({required this.props, super.key});

  final TimeActionsBarProps props;

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
              key: const Key('actions_bar_left_button'),
              props: ButtonProps(
                semanticsLabel: loc.resetSemanticsLabel,
                onPressed: props.onStopPressed,
                leftIcon: Assets.icons.stop,
                buttonStyle: ButtonStyles.byType(
                  theme,
                  ButtonType.circleIconMedium,
                ),
              ),
            ),
            Button(
              key: const Key('actions_bar_center_button'),
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
              key: const Key('actions_bar_right_button'),
              props: ButtonProps(
                semanticsLabel: loc.intervalTitle,
                onPressed: props.onIntervalPressed,
                leftIcon: Assets.icons.interval,
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
