import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/features/features.dart';

void main() {
  late AlarmEditNotifier notifier;

  setUp(() {
    notifier = AlarmEditNotifier();
  });

  group('AlarmEditNotifier Tests', () {
    test('when set all parameters then return valid alarm object', () {
      final alarm = Alarm(
          time: DateTime.now(), createdAt: DateTime.now(), name: 'Dummy name');

      const name = 'Test Alarm';
      const hours = 10;
      const minutes = 30;

      notifier.setAlarm(alarm);

      notifier.alarmName = name;
      notifier.updateHours(hours);
      notifier.updateMinutes(minutes);

      final newAlarm = notifier.alarm;
      expect(newAlarm.time.hour, hours);
      expect(newAlarm.time.minute, minutes);
      expect(newAlarm.name, name);
      expect(newAlarm.createdAt, isNotNull);
    });
  });
}
