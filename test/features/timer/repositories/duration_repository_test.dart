import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:keep_mindful/app/hive/hive.dart';
import 'package:keep_mindful/features/features.dart';

void main() {
  group('DurationRepositoryTest', () {
    late Box box;
    late DurationRepository repository;
    setUpAll(() async {
      final temp = await Directory.systemTemp.createTemp();
      Hive.init(temp.path);
      Hive.registerAdapter(DurationAdapter());
    });

    tearDownAll(() async {
      await Hive.close();
    });

    setUp(() async {
      box = await Hive.openBox(HiveAppBox.timer.name);
      await box.clear();
      repository = DurationRepository();
    });

    tearDown(() async {
      await box.deleteFromDisk();
    });
    test(
        'when set() method called with current time then get() method should return current time',
        () async {
      final now = DateTime.now();
      await repository.set(now);

      final savedTime = repository.get();
      expect(savedTime, now);
    });
    test(
        'given current time when reset() method called then get() method should return null',
        () async {
      await repository.set(DateTime.now());
      await repository.reset();

      final savedDuration = repository.get();
      expect(savedDuration, null);
    });
  });
}
