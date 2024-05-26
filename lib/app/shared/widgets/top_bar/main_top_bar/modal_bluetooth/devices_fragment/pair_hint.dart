import 'package:flutter/material.dart';

import '../../../../../../../generated/assets.gen.dart';
import '../../../../../../../l10n/app_loc_extension.dart';

const _iconPadding = 8.0;

class PairHint extends StatelessWidget {
  const PairHint({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          loc.bluetoothConnectHintFirst,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(_iconPadding),
          child: Assets.icons.connect.svg(),
        ),
        Text(
          loc.bluetoothConnectHintSecond,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
