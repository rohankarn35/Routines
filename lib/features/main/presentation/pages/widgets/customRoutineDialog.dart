import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/core/utils/toastbar.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';
import 'package:routines/features/main/presentation/pages/widgets/customDropDown.dart';
import 'package:routines/features/main/presentation/pages/widgets/customSubmitButton.dart';
import 'package:routines/features/main/presentation/pages/widgets/customTextfield.dart';
import 'package:routines/features/main/presentation/pages/widgets/routineTimeWidget.dart';
import 'package:routines/features/main/presentation/utils/checkAddRoutines.dart';
import 'package:routines/features/main/presentation/utils/checkTimeAlreadyExist.dart';

class CustomAddRoutinesDialog extends StatefulWidget {
  final TextEditingController subjectTextController;
  final TextEditingController teacherTextController;
  final TextEditingController roomNoTextController;
  final String? startTime;
  final String? endTime;
  final String? selectedDay;
  final bool isEdit;
  final int? index;

  const CustomAddRoutinesDialog({
    super.key,
    required this.subjectTextController,
    required this.teacherTextController,
    required this.roomNoTextController,
    this.selectedDay,
    required this.isEdit,
    this.startTime,
    this.endTime,
    this.index,
  });

  @override
  State<CustomAddRoutinesDialog> createState() =>
      _CustomAddRoutinesDialogState();
}

class _CustomAddRoutinesDialogState extends State<CustomAddRoutinesDialog> {
  String? day;
  late TextEditingController subjectTextController;
  late TextEditingController teacherTextController;
  late TextEditingController roomNoTextController;
  String time = "";
  String? startTime;
  String? endTime;

  @override
  void initState() {
    super.initState();
    subjectTextController = widget.subjectTextController;
    teacherTextController = widget.teacherTextController;
    roomNoTextController = widget.roomNoTextController;
    startTime = widget.startTime;
    endTime = widget.endTime;
    day = widget.selectedDay;
  }

  @override
  void dispose() {
    super.dispose();
    subjectTextController.dispose();
    teacherTextController.dispose();
    roomNoTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: !widget.isEdit ? Text("Add Routines") : Text("Edit Routines")),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CustomDropDown(selectedDay: day),
            const SizedBox(height: 16),
            CustomTextField()
                .customTextField(subjectTextController, 'Enter Subject Name'),
            const SizedBox(height: 20),
            CustomTextField()
                .customTextField(teacherTextController, 'Enter Teacher Name'),
            const SizedBox(height: 20),
            CustomTextField()
                .customTextField(roomNoTextController, 'Enter Room No'),
            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                child:
                    Routinetimewidget(startTime: startTime, endTime: endTime),
              ),
            ),
            const SizedBox(height: 20),
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
                      day: day,
                    );
                    if (checkTimeAlreadyExist(day ?? "", startTime ?? "",
                        endTime ?? "", widget.index)) {
                      if (startTime != null && endTime != null) {
                        if (status['status']) {
                          final String _day =
                              day!.substring(0, 3).toUpperCase();
                          final Subject sub = Subject(
                            subject: subjectTextController.text.trim(),
                            time: time,
                            subjectTeacher: teacherTextController.text.trim(),
                            roomNo: roomNoTextController.text.trim(),
                          );
                          !widget.isEdit
                              ? context.read<RoutineBloc>().add(
                                    RoutineUploadToHiveEvent(
                                        subject: sub, day: _day),
                                  )
                              : context.read<RoutineBloc>().add(
                                    RoutineEditFromHiveEvent(
                                        sub: sub,
                                        index: widget.index ?? 0,
                                        day: _day),
                                  );

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
                        Colors.red,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog {
  void showCustomDialog(
    BuildContext context,
    final int? index,
    final String? selectedDay,
    final String? startTime,
    final String? endTime, {
    required TextEditingController subjectTextController,
    required TextEditingController teacherTextController,
    required TextEditingController roomNoTextController,
    bool isEdit = false,
  }) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Animate(
          effects: [
            const MoveEffect(begin: Offset(0, -20)),
            const FadeEffect(),
          ],
          child: CustomAddRoutinesDialog(
            subjectTextController: subjectTextController,
            teacherTextController: teacherTextController,
            roomNoTextController: roomNoTextController,
            selectedDay: selectedDay,
            isEdit: isEdit,
            startTime: startTime,
            endTime: endTime,
            index: index,
          ),
        );
      },
    );
  }
}
