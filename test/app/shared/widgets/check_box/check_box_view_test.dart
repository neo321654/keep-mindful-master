import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/app/shared/widgets/icon/icon.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('CheckBox', () {
    testWidgets('given value is true', (tester) async {
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Center(
              child: CheckBox(
                props: CheckBoxProps(isSelected: true),
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

      final checkBoxFinder = find.byType(CheckBox);
      final decoratedCheckIconFinder = find.byType(DecoratedCheckIcon);

      expect(checkBoxFinder, findsOneWidget);
      expect(decoratedCheckIconFinder, findsOneWidget);
    });
  });
}
