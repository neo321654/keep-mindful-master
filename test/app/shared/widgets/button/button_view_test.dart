import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/generated/l10n.dart';

const _testText = 'Test text';

void main() {
  group('Button', () {
    testWidgets('given text with value \'$_testText\'', (tester) async {
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Center(
              child: Button(
                props: ButtonProps(
                  title: _testText,
                  buttonStyle:
                      ButtonStyles.byType(theme, ButtonType.rectangleText),
                ),
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
      final textFinder = find.text(_testText);

      expect(textFinder, findsOneWidget);
    });
  });
}
