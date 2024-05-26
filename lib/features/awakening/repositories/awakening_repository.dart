import 'package:hive/hive.dart';

import '../../../app/hive/hive.dart';
import '../constants/constants.dart';

class AwakeningRepository {
  final _hiveBox = Hive.box(HiveAppBox.awakening.name);

  DateTime? getAlarmsSentAt() {
    return _hiveBox.get(AwakeningHiveKeys.alarmsSentAt);
  }

  DateTime? getAlarmsUpdatedAt() {
    return _hiveBox.get(AwakeningHiveKeys.alarmsUpdatedAt);
  }

  Future<void> setAlarmsUpdatedNow() async {
    await _hiveBox.put(AwakeningHiveKeys.alarmsUpdatedAt, DateTime.now());
  }

  Future<void> setAlarmsSentNow() async {
    await _hiveBox.put(AwakeningHiveKeys.alarmsSentAt, DateTime.now());
  }

  DateTime? getAlarmsDisabledSentAt() {
    return _hiveBox.get(AwakeningHiveKeys.alarmsDisableSentAt);
  }

  DateTime? getAlarmsDisabledUpdatedAt() {
    return _hiveBox.get(AwakeningHiveKeys.alarmsDisableUpdatedAt);
  }

  Future<void> setAlarmsDisabledUpdatedNow() async {
    await _hiveBox.put(
        AwakeningHiveKeys.alarmsDisableUpdatedAt, DateTime.now());
  }

  Future<void> setAlarmsDisabledSentNow() async {
    await _hiveBox.put(AwakeningHiveKeys.alarmsDisableSentAt, DateTime.now());
  }

  Future<void> clear() async {
    await _hiveBox.delete(AwakeningHiveKeys.alarmsSentAt);
    await _hiveBox.delete(AwakeningHiveKeys.alarmsUpdatedAt);
    await _hiveBox.delete(AwakeningHiveKeys.alarmsDisableUpdatedAt);
    await _hiveBox.delete(AwakeningHiveKeys.alarmsDisableSentAt);
  }
}
