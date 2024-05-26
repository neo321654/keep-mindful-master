import 'package:hive/hive.dart';

import '../../../app/hive/hive.dart';
import '../constants/timer_hive_keys.dart';

class IntervalRepository {
  final _hiveBox = Hive.box(HiveAppBox.timer.name);

  Duration? get() {
    return _hiveBox.get(TimerHiveKeys.interval);
  }

  Future<void> set(Duration? duration) async {
    await _hiveBox.put(TimerHiveKeys.interval, duration);
    await _hiveBox.put(TimerHiveKeys.intervalUpdatedAt, DateTime.now());
  }

  Future<void> reset() async {
    await _hiveBox.delete(TimerHiveKeys.interval);
    await _hiveBox.delete(TimerHiveKeys.intervalUpdatedAt);
    await _hiveBox.delete(TimerHiveKeys.intervalSentAt);
  }

  DateTime? getUpdatedAt() {
    return _hiveBox.get(TimerHiveKeys.intervalUpdatedAt);
  }

  DateTime? getSentAt() {
    return _hiveBox.get(TimerHiveKeys.intervalSentAt);
  }

  Future<void> setSentNow() async {
    await _hiveBox.put(TimerHiveKeys.intervalSentAt, DateTime.now());
  }
}
