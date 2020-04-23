// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kolonya.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CologneAdapter extends TypeAdapter<Cologne> {
  @override
  final typeId = 0;

  @override
  Cologne read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cologne(
      id: fields[0] as int,
      title: fields[1] as String,
      imageUrl: fields[2] as String,
      frequancy: fields[3] as Frequancy,
      targetCleaningCount: fields[4] as int,
      histories: (fields[5] as HiveList)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Cologne obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.frequancy)
      ..writeByte(4)
      ..write(obj.targetCleaningCount)
      ..writeByte(5)
      ..write(obj.histories);
  }
}
