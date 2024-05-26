import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keep_mindful/app/hive/hive.dart';
import 'package:keep_mindful/features/features.dart';

void main() {
  group('AlarmDisableQrCodeRepository test', () {
    late Box box;
    late AlarmsRepository repository;

    setUpAll(() async {
      final temp = await Directory.systemTemp.createTemp();
      Hive.init(temp.path);
      Hive.registerAdapter(AlarmAdapter());
      Hive.registerAdapter(DurationAdapter());
    });

    setUp(() async {
      box = await Hive.openBox<Alarm>(HiveAppBox.alarms.name);
      await box.clear();
      repository = AlarmsRepository();
    });

    tearDown(() async {
      await box.deleteFromDisk();
    });

    test('when alarm added then list lenght is 1', () async {
      final alarm = Alarm(
          time: DateTime.now(), createdAt: DateTime.now(), name: 'Some name');
      await repository.add(alarm);

      expect(repository.getList().length, 1);
    });

    test('when alarm updated then alarm name should be \'Test alarm\'',
        () async {
      const newName = 'Test alarm';
      final alarm = Alarm(
          time: DateTime.now(), createdAt: DateTime.now(), name: 'Some name');

      await repository.add(alarm);
      await repository.update(alarm.copyWith(name: newName));

      expect(repository.getList().first.name, newName);
    });

    test('when remove called then lenght of list should be zero',
        () async {
      final alarm = Alarm(
          time: DateTime.now(), createdAt: DateTime.now(), name: 'Some name');

      await repository.add(alarm);
      await repository.remove(alarm.createdAt);

      expect(repository.getList().isEmpty, true);
    });
  });
}
