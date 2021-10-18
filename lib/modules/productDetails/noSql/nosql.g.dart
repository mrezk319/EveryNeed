// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nosql.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProdcutModelAdapter extends TypeAdapter<ProdcutModel> {
  @override
  final int typeId = 15;

  @override
  ProdcutModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProdcutModel(
      name: fields[1] as String?,
      pic: fields[0] as String?,
      disc: fields[2] as String?,
      price: fields[7] as int?,
      details: fields[3] as dynamic,
      size: fields[4] as dynamic,
      color: fields[5] as dynamic,
      id: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, ProdcutModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.pic)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.disc)
      ..writeByte(3)
      ..write(obj.details)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProdcutModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
