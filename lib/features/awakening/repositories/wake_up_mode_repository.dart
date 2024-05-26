import 'package:hive/hive.dart';

import '../../../app/hive/hive.dart';
import '../constants/constants.dart';

class WakeUpModeRepository {
  final _box = Hive.box(HiveAppBox.awakening.name);

  bool? getByMode(AlarmDisableMode mode) {
    switch (mode) {
      case AlarmDisableMode.qrCode:
        return _box.get(AwakeningHiveKeys.wakeUpModeQrEnabled);
      case AlarmDisableMode.mathQuiz:
        return _box.get(AwakeningHiveKeys.wakeUpModeMathExerciseEnabled);
      case AlarmDisableMode.captcha:
        return _box.get(AwakeningHiveKeys.wakeUpModeCaptchaEnabled);
    }
  }

  Future<void> setByMode(AlarmDisableMode mode, bool enabled) {
    switch (mode) {
      case AlarmDisableMode.qrCode:
        return _box.put(AwakeningHiveKeys.wakeUpModeQrEnabled, enabled);
      case AlarmDisableMode.mathQuiz:
        return _box.put(
            AwakeningHiveKeys.wakeUpModeMathExerciseEnabled, enabled);
      case AlarmDisableMode.captcha:
        return _box.put(AwakeningHiveKeys.wakeUpModeCaptchaEnabled, enabled);
    }
  }
}
