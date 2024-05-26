import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../features/features.dart';

class AppLanguageAdapter extends TypeAdapter<AppLanguage> {
  @override
  final int typeId = 37;

  @override
  AppLanguage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppLanguage(
      name: fields[0] as String,
      locale: Locale(fields[1] as String),
    );
  }

  @override
  void write(BinaryWriter writer, AppLanguage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.locale.languageCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppLanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
