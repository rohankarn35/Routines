import 'package:routines/core/cubits/user_entity/subjectModel.dart';

class ScheduleJson {
  Map<String, List<SubjectModel>> schedule;

  ScheduleJson({required this.schedule});

  factory ScheduleJson.fromJson(Map<String, dynamic> json) {
    Map<String, List<SubjectModel>> parsedSchedule = {};

    json.forEach((day, subjectsJson) {
      List<SubjectModel> subjects = (subjectsJson as List)
          .map((subjectJson) => SubjectModel.fromJson(subjectJson))
          .toList();
      parsedSchedule[day] = subjects;
    });

    return ScheduleJson(schedule: parsedSchedule);
  }
}
