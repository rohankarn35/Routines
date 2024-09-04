import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';
import 'package:routines/features/main/presentation/pages/widgets/routineCard.dart';

Widget buildDailySchedule(String day, BuildContext context) {
  return BlocBuilder<RoutineBloc, RoutineState>(
    builder: (context, state) {
      if (state is RoutineLoadFromHiveState) {
        return ListView.builder(
          itemCount: state.subject.length,
          itemBuilder: (context, index) {
            return RoutineCard(subject: state.subject[index]);
          },
        );
      } else if (state is RoutineInitial) {
        return Center(child: CircularProgressIndicator());
      } else if (state is RoutineNoClassState) {
        return Center(child: Text('No classes today'));
      } else {
        return Center(child: Text('Something Went Wrong'));
      }
    },
  );
}
