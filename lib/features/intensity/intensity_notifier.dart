import 'package:flutter/material.dart';

import '../../app/shared/shared.dart';
import '../bluetooth/bluetooth.dart';
import 'constants/constants.dart';
import 'repositories/repositories.dart';

const _defaultIntensity = 100.0;

class IntensityNotifier extends ChangeNotifier {
  final Debouncer _intensityDebouncer = Debouncer();

  late final IntensityRepository _repository;
  late final IntensityMode _mode;

  KeepMindfulDevice? _device;

  NotificationType _selectedNotifyType = NotificationType.vibration;
  double _intensity = _defaultIntensity;

  double get intensity => _intensity;
  NotificationType get selectedNotifyType => _selectedNotifyType;

  void setMode(IntensityMode mode) {
    _mode = mode;
    _repository = mode == IntensityMode.timer
        ? IntensityTimerRepository()
        : IntensityMetronomeRepository();
    final intensity = _repository.getPower()?.toDouble();
    final intensityNotifyType = _repository.getIntensityType();
    _intensity = intensity ?? _defaultIntensity;
    _selectedNotifyType = intensityNotifyType ?? NotificationType.vibration;
    notifyListeners();
  }

  void updateSelectedType(NotificationType selectedNotifyType) {
    if (_device == null) {
      return;
    }
    if (_selectedNotifyType == selectedNotifyType) {
      return;
    }
    _selectedNotifyType = selectedNotifyType;
    notifyListeners();
    _saveIntensityNotifyType(selectedNotifyType);
  }

  void updateIntensity(double intensity) {
    if (_device == null) {
      return;
    }
    _intensity = intensity;
    notifyListeners();
    _intensityDebouncer.run(() => _saveIntensity(intensity));
  }

  Future<void> _saveIntensityNotifyType(
      NotificationType selectedNotifyType) async {
    try {
      if (_mode == IntensityMode.timer) {
        await _device?.setTimerNotification(
            selectedNotifyType, _intensity.toInt());
      } else {
        await _device?.setMetronomeNotification(
            selectedNotifyType, _intensity.toInt());
      }

      await _repository.setIntensityType(selectedNotifyType);
    } catch (_) {}
  }

  Future<void> _saveIntensity(double intensity) async {
    try {
      if (_mode == IntensityMode.timer) {
        await _device?.setTimerNotification(
            selectedNotifyType, intensity.toInt());
      } else {
        await _device?.setMetronomeNotification(
            selectedNotifyType, intensity.toInt());
      }
      await _repository.setPower(intensity.toInt());
    } catch (_) {}
  }

  Future<void> resetIntensity() async {
    _intensityDebouncer.dispose();
    _selectedNotifyType = NotificationType.vibration;
    _intensity = _defaultIntensity;
    notifyListeners();
    await _repository.reset();
  }

  Future<void> checkIntensity() async {
    try {
      if (_mode == IntensityMode.timer) {
        await _device?.checkTimerNotification();
      } else {
        await _device?.checkMetronomeNotification();
      }
    } catch (_) {}
  }

  void updateDevice(KeepMindfulDevice? device) {
    if (device != null && device.remoteId != _device?.remoteId) {
      resetIntensity();
    }
    _device = device;
  }
}
