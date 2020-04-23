// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryAdapter extends TypeAdapter<History> {
  @override
  final typeId = 1;

  @override
  History read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return History(
      cologneId: fields[1] as int,
      cleanDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, History obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.cologneId)
      ..writeByte(2)
      ..write(obj.cleanDate);
  }
}
