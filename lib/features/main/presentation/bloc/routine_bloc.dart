import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:routines/core/data/subject.dart';
part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  RoutineBloc() : super(RoutineInitial()) {
    on<LoadDataFromHiveEvent>((event, emit) {
      try {} catch (e) {}
    });
  }
}
