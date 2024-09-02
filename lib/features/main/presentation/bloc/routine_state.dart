part of 'routine_bloc.dart';

@immutable
sealed class RoutineState {}

final class RoutineInitial extends RoutineState {}

final class RoutineLoadFromHiveState extends RoutineState {
  final List<Subject> subject;

  RoutineLoadFromHiveState(
    this.subject,
  );
}

final class RoutineNoClassState extends RoutineState {}
