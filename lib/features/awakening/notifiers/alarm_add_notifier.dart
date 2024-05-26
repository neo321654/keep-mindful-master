import 'package:flutter/material.dart';

import '../../../app/shared/shared.dart';
import '../models/models.dart';

const _defaultAlarmName = 'Alarm';

class AlarmAddNotifier {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 0);

  String alarmName = _defaultAlarmName;

  void updateMinutes(int minute) {
    final oldTime = _time;
    _time = TimeOfDay(hour: oldTime.hour, minute: minute);
  }

  void updateHours(int hour) {
    final oldTime = _time;
    _time = TimeOfDay(hour: hour, minute: oldTime.minute);
  }

  Alarm get alarm {
    final name = alarmName.isEmpty ? _defaultAlarmName : alarmName;
    return Alarm(
        time: _time.toDateTime(), name: name, createdAt: DateTime.now());
  }
}
