import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';
import 'package:routines/features/main/presentation/pages/widgets/CustomTimePicker.dart';

class Routinetimewidget extends StatefulWidget {
  final String? startTime;
  final String? endTime;

  const Routinetimewidget({super.key, this.startTime, this.endTime});
  @override
  State<Routinetimewidget> createState() => _RoutinetimewidgetState();
}

class _RoutinetimewidgetState extends State<Routinetimewidget> {
  String? startTime;
  String? endTime;
  TimeOfDay? startTimeofDay;
  TimeOfDay? endTimeofDay;

  @override
  void initState() {
    startTimeofDay = parseTimeOfDay(widget.startTime);
    endTimeofDay = parseTimeOfDay(widget.endTime);
    startTime = widget.startTime;
    endTime = widget.endTime;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutineBloc, RoutineState>(
      listener: (context, state) {
        if (state is RoutineStartTimeSelectedState) {
          startTime = state.startTime;
          startTimeofDay = parseTimeOfDay(startTime);
        } else if (state is RoutineEndTimeSelectedState) {
          endTime = state.endTime;
          endTimeofDay = parseTimeOfDay(endTime);
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTimePicker(
              title: startTime ?? "Start Time",
              onSelectTime: (val) {
                final time = _formatTimeWithoutAmPm(val);
                context
                    .read<RoutineBloc>()
                    .add(RoutineSelectStartTimeEvent(time: time));
              },
              selectedTime: startTimeofDay ?? TimeOfDay.now(),
            ),
            Text("-"),
            CustomTimePicker(
              title: endTime ?? 'End Time',
              onSelectTime: (val) {
                final time = _formatTimeWithoutAmPm(val);
                context
                    .read<RoutineBloc>()
                    .add(RoutineSelectEndTimeEvent(time: time));
              },
              selectedTime: endTimeofDay ?? TimeOfDay.now(),
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

  TimeOfDay? parseTimeOfDay(String? time) {
    if (time != null) {
      final timeParts = time.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      // Adjust time based on 24-hour format assumption
      if (hour < 8) {
        return TimeOfDay(
            hour: hour + 12,
            minute: minute); // Handle AM to PM conversion if necessary
      } else {
        return TimeOfDay(hour: hour, minute: minute);
      }
    } else {
      return null;
    }
  }
}
