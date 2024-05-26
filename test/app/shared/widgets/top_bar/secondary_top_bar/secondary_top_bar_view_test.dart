import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/generated/l10n.dart';

const _topBarTitle = 'test title';

void main() {
  group('SecondaryTopBar', () {
    testWidgets('checking contents', (tester) async {
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            appBar: SecondaryTopBar(
              props: SecondaryTopBarProps(title: _topBarTitle),
            ),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
          ],
        ),
      );
      final textFinder = find.text(_topBarTitle);

      expect(textFinder, findsOneWidget);
    });
  });
}
