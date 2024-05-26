import 'package:hive_flutter/hive_flutter.dart';

import '../../../app/hive/hive.dart';
import '../constants/awakening_hive_keys.dart';

class AlarmDisableQrCodeRepository {
  final _box = Hive.box(HiveAppBox.awakening.name);

  String? get() {
    return _box.get(AwakeningHiveKeys.alarmsDisableQrCode);
  }

  Future<void> set(String qr) {
    return _box.put(AwakeningHiveKeys.alarmsDisableQrCode, qr);
  }
}
