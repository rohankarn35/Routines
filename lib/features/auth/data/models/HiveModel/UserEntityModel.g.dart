// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserEntityModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserentitymodelAdapter extends TypeAdapter<Userentitymodel> {
  @override
  final int typeId = 3;

  @override
  Userentitymodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Userentitymodel(
      year: fields[0] as String?,
      branch: fields[1] as String?,
      coreSection: fields[2] as String?,
      electiveSections: (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Userentitymodel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.branch)
      ..writeByte(2)
      ..write(obj.coreSection)
      ..writeByte(3)
      ..write(obj.electiveSections);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserentitymodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
