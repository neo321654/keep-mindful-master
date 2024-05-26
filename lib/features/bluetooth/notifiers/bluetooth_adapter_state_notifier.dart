import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../services/services.dart';

class BluetoothAdapterStateNotifier extends ChangeNotifier {
  BluetoothAdapterStateNotifier(BleEnableService enableService)
      : _enableService = enableService {
    _adapterState = enableService.adapterStateNow;
    _adapterStateStateSubscription =
        enableService.adapterState.listen(_onAdapterStateChanged);
  }

  final BleEnableService _enableService;

  late final StreamSubscription<BluetoothAdapterState>
      _adapterStateStateSubscription;

  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  BluetoothAdapterState get adapterState => _adapterState;

  Future<void> enable() async {
    if (_enableService.adapterStateNow == BluetoothAdapterState.turningOn) {
      return;
    }
    await _enableService.enableBluetooth();
  }

  void _onAdapterStateChanged(BluetoothAdapterState adapterState) {
    if (_adapterState == adapterState) {
      return;
    }
    _adapterState = adapterState;
    notifyListeners();
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }
}
