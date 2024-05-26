import 'package:hive_flutter/hive_flutter.dart';

import '../../../app/hive/hive.dart';
import '../constants/constants.dart';

class AlarmDisableQrShownRepository {
  final Box _box = Hive.box(HiveAppBox.awakening.name);

  bool? get() {
    return _box.get(AwakeningHiveKeys.alarmDisableQrShown);
  }

  Future<void> set(bool wasShown) {
    return _box.put(AwakeningHiveKeys.alarmDisableQrShown, wasShown);
  }
}
