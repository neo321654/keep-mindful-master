import 'package:hive_flutter/hive_flutter.dart';

import '../../../features/features.dart';

class IntensityNotifyTypeAdapter extends TypeAdapter<NotificationType> {
  @override
  final int typeId = 35;

  @override
  NotificationType read(BinaryReader reader) {
    return NotificationType.values[reader.read() as int];
  }

  @override
  void write(BinaryWriter writer, NotificationType obj) {
    writer.write(obj.index);
  }
}
