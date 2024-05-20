import 'package:flutter/material.dart';
import 'package:routines/features/auth/presentation/widgets/customDropdown.dart';

class DropDownGroup extends StatefulWidget {
  const DropDownGroup({super.key});

  @override
  State<DropDownGroup> createState() => _DropDownGroupState();
}

class _DropDownGroupState extends State<DropDownGroup> {
  final List<String> sub = List.generate(3, (index) => 'Elective-${index + 1}');
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: sub.map((e) => CustomDropDown(title: e, list: ["list", "List"])
      ).toList()
    );
  }
}