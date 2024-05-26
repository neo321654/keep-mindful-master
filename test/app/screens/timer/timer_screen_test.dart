import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keep_mindful/app/screens/timer/timer_screen.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:keep_mindful/generated/l10n.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'timer_screen_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TimerNotifier>(),
  MockSpec<DurationNotifier>(),
  MockSpec<IntervalNotifier>(),
])
void main() {
  late Widget timerScreen;
  late MockTimerNotifier timerNotifier;
  late MockDurationNotifier durationNotifier;
  late MockIntervalNotifier intervalNotifier;
  group('Timer screen', () {
    setUp(() async {
      timerScreen = MaterialApp(
        theme: AppTheme.themeData,
        home: const TimerScreen(),
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
      intervalNotifier = MockIntervalNotifier();

      GetIt.instance.registerSingleton<TimerNotifier>(timerNotifier);
      GetIt.instance.registerSingleton<DurationNotifier>(durationNotifier);
      GetIt.instance.registerSingleton<IntervalNotifier>(intervalNotifier);
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    testWidgets('checking contents', (tester) async {
      when(timerNotifier.duration).thenReturn(const Duration(minutes: 10));
      await tester.pumpWidget(timerScreen);
      final textFinder = find.text('Timer');
      final listWhellFinder = find.byType(ListWheel);
      final timeActionsBarFinder = find.byType(TimeActionsBar);
      final buttonsFinder = find.byType(Button);

      expect(textFinder, findsOneWidget);
      expect(listWhellFinder, findsNWidgets(3));
      expect(timeActionsBarFinder, findsOneWidget);
      expect(buttonsFinder, findsNWidgets(4));
    });

    testWidgets(
        'checking list wheels current item by giving Duration(hours: 12, minutes: 41, seconds: 10)',
        (tester) async {
      const duration = Duration(hours: 12, minutes: 41, seconds: 10);
      when(timerNotifier.duration).thenReturn(duration);
      when(timerNotifier.isCountdownActive).thenReturn(true);
      await tester.pumpWidget(timerScreen);

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
        'given Duration(minutes: 10) and isCountdownActive value true when reset button pressed then resetDuration(), resetInterval() methods should be invoked',
        (tester) async {
      when(timerNotifier.duration).thenReturn(const Duration(minutes: 10));
      when(timerNotifier.isCountdownActive).thenReturn(true);
      await tester.pumpWidget(timerScreen);

      final resetButtonFinder =
          find.byKey(const Key('actions_bar_left_button'));

      tester.tap(resetButtonFinder);

      verify(timerNotifier.resetDuration()).called(1);
      verify(durationNotifier.resetDuration()).called(1);
      verify(intervalNotifier.resetInterval()).called(1);
    });
    testWidgets(
        'given Duration(minutes: 10) and isCountdownActive value true when play button pressed then setCountdownActive(false) method should be invoked',
        (tester) async {
      when(timerNotifier.duration).thenReturn(const Duration(minutes: 10));
      when(timerNotifier.isCountdownActive).thenReturn(true);
      await tester.pumpWidget(timerScreen);

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
      when(timerNotifier.duration).thenReturn(Duration.zero);
      when(durationNotifier.duration).thenReturn(Duration.zero);
      when(timerNotifier.isCountdownActive).thenReturn(false);
      when(durationNotifier.isCountdownActive).thenReturn(false);
      await tester.pumpWidget(timerScreen);
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

      verify(timerNotifier.setDuration(const Duration(hours: 1))).called(1);
      verify(timerNotifier.setDuration(const Duration(minutes: 1))).called(1);
      verify(timerNotifier.setDuration(const Duration(seconds: 1))).called(1);
    });
  });
}
