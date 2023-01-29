// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigAdapter extends TypeAdapter<Config> {
  @override
  final int typeId = 1;

  @override
  Config read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Config(
      dynamicColor: fields[0] as bool?,
      highRefreshRate: fields[1] as bool?,
      autoSign: fields[2] as bool?,
      traditionalChinese: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Config obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dynamicColor)
      ..writeByte(1)
      ..write(obj.highRefreshRate)
      ..writeByte(2)
      ..write(obj.autoSign)
      ..writeByte(3)
      ..write(obj.traditionalChinese);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
