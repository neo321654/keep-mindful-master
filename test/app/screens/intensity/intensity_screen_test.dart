import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keep_mindful/app/screens/intensity/intensity_indicator/intensity_indicator.dart';
import 'package:keep_mindful/app/screens/intensity/intensity_screen.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/app/shared/widgets/widgets.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:keep_mindful/generated/l10n.dart';
import 'package:mockito/annotations.dart';

import 'intensity_screen_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<IntensityNotifier>(), MockSpec<BluetoothDeviceStateNotifier>()])
void main() {
  group('Intensity screen', () {
    late MockIntensityNotifier intensityNotifier;
    late MockBluetoothDeviceStateNotifier deviceNotifier;

    setUp(() async {
      intensityNotifier = MockIntensityNotifier();
      deviceNotifier = MockBluetoothDeviceStateNotifier();
      GetIt.instance.registerSingleton<IntensityNotifier>(intensityNotifier);
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
          home: const Scaffold(
              body: IntensityScreen(
            mode: IntensityMode.timer,
          )),
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

      final textFinder = find.text('Intensity');
      final selectorFinder = find.byType(Selector);
      final intensityIndicatorFinder = find.byType(IntensityIndicator);
      final sliderFinder = find.byType(AppSlider);
      final hintTextFinder = find.text('Check the selected intensity');
      final buttonFinder = find.byType(Button);

      expect(textFinder, findsOneWidget);
      expect(selectorFinder, findsOneWidget);
      expect(intensityIndicatorFinder, findsOneWidget);
      expect(sliderFinder, findsOneWidget);
      expect(hintTextFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
    });
  });
}
