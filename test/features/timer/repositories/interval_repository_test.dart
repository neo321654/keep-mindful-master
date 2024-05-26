import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:keep_mindful/app/hive/hive.dart';
import 'package:keep_mindful/features/timer/repositories/interval_repository.dart';

void main() {
  group('IntervalRepositoryTest', () {
    late Box box;
    late IntervalRepository repository;
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
      repository = IntervalRepository();
    });

    tearDown(() async {
      await box.deleteFromDisk();
    });
    test(
        'when set() method called with Duration(seconds: 1) then get() method should return Duration(seconds: 1)',
        () async {
      const duration = Duration(seconds: 1);
      await repository.set(duration);

      final savedDuration = repository.get();
      expect(savedDuration, duration);
    });
    test(
        'given Duration(seconds: 1) when reset() method called then get() method should return null',
        () async {
      await repository.set(const Duration(seconds: 1));
      await repository.reset();

      final savedDuration = repository.get();
      expect(savedDuration, null);
    });
  });
}
