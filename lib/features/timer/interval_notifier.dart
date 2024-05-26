import 'package:flutter/material.dart';

import '../bluetooth/bluetooth.dart';
import 'repositories/repositories.dart';

const _defaultInterval = Duration(seconds: 15);

class IntervalNotifier extends ChangeNotifier {
  IntervalNotifier(IntervalRepository repository)
      : _intervalRepository = repository;

  final IntervalRepository _intervalRepository;

  KeepMindfulDevice? _device;

  Duration _interval = _defaultInterval;
  Duration get interval => _interval;

  void setInterval(Duration duration) {
    if (duration.compareTo(_interval) == 0) {
      return;
    }
    _interval = duration;
    notifyListeners();
  }

  void getInitialInterval() {
    final savedInterval = _intervalRepository.get();
    _interval = savedInterval ?? _defaultInterval;
  }

  Future<void> saveInterval() async {
    await _intervalRepository.set(_interval);
    await _sendInterval(_interval);
  }

  Future<void> resetInterval() async {
    await _intervalRepository.reset();
    _interval = _defaultInterval;
    notifyListeners();
    await _sendInterval(null);
  }

  Future<void> _sendInterval(Duration? duration) async {
    if (_device == null || !_device!.isConnected) {
      return;
    }
    try {
      await _device!.setTimerInterval(duration ?? _defaultInterval);
      await _intervalRepository.setSentNow();
    } catch (_) {}
  }

  Future<void> updateDevice(KeepMindfulDevice? newDevice) async {
    final oldDevice = _device;
    _device = newDevice;
    if (newDevice == null || oldDevice == null) {
      return;
    }
    if (oldDevice.remoteId != newDevice.remoteId) {
      await resetInterval();
    }
  }
}
