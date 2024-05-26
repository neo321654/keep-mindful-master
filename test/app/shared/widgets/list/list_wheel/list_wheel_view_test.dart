import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/generated/l10n.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mock_callable.dart';

const _testText = 'Test text';
const _listWheelAnimationDuration = Duration(milliseconds: 400);
void main() {
  group('ListWheel', () {
    testWidgets('checking contents', (tester) async {
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Center(
                child: ListWheel(
                    props: ListWheelProps(count: 10, title: _testText))),
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
      final listWheelFinder = find.byType(ListWheelScrollView);

      expect(textFinder, findsOneWidget);
      expect(listWheelFinder, findsOneWidget);
    });

    testWidgets(
        'given value 1 when controller value updated to 0 then animation should finished in 500ms',
        (tester) async {
      final theme = AppTheme.themeData;
      final controller = FixedExtentScrollController(initialItem: 1);
      final callable = MockCallable<int>();
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Center(
              child: ListWheel(
                props: ListWheelProps(
                    count: 10,
                    title: _testText,
                    controller: controller,
                    onChanged: callable),
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
      controller.animateToItem(0,
          duration: _listWheelAnimationDuration, curve: Curves.easeInOut);

      await tester.pumpAndSettle(const Duration(milliseconds: 100),
          EnginePhase.sendSemanticsUpdate, const Duration(milliseconds: 500));
      verify(callable(0)).called(1);
    });
  });
}
