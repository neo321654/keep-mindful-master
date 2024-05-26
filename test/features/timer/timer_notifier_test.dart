import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mock_callable.dart';
import 'timer_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TimerRepository>()])
void main() {
  group('TimerNotifier test', () {
    const timerDuration = Duration(minutes: 10);
    late MockTimerRepository repository;
    late TimerNotifier timerNotifier;

    setUp(() {
      repository = MockTimerRepository();
      timerNotifier = TimerNotifier(repository);
    });

    tearDown(() {
      timerNotifier.dispose();
    });

    test(
        'when setDuration(Duration(minutes: 10)) called then timer equals to Duration(minutes: 10)',
        () async {
      when(repository.get()).thenReturn(null);

      timerNotifier.setDuration(timerDuration);

      expect(timerNotifier.duration, timerDuration);
    });

    test(
        'when setDuration(Duration(minutes: 10)) called then timer equals to Duration(minutes: 10)',
        () async {
      when(repository.get()).thenReturn(null);

      timerNotifier.setDuration(timerDuration);

      expect(timerNotifier.duration, timerDuration);
    });

    test('when resetDuration() called then timer equals to Duration.zero',
        () async {
      when(repository.get()).thenReturn(DateTime.now());

      timerNotifier.setDuration(timerDuration);
      timerNotifier.resetDuration();

      expect(timerNotifier.duration, Duration.zero);
    });

    test(
        'given Duration(minutes: 10) when init() called then countdown should finish after 10 minutes',
        () async {
      final mockCallable = MockCallable<Duration>();
      when(repository.get()).thenReturn(DateTime.now().add(timerDuration));

      timerNotifier.addListener(() {
        if (!timerNotifier.isCountdownActive) {
          return;
        }
        mockCallable.call(timerNotifier.duration);
      });

      fakeAsync((async) {
        timerNotifier.init();
        async.elapse(timerDuration);
      });

      verify(mockCallable.call(Duration.zero)).called(1);
    });

    test(
        'when setDuration(Duration(minutes: 10)) and setCountdownActive(true) called timer duration after 10 min should be Duration.zero',
        () async {
      final mockCallable = MockCallable<Duration>();
      when(repository.get()).thenReturn(null);

      timerNotifier.addListener(() {
        if (!timerNotifier.isCountdownActive) {
          return;
        }
        mockCallable.call(timerNotifier.duration);
      });
      timerNotifier.setDuration(timerDuration);
      fakeAsync((async) {
        timerNotifier.setCountdownActive(true);
        async.elapse(timerDuration);
      });

      verify(mockCallable.call(Duration.zero)).called(1);
    });
  });
}
