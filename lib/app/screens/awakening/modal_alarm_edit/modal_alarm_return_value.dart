import '../../../../features/features.dart';

class ModalAlarmEditReturnValue {
  const ModalAlarmEditReturnValue(
      {required this.alarm, this.removeAlarm = false});

  final Alarm alarm;
  final bool removeAlarm;
}
