// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daySchedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayScheduleAdapter extends TypeAdapter<DaySchedule> {
  @override
  final int typeId = 1;

  @override
  DaySchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DaySchedule(
      day: fields[0] as String,
      subjects: (fields[1] as List).cast<Subject>(),
    );
  }

  @override
  void write(BinaryWriter writer, DaySchedule obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.subjects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
