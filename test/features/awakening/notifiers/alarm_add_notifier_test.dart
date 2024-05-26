import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/features/features.dart';

void main() {
  late AlarmAddNotifier notifier;

  setUp(() {
    notifier = AlarmAddNotifier();
  });

  group('AlarmAddNotifier Tests', () {
    test('when set all parameters then return valid alarm object', () {
      const name = 'Test Alarm';
      const hours = 10;
      const minutes = 30;

      notifier.alarmName = name;
      notifier.updateHours(hours);
      notifier.updateMinutes(minutes);

      final alarm = notifier.alarm;
      expect(alarm.time.hour, hours);
      expect(alarm.time.minute, minutes);
      expect(alarm.name, name);
      expect(alarm.createdAt, isNotNull);
    });
  });
}
