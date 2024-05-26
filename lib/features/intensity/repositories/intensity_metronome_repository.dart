import 'package:hive/hive.dart';

import '../../../app/hive/hive.dart';
import '../../bluetooth/bluetooth.dart';
import '../constants/constants.dart';
import 'intensity_repository.dart';

class IntensityMetronomeRepository extends IntensityRepository {
  final _hiveBox = Hive.box(HiveAppBox.metronome.name);
  @override
  int? getPower() {
    return _hiveBox.get(IntensityHiveKeys.power);
  }

  @override
  Future<void> setPower(int power) async {
    await _hiveBox.put(IntensityHiveKeys.power, power);
    await _hiveBox.put(IntensityHiveKeys.updatedAt, DateTime.now());
  }

  @override
  NotificationType? getIntensityType() {
    return _hiveBox.get(IntensityHiveKeys.notifyType);
  }

  @override
  Future<void> setIntensityType(NotificationType intensity) async {
    await _hiveBox.put(IntensityHiveKeys.notifyType, intensity);
    await _hiveBox.put(IntensityHiveKeys.updatedAt, DateTime.now());
  }

  @override
  Future<void> reset() async {
    await _hiveBox.delete(IntensityHiveKeys.notifyType);
    await _hiveBox.delete(IntensityHiveKeys.power);
    await _hiveBox.delete(IntensityHiveKeys.updatedAt);
    await _hiveBox.delete(IntensityHiveKeys.sentAt);
  }

  @override
  DateTime? getSentAt() {
    return _hiveBox.get(IntensityHiveKeys.sentAt);
  }

  @override
  DateTime? getUpdatedAt() {
    return _hiveBox.get(IntensityHiveKeys.updatedAt);
  }

  @override
  Future<void> setSentNow() async {
    await _hiveBox.put(IntensityHiveKeys.sentAt, DateTime.now());
  }
}
