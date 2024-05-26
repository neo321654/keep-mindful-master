import 'package:flutter/material.dart';

import '../../app/shared/shared.dart';
import '../bluetooth/keep_mindful_device.dart';
import 'repositories/repositories.dart';

class DurationNotifier extends ChangeNotifier {
  DurationNotifier(DurationRepository durationRepository)
      : _durationRepository = durationRepository;

  final DurationRepository _durationRepository;

  KeepMindfulDevice? _device;

  CountdownTimer? _countdown;

  Duration _duration = Duration.zero;

  bool _isCountdownActive = false;

  Duration get duration => _duration;

  bool get isCountdownActive => _isCountdownActive;

  void init() {
    final DateTime? finishTime = _durationRepository.get();
    if (finishTime == null) {
      return;
    }
    final now = DateTime.now();
    if (finishTime.compareTo(now) == -1 || finishTime.compareTo(now) == 0) {
      return;
    }

    _duration = finishTime.difference(now);
    _toggleCountdown(true);
    _isCountdownActive = true;
  }

  void _toggleCountdown(bool isActive) {
    if (isActive) {
      if (_countdown?.value != _duration) {
        _countdown?.dispose();
        _countdown = CountdownTimer(_duration);
        _countdown!.addListener(() {
          _duration = _countdown!.value;
          notifyListeners();
          if (_duration.compareTo(Duration.zero) == 0) {
            _isCountdownActive = false;
            notifyListeners();
          }
        });
      }
    }
    _countdown!.togglePlayState();
  }

  void _resetCountdown() {
    _countdown?.dispose();
    _countdown = null;
    _duration = Duration.zero;
    _isCountdownActive = true;
    notifyListeners();

    _isCountdownActive = false;
    notifyListeners();
  }

  void resetDuration() {
    _resetCountdown();
    _updateFinishTime(false);
  }

  void setDuration(Duration duration) {
    if (_duration.compareTo(duration) == 0) {
      return;
    }
    _duration = duration;
    _isCountdownActive = false;
    notifyListeners();
  }

  void setCountdownActive(bool isActive) {
    if (_isCountdownActive == isActive) {
      return;
    }
    if (isActive && _duration == Duration.zero) {
      return;
    }
    _isCountdownActive = isActive;
    notifyListeners();
    _toggleCountdown(isActive);
    _updateFinishTime(isActive);
  }

  Future<void> _updateFinishTime(bool isActive) async {
    try {
      if (isActive) {
        final finishTime = DateTime.now().add(duration);
        await _durationRepository.set(finishTime);
        await _device!.setTimerDuration(finishTime);
        return;
      }
      await _durationRepository.set(null);
      await _sendDuration(null);
    } catch (_) {}
  }

  Future<void> _sendDuration(DateTime? timer) async {
    if (_device == null || !_device!.isConnected) {
      return;
    }
    try {
      await _device!.setTimerDuration(timer);
      await _durationRepository.setSentNow();
    } catch (_) {}
  }

  Future<void> updateDevice(KeepMindfulDevice? newDevice) async {
    final oldDevice = _device;
    _device = newDevice;
    if (newDevice == null || oldDevice == null) {
      return;
    }
    if (oldDevice.remoteId != newDevice.remoteId) {
      _resetCountdown();
      _durationRepository.reset();
      return;
    }
  }
}
