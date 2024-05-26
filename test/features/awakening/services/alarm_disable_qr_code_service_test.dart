import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'alarm_disable_qr_code_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AlarmDisableQrCodeRepository>()])
void main() {
  group('AlarmDisableQrCodeService test', () {
    late AlarmDisableQrCodeService service;
    late MockAlarmDisableQrCodeRepository repository;

    setUp(() {
      repository = MockAlarmDisableQrCodeRepository();
      service = AlarmDisableQrCodeService(repository);
    });

    test('given empty qr code then getQr() return value should be null',
        () async {
      when(repository.get()).thenReturn(null);

      expect(service.getQr(), null);
    });
    test('given not empty qr code then getQr() return value should be \'test\'',
        () async {
      const qr = 'test';
      when(repository.get()).thenReturn(qr);

      expect(service.getQr(), qr);
    });

    test(
        'when generateQrIfNotExists() called then repository set method should be called',
        () async {
      when(repository.get()).thenReturn(null);

      await service.generateQrIfNotExists();

      verify(repository.set(any)).called(1);
    });
  });
}
