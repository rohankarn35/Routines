import 'package:flutter/material.dart';
import 'package:routines/core/utils/toastbar.dart';

class CustomTimePicker extends StatelessWidget {
  final String title;
  final Function(TimeOfDay) onSelectTime;
  final TimeOfDay selectedTime;

  const CustomTimePicker({
    super.key,
    required this.title,
    required this.onSelectTime,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => _selectTime(context),
      child: Text(title),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (time != null) {
      if (_isTimeInRange(time)) {
        onSelectTime(time);
      } else {
        showToast(
            "Please select a time between 8:00 AM and 7:00 PM.", Colors.red);
      }
    }
  }

  bool _isTimeInRange(TimeOfDay time) {
    final morningTime = const TimeOfDay(hour: 8, minute: 0); // 7:00 AM
    final eveningTime = const TimeOfDay(hour: 19, minute: 0); // 7:00 PM

    return time.hour >= morningTime.hour && time.hour < eveningTime.hour;
  }
}
