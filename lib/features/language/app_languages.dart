import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../generated/l10n.dart';
import 'app_language.dart';

class AppLanguages {
  static const List<LocalizationsDelegate> appDelegates = [
    AppLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static List<Locale> get supportedLocales =>
      supportedLanguages.map((e) => e.locale).toList();

  static const List<AppLanguage> supportedLanguages = [
    AppLanguage(name: 'English', locale: Locale('en')),
    AppLanguage(name: 'Русский', locale: Locale('ru')),
  ];
}
