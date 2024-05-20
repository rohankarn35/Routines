import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routines/features/auth/presentation/widgets/buttonselect.dart';
import 'package:routines/features/auth/presentation/widgets/customDropdown.dart';
import 'package:routines/features/auth/presentation/widgets/droupdowngroup.dart';

class CustomDialog {
  final List<String> branches = ['CSE', 'CSSE', 'CSCE', 'IT'];
  final List<String> years = ['2nd Year', '3rd Year'];
    final List<List<String>> subjects = [
    ['Maths', 'Science', 'History'],
    ['Physics', 'Chemistry', 'Biology']
  ];
  final List<List<String>> teachers = [
    ['Mr. A', 'Ms. B', 'Mr. C'],
    ['Ms. D', 'Mr. E', 'Ms. F']
  ];

  customDialog() {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
      title: 'Setup Your Routines',
      titleStyle: const TextStyle(fontSize: 20),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonSelectionGroup(
              height: 50,
              width: 120,
              titles: years,
              onSelect: (selectedYear) {
                print('Selected Year: $selectedYear');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonSelectionGroup(
              height: 50,
              width: 100,
              titles: branches,
              isWrap: true,
              onSelect: (selectedBranch) {
                print('Selected Branch: $selectedBranch');
              },
            ),
            CustomDropDown(title: "title", list: branches),
            DropDownGroup()
          ],
        ),
      ),
    );
  }
}
