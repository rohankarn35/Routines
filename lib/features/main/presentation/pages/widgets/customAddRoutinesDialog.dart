import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/utils/toastbar.dart';
import 'package:routines/features/auth/presentation/widgets/customSubmitButton.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';
import 'package:routines/features/main/presentation/pages/widgets/customDropDown.dart';
import 'package:routines/features/main/presentation/pages/widgets/customTextfield.dart';
import 'package:routines/features/main/presentation/pages/widgets/CustomTimePicker.dart';
import 'package:routines/features/main/presentation/pages/widgets/routineTimeWidget.dart';
import 'package:routines/features/main/presentation/utils/checkAddRoutines.dart';
import 'package:routines/features/main/presentation/utils/checkTimeAlreadyExist.dart';

class CustomAddRoutinesDialog extends StatefulWidget {
  const CustomAddRoutinesDialog({super.key});

  @override
  State<CustomAddRoutinesDialog> createState() =>
      _CustomAddRoutinesDialogState();
}

class _CustomAddRoutinesDialogState extends State<CustomAddRoutinesDialog> {
  String? day;
  final TextEditingController subjectTextController = TextEditingController();
  final TextEditingController teacherTextController = TextEditingController();
  final TextEditingController roomNoTextController = TextEditingController();
  String time = "";
  String? startTime;
  String? endTime;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    subjectTextController.dispose();
    teacherTextController.dispose();
    roomNoTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Add Routines")),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for selecting the weekday
            const SizedBox(
              height: 20,
            ),
            CustomDropDown(),
            const SizedBox(height: 16),

            // Text Box

            CustomTextField()
                .customTextField(subjectTextController, 'Enter Subject Name'),
            const SizedBox(
              height: 20,
            ),

            CustomTextField()
                .customTextField(teacherTextController, 'Enter Teacher Name'),
            const SizedBox(
              height: 20,
            ),

            CustomTextField()
                .customTextField(roomNoTextController, 'Enter RoomNo'),

            const SizedBox(
              height: 20,
            ),

            Center(
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
                child: Routinetimewidget(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Center(
              child: BlocListener<RoutineBloc, RoutineState>(
                listener: (context, state) {
                  if (state is RoutineStartTimeSelectedState) {
                    startTime = state.startTime;
                  }
                  if (state is RoutineEndTimeSelectedState) {
                    endTime = state.endTime;
                  }
                  if (state is RoutineChangeDropDownValueState) {
                    day = state.day;
                  }
                },
                child: CustomSubmitButton(
                  title: "Submit",
                  onTap: () {
                    time = "$startTime-$endTime";

                    Map<String, dynamic> status = checkAddRoutines(
                        teacherName: teacherTextController.text.trim(),
                        subjectName: subjectTextController.text.trim(),
                        roomNo: roomNoTextController.text.trim(),
                        time: time,
                        day: day);

                    // print(startTime);
                    // print(endTime);

                    if (checkTimeAlreadyExist(
                        day ?? "", startTime ?? "", endTime ?? "")) {
                      if (startTime != null && endTime != null) {
                        if (status['status']) {
                          final String _day =
                              day!.substring(0, 3).toUpperCase();

                          final Subject sub = Subject(
                            subject: subjectTextController.text.trim(),
                            time: time,
                            subjectTeacher: subjectTextController.text.trim(),
                            roomNo: roomNoTextController.text.trim(),
                          );
                          context.read<RoutineBloc>().add(
                              RoutineUploadToHiveEvent(
                                  subject: sub, day: _day));

                          Navigator.pop(context);
                        } else {
                          showToast(status['message'], Colors.red);
                        }
                      } else {
                        showToast("Select the time", Colors.red);
                      }
                    } else {
                      showToast(
                          "The time slot you selected overlaps with an existing class. Please choose a different time.",
                          Colors.red);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomDialog {
  void showCustomDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Animate(effects: [
          const MoveEffect(begin: Offset(0, -20)),
          const FadeEffect()
        ], child: const CustomAddRoutinesDialog());
      },
    );
  }
}
