import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../constants/constants.dart';
import '../keep_mindful_device.dart';
import '../keep_mindful_ring.dart';
import '../repositories/repositories.dart';

class BluetoothDeviceStateNotifier extends ChangeNotifier {
  BluetoothDeviceStateNotifier(BluetoothDeviceRepository repository)
      : _repository = repository;

  final BluetoothDeviceRepository _repository;

  StreamSubscription<BleDeviceConnectionState>?
      _deviceConnectionStateSubscription;
  String? _lastErrorConnectionRemoteId;
  KeepMindfulDevice? _device;
  BleDeviceConnectionState _connectionState =
      BleDeviceConnectionState.disconnected;
  String? get lastErrorConnectionRemoteId => _lastErrorConnectionRemoteId;
  KeepMindfulDevice? get device => _device;
  BleDeviceConnectionState get connectionState => _connectionState;

  Future<void> _onConnectionStateChanged(BleDeviceConnectionState state) async {
    _connectionState = state;
    notifyListeners();
    if (state != BleDeviceConnectionState.connected) {
      return;
    }
    try {
      await _device!.setCurrentDateTime(DateTime.now());
      await _repository.set(_device!.remoteId);
    } catch (_) {}
  }

  Future<void> reconnect() async {
    final remoteId = _repository.get();
    if (remoteId == null) {
      return;
    }
    _device = KeepMindfulRing(deviceRemoteId: remoteId);
    if (_device!.isConnected) {
      return;
    }
    _lastErrorConnectionRemoteId = null;
    notifyListeners();
    _deviceConnectionStateSubscription ??=
        _device!.connectionState.listen(_onConnectionStateChanged);
    try {
      await _device!.connect();
    } catch (_) {
      _lastErrorConnectionRemoteId = remoteId;
      notifyListeners();
    }
  }

  Future<void> connect(BluetoothDevice selectedDevice) async {
    if (_connectionState == BleDeviceConnectionState.connecting) {
      return;
    }
    if (selectedDevice.remoteId.str == _device?.remoteId &&
        _connectionState == BleDeviceConnectionState.connected) {
      return;
    }
    try {
      await _device?.disconnect();
      _deviceConnectionStateSubscription?.cancel();
      _lastErrorConnectionRemoteId = null;
      _device = KeepMindfulRing(deviceRemoteId: selectedDevice.remoteId.str);
      notifyListeners();
      _deviceConnectionStateSubscription =
          _device!.connectionState.listen(_onConnectionStateChanged);
      await _device!.connect();
    } catch (_) {
      _lastErrorConnectionRemoteId = selectedDevice.remoteId.str;
      notifyListeners();
    }
  }
}
