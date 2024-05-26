import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'interval_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IntervalRepository>()])
void main() {
  group('IntervalNotifier test', () {
    const defaultDuration = Duration(seconds: 15);
    late MockIntervalRepository repository;
    late IntervalNotifier intervalNotifier;

    setUp(() {
      repository = MockIntervalRepository();
      intervalNotifier = IntervalNotifier(repository);
    });

    tearDown(() {
      intervalNotifier.dispose();
    });

    test('checking default interval duration', () async {
      when(repository.get()).thenReturn(null);

      expect(intervalNotifier.interval, defaultDuration);
    });
    test(
        'given default duration when getInitialInterval() invoked then duration should be Duration(seconds: 1)',
        () async {
      const interval = Duration(seconds: 1);
      when(repository.get()).thenReturn(interval);
      intervalNotifier.getInitialInterval();
      expect(intervalNotifier.interval, interval);
    });

    test(
        'given default duration when setInterval invoked then duration should be Duration(seconds: 1)',
        () async {
      const interval = Duration(seconds: 1);
      when(repository.get()).thenReturn(null);
      intervalNotifier.getInitialInterval();
      intervalNotifier.setInterval(interval);
      expect(intervalNotifier.interval, interval);
    });
    test(
        'given Duration(seconds: 1) when reset invoked then duration should be default duration',
        () async {
      const interval = Duration(seconds: 1);
      when(repository.get()).thenReturn(interval);
      intervalNotifier.getInitialInterval();
      await intervalNotifier.resetInterval();
      expect(intervalNotifier.interval, defaultDuration);
    });
    test(
        'given Duration(seconds: 1) when saveInterval() invoked then set method from repository should be invoked',
        () async {
      const interval = Duration(seconds: 1);
      when(repository.get()).thenReturn(null);
      intervalNotifier.getInitialInterval();
      intervalNotifier.setInterval(interval);
      await intervalNotifier.saveInterval();

      verify(repository.set(interval)).called(1);
    });
  });
}
