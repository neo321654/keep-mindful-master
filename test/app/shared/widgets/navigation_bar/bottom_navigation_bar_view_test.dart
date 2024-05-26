import 'package:flutter/material.dart'
    hide BottomNavigationBar, BottomNavigationBarItem;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/generated/assets.gen.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('BottomNavigationBar', () {
    testWidgets('checking contents', (tester) async {
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              props: BottomNavigationBarProps(items: [
                BottomNavigationBarItem(Assets.icons.bluetooth),
                BottomNavigationBarItem(Assets.icons.bluetooth),
                BottomNavigationBarItem(Assets.icons.bluetooth),
                BottomNavigationBarItem(Assets.icons.bluetooth),
              ]),
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
      final buttonFinder = find.byType(Button);

      expect(buttonFinder, findsNWidgets(4));
    });
  });
}
