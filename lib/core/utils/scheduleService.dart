import 'package:routines/core/cubits/user_entity/scheduleJson.dart';
import 'package:routines/core/cubits/user_entity/subjectTeacher.dart';

class ScheduleService {
  ScheduleJson fetchSchedule(Map<String, dynamic> jsonfile) {
    return ScheduleJson.fromJson(jsonfile);
  }

  SubjectTeacherJson fetchSubjectTeachers(Map<String, dynamic> jsonfile) {
    return SubjectTeacherJson.fromJson(jsonfile);
  }
}
