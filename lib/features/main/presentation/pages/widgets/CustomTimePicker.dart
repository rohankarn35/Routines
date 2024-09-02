import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final String title;
  const CustomTimePicker({super.key, required this.title});

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay selectedTime = TimeOfDay.now();
  String val = '';

  @override
  void initState() {
    super.initState();
    val = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _selectTime,
      child: Text(val),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (time != null) {
      // Validate if the selected time is within the allowed range
      if (_isTimeInRange(time)) {
        setState(() {
          selectedTime = time;
          val = _formatTimeWithoutAmPm(selectedTime);
        });
      } else {
        _showInvalidTimeAlert();
      }
    }
  }

  bool _isTimeInRange(TimeOfDay time) {
    final morningTime = const TimeOfDay(hour: 8, minute: 0); // 8:00 AM
    final eveningTime = const TimeOfDay(hour: 19, minute: 0); // 7:00 PM

    return time.hour >= morningTime.hour && time.hour < eveningTime.hour;
  }

  void _showInvalidTimeAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Time'),
          content:
              const Text('Please select a time between 8:00 AM and 7:00 PM.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _formatTimeWithoutAmPm(TimeOfDay time) {
    final hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
