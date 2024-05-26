import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('Selector', () {
    testWidgets('checking contents', (tester) async {
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Center(
              child: Selector(
                props: SelectorProps(items: const [
                  SelectorItemProps(title: '1', value: '1'),
                  SelectorItemProps(title: '2', value: '2'),
                ], groupValue: '1'),
              ),
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
      final firstValueFinder = find.text('1');
      final secondValueFinder = find.text('2');

      expect(firstValueFinder, findsOneWidget);
      expect(secondValueFinder, findsOneWidget);
    });
  });
}
