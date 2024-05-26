import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../repositories/repositories.dart';

class WakeUpModeNotifier extends ChangeNotifier {
  WakeUpModeNotifier(WakeUpModeRepository repository)
      : _repository = repository;

  final WakeUpModeRepository _repository;

  bool _qrCodeEnabled = true;
  bool _mathExerciseEnabled = true;
  bool _captchaEnabled = true;

  bool get qrCodeEnabled => _qrCodeEnabled;
  bool get mathQuizEnabled => _mathExerciseEnabled;
  bool get captchaEnabled => _captchaEnabled;

  void init() {
    _qrCodeEnabled = _repository.getByMode(AlarmDisableMode.qrCode) ?? true;
    _mathExerciseEnabled =
        _repository.getByMode(AlarmDisableMode.mathQuiz) ?? true;
    _captchaEnabled = _repository.getByMode(AlarmDisableMode.captcha) ?? true;
  }

  List<AlarmDisableMode> get availableModes {
    final list = <AlarmDisableMode>[];
    if (_qrCodeEnabled) {
      list.add(AlarmDisableMode.qrCode);
    }
    if (_mathExerciseEnabled) {
      list.add(AlarmDisableMode.mathQuiz);
    }
    if (_captchaEnabled) {
      list.add(AlarmDisableMode.captcha);
    }
    return list;
  }

  void setQrCodeEnabled(bool value) {
    _qrCodeEnabled = value;
    notifyListeners();
    _repository.setByMode(AlarmDisableMode.qrCode, value);
  }

  void setMathQuizEnabled(bool value) {
    _mathExerciseEnabled = value;
    notifyListeners();
    _repository.setByMode(AlarmDisableMode.mathQuiz, value);
  }

  void setCaptchaEnabled(bool value) {
    _captchaEnabled = value;
    notifyListeners();
    _repository.setByMode(AlarmDisableMode.captcha, value);
  }
}
