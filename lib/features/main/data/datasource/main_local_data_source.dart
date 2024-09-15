import 'package:hive/hive.dart';
import 'package:routines/core/data/daySchedule.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/hiveUtils/boxes.dart';
import 'package:routines/core/utils/sortHIve.dart';

abstract interface class MainLocalDataSource {
  List<Subject> getDataFromHive({required String day});
  void uploadToHive({required Subject subject, required String day});
  void deleteFromHive({required Subject subject, required String day});
  void updateHiveData(
      {required Subject subject, required int index, required String day});
}

class MainLocalDataSourceImpl implements MainLocalDataSource {
  @override
  List<Subject> getDataFromHive({required String day}) {
    final box = Boxes.getData();
    List<Subject> subject = [];

    final data = box.get(day);

    if (data != null && data.subjects.isNotEmpty) {
      for (var sub in data.subjects) {
        subject.add(sub);
      }
    }
    return subject;
  }

  @override
  void uploadToHive({required Subject subject, required String day}) {
    if (day.isNotEmpty) {
      final box = Boxes.getData();
      DaySchedule? schedule = box.get(day);
      print(schedule?.subjects.length);
      if (schedule != null) {
        subject.isUserAdded = true;
        schedule.subjects.add(subject);
        schedule.save();
        sortSubjectsByTimeForDay(day);
      }
    } else {
      throw HiveError("Select day");
    }
  }

  @override
  void deleteFromHive({required Subject subject, required String day}) {
    final box = Boxes.getData();

    DaySchedule? schedule = box.get(day);
    if (schedule != null) {
      schedule.subjects
          .removeWhere((subjectTodelete) => subjectTodelete == subject);

      schedule.save();
      sortSubjectsByTimeForDay(day);
    }
  }

  @override
  void updateHiveData(
      {required Subject subject, required int index, required String day}) {
    final box = Boxes.getData();
    final String _day = day.substring(0, 3).toUpperCase();
    DaySchedule? schedule = box.get(_day);
    if (schedule != null) {
      if (index != -1) {
        subject.isUserAdded = true;
        schedule.subjects[index] = subject;
        schedule.save();
        sortSubjectsByTimeForDay(_day);
      }
    }
  }
}
