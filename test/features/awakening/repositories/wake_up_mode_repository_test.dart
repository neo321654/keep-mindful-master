import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keep_mindful/app/hive/hive_app.dart';
import 'package:keep_mindful/features/awakening/awakening.dart';

void main() {
  group('AlarmDisableQrShownRepository test', () {
    late Box box;
    late WakeUpModeRepository repository;

    setUp(() async {
      final temp = await Directory.systemTemp.createTemp();
      Hive.init(temp.path);
      box = await Hive.openBox(HiveAppBox.awakening.name);
      await box.clear();
      repository = WakeUpModeRepository();
    });

    tearDown(() async {
      await box.deleteFromDisk();
    });

    test('when setByMode(mode, true) called then getByMode(mode) returns true',
        () async {
      const currentMode = AlarmDisableMode.qrCode;
      await repository.setByMode(currentMode, true);

      expect(repository.getByMode(currentMode), true);
    });
  });
}
