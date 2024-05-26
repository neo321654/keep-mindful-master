import 'package:flutter/material.dart';

import '../bluetooth/bluetooth.dart';
import 'app_language.dart';
import 'app_language_repository.dart';
import 'app_languages.dart';

class AppLanguageNotifier extends ChangeNotifier {
  AppLanguageNotifier(this._languageRepository);

  KeepMindfulDevice? _device;

  final AppLanguageRepository _languageRepository;

  AppLanguage? _language;

  AppLanguage? get language => _language;

  void fetchLanguage() {
    _language = _languageRepository.fetch();
    _language ??= AppLanguages.supportedLanguages.first;
    notifyListeners();
  }

  Future<void> updateLanguage(AppLanguage language) async {
    await _languageRepository.update(language);
    _language = language;
    notifyListeners();
    await _sendLanguage(language);
  }

  Future<void> _sendLanguage(AppLanguage language) async {
    if (_device == null || !_device!.isConnected) {
      return;
    }
    try {
      await _device!
          .setLanguage(AppLanguages.supportedLanguages.indexOf(language));
    } catch (_) {}
  }

  Future<void> updateDevice(KeepMindfulDevice? newDevice) async {
    final oldDevice = _device;
    _device = newDevice;
    if (newDevice == null || oldDevice == null) {
      return;
    }
    if (oldDevice.remoteId != newDevice.remoteId) {
      await _sendLanguage(_language ?? AppLanguages.supportedLanguages.first);
    }
  }
}
