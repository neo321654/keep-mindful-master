import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/app/shared/widgets/icon/icon.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('DecoratedCheckIcon', () {
    testWidgets('checking contents', (tester) async {
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Center(
              child: DecoratedCheckIcon(
                props: DecoratedCheckIconProps(),
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

      final decoratedCheckIconFinder = find.byType(DecoratedCheckIcon);
      final checkIconFinder = find.byType(SvgPicture);

      expect(decoratedCheckIconFinder, findsOneWidget);
      expect(checkIconFinder, findsOneWidget);
    });
  });
}
