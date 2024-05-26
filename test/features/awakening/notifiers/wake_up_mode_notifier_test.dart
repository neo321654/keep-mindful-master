import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/features/awakening/awakening.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'wake_up_mode_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WakeUpModeRepository>()])
void main() {
  group('WakeUpModeNotifier test', () {
    late MockWakeUpModeRepository repository;
    late WakeUpModeNotifier notifier;
    setUp(() async {
      repository = MockWakeUpModeRepository();
      notifier = WakeUpModeNotifier(repository);
    });

    test('qrCodeEnabled, mathExcercise true by default', () async {
      final qrEnabled = notifier.qrCodeEnabled;
      final mathQuizEnabled = notifier.mathQuizEnabled;

      expect(qrEnabled, true);
      expect(mathQuizEnabled, true);
    });
    test(
        'when repository getByMode() returns false then qrCodeEnabled, mathExcercise false',
        () async {
      when(repository.getByMode(AlarmDisableMode.qrCode)).thenReturn(false);
      when(repository.getByMode(AlarmDisableMode.mathQuiz)).thenReturn(false);

      notifier.init();

      final qrEnabled = notifier.qrCodeEnabled;
      final mathQuizEnabled = notifier.mathQuizEnabled;

      expect(qrEnabled, false);
      expect(mathQuizEnabled, false);
    });
    test('when setQrCodeEnabled(false) called then qrCodeEnabled flag is false',
        () async {
      notifier.setQrCodeEnabled(false);

      expect(notifier.qrCodeEnabled, false);
    });
    test(
        'when setMathQuizEnabled(false) called then qrCodeEnabled flag is false',
        () async {
      notifier.setMathQuizEnabled(false);

      expect(notifier.mathQuizEnabled, false);
    });
  });
}
