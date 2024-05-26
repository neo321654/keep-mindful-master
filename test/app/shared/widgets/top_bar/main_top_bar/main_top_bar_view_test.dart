import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/app/shared/widgets/top_bar/main_top_bar/battery_indicator.dart';
import 'package:keep_mindful/features/features.dart';
import 'package:keep_mindful/generated/l10n.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_top_bar_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BluetoothDeviceBatteryNotifier>()])
void main() {
  late MockBluetoothDeviceBatteryNotifier batteryNotifier;

  group('MainTopBar', () {
    setUp(() async {
      batteryNotifier = MockBluetoothDeviceBatteryNotifier();
      GetIt.instance
          .registerSingleton<BluetoothDeviceBatteryNotifier>(batteryNotifier);
    });

    tearDown(() async {
      GetIt.instance.reset();
    });

    testWidgets('checking contents', (tester) async {
      when(batteryNotifier.batteryLevel).thenReturn(0.0);
      const menuItems = [
        DropdownItemProps(title: 'testText', value: 'testText'),
        DropdownItemProps(title: 'testText1', value: 'testText1'),
        DropdownItemProps(title: 'testText2', value: 'testText2'),
      ];
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            appBar: MainTopBar(
              props: MainTopBarProps(
                menuItems: menuItems,
                selectedMenuItemPosition: 0,
                menuWidth: 184.0,
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
      final button = find.byType(Button);
      final batteryIndicator = find.byType(BatteryIndicator);
      final text = find.text(menuItems.first.title);

      expect(button, findsOneWidget);
      expect(text, findsOneWidget);
      expect(batteryIndicator, findsOneWidget);
    });
  });
}
