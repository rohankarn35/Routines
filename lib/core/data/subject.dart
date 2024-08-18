import 'package:hive/hive.dart';
part 'subject.g.dart';

@HiveType(typeId: 0)
class Subject extends HiveObject {
  @HiveField(0)
  String subject;

  @HiveField(1)
  String time;

  @HiveField(2)
  String subjectTeacher;

  @HiveField(3)
  String roomNo;

  @HiveField(4)
  bool isUserAdded;

  Subject({
    required this.subject,
    required this.time,
    required this.subjectTeacher,
    required this.roomNo,
    this.isUserAdded = false,
  });
}
