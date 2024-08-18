// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 0;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subject(
      subject: fields[0] as String,
      time: fields[1] as String,
      subjectTeacher: fields[2] as String,
      roomNo: fields[3] as String,
      isUserAdded: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.subjectTeacher)
      ..writeByte(3)
      ..write(obj.roomNo)
      ..writeByte(4)
      ..write(obj.isUserAdded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
