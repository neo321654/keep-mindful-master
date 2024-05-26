import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/screens/splash/splash_screen.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('Splash screen', () {
    testWidgets('checking contents', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.themeData,
          home: const SplashScreen(),
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
      final center = find.byType(Center);
      final column = find.byType(Column);
      final logo = find.byType(Image);
      final title = find.byType(Text);

      expect(column, findsOneWidget);
      expect(center, findsOneWidget);
      expect(logo, findsOneWidget);
      expect(title, findsOneWidget);
    });
  });
}
