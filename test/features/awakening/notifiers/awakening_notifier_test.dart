import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'awakening_notifier_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<AlarmsRepository>(), MockSpec<AwakeningRepository>()])
void main() {
  group('AwakeningNotifier tests', () {
    late MockAlarmsRepository alarmsRepository;
    late MockAwakeningRepository awakeningRepository;
    late AwakeningNotifier notifier;

    setUp(() {
      alarmsRepository = MockAlarmsRepository();
      awakeningRepository = MockAwakeningRepository();
      notifier = AwakeningNotifier(alarmsRepository, awakeningRepository);
    });

    tearDown(() {
      notifier.dispose();
    });

    test('initial list of alarms is empty', () async {
      when(alarmsRepository.getList()).thenReturn([]);
      expect(notifier.alarms.length, 0);
    });

    test('given alarm with time past 10 min then alarm should be triggered',
        () async {
      const duration = Duration(minutes: 10);
      final initialAlarm = Alarm(
          time: DateTime.now().subtract(duration), createdAt: DateTime.now());
      when(alarmsRepository.getList()).thenReturn([initialAlarm]);

      notifier.init();

      expect(notifier.waitingForAlarmConfirm, true);
    });
    test('add alarm that should be triggered after 10 min', () async {
      const duration = Duration(minutes: 10);
      final newAlarm =
          Alarm(time: DateTime.now().add(duration), createdAt: DateTime.now());
      when(alarmsRepository.getList()).thenReturn([]);

      notifier.init();

      fakeAsync((async) {
        notifier.addAlarm(newAlarm);
        async.elapse(duration);
      });

      expect(notifier.waitingForAlarmConfirm, true);
    });

    test(
        'given alarm with time past 10 min when onAlarmConfirmed() called then waitingForAlarmConfirm false',
        () async {
      const duration = Duration(minutes: 10);
      final initialAlarm = Alarm(
          time: DateTime.now().subtract(duration), createdAt: DateTime.now());
      when(alarmsRepository.getList()).thenReturn([initialAlarm]);

      notifier.init();
      await notifier.onAlarmConfirmed();

      expect(notifier.waitingForAlarmConfirm, false);
    });
  });
}
