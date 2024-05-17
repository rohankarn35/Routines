import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routines/features/auth/presentation/widgets/customDropdown.dart';
import 'package:routines/features/auth/presentation/widgets/custom_select_button.dart';

class CustomDialog {
  final List<String> branches = ['CSE', 'CSSE', 'CSCE', 'IT'];

  customDialog() {
    return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
      title: 'Setup Your Routines',
      titleStyle: const TextStyle(fontSize: 20),
      content: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomSelectButtonWidget(
                title: '2nd Year',
              ),
              CustomSelectButtonWidget(
                title: '3rd Year',
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          CustomDropDown(
            title: "Branch",
            list: branches,
          ),
        ],
      ),
    );
  }
}
