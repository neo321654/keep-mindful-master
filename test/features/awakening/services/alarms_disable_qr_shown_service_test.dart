import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'alarms_disable_qr_shown_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AlarmDisableQrShownRepository>()])
void main() {
  group('AlarmDisableQrShownService test', () {
    late AlarmDisableQrShownService service;
    late MockAlarmDisableQrShownRepository repository;
    setUp(() {
      repository = MockAlarmDisableQrShownRepository();
      service = AlarmDisableQrShownService(repository);
    });

    test('given repository with true when wasShown() called then return true',
        () async {
      when(repository.get()).thenReturn(true);

      expect(service.wasShown(), true);
    });

    test('given repository with null when wasShown() called then return false',
        () async {
      when(repository.get()).thenReturn(null);

      expect(service.wasShown(), false);
    });

    test('given repository with null when wasShown() called then return true',
        () async {
      when(repository.get()).thenReturn(null);

      await service.markAsShown();

      verify(repository.set(true)).called(1);
    });
  });
}
