import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'bluetooth_device_state_notifier.dart';

class BluetoothDeviceBatteryNotifier extends ChangeNotifier {
  BluetoothDeviceBatteryNotifier(this.deviceStateNotifier) {
    _init();
  }

  final BluetoothDeviceStateNotifier deviceStateNotifier;

  StreamSubscription<int>? _batterySubscription;

  double _batteryLevel = 0.0;

  double get batteryLevel => _batteryLevel;

  Future<void> _init() async {
    deviceStateNotifier.addListener(_onDeviceUpdated);
    if (deviceStateNotifier.connectionState ==
        BleDeviceConnectionState.connected) {
      _batterySubscription = deviceStateNotifier.device!.batteryLevel
          .listen(_onBatteryLevelChanged);
      try {
        await deviceStateNotifier.device?.queueBatteryLevel();
      } catch (_) {}
    }
  }

  Future<void> _onDeviceUpdated() async {
    _batterySubscription?.cancel();
    if (!(deviceStateNotifier.connectionState ==
        BleDeviceConnectionState.connected)) {
      _batteryLevel = 0.0;
      notifyListeners();
      return;
    }
    _batterySubscription =
        deviceStateNotifier.device?.batteryLevel.listen(_onBatteryLevelChanged);
    try {
      await deviceStateNotifier.device?.queueBatteryLevel();
    } catch (_) {}
  }

  void _onBatteryLevelChanged(int batteryLevel) {
    _batteryLevel = batteryLevel / 4;
    notifyListeners();
  }

  @override
  void dispose() {
    deviceStateNotifier.removeListener(_onDeviceUpdated);
    _batterySubscription?.cancel();
    super.dispose();
  }
}
