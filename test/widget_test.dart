import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:keep_mindful/app/router/router.dart';
import 'package:keep_mindful/app/shared/shared.dart';

Future<void> main() async {
  GetIt.I.registerSingleton<AppRouter>(AppRouter());

  testWidgets('Main screen test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Button(
            props: ButtonProps(buttonStyle: ButtonBaseStyle(), title: 'test')),
      ),
    ));

    expect(find.text('test'), findsOneWidget);
  });
}
