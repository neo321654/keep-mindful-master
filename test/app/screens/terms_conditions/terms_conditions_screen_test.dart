import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/screens/terms_conditions/terms_conditions_screen.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('Terms conditions screen', () {
    testWidgets('checking contents', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.themeData,
          home: const TermsConditionsScreen(),
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
      final appbarFinder = find.byType(SecondaryTopBar);

      expect(appbarFinder, findsOneWidget);
    });
  });
}
