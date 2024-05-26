import 'package:flutter/material.dart';

import '../../../../../../../../features/features.dart';
import '../../../../../../../../generated/assets.gen.dart';
import '../../../../../../../../l10n/app_loc_extension.dart';
import '../../../../../button/button.dart';
import '../../../../../spacer/spacer.dart';
import 'ble_device.dart';

const _paddingBetweenElements = 10.0;
const _containerPadding = 12.0;
const _buttonSize = 50.0;

const _borderRadius = 12.0;
const _outerShadowDistance = Offset(10.0, 10.0);
const _outerShadowBlur = 20.0;
const _outerDecorationOpacity = 0.4;
const _errorTextTopPadding = 5.0;

class BleDevice extends StatelessWidget {
  const BleDevice({required this.props, super.key});

  final BleDeviceProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final content = <Widget>[
      Text(
        props.title,
        style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface, fontWeight: FontWeight.w300),
      ),
    ];

    if (props.showConnectionError) {
      content.addAll([
        const HeightSpacer(_errorTextTopPadding),
        Text(
          context.loc.notConnected,
          style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.4),
              fontWeight: FontWeight.w300),
        ),
      ]);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(_borderRadius),
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
      child: Padding(
        padding: const EdgeInsets.all(_containerPadding),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: content),
            ),
            const WidthSpacer(_paddingBetweenElements),
            SizedBox(
              height: _buttonSize,
              width: _buttonSize,
              child: Center(
                child: Button(
                  props: ButtonProps(
                      leftIcon: Assets.icons.connect,
                      isPressed:
                          props.state == BleDeviceConnectionState.connecting,
                      isDisabled:
                          props.state == BleDeviceConnectionState.connected,
                      buttonStyle: ButtonStyles.byType(
                        theme,
                        ButtonType.rectanlgeIconSmallSecondary,
                      ),
                      onPressed: props.onPressed),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
