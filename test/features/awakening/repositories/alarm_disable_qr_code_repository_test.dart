import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keep_mindful/app/hive/hive.dart';
import 'package:keep_mindful/features/features.dart';

void main() {
  group('AlarmDisableQrCodeRepository test', () {
    const testQrCode = 'test_qr_code';
    late Box box;
    late AlarmDisableQrCodeRepository repository;

    setUp(() async {
      final temp = await Directory.systemTemp.createTemp();
      Hive.init(temp.path);
      box = await Hive.openBox(HiveAppBox.awakening.name);
      await box.clear();
      repository = AlarmDisableQrCodeRepository();
    });

    tearDown(() async {
      await box.deleteFromDisk();
    });

    test('when set($testQrCode) called then get() returns $testQrCode',
        () async {
      await repository.set(testQrCode);

      expect(repository.get(), testQrCode);
    });
  });
}
