import 'package:routines/core/data/daySchedule.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/hiveUtils/boxes.dart';

bool checkTimeAlreadyExist(
  String day,
  String starttime,
  String endtime,
  int? index,
) {
  try {
    final box = Boxes.getData();
    DaySchedule? daySchedule;
    if (day.isNotEmpty) {
      final String _day = day.substring(0, 3).toUpperCase();
      daySchedule = box.get(_day);
    }

    if (daySchedule != null) {
      for (int i = 0; i < daySchedule.subjects.length; i++) {
        // Skip the subject at the provided index if it's not null and matches
        if (index != null && i == index) {
          continue;
        }

        Subject subject = daySchedule.subjects[i];
        List<String> timeRange = subject.time.split('-');
        String existingStartTime = timeRange[0];
        if (!existingStartTime.contains(":")) {
          existingStartTime = '$existingStartTime:00';
        }
        String existingEndTime = timeRange[1];
        if (!existingEndTime.contains(":")) {
          existingEndTime = '$existingEndTime:00';
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

  // Convert hour to 24-hour format
  if (hour < 8) {
    hour += 12;
  }

  return hour + minute;
}
