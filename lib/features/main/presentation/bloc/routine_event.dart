part of 'routine_bloc.dart';

@immutable
sealed class RoutineEvent {}

final class LoadDataFromHiveEvent extends RoutineEvent {
  final String day;

  LoadDataFromHiveEvent({required this.day});
}

final class RoutineChangeDropDownValueEvent extends RoutineEvent {
  final String? day;

  RoutineChangeDropDownValueEvent({required this.day});
}

final class RoutineSelectStartTimeEvent extends RoutineEvent {
  final String? time;

  RoutineSelectStartTimeEvent({required this.time});
}

final class RoutineSelectEndTimeEvent extends RoutineEvent {
  final String? time;

  RoutineSelectEndTimeEvent({required this.time});
}

final class RoutineUploadToHiveEvent extends RoutineEvent {
  final Subject subject;
  final String day;

  RoutineUploadToHiveEvent({required this.subject, required this.day});
}

final class RoutineDeleteFromHiveEvent extends RoutineEvent {
  final Subject sub;
  final String day;

  RoutineDeleteFromHiveEvent({required this.day, required this.sub});
}

final class RoutineEditFromHiveEvent extends RoutineEvent {
  final Subject sub;

  final String day;
  final int index;

  RoutineEditFromHiveEvent(
      {required this.index, required this.sub, required this.day});
}
