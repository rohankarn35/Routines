import 'package:routines/core/cubits/user_entity/subjectModel.dart';
import 'package:routines/core/data/daySchedule.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/hiveUtils/boxes.dart';

class UploadHive {
  uploadHive(Subject subject, String day) {
    try {
      final box = Boxes.getData();
      DaySchedule? schedule = box.get(day.substring(0, 3).toUpperCase());

      if (schedule != null) {
        schedule.subjects.add(subject);
        schedule.save();
        print('Subject added successfully');
      } else {
        print('No schedule found for the specified day');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
