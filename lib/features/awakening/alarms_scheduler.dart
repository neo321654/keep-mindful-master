import 'dart:async';

import 'models/models.dart';

class AlarmsScheduler {
  AlarmsScheduler();

  final _streamController = StreamController<DateTime>();

  final Map<DateTime, Timer> _alarms = {};

  Stream<DateTime> get events => _streamController.stream.asBroadcastStream();

  void setUpAlarms(List<Alarm> alarms) {
    final now = DateTime.now();
    for (final alarm in alarms) {
      final time = alarm.time;
      if (now.isAfter(time)) {
        continue;
      }
      if (_alarms.containsKey(time)) {
        continue;
      }
      final timer =
          Timer(now.difference(time), () => _handleAlarmTriggered(time));
      _alarms[time] = timer;
    }
  }

  void updateAlarm(DateTime oldTime, DateTime newTime) {
    if (oldTime.compareTo(newTime) == 0) {
      return;
    }
    removeAlarm(oldTime);
    addAlarm(newTime);
  }

  void removeAlarm(DateTime time) {
    _alarms[time]?.cancel();
    _alarms.remove(time);
  }

  void addAlarm(DateTime time) {
    final now = DateTime.now();
    if (time.isBefore(now)) {
      return;
    }
    final timer = Timer(time.difference(now), () {
      _streamController.add(time);
    });
    _alarms[time] = timer;
  }

  void _handleAlarmTriggered(DateTime alarm) {
    _streamController.add(alarm);
    _alarms.remove(alarm);
  }

  void dispose() {
    for (final timer in _alarms.values) {
      timer.cancel();
    }
    _alarms.clear();
  }
}
