import '../bluetooth/bluetooth.dart';
import 'app_language.dart';
import 'app_language_repository.dart';
import 'app_languages.dart';


class AppLanguageSynchronizer {
  const AppLanguageSynchronizer({required AppLanguageRepository languageRepository})
      : _languageRepository = languageRepository;

  final AppLanguageRepository _languageRepository;

  Future<void> makeSync(KeepMindfulDevice? device) async {
    if (device == null || !device.isConnected) {
      return;
    }
    await _syncLanguage(device);
  }

  Future<void> _syncLanguage(KeepMindfulDevice device) async {
    AppLanguage? language = _languageRepository.fetch();
    language ??= AppLanguages.supportedLanguages.first;
    try {
      await device
          .setLanguage(AppLanguages.supportedLanguages.indexOf(language));
    } catch (_) {}
  }
}
