import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/shared.dart';
import 'package:keep_mindful/app/shared/themes/theme.dart';
import 'package:keep_mindful/app/shared/widgets/dropdown/dropdown_item_props.dart';
import 'package:keep_mindful/generated/l10n.dart';

void main() {
  group('Dropdown', () {
    testWidgets('checking contents', (tester) async {
      const values = [
        DropdownItemProps(title: 'somevalue', value: 'somevalue'),
        DropdownItemProps(title: 'somevalue1', value: 'somevalue1')
      ];
      const selectedValue =
          DropdownItemProps(title: 'somevalue1', value: 'somevalue1');
      final theme = AppTheme.themeData;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Center(
              child: Dropdown(
                props: DropdownProps(values: values, value: selectedValue),
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

      final dropdownFinder = find.byType(Dropdown);
      final text = find.text(selectedValue.title);
      final svgIcon = find.byType(SvgPicture);

      expect(dropdownFinder, findsOneWidget);
      expect(text, findsOneWidget);
      expect(svgIcon, findsOneWidget);
    });
  });
}
