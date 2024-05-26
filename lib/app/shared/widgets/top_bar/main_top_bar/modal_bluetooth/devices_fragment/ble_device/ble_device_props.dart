import 'package:flutter/material.dart';

import '../../../../../../../../features/features.dart';

class BleDeviceProps {
  const BleDeviceProps(
      {required this.title,
      required this.state,
      this.onPressed,
      this.showConnectionError = false});

  final String title;
  final BleDeviceConnectionState state;
  final VoidCallback? onPressed;
  final bool showConnectionError;
}
