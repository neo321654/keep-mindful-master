import 'package:hive/hive.dart';

import '../../../app/hive/hive.dart';
import '../constants/constants.dart';

class BluetoothDeviceRepository {
  final _hiveBox = Hive.box(HiveAppBox.bluetooth.name);

  String? get() {
    return _hiveBox.get(BleHiveKeys.deviceId);
  }

  Future<void> set(String deviceId) async {
    await _hiveBox.put(BleHiveKeys.deviceId, deviceId);
  }

  Future<void> remove() async {
    await _hiveBox.delete(BleHiveKeys.deviceId);
  }
}
