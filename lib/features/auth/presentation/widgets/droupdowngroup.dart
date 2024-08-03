import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routines/features/auth/presentation/widgets/customDropdown.dart';

class DropDownGroup extends StatefulWidget {
  const DropDownGroup({super.key});

  @override
  State<DropDownGroup> createState() => _DropDownGroupState();
}

class _DropDownGroupState extends State<DropDownGroup> {
  List<String> sub = [];
  Map<String, String> electiveMap = {};
  int num = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthBranchAndYearSelectedState) {
          num = state.numbers[1];
          sub = List.generate(num, (index) => 'Elective-${index + 1}');

          electiveMap = {for (var e in sub) e: ""};

          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: sub
                  .map((e) => CustomDropDown(
                        title: e,
                        list: ["list", "List"],
                        onChanged: (value) {
                          electiveMap[e] = value;
                        },
                      ))
                  .toList());
        }
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: sub
                .map((e) => CustomDropDown(
                      title: e,
                      list: ["list", "List"],
                      onChanged: (value) {
                        electiveMap[e] = value;
                        print(electiveMap);
                      },
                    ))
                .toList());
      },
    );
  }
}
