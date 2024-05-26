import 'package:hive/hive.dart';

import '../../../app/hive/hive.dart';
import '../constants/timer_hive_keys.dart';

class TimerRepository {
  final _hiveBox = Hive.box(HiveAppBox.timer.name);

  DateTime? get() {
    return _hiveBox.get(TimerHiveKeys.finishTimerTime);
  }

  Future<void> set(DateTime? finishTime) async {
    await _hiveBox.put(TimerHiveKeys.finishTimerTime, finishTime);
    await _hiveBox.put(TimerHiveKeys.finishTimerTimeUpdatedAt, DateTime.now());
  }

  Future<void> reset() async {
    await _hiveBox.delete(TimerHiveKeys.finishTimerTime);
    await _hiveBox.delete(TimerHiveKeys.finishTimerTimeUpdatedAt);
    await _hiveBox.delete(TimerHiveKeys.finishTimerTimeSentAt);
  }

  DateTime? getUpdatedAt() {
    return _hiveBox.get(TimerHiveKeys.finishTimerTimeUpdatedAt);
  }

  DateTime? getSentAt() {
    return _hiveBox.get(TimerHiveKeys.finishTimerTimeSentAt);
  }

  Future<void> setSentNow() async {
    await _hiveBox.put(TimerHiveKeys.finishTimerTimeSentAt, DateTime.now());
  }
}
