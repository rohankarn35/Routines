import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:routines/core/data/subject.dart';
import 'package:routines/features/auth/presentation/widgets/customSubmitButton.dart';
import 'package:routines/features/main/presentation/pages/testUploadHIve.dart';
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

            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Text(
                  'Select Weekday',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                items: [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday'
                ]
                    .map((String day) => DropdownMenuItem<String>(
                          value: day,
                          child: Text(
                            day,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedDay,
                onChanged: (value) {
                  setState(() {
                    selectedDay = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  elevation: 2,
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black,
                  ),
                  offset: const Offset(-10, -7),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all(6),
                    thumbVisibility: MaterialStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                ),
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    daytextController.clear();
                  }
                },
              ),
            ),
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
                    onTap: () {
                      final Subject sub = Subject(
                          subject: 'Test',
                          time: '11-12',
                          subjectTeacher:
                              'Rohan Karnsdfffffffffffffffffffffffffffffffsdfffffffffffffffffffffffffffffffffffffffffffffffff',
                          roomNo: '5b-79',
                          isUserAdded: true);
                      UploadHive().uploadHive(sub, 'Tuesday');
                    }))
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
