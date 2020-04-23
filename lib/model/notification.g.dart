// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final typeId = 3;

  @override
  NotificationModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      title: fields[0] as String,
      body: fields[1] as String,
      frequancy: fields[2] as Frequancy,
      time: fields[3] as DateTime,
      day: fields[4] as int,
      payload: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.frequancy)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.day)
      ..writeByte(5)
      ..write(obj.payload);
  }
}
