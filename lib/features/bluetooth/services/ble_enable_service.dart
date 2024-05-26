import 'dart:io' show Platform;

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleEnableService {
  const BleEnableService();

  Stream<BluetoothAdapterState> get adapterState =>
      FlutterBluePlus.adapterState;

  BluetoothAdapterState get adapterStateNow => FlutterBluePlus.adapterStateNow;

  Future<void> enableBluetooth() async {
    final isSupported = await FlutterBluePlus.isSupported;

    if (!isSupported) {
      return;
    }
   
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
      return;
    }
  }
}
