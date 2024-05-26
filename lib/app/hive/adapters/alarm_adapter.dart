import 'package:hive_flutter/hive_flutter.dart';

import '../../../features/features.dart';

class AlarmAdapter extends TypeAdapter<Alarm> {
  @override
  final int typeId = 36;

  @override
  Alarm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Alarm(
        time: fields[0] as DateTime,
        name: fields[1] as String,
        isActive: fields[2] as bool,
        createdAt: fields[3] as DateTime);
  }

  @override
  void write(BinaryWriter writer, Alarm obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isActive)
      ..writeByte(3)
      ..write(obj.createdAt);
  }
}
