import 'package:flutter/material.dart';

import '../../app/shared/shared.dart';
import '../bluetooth/bluetooth.dart';
import 'metronome_repository.dart';

const _defaultNumberOfBars = 4;
const _defaultBpm = 120.0;

class MetronomeNotifier extends ChangeNotifier {
  MetronomeNotifier(MetronomeRepository repository) : _repository = repository;

  final MetronomeRepository _repository;

  final Debouncer _bpmDebouncer = Debouncer();
  final Debouncer _barsDebouncer = Debouncer();

  KeepMindfulDevice? _device;

  double _bpm = _defaultBpm;
  int _numberOfBars = _defaultNumberOfBars;
  bool _barSkipSwitcherEnabled = false;
  bool _isActive = false;

  int get numberOfBars => _numberOfBars;
  bool get isActive => _isActive;
  double get bpm => _bpm;
  bool get barSkipSwitcherEnabled => _barSkipSwitcherEnabled;

  void init() {
    _numberOfBars = _repository.getNumberOfBars() ?? _defaultNumberOfBars;
    _bpm = _repository.getBpm() ?? _defaultBpm;
    _barSkipSwitcherEnabled = _repository.getSkippingOneBar() ?? false;
    _isActive = _repository.getIsActive() ?? false;
  }

  void updateNumberOfBars(int numberOfBars) {
    if (_numberOfBars == numberOfBars) {
      return;
    }
    _numberOfBars = numberOfBars;
    _barsDebouncer.run(() => _saveNumberOfBars());
  }

  Future<void> _saveNumberOfBars() async {
    await _repository.saveNumberOfBars(_numberOfBars.toInt());
    await _repository.setUpdatedNow();
    await _sendMetronome();
  }

  Future<void> _saveIsActive() async {
    await _repository.saveIsActive(_isActive);
    await _repository.setUpdatedNow();
    await _sendMetronome(enableReset: true);
  }

  Future<void> updateIsActive() async {
    _isActive = !_isActive;
    notifyListeners();
    await _saveIsActive();
  }

  void updateBpm(double intensity) {
    _bpm = intensity;
    notifyListeners();
    _bpmDebouncer.run(() => _saveBpm());
  }

  Future<void> _saveBpm() async {
    await _repository.saveBpm(bpm);
    await _repository.setUpdatedNow();
    await _sendMetronome();
  }

  Future<void> _saveSkippingBar() async {
    await _repository.saveSkippingOneBar(_barSkipSwitcherEnabled);
    await _repository.setUpdatedNow();
    await _sendMetronome();
  }

  Future<void> updateBarSkipSwither(bool isSelected) async {
    _barSkipSwitcherEnabled = isSelected;
    notifyListeners();
    _saveSkippingBar();
  }

  Future<void> _sendMetronome({bool enableReset = false}) async {
    try {
      if (_isActive) {
        await _device!.setMetronome(
            bpm: _bpm.toInt(),
            tact: _numberOfBars,
            skipOneTact: _barSkipSwitcherEnabled);
        await _repository.setSentNow();
        return;
      }
      if (enableReset) {
        await _device!.resetMetronome();
        await _repository.setSentNow();
      }
    } catch (_) {}
  }

  Future<void> resetMetronome() async {
    _bpm = _defaultBpm;
    _numberOfBars = _defaultNumberOfBars;
    _barSkipSwitcherEnabled = false;
    _isActive = false;
    notifyListeners();
    await _repository.clear();
  }

  Future<void> updateDevice(KeepMindfulDevice? newDevice) async {
    final oldDevice = _device;
    _device = newDevice;
    if (newDevice == null || oldDevice == null) {
      return;
    }
    if (oldDevice.remoteId != newDevice.remoteId) {
      await resetMetronome();
    }
  }
}
