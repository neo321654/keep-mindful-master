import 'package:flutter/material.dart';

import '../../../../../../../generated/assets.gen.dart';
import '../../../../../../../l10n/app_loc_extension.dart';

class ConnectDecoration extends StatelessWidget {
  const ConnectDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final theme = Theme.of(context);

    return Stack(
      children: [
        Positioned.fill(child: Assets.images.bluetoothWaves.svg()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            loc.bluetoothTurnOnHint,
            style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
