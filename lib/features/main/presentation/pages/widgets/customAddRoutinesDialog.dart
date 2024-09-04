import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/features/auth/presentation/widgets/customSubmitButton.dart';
import 'package:routines/features/main/presentation/pages/widgets/customDropDown.dart';
import 'package:routines/features/main/presentation/pages/widgets/customTextfield.dart';
import 'package:routines/features/main/presentation/pages/widgets/CustomTimePicker.dart';
import 'package:routines/features/main/presentation/pages/widgets/routineTimeWidget.dart';

class CustomAddRoutinesDialog extends StatefulWidget {
  const CustomAddRoutinesDialog({super.key});

  @override
  State<CustomAddRoutinesDialog> createState() =>
      _CustomAddRoutinesDialogState();
}

class _CustomAddRoutinesDialogState extends State<CustomAddRoutinesDialog> {
  String? selectedDay;
  final TextEditingController subjectTextController = TextEditingController();
  final TextEditingController teacherTextController = TextEditingController();
  final TextEditingController roomNoTextController = TextEditingController();
  final TextEditingController daytextController = TextEditingController();

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
                .customTextField(TextEditingController(), 'Enter Subject Name'),
            const SizedBox(
              height: 20,
            ),

            CustomTextField()
                .customTextField(TextEditingController(), 'Enter Teacher Name'),
            const SizedBox(
              height: 20,
            ),

            CustomTextField()
                .customTextField(TextEditingController(), 'Enter RoomNo'),

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
                child: const Routinetimewidget(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Center(
              child: CustomSubmitButton(
                title: "Submit",
                onTap: () {},
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
