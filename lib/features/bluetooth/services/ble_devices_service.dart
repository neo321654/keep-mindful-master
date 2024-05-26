import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../constants/constants.dart';

const _defaultScanTimeout = Duration(seconds: 5);

class BleDevicesService {
  const BleDevicesService();

  Future<void> startScan() => FlutterBluePlus.startScan(
      withServices: [Guid(BaseGuids.service)],
      androidUsesFineLocation: true,
      timeout: _defaultScanTimeout);

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  bool get isScanningNow => FlutterBluePlus.isScanningNow;

  Stream<bool> get isScanning => FlutterBluePlus.isScanning;

  Future<void> stopScan() => FlutterBluePlus.stopScan();

  BluetoothDevice? get connectedDevice {
    final devices = FlutterBluePlus.connectedDevices;
    if (devices.isEmpty) {
      return null;
    }
    return devices.first;
  }
}
