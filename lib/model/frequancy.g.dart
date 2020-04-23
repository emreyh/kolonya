// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequancy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FrequancyAdapter extends TypeAdapter<Frequancy> {
  @override
  final typeId = 2;

  @override
  Frequancy read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Frequancy.Daily;
      case 1:
        return Frequancy.Weekly;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, Frequancy obj) {
    switch (obj) {
      case Frequancy.Daily:
        writer.writeByte(0);
        break;
      case Frequancy.Weekly:
        writer.writeByte(1);
        break;
    }
  }
}
