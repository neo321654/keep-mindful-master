import '../features.dart';

const _defaultNumberOfBars = 4;
const _defaultBpm = 120.0;

class MetronomeSynchronizer {
  const MetronomeSynchronizer(
      {required MetronomeRepository metronomeRepository})
      : _repository = metronomeRepository;
  final MetronomeRepository _repository;

  Future<void> makeSync(KeepMindfulDevice? device) async {
    if (device == null || !device.isConnected) {
      return;
    }
    await _syncMetronome(device);
  }

  Future<void> _syncMetronome(KeepMindfulDevice device) async {
    final timerUpdatedAt = _repository.getUpdatedAt();
    final timerSentAt = _repository.getSentAt();
    if (timerUpdatedAt == null) {
      return;
    }
    final int sentComparision =
        timerSentAt == null ? -1 : timerSentAt.compareTo(timerUpdatedAt);
    if (sentComparision >= 0) {
      return;
    }

    final isPlaying = _repository.getIsActive() ?? false;
    if (!isPlaying) {
      try {
        await device.resetMetronome();
        await _repository.setSentNow();
      } catch (_) {}
    }

    final bpm = _repository.getBpm() ?? _defaultBpm;
    final tact = _repository.getNumberOfBars() ?? _defaultNumberOfBars;
    final isSkipOneTact = _repository.getSkippingOneBar() ?? false;
    try {
      await device.setMetronome(
          bpm: bpm.toInt(), tact: tact, skipOneTact: isSkipOneTact);
      await _repository.setSentNow();
    } catch (_) {}
  }
}
