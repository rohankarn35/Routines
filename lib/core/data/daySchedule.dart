import 'package:hive/hive.dart';
import 'package:routines/core/data/subject.dart';

part 'daySchedule.g.dart';

@HiveType(typeId: 1)
class DaySchedule extends HiveObject {
  @HiveField(0)
  String day;

  @HiveField(1)
  List<Subject> subjects;

  DaySchedule({required this.day, required this.subjects});
}
