import 'package:hive/hive.dart';
import 'package:routines/core/data/daySchedule.dart';

class Boxes {
  static Box<DaySchedule> getData() {
    return Hive.box<DaySchedule>('timetable');
  }
}
