part of 'routine_bloc.dart';

@immutable
sealed class RoutineState {}

final class RoutineInitial extends RoutineState {}

final class RoutineLoadFromHiveState extends RoutineState {
  final List<String> subject;
  final List<String> time;
  final List<String> subjectTeacher;
  final List<String> roomNo;

  RoutineLoadFromHiveState(
    this.subject,
    this.time,
    this.subjectTeacher,
    this.roomNo,
  );
}

final class RoutineNoClassState extends RoutineState {}

final class RoutineAlarmClockState extends RoutineState {
  final String timeStamp;

  RoutineAlarmClockState({required this.timeStamp});
}
