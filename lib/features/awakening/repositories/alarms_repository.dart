import 'package:hive_flutter/hive_flutter.dart';

import '../../../app/hive/hive.dart';
import '../../features.dart';

class AlarmsRepository {
  final _box = Hive.box<Alarm>(HiveAppBox.alarms.name);

  Future<void> update(Alarm alarm) {
    final pos = getList().indexWhere(
        (element) => element.createdAt.compareTo(alarm.createdAt) == 0);
    return _box.putAt(pos, alarm);
  }

  Future<void> add(Alarm alarm) {
    return _box.add(alarm);
  }

  Future<void> remove(DateTime createdAt) {
    final pos = getList()
        .indexWhere((element) => element.createdAt.compareTo(createdAt) == 0);
    return _box.deleteAt(pos);
  }

  List<Alarm> getList() {
    return _box.values.toList().cast<Alarm>();
  }

  Future<void> clear() {
    return _box.clear();
  }
}
