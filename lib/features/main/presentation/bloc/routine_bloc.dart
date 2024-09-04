import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/error/failure.dart';
import 'package:routines/features/main/domain/usecases/get_from_hive.dart';
import 'package:routines/features/main/domain/usecases/update_hive_data.dart';
import 'package:routines/features/main/domain/usecases/upload_to_hive.dart';
part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  final UpdateHiveData _updateHiveData;
  final UploadToHive _uploadToHive;
  final GetFromHive _getFromHive;

  RoutineBloc({
    required UpdateHiveData updateHiveData,
    required UploadToHive uploadToHive,
    required GetFromHive getFromHive,
  })  : _updateHiveData = updateHiveData,
        _uploadToHive = uploadToHive,
        _getFromHive = getFromHive,
        super(RoutineInitial()) {
    on<LoadDataFromHiveEvent>(_loadDataFromHive);
    on<RoutineChangeDropDownValueEvent>(_routineChangeDropDown);
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
}
