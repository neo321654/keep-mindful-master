import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'alarm_disable_qr_props.dart';

const _borderRadius = 12.0;
const _containerPadding = 1.0;
const _qrPadding = 5.0;
const _size = 250.0;

class AlarmDisableQr extends StatelessWidget {
  const AlarmDisableQr({required this.props, super.key});

  final AlarmDisableQrProps props;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(_borderRadius);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: theme.primaryColor),
      ),
      padding: const EdgeInsets.all(_containerPadding),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: QrImageView(
          semanticsLabel: props.qr,
          padding: const EdgeInsets.all(_qrPadding),
          data: props.qr,
          size: _size,
          eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square, color: theme.colorScheme.onSurface),
          backgroundColor: theme.colorScheme.surface,
          dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}
