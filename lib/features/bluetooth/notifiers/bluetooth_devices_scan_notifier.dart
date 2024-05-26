import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../services/services.dart';

class BluetoothDevicesScanNotifier extends ChangeNotifier {
  BluetoothDevicesScanNotifier(BleDevicesService devicesService)
      : _devicesService = devicesService {
    _isScanning = devicesService.isScanningNow;
    _isScanningSubscription =
        _devicesService.isScanning.listen(_onScanStateChanged);
    _scanSubscription =
        _devicesService.scanResults.listen(_onScanResultsChanged);
  }

  final BleDevicesService _devicesService;

  late final StreamSubscription<List<ScanResult>> _scanSubscription;
  late final StreamSubscription<bool> _isScanningSubscription;

  bool _isScanning = false;
  final List<ScanResult> _scanResults = [];

  bool get isScanning => _isScanning;
  List<ScanResult> get scanResults => _scanResults;

  Future<void> scan() async {
    if (_isScanning) {
      return;
    }
    _scanResults.clear();
    await _devicesService.startScan();
  }

  void _onScanStateChanged(bool isScanning) {
    if (_isScanning == isScanning) {
      return;
    }
    _isScanning = isScanning;
    notifyListeners();
  }

  void _onScanResultsChanged(List<ScanResult> scanResults) {
    _scanResults.clear();
    _scanResults.addAll(scanResults);
    notifyListeners();
  }

  @override
  void dispose() {
    _isScanningSubscription.cancel();
    _scanSubscription.cancel();
    super.dispose();
  }
}
