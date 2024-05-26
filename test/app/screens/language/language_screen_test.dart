import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keep_mindful/app/screens/language/language_screen.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:mockito/annotations.dart';

import 'language_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AppLanguageNotifier>()])
void main() {
  group('Language screen', () {
    late MockAppLanguageNotifier languageNotifier;

    setUp(() async {
      languageNotifier = MockAppLanguageNotifier();
      GetIt.instance.registerSingleton<AppLanguageNotifier>(languageNotifier);
    });

    tearDown(() async {
      GetIt.instance.reset();
    });
    testWidgets('checking contents', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.themeData,
          locale: const Locale('en'),
          home: const Material(child: LanguageScreen()),
          localizationsDelegates: AppLanguages.appDelegates,
          supportedLocales: AppLanguages.supportedLocales,
        ),
      );
      final topBarFinder = find.byType(SecondaryTopBar);
      final selectableTilesFinder = find.byType(SelectableListTile);
      final checkBoxesFinder = find.byType(RadioBox<AppLanguage>);

      expect(topBarFinder, findsOneWidget);
      expect(selectableTilesFinder, findsNWidgets(2));
      expect(checkBoxesFinder, findsNWidgets(2));
    });
  });
}
