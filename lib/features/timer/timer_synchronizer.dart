import '../bluetooth/bluetooth.dart';
import 'repositories/repositories.dart';

const _defaultInterval = Duration(seconds: 15);

class TimerSynchronizer {
  const TimerSynchronizer(
      {required TimerRepository timerRepository,
      required DurationRepository durationRepository,
      required IntervalRepository intervalRepository})
      : _timerRepository = timerRepository,
        _durationRepository = durationRepository,
        _intervalRepository = intervalRepository;

  final TimerRepository _timerRepository;
  final DurationRepository _durationRepository;
  final IntervalRepository _intervalRepository;

  Future<void> makeSync(KeepMindfulDevice? device) async {
    if (device == null || !device.isConnected) {
      return;
    }
    await _syncTimer(device);
    await _syncDuration(device);
    await _syncInterval(device);
  }

  Future<void> _syncTimer(KeepMindfulDevice device) async {
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
    final timeToSend = _timerRepository.get();
    try {
      await device.setTimer(timeToSend);
      await _timerRepository.setSentNow();
    } catch (_) {}
  }

  Future<void> _syncDuration(KeepMindfulDevice device) async {
    final durationUpdatedAt = _durationRepository.getUpdatedAt();
    final durationSentAt = _durationRepository.getSentAt();
    if (durationUpdatedAt == null) {
      return;
    }
    final int sentComparision = durationSentAt == null
        ? -1
        : durationSentAt.compareTo(durationUpdatedAt);
    if (sentComparision >= 0) {
      return;
    }
    final timeToSend = _durationRepository.get();
    try {
      await device.setTimerDuration(timeToSend);
      await _durationRepository.setSentNow();
    } catch (_) {}
  }

  Future<void> _syncInterval(KeepMindfulDevice device) async {
    final intervalUpdatedAt = _intervalRepository.getUpdatedAt();
    final intervalSentAt = _intervalRepository.getSentAt();
    if (intervalUpdatedAt == null) {
      return;
    }
    final int sentComparision = intervalSentAt == null
        ? -1
        : intervalSentAt.compareTo(intervalUpdatedAt);
    if (sentComparision >= 0) {
      return;
    }
    final timeToSend = _intervalRepository.get() ?? _defaultInterval;
    try {
      await device.setTimerInterval(timeToSend);
      await _intervalRepository.setSentNow();
    } catch (_) {}
  }
}
