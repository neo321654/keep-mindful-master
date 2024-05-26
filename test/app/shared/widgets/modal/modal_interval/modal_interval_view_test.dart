import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:keep_mindful/generated/l10n.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'modal_interval_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IntervalNotifier>()])
void main() {
  group('ModalInterval test', () {
    const defaultDuration = Duration(seconds: 15);
    late MockIntervalNotifier intervalNotifier;
    late Widget modal;

    setUp(() {
      intervalNotifier = MockIntervalNotifier();
      GetIt.instance.registerSingleton<IntervalNotifier>(intervalNotifier);
      modal = MaterialApp(
        theme: AppTheme.themeData,
        home: const Scaffold(
          body: ModalInterval(),
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
      );
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    testWidgets('checking contents', (tester) async {
      when(intervalNotifier.interval).thenReturn(defaultDuration);
      await tester.pumpWidget(modal);

      final titleFinder = find.text('Interval');
      final minutesTitleFinder = find.text('Minutes');
      final secondsTitleFinder = find.text('Seconds');
      final listWheelsFinder = find.byType(ListWheel);
      final buttonsFinder = find.byType(Button);

      expect(titleFinder, findsOneWidget);
      expect(minutesTitleFinder, findsOneWidget);
      expect(secondsTitleFinder, findsOneWidget);
      expect(listWheelsFinder, findsNWidgets(2));
      expect(buttonsFinder, findsNWidgets(6));
    });

    testWidgets(
        'when 60min button tapped then setInterval(Duration(minutes: 60, seconds: 15)) called ones',
        (tester) async {
      const updatedDuration = Duration(minutes: 60, seconds: 15);
      when(intervalNotifier.interval).thenReturn(defaultDuration);
      await tester.pumpWidget(modal);

      final minButton = find.byKey(const Key('min_60'));
      await tester.ensureVisible(minButton);
      await tester.tap(minButton);
      await tester.pumpAndSettle();

      verify(intervalNotifier.setInterval(updatedDuration)).called(1);
    });
  });
}
