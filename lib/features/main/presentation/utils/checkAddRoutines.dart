import 'package:routines/features/main/presentation/utils/checkTimeAlreadyExist.dart';

Map<String, dynamic> checkAddRoutines({
  required String teacherName,
  required String subjectName,
  required String roomNo,
  required String time,
  required String? day,
}) {
  List<String> timeRange = time.split('-');
  String starttime = timeRange[0];
  String endtime = timeRange[1];

  double newStartTime = convertTo24HourFormat(starttime);
  double newEndTime = convertTo24HourFormat(endtime);
  try {
    if (teacherName.isEmpty) {
      return {"status": false, "message": "Teacher name is required."};
    } else if (subjectName.isEmpty) {
      return {"status": false, "message": "Subject name is required."};
    } else if (roomNo.isEmpty) {
      return {"status": false, "message": "Room number is required."};
    } else if (time.isEmpty) {
      return {"status": false, "message": "Time is required."};
    } else if (day == null) {
      return {"status": false, "message": "Day is required."};
    } else if (roomNo.length >= 15) {
      return {
        "status": false,
        "message": "Room number should be less than 15 characters."
      };
    } else if (time.length <= 1) {
      return {
        "status": false,
        "message": "Time should be more than one character."
      };
    } else if (newStartTime > newEndTime) {
      return {"status": false, "message": "Endtime should be after Starttime"};
    } else {
      return {"status": true, "message": "Routine added successfully."};
    }
  } catch (e) {
    return {"status": false, "message": "An unexpected error occurred."};
  }
}
