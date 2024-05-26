import 'package:hive/hive.dart';

import '../../app/hive/hive.dart';
import 'app_language.dart';
import 'app_language_hive_keys.dart';

class AppLanguageRepository {
  AppLanguageRepository();
  final _languageBox = Hive.box(HiveAppBox.language.name);

  AppLanguage? fetch() {
    final language = _languageBox.get(AppLanguageHiveKeys.language);
    if (language == null) {
      return null;
    }
    return language;
  }

  Future<void> update(AppLanguage language) {
    return _languageBox.put(AppLanguageHiveKeys.language, language);
  }
}
