import 'package:flutter/material.dart';

import '../../../app/shared/shared.dart';
import '../models/models.dart';

const _defaultAlarmName = 'Alarm';

/// Set alarm before using this notifier.
class AlarmEditNotifier {
  late final Alarm alarmToEdit;
  late TimeOfDay _time;
  late String alarmName;

  void setAlarm(Alarm alarm) {
    _time = TimeOfDay.fromDateTime(alarm.time);
    alarmToEdit = alarm;
    alarmName = alarm.name;
  }

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
    return alarmToEdit.copyWith(time: _time.toDateTime(), name: name);
  }
}
