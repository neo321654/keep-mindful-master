import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keep_mindful/app/screens/wake_up_mode/wake_up_mode_screen.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:keep_mindful/generated/l10n.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'wake_up_mode_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WakeUpModeNotifier>()])
void main() {
  group('Wake up mode screen', () {
    late MockWakeUpModeNotifier notifier;
    late Widget screen;

    setUp(() async {
      notifier = MockWakeUpModeNotifier();
      GetIt.instance.registerSingleton<WakeUpModeNotifier>(notifier);
      screen = MaterialApp(
        theme: AppTheme.themeData,
        home: const Material(child: WakeUpModeScreen()),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
        ],
      );
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });
    testWidgets('checking contents', (tester) async {
      when(notifier.qrCodeEnabled).thenReturn(true);
      when(notifier.mathQuizEnabled).thenReturn(true);
      when(notifier.captchaEnabled).thenReturn(true);

      await tester.pumpWidget(screen);

      final topBarFinder = find.byType(SecondaryTopBar);
      final selectableTilesFinder = find.byType(SelectableListTile);
      final checkBoxesFinder = find.byType(CheckBox);
      final buttonFinder = find.byType(Button);

      expect(topBarFinder, findsOneWidget);
      expect(selectableTilesFinder, findsNWidgets(3));
      expect(checkBoxesFinder, findsNWidgets(3));
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('check when list tiles are tapped', (tester) async {
      when(notifier.qrCodeEnabled).thenReturn(false);
      when(notifier.mathQuizEnabled).thenReturn(false);
      when(notifier.captchaEnabled).thenReturn(false);

      await tester.pumpWidget(screen);

      final selectableTilesFinder = find.byType(SelectableListTile);
      expect(selectableTilesFinder, findsNWidgets(3));

      for (final element in selectableTilesFinder.evaluate()) {
        await tester.tapAt(tester.getCenter(find.byWidget(element.widget)));
      }

      verify(notifier.setMathQuizEnabled(true)).called(1);
      verify(notifier.setQrCodeEnabled(true)).called(1);
      verify(notifier.setCaptchaEnabled(true)).called(1);
    });
  });
}
