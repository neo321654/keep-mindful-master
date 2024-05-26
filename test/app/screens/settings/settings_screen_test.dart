import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/screens/settings/settings_screen.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/app/shared/widgets/tile/selectable_list_tile/selectable_list_tile_view.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('Settings screen', () {
    testWidgets('checking contents', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.themeData,
          home: const Scaffold(body: SettingsScreen()),
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
      final textFinder = find.text('Settings');
      final tilesFinder = find.byType(SelectableListTile);

      expect(textFinder, findsOneWidget);
      expect(tilesFinder, findsNWidgets(6));
    });
  });
}
