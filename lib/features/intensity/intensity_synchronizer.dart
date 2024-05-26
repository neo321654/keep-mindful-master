import '../bluetooth/bluetooth.dart';
import 'repositories/repositories.dart';

class IntensitySynchronizer {
  const IntensitySynchronizer(
      {required IntensityTimerRepository timerRepository,
      required IntensityMetronomeRepository metronomeRepository})
      : _timerRepository = timerRepository,
        _metronomeRepository = metronomeRepository;
  final IntensityTimerRepository _timerRepository;
  final IntensityMetronomeRepository _metronomeRepository;

  Future<void> makeSync(KeepMindfulDevice? device) async {
    if (device == null || !device.isConnected) {
      return;
    }
    await _syncTimerIntensity(device);
    await _syncMetronomeIntensity(device);
  }

  Future<void> _syncTimerIntensity(KeepMindfulDevice device) async {
    final timerUpdatedAt = _timerRepository.getUpdatedAt();
    final timerSentAt = _timerRepository.getSentAt();
    if (timerUpdatedAt == null) {
      return;
    }
    final int sentComparision =
        timerSentAt == null ? -1 : timerSentAt.compareTo(timerUpdatedAt);
    if (sentComparision >= 0) {
      return;
    }
    final notificationTypeToSend =
        _timerRepository.getIntensityType() ?? NotificationType.vibration;
    final powerToSend = _timerRepository.getPower() ?? 100;
    try {
      await device.setTimerNotification(notificationTypeToSend, powerToSend);
      await _timerRepository.setSentNow();
    } catch (_) {}
  }

  Future<void> _syncMetronomeIntensity(KeepMindfulDevice device) async {
    final timerUpdatedAt = _metronomeRepository.getUpdatedAt();
    final timerSentAt = _metronomeRepository.getSentAt();
    if (timerUpdatedAt == null) {
      return;
    }
    final int sentComparision =
        timerSentAt == null ? -1 : timerSentAt.compareTo(timerUpdatedAt);
    if (sentComparision >= 0) {
      return;
    }
    final notificationTypeToSend =
        _metronomeRepository.getIntensityType() ?? NotificationType.vibration;
    final powerToSend = _metronomeRepository.getPower() ?? 100;
    try {
      await device.setMetronomeNotification(
          notificationTypeToSend, powerToSend);
      await _metronomeRepository.setSentNow();
    } catch (_) {}
  }
}
