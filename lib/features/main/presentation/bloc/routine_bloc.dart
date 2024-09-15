import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/features/main/domain/usecases/delete_from_hive.dart';
import 'package:routines/features/main/domain/usecases/get_from_hive.dart';
import 'package:routines/features/main/domain/usecases/update_hive_data.dart';
import 'package:routines/features/main/domain/usecases/upload_to_hive.dart';
part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  final UpdateHiveData _updateHiveData;
  final UploadToHive _uploadToHive;
  final GetFromHive _getFromHive;
  final DeleteFromHive _deleteFromHive;
  String? startTime;
  String? endTime;

  RoutineBloc({
    required UpdateHiveData updateHiveData,
    required UploadToHive uploadToHive,
    required GetFromHive getFromHive,
    required DeleteFromHive deleteFromHive,
  })  : _updateHiveData = updateHiveData,
        _uploadToHive = uploadToHive,
        _getFromHive = getFromHive,
        _deleteFromHive = deleteFromHive,
        super(RoutineInitial()) {
    on<LoadDataFromHiveEvent>(_loadDataFromHive);
    on<RoutineChangeDropDownValueEvent>(_routineChangeDropDown);
    on<RoutineSelectStartTimeEvent>(_selectStartTime);
    on<RoutineSelectEndTimeEvent>(_selectEndTime);
    on<RoutineUploadToHiveEvent>(_onUploadToHive);
    on<RoutineDeleteFromHiveEvent>(_onDeleteFromHive);
    on<RoutineEditFromHiveEvent>(_onEditFromHive);
  }

  void _loadDataFromHive(
      LoadDataFromHiveEvent event, Emitter<RoutineState> emit) async {
    final Either<Failure, List<Subject>> res =
        _getFromHive.call(GetFromHiveParams(day: event.day));
    res.fold((failure) => emit(RoutineFailure(failure.message)), (subject) {
      if (subject.isEmpty) {
        emit(RoutineNoClassState());
      } else {
        emit(RoutineLoadFromHiveState(subject));
        print(subject.length);
      }
    });
  }

  void _routineChangeDropDown(
      RoutineChangeDropDownValueEvent event, Emitter<RoutineState> emit) {
    emit(RoutineChangeDropDownValueState(day: event.day));
  }

  void _selectStartTime(
      RoutineSelectStartTimeEvent event, Emitter<RoutineState> emit) {
    startTime = event.time;

    emit(RoutineStartTimeSelectedState(startTime: startTime!));
  }

  void _selectEndTime(
      RoutineSelectEndTimeEvent event, Emitter<RoutineState> emit) {
    endTime = event.time;

    emit(RoutineEndTimeSelectedState(endTime: endTime!));
  }

  _onUploadToHive(RoutineUploadToHiveEvent event, Emitter<RoutineState> emit) {
    final res = _uploadToHive
        .call(UploadToHiveParams(subject: event.subject, day: event.day));

    res.fold((l) => emit(RoutineFailure(l.message)), (r) {
      emit(RoutineSucess());
      add(LoadDataFromHiveEvent(day: event.day));
    });
  }

  _onDeleteFromHive(
      RoutineDeleteFromHiveEvent event, Emitter<RoutineState> emit) {
    final res = _deleteFromHive
        .call(DeleteFromHiveParams(subject: event.sub, day: event.day));

    res.fold((l) => emit(RoutineFailure(l.message)), (r) {
      emit(RoutineSucess());
      add(LoadDataFromHiveEvent(day: event.day));
    });
  }

  _onEditFromHive(RoutineEditFromHiveEvent event, Emitter<RoutineState> emit) {
    final res = _updateHiveData(UpdateHiveDataParams(
        subject: event.sub, index: event.index, day: event.day));
    res.fold((l) => emit(RoutineFailure(l.message)), (r) {
      emit(RoutineSucess());
      add(LoadDataFromHiveEvent(day: event.day));
    });
  }
}
