// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'red_wifi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RedWifiAdapter extends TypeAdapter<RedWifi> {
  @override
  final int typeId = 1;

  @override
  RedWifi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RedWifi(
      wifiName: fields[0] as String,
      wifiBSSID: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RedWifi obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.wifiName)
      ..writeByte(1)
      ..write(obj.wifiBSSID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RedWifiAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
