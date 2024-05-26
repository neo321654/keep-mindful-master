import 'package:flutter/material.dart';

import '../../../../../../generated/assets.gen.dart';
import '../../../../../../l10n/app_loc_extension.dart';

const _iconSize = 74.0;
const _borderRadius = 16.0;

class AlarmConfirmed extends StatelessWidget {
  const AlarmConfirmed({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.circleCheckMark.svg(
            height: _iconSize,
            width: _iconSize,
            colorFilter:
                ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn),
          ),
          Text(
            context.loc.alarmDisableQrConfirmed,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}
