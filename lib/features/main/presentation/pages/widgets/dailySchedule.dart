import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';
import 'package:routines/features/main/presentation/pages/widgets/customFloatingDialog.dart';
import 'package:routines/features/main/presentation/pages/widgets/customRoutineDialog.dart';
import 'package:routines/features/main/presentation/pages/widgets/routineCard.dart';

Widget buildDailySchedule(String day, BuildContext context) {
  Map<String, String> daysMap = {
    'MON': 'Monday',
    'TUE': 'Tuesday',
    'WED': 'Wednesday',
    'THU': 'Thursday',
    'FRI': 'Friday',
    'SAT': 'Saturday',
    'SUN': 'Sunday'
  };

  return BlocBuilder<RoutineBloc, RoutineState>(
    builder: (context, state) {
      if (state is RoutineLoadFromHiveState) {
        return ListView.builder(
          itemCount: state.subject.length,
          itemBuilder: (context, index) {
            return state.subject[index].isUserAdded
                ? ChatOptionsMenu(
                    onOptionSelected: (option) {
                      if (option == 'Delete') {
                        context.read<RoutineBloc>().add(
                              RoutineDeleteFromHiveEvent(
                                day: day,
                                sub: state.subject[index],
                              ),
                            );
                      }
                      if (option == 'Edit') {
                        final TextEditingController subjectTextController =
                            TextEditingController(
                                text: state.subject[index].subject);
                        final TextEditingController teacherTextController =
                            TextEditingController(
                                text: state.subject[index].subjectTeacher);
                        final TextEditingController roomNoTextController =
                            TextEditingController(
                                text: state.subject[index].roomNo);
                        final String time = state.subject[index].time;
                        final String startTime = time.split("-")[0];
                        final String endTime = time.split("-")[1];
                        CustomDialog().showCustomDialog(
                          context,
                          index,
                          daysMap[day],
                          startTime,
                          endTime,

                          subjectTextController: subjectTextController,
                          teacherTextController: teacherTextController,
                          roomNoTextController: roomNoTextController,
                          isEdit: true, // Set isEdit to true
                        );
                      }
                    },
                    child: RoutineCard(subject: state.subject[index]),
                  )
                : RoutineCard(subject: state.subject[index]);
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
