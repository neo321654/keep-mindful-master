import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_mindful/app/shared/shared.dart';

void main() {
  group('SeparatedRow test', () {
    testWidgets(
        'given 4 text elements then separated elements length should be 3',
        (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: SeparatedRow(
            children: List.generate(4, (_) => const Text('')),
            separatorBuilder: (_, pos) => const HeightSpacer(1.0)),
      ));

      final textsFinder = find.text('');
      final spacersFinder = find.byType(HeightSpacer);

      expect(textsFinder, findsNWidgets(4));
      expect(spacersFinder, findsNWidgets(3));
    });
    testWidgets('given 1 element then spacer elements length should be 0',
        (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: SeparatedRow(
            children: const [Text('')],
            separatorBuilder: (_, pos) => const HeightSpacer(1.0)),
      ));

      final textsFinder = find.text('');
      final spacersFinder = find.byType(HeightSpacer);

      expect(textsFinder, findsNWidgets(1));
      expect(spacersFinder, findsNothing);
    });
    testWidgets('given 0 elements then spacer elements length should be 0',
        (tester) async {
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: SeparatedRow(
            children: const [],
            separatorBuilder: (_, pos) => const HeightSpacer(1.0)),
      ));

      final spacersFinder = find.byType(HeightSpacer);

      expect(spacersFinder, findsNothing);
    });
  });
}
