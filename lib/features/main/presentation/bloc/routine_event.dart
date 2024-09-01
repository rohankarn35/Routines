part of 'routine_bloc.dart';

@immutable
sealed class RoutineEvent {}

final class LoadDataFromHiveEvent extends RoutineEvent {
  final String day;

  LoadDataFromHiveEvent({required this.day});
}

final class RoutineAlarmTimeClockEvent extends RoutineEvent {}
