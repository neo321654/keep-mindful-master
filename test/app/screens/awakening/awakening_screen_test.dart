import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keep_mindful/app/screens/awakening/awakening_screen.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:keep_mindful/generated/l10n.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'awakening_screen_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<AwakeningNotifier>(), MockSpec<AlarmDisableQrShownService>()])
void main() {
  group('Awakening screen', () {
    late MockAwakeningNotifier awakeningNotifier;
    late MockAlarmDisableQrShownService qrShownService;
    late Widget screen;

    setUp(() async {
      awakeningNotifier = MockAwakeningNotifier();
      qrShownService = MockAlarmDisableQrShownService();
      GetIt.instance.registerSingleton<AwakeningNotifier>(awakeningNotifier);
      GetIt.instance
          .registerSingleton<AlarmDisableQrShownService>(qrShownService);

      screen = MaterialApp(
        theme: AppTheme.themeData,
        home: const AwakeningScreen(),
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
      when(qrShownService.wasShown()).thenReturn(true);
      when(awakeningNotifier.alarms).thenReturn([]);
      await tester.pumpWidget(screen);
      final titleFinder = find.text('Alarm clocks');
      final bodyTextFinder =
          find.text('You don\'t have any alarm\nclocks added yet');
      final addButtonFinder = find.byType(Button);

      expect(titleFinder, findsOneWidget);
      expect(bodyTextFinder, findsOneWidget);
      expect(addButtonFinder, findsOneWidget);
    });
    testWidgets('checking contents when alarms exists', (tester) async {
      const alarmName = 'Test alarm';
      final alarm = Alarm(
          time: DateTime.now(), createdAt: DateTime.now(), name: alarmName);
      when(qrShownService.wasShown()).thenReturn(true);
      when(awakeningNotifier.alarms).thenReturn([alarm]);
      await tester.pumpWidget(screen);
      final titleFinder = find.text('Alarm clocks');
      final bodyTextFinder =
          find.text('You don\'t have any alarm\nclocks added yet');
      final alarmTitleFinder = find.text(alarmName);
      final addButtonFinder = find.byType(Button);

      expect(titleFinder, findsOneWidget);
      expect(bodyTextFinder, findsNothing);
      expect(addButtonFinder, findsOneWidget);
      expect(alarmTitleFinder, findsOneWidget);
    });
  });
}
