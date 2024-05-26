import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mock_callable.dart';
import 'duration_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DurationRepository>()])
void main() {
  group('DurationNotifier test', () {
    const timerDuration = Duration(minutes: 10);
    late MockDurationRepository repository;
    late DurationNotifier durationNotifier;

    setUp(() {
      repository = MockDurationRepository();
      durationNotifier = DurationNotifier(repository);
    });

    tearDown(() {
      durationNotifier.dispose();
    });

    test(
        'when setDuration(Duration(minutes: 10)) called then timer equals to Duration(minutes: 10)',
        () async {
      when(repository.get()).thenReturn(null);

      durationNotifier.setDuration(timerDuration);

      expect(durationNotifier.duration, timerDuration);
    });

    test(
        'when setDuration(Duration(minutes: 10)) called then timer equals to Duration(minutes: 10)',
        () async {
      when(repository.get()).thenReturn(null);

      durationNotifier.setDuration(timerDuration);

      expect(durationNotifier.duration, timerDuration);
    });

    test('when resetDuration() called then timer equals to Duration.zero',
        () async {
      when(repository.get()).thenReturn(DateTime.now());

      durationNotifier.setDuration(timerDuration);
      durationNotifier.resetDuration();

      expect(durationNotifier.duration, Duration.zero);
    });

    test(
        'given Duration(minutes: 10) when init() called then countdown should finish after 10 minutes',
        () async {
      final mockCallable = MockCallable<Duration>();
      when(repository.get()).thenReturn(DateTime.now().add(timerDuration));

      durationNotifier.addListener(() {
        if (!durationNotifier.isCountdownActive) {
          return;
        }
        mockCallable.call(durationNotifier.duration);
      });

      fakeAsync((async) {
        durationNotifier.init();
        async.elapse(timerDuration);
      });

      verify(mockCallable.call(Duration.zero)).called(1);
    });

    test(
        'when setDuration(Duration(minutes: 10)) and setCountdownActive(true) called timer duration after 10 min should be Duration.zero',
        () async {
      final mockCallable = MockCallable<Duration>();
      when(repository.get()).thenReturn(null);

      durationNotifier.addListener(() {
        if (!durationNotifier.isCountdownActive) {
          return;
        }
        mockCallable.call(durationNotifier.duration);
      });
      durationNotifier.setDuration(timerDuration);
      fakeAsync((async) {
        durationNotifier.setCountdownActive(true);
        async.elapse(timerDuration);
      });

      verify(mockCallable.call(Duration.zero)).called(1);
    });
  });
}
