import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keep_mindful/app/screens/metronome/controller_bar/controller_bar_view.dart';
import 'package:keep_mindful/app/screens/metronome/metronome_screen.dart';
import 'package:keep_mindful/app/screens/metronome/sound_switcher/sound_switcher.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/app/shared/widgets/widgets.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:keep_mindful/generated/l10n.dart';
import 'package:mockito/annotations.dart';

import 'metronome_screen_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<MetronomeNotifier>(), MockSpec<BluetoothDeviceStateNotifier>()])
void main() {
  group('Metronome screen', () {
    late MockMetronomeNotifier metronomeNotifier;
    late MockBluetoothDeviceStateNotifier deviceNotifier;

    setUp(() async {
      metronomeNotifier = MockMetronomeNotifier();
      deviceNotifier = MockBluetoothDeviceStateNotifier();

      GetIt.instance.registerSingleton<MetronomeNotifier>(metronomeNotifier);
      GetIt.instance
          .registerSingleton<BluetoothDeviceStateNotifier>(deviceNotifier);
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    testWidgets('checking contents', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.themeData,
          home: const Scaffold(body: MetronomeScreen()),
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

      final textFinder = find.text('Pace');
      final inputFinder = find.byType(Input);
      final sliderFinder = find.byType(AppSlider);
      final listWheelFinder = find.byType(ListWheel);
      final controllerFinder = find.byType(ControllerBar);
      final soundSwitherFinder = find.byType(SoundSwitcher);
      final hintTextFinder =
          find.text('1 bar with sound and 1 bar without sound');

      expect(textFinder, findsOneWidget);
      expect(inputFinder, findsOneWidget);
      expect(listWheelFinder, findsOneWidget);
      expect(soundSwitherFinder, findsOneWidget);
      expect(controllerFinder, findsOneWidget);
      expect(sliderFinder, findsOneWidget);
      expect(hintTextFinder, findsOneWidget);
    });
  });
}
