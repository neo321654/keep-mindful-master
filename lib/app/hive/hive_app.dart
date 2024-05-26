import 'package:hive_flutter/hive_flutter.dart';

import '../../features/features.dart';
import 'adapters/adapters.dart';

enum HiveAppBox { awakening, timer, metronome, alarms, bluetooth, language }

class HiveApp {
  Future<void> initHive() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openBoxes();
  }

  Future<void> _openBoxes() async {
    await Hive.openBox(HiveAppBox.awakening.name);
    await Hive.openBox(HiveAppBox.timer.name);
    await Hive.openBox(HiveAppBox.metronome.name);
    await Hive.openBox<Alarm>(HiveAppBox.alarms.name);
    await Hive.openBox(HiveAppBox.bluetooth.name);
    await Hive.openBox(HiveAppBox.language.name);
  }

  void _registerAdapters() {
    Hive.registerAdapter(AlarmAdapter());
    Hive.registerAdapter(DurationAdapter());
    Hive.registerAdapter(IntensityNotifyTypeAdapter());
    Hive.registerAdapter(AppLanguageAdapter());
  }
}
