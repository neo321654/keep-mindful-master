import 'package:hive/hive.dart';

import '../../app/hive/hive.dart';
import 'consts/metronome_hive_keys.dart';

class MetronomeRepository {
  final _box = Hive.box(HiveAppBox.metronome.name);

  Future<void> saveBpm(double bpm) {
    return _box.put(MetronomeHiveKeys.bpm, bpm);
  }

  Future<void> saveNumberOfBars(int numberOfBars) {
    return _box.put(MetronomeHiveKeys.numberOfBars, numberOfBars);
  }

  Future<void> saveSkippingOneBar(bool enabled) {
    return _box.put(MetronomeHiveKeys.skippingOneBar, enabled);
  }

  Future<void> saveIsActive(bool enabled) {
    return _box.put(MetronomeHiveKeys.isActive, enabled);
  }

  double? getBpm() {
    return _box.get(MetronomeHiveKeys.bpm);
  }

  int? getNumberOfBars() {
    return _box.get(MetronomeHiveKeys.numberOfBars);
  }

  bool? getSkippingOneBar() {
    return _box.get(MetronomeHiveKeys.skippingOneBar);
  }

  bool? getIsActive() {
    return _box.get(MetronomeHiveKeys.isActive);
  }

  Future<void> clear() async {
    await _box.delete(MetronomeHiveKeys.numberOfBars);
    await _box.delete(MetronomeHiveKeys.skippingOneBar);
    await _box.delete(MetronomeHiveKeys.isActive);
    await _box.delete(MetronomeHiveKeys.bpm);
    await _box.delete(MetronomeHiveKeys.updatedAt);
    await _box.delete(MetronomeHiveKeys.sentAt);
  }

  DateTime? getUpdatedAt() {
    return _box.get(MetronomeHiveKeys.updatedAt);
  }

  DateTime? getSentAt() {
    return _box.get(MetronomeHiveKeys.sentAt);
  }

  Future<void> setUpdatedNow() async {
    await _box.put(MetronomeHiveKeys.updatedAt, DateTime.now());
  }

  Future<void> setSentNow() async {
    await _box.put(MetronomeHiveKeys.sentAt, DateTime.now());
  }
}
