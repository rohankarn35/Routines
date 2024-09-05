import 'package:routines/core/data/daySchedule.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/hiveUtils/boxes.dart';

bool checkTimeAlreadyExist(String day, String starttime, String endtime) {
  try {
    final box = Boxes.getData();
    DaySchedule? daySchedule;
    if (day.isNotEmpty) {
      final String _day = day.substring(0, 3).toUpperCase();
      daySchedule = box.get(_day);
    }

    if (daySchedule != null) {
      for (Subject subject in daySchedule.subjects) {
        List<String> timeRange = subject.time.split('-');
        String existingStartTime = timeRange[0];
        if (!existingStartTime.contains(":")) {
          existingStartTime = '$existingStartTime' ":00";
        }
        String existingEndTime = timeRange[1];
        if (!existingEndTime.contains(":")) {
          existingEndTime = '$existingEndTime' ":00";
        }

        double newStartTime = convertTo24HourFormat(starttime);
        double newEndTime = convertTo24HourFormat(endtime);
        double existingStart = convertTo24HourFormat(existingStartTime);
        double existingEnd = convertTo24HourFormat(existingEndTime);

        bool isOverlap =
            (newStartTime < existingEnd && newEndTime > existingStart);

        if (isOverlap) {
          return false;
        }
      }
    } else {
      return false;
    }

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

double convertTo24HourFormat(String time) {
  List<String> parts = time.split(':');
  double hour = double.parse(parts[0]);
  double minute = double.parse(parts[1]);
  minute = minute / 60;
  if (hour < 8) {
    hour += 12;
  }

  return hour + minute;
}
