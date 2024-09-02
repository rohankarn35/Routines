import 'package:routines/core/data/daySchedule.dart';
import 'package:routines/core/hiveUtils/boxes.dart';
import 'package:flutter/material.dart';

void sortSubjectsByTimeForDay(String day) {
  final box = Boxes.getData();
  DaySchedule? daySchedule = box.get(day.substring(0, 2).toUpperCase());

  if (daySchedule != null && daySchedule.subjects.isNotEmpty) {
    daySchedule.subjects.sort((a, b) {
      TimeOfDay timeA = _getStartTime(a.time);
      TimeOfDay timeB = _getStartTime(b.time);
      return _compareTimeOfDay(timeA, timeB);
    });
    daySchedule.save();
    print('Subjects sorted by starting time for $day.');
  } else {
    print('No subjects found for $day.');
  }
}

TimeOfDay _getStartTime(String time) {
  final startTime = time.split('-')[0].trim();
  List<String> hourMinute;
  if (startTime.contains(':')) {
    hourMinute = startTime.split(':');
  } else {
    hourMinute = [startTime, "0"];
  }

  int hour = int.parse(hourMinute[0]);
  int minute = int.parse(hourMinute[1]);

  if (hour < 8) {
    hour += 12;
  }

  return TimeOfDay(hour: hour, minute: minute);
}

int _compareTimeOfDay(TimeOfDay time1, TimeOfDay time2) {
  if (time1.hour == time2.hour) {
    return time1.minute.compareTo(time2.minute);
  }
  return time1.hour.compareTo(time2.hour);
}
