import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('CircleProgressbar', () {
    testWidgets('checking contents', (tester) async {
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Center(
                child: CircleProgressbar(
                    key: Key('custom_painter'),
                    props: CircleProgressbarProps())),
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
      final circleProgressbarFinder = find.byType(CircleProgressbar);

      expect(circleProgressbarFinder, findsOneWidget);
    });
  });
}
