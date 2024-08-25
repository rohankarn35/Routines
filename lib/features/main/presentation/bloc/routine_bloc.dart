import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:routines/core/hiveUtils/boxes.dart';
import 'package:routines/core/utils/toastbar.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  RoutineBloc() : super(RoutineInitial()) {
    on<LoadDataFromHiveEvent>((event, emit) {
      try {
        final box = Boxes.getData();
        List<String> subject = [];
        List<String> time = [];
        List<String> subjectTeacher = [];
        List<String> roomNo = [];

        final data = box.get(event.day);

        if (data != null && data.subjects.isNotEmpty) {
          for (var sub in data.subjects) {
            subject.add(sub.subject);
            time.add(sub.time);
            subjectTeacher.add(sub.subjectTeacher);
            roomNo.add(sub.roomNo);
          }
        }

        if (subject.isNotEmpty) {
          print(subjectTeacher);
          emit(RoutineLoadFromHiveState(
            List<String>.from(subject),
            List<String>.from(time),
            List<String>.from(subjectTeacher),
            List<String>.from(roomNo),
          ));
        } else {
          emit(RoutineNoClassState());
        }
      } catch (e) {
        showToast("Something went wrong", Colors.red);
      }
    });
  }
}
