import 'package:hive_flutter/hive_flutter.dart';
import 'package:routines/core/cubits/user_entity/scheduleJson.dart';
import 'package:routines/core/cubits/user_entity/subjectTeacher.dart';
import 'package:routines/core/data/daySchedule.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/hiveUtils/boxes.dart';

void uploadInitialDataToHive(
    ScheduleJson scheduleJson, SubjectTeacherJson subjecteacherJson) {
  var scheduleBox = Boxes.getData();
  scheduleJson.schedule.forEach((day, subjectsJson) {
    List<Subject> subjects = subjectsJson.map((subjectJson) {
      return Subject(
        subject: subjectJson.subject,
        time: subjectJson.time,
        roomNo: subjectJson.roomNo,
        subjectTeacher:
            subjecteacherJson.subjectTeachers[subjectJson.subject] ?? '',
      );
    }).toList();
    var daySchedule = DaySchedule(day: day, subjects: subjects);

    scheduleBox.put(day, daySchedule);
  });
}
