import 'package:hive/hive.dart';

import '../../../app/hive/hive.dart';
import '../constants/timer_hive_keys.dart';

class DurationRepository {
  final _hiveBox = Hive.box(HiveAppBox.timer.name);

  DateTime? get() {
    return _hiveBox.get(TimerHiveKeys.finishDurationTime);
  }

  Future<void> set(DateTime? finishTime) async {
    await _hiveBox.put(TimerHiveKeys.finishDurationTime, finishTime);
    await _hiveBox.put(
        TimerHiveKeys.finishDurationTimeUpdatedAt, DateTime.now());
  }

  Future<void> reset() async {
    await _hiveBox.delete(TimerHiveKeys.finishDurationTime);
    await _hiveBox.delete(TimerHiveKeys.finishDurationTimeUpdatedAt);
    await _hiveBox.delete(TimerHiveKeys.finishDurationTimeSentAt);
  }

  DateTime? getUpdatedAt() {
    return _hiveBox.get(TimerHiveKeys.finishDurationTimeUpdatedAt);
  }

  DateTime? getSentAt() {
    return _hiveBox.get(TimerHiveKeys.finishDurationTimeSentAt);
  }

  Future<void> setSentNow() async {
    await _hiveBox.put(TimerHiveKeys.finishDurationTimeSentAt, DateTime.now());
  }
}
