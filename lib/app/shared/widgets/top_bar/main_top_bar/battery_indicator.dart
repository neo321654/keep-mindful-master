import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../features/features.dart';
import '../../../../../generated/assets.gen.dart';
import '../../../../../l10n/app_loc_extension.dart';
import '../../../shared.dart';

const _iconSize = 24.0;
const _indicatorPaddingRight = 4.0;

class BatteryIndicator extends StatefulWidget {
  const BatteryIndicator({super.key});

  @override
  State<BatteryIndicator> createState() => _BatteryIndicatorState();
}

class _BatteryIndicatorState extends State<BatteryIndicator> {
  final _deviceBatteryIndicator =
      GetIt.instance<BluetoothDeviceBatteryNotifier>();

  SvgGenImage _getBatteryIcon(double level) {
    if (level < 10) {
      return Assets.icons.batteryIndicator0;
    }
    if (level < 20) {
      return Assets.icons.batteryIndicator1;
    }
    if (level < 30) {
      return Assets.icons.batteryIndicator2;
    }
    if (level < 40) {
      return Assets.icons.batteryIndicator3;
    }
    if (level < 50) {
      return Assets.icons.batteryIndicator4;
    }
    if (level < 60) {
      return Assets.icons.batteryIndicator5;
    }
    if (level < 70) {
      return Assets.icons.batteryIndicator6;
    }
    if (level < 80) {
      return Assets.icons.batteryIndicator7;
    }
    if (level < 90) {
      return Assets.icons.batteryIndicator8;
    }
    if (level < 100) {
      return Assets.icons.batteryIndicator9;
    }
    if (level >= 100) {
      return Assets.icons.batteryIndicator10;
    }
    return Assets.icons.batteryIndicator0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: context.loc.batteryIndicatorSemanticsLabel,
      excludeSemantics: true,
      child: ListenableBuilder(
          listenable: _deviceBatteryIndicator,
          builder: (_, __) {
            final batteryLevel = _deviceBatteryIndicator.batteryLevel * 100;
            final battery = _getBatteryIcon(batteryLevel);
            return Row(
              children: [
                battery.svg(
                    width: _iconSize,
                    height: _iconSize,
                    colorFilter: ColorFilter.mode(
                        theme.colorScheme.onSurface, BlendMode.srcIn)),
                const WidthSpacer(_indicatorPaddingRight),
                Text(
                  '${batteryLevel.toInt()}%',
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w300),
                )
              ],
            );
          }),
    );
  }
}
