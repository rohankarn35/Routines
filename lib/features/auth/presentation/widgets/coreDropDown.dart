import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routines/features/auth/presentation/widgets/customDropdown.dart';

class Coredropdown extends StatefulWidget {
  const Coredropdown({
    super.key,
  });

  @override
  State<Coredropdown> createState() => _CoredropdownState();
}

class _CoredropdownState extends State<Coredropdown> {
  int number = 0;
  String branch = "";
  List<String> sub = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSectionNameSelectedState) {
          // print("Your selected section is ${state.sectionName}");
        }
        if (state is AuthBranchButton) {
          branch = state.branch;
        }
      },
      builder: (context, state) {
        if (state is AuthBranchAndYearSelectedState) {
          number = state.numbers[0];

          if (branch.isNotEmpty && number > 0) {
            sub = List.generate(number, (index) => '$branch-${index + 1}');
          }

          return CustomDropDown(
            title: "Select Core Section",
            list: sub,
            onChanged: (value) {
              print("Value of ${value}");
            },
          );
        }

        return CustomDropDown(
          title: "Select Core Section",
          list: sub,
          onChanged: (value) {
            print("Core section ${value}");
          },
        );
      },
    );
  }
}
