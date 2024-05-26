import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keep_mindful/app/screens/duration/duration_screen.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:keep_mindful/generated/l10n.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'duration_screen_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TimerNotifier>(),
  MockSpec<DurationNotifier>(),
])
void main() {
  late Widget durationScreen;
  late MockTimerNotifier timerNotifier;
  late MockDurationNotifier durationNotifier;
  group('Duration screen', () {
    setUp(() async {
      durationScreen = MaterialApp(
        theme: AppTheme.themeData,
        home: const DurationScreen(),
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
      timerNotifier = MockTimerNotifier();
      durationNotifier = MockDurationNotifier();

      GetIt.instance.registerSingleton<TimerNotifier>(timerNotifier);
      GetIt.instance.registerSingleton<DurationNotifier>(durationNotifier);
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    testWidgets('checking contents', (tester) async {
      when(durationNotifier.duration).thenReturn(const Duration(minutes: 10));
      await tester.pumpWidget(durationScreen);
      final textFinder = find.text('Duration');
      final listWhellFinder = find.byType(ListWheel);
      final timeActionsBarFinder = find.byType(TimeActionsBar);
      final buttonsFinder = find.byType(Button);

      expect(textFinder, findsOneWidget);
      expect(listWhellFinder, findsNWidgets(3));
      expect(timeActionsBarFinder, findsOneWidget);
      expect(buttonsFinder, findsNWidgets(3));
    });

    testWidgets(
        'checking list wheels current item by giving Duration(hours: 12, minutes: 41, seconds: 10)',
        (tester) async {
      const duration = Duration(hours: 12, minutes: 41, seconds: 10);
      when(durationNotifier.duration).thenReturn(duration);
      when(durationNotifier.isCountdownActive).thenReturn(true);
      await tester.pumpWidget(durationScreen);

      final listWheelHours = tester
          .widget<ListWheelScrollView>(find.byKey(const Key('hours_wheel')));
      final listWheelMinutes = tester
          .widget<ListWheelScrollView>(find.byKey(const Key('minutes_wheel')));
      final listWheelSeconds = tester
          .widget<ListWheelScrollView>(find.byKey(const Key('seconds_wheel')));

      expect(
          (listWheelHours.controller as FixedExtentScrollController)
              .selectedItem,
          equals(duration.inHours));
      expect(
          (listWheelMinutes.controller as FixedExtentScrollController)
              .selectedItem,
          equals(duration.inMinutes.remainder(60)));
      expect(
          (listWheelSeconds.controller as FixedExtentScrollController)
              .selectedItem,
          equals(duration.inSeconds.remainder(60)));
    });

    testWidgets(
        'given Duration(minutes: 10) and isCountdownActive value true when reset button pressed then resetDuration() method should be invoked',
        (tester) async {
      when(durationNotifier.duration).thenReturn(const Duration(minutes: 10));
      when(durationNotifier.isCountdownActive).thenReturn(true);
      await tester.pumpWidget(durationScreen);

      final resetButtonFinder =
          find.byKey(const Key('actions_bar_left_button'));

      tester.tap(resetButtonFinder);

      verify(durationNotifier.resetDuration()).called(1);
    });
    testWidgets(
        'given Duration(minutes: 10) and isCountdownActive value true when play button pressed then setCountdownActive(false) methods should be invoked',
        (tester) async {
      when(durationNotifier.duration).thenReturn(const Duration(minutes: 10));
      when(durationNotifier.isCountdownActive).thenReturn(true);
      when(timerNotifier.isCountdownActive).thenReturn(true);
      await tester.pumpWidget(durationScreen);

      final toggleCountdownButtonFinder =
          find.byKey(const Key('actions_bar_center_button'));

      tester.tap(toggleCountdownButtonFinder);

      verify(timerNotifier.setCountdownActive(false)).called(1);
      verify(durationNotifier.setCountdownActive(false)).called(1);
    });

    testWidgets(
        'given Duration.zero on scroll controller position changed then call setDuration(Duration)',
        (tester) async {
      const animationDuration = Duration(milliseconds: 400);
      when(durationNotifier.duration).thenReturn(Duration.zero);
      when(durationNotifier.isCountdownActive).thenReturn(false);
      await tester.pumpWidget(durationScreen);
      final listWheelHours = tester
          .widget<ListWheelScrollView>(find.byKey(const Key('hours_wheel')));
      final listWheelMinutes = tester
          .widget<ListWheelScrollView>(find.byKey(const Key('minutes_wheel')));
      final listWheelSeconds = tester
          .widget<ListWheelScrollView>(find.byKey(const Key('seconds_wheel')));
      final controllerHours =
          listWheelHours.controller as FixedExtentScrollController;
      final controllerMinutes =
          listWheelMinutes.controller as FixedExtentScrollController;
      final controllerSeconds =
          listWheelSeconds.controller as FixedExtentScrollController;

      controllerHours.animateToItem(1,
          duration: animationDuration, curve: Curves.easeInOut);
      controllerMinutes.animateToItem(1,
          duration: animationDuration, curve: Curves.easeInOut);
      controllerSeconds.animateToItem(1,
          duration: animationDuration, curve: Curves.easeInOut);
      await tester.pumpAndSettle();

      verify(durationNotifier.setDuration(const Duration(hours: 1))).called(1);
      verify(durationNotifier.setDuration(const Duration(minutes: 1)))
          .called(1);
      verify(durationNotifier.setDuration(const Duration(seconds: 1)))
          .called(1);
    });
  });
}
