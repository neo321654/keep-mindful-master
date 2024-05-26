import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/screens/theme/theme_screen.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('Theme screen', () {
    testWidgets('checking contents', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.themeData,
          home: const Material(child: ThemeScreen()),
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
      final topBarFinder = find.byType(SecondaryTopBar);
      final selectableTilesFinder = find.byType(SelectableListTile);
      final checkBoxesFinder = find.byType(RadioBox<ThemeMode>);

      expect(topBarFinder, findsOneWidget);
      expect(selectableTilesFinder, findsNWidgets(3));
      expect(checkBoxesFinder, findsNWidgets(3));
    });
  });
}
