import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/app/shared/widgets/switcher/swither_thumb.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('Switcher', () {
    testWidgets('checking contents', (tester) async {
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Center(
              child: Switcher(
                  props: SwitcherProps(value: true, onChange: (val) {})),
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
      final switcherThumb = find.byType(SwitcherThumb);

      expect(switcherThumb, findsOneWidget);
    });
  });
}
