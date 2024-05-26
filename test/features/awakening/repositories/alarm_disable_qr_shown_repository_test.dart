import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keep_mindful/app/hive/hive_app.dart';
import 'package:keep_mindful/features/features.dart';

void main() {
  group('AlarmDisableQrShownRepository test', () {
    late Box box;
    late AlarmDisableQrShownRepository repository;

    setUp(() async {
      final temp = await Directory.systemTemp.createTemp();
      Hive.init(temp.path);
      box = await Hive.openBox(HiveAppBox.awakening.name);
      await box.clear();
      repository = AlarmDisableQrShownRepository();
    });

    tearDown(() async {
      await box.deleteFromDisk();
    });

    test('when set(true) called then get() returns true', () async {
      await repository.set(true);

      expect(repository.get(), true);
    });
  });
}
