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

final class RoutineFailure extends RoutineState {
  final String message;

  RoutineFailure(this.message);
}

final class RoutineChangeDropDownValueState extends RoutineState {
  final String? day;

  RoutineChangeDropDownValueState({required this.day});
}

final class RoutineStartTimeSelectedState extends RoutineState {
  final String? startTime;

  RoutineStartTimeSelectedState({required this.startTime});
}

final class RoutineEndTimeSelectedState extends RoutineState {
  final String? endTime;

  RoutineEndTimeSelectedState({required this.endTime});
}

final class RoutineAddSucess extends RoutineState {
  final String day;

  RoutineAddSucess({required this.day});
}

final class RoutineSucess extends RoutineState {}
