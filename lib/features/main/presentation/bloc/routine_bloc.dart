import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:routines/core/data/subject.dart';

import 'package:routines/core/hiveUtils/boxes.dart';
import 'package:routines/core/utils/toastbar.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  RoutineBloc() : super(RoutineInitial()) {
    on<LoadDataFromHiveEvent>((event, emit) {
      try {
        final box = Boxes.getData();
        List<Subject> subject = [];

        final data = box.get(event.day);

        if (data != null && data.subjects.isNotEmpty) {
          for (var sub in data.subjects) {
            subject.add(sub);
          }
        }

        if (subject.isNotEmpty) {
          emit(RoutineLoadFromHiveState(List<Subject>.from(subject)));
        } else {
          emit(RoutineNoClassState());
        }
      } catch (e) {
        showToast("Something went wrong", Colors.red);
      }
    });
  }
}
