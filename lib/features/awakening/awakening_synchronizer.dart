import '../bluetooth/bluetooth.dart';
import 'repositories/repositories.dart';

class AwakeningSynchronizer {
  const AwakeningSynchronizer(
      {required AwakeningRepository awakeningRepository,
      required AlarmsRepository alarmsRepository})
      : _awakeningRepository = awakeningRepository,
        _alarmsRepository = alarmsRepository;

  final AwakeningRepository _awakeningRepository;
  final AlarmsRepository _alarmsRepository;

  Future<void> makeSync(KeepMindfulDevice? device) async {
    if (device == null || !device.isConnected) {
      return;
    }
    await _syncAlarmsDisabledAt(device);
    await _syncAlarms(device);
  }

  Future<void> _syncAlarmsDisabledAt(KeepMindfulDevice device) async {
    final alarmsDisableUpdatedAt =
        _awakeningRepository.getAlarmsDisabledUpdatedAt();
    final alarmsDisableSentAt = _awakeningRepository.getAlarmsDisabledSentAt();
    if (alarmsDisableUpdatedAt == null) {
      return;
    }
    final int sentComparision = alarmsDisableSentAt == null
        ? -1
        : alarmsDisableSentAt.compareTo(alarmsDisableUpdatedAt);
    if (sentComparision >= 0) {
      return;
    }
    try {
      await device.disableAllAlarmsUntilNow();
      await _awakeningRepository.setAlarmsDisabledSentNow();
    } catch (_) {}
  }

  Future<void> _syncAlarms(KeepMindfulDevice device) async {
    final alarmsUpdatedAt = _awakeningRepository.getAlarmsUpdatedAt();
    final alarmsSentAt = _awakeningRepository.getAlarmsSentAt();

    if (alarmsUpdatedAt == null) {
      return;
    }
    final int sentComparision =
        alarmsSentAt == null ? -1 : alarmsSentAt.compareTo(alarmsUpdatedAt);
    if (sentComparision >= 0) {
      return;
    }
    try {
      await device
          .setAlarms(_alarmsRepository.getList().map((e) => e.time).toList());
      await _awakeningRepository.setAlarmsSentNow();
    } catch (_) {}
  }
}
