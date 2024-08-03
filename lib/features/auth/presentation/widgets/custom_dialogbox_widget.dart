import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routines/features/auth/presentation/widgets/buttonselect.dart';
import 'package:routines/features/auth/presentation/widgets/coreDropDown.dart';
import 'package:routines/features/auth/presentation/widgets/droupdowngroup.dart';

class CustomDialog {
  final List<String> branches = ['CSE', 'CSSE', 'CSCE', 'IT'];
  final List<String> years = ['2nd Year', '3rd Year'];
  bool isWrapSelected = false;
  String year = "";
  String branch = "";

  void customDialog(BuildContext context) {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
      title: 'Setup Your Routines',
      titleStyle: const TextStyle(fontSize: 20),
      content: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthYearButton) {
            // print("Dialog selected title: ${state.year}");
            // year = state.year;
            if (state.year == "2nd Year") {
              year = "second";
            } else if (state.year == "3rd Year") {
              year = "third";
            }

            if (year.isNotEmpty && branch.isNotEmpty) {
              context.read<AuthBloc>().add(
                  AuthBranchAndYearSelectedEvent(branch: branch, year: year));
            }
          }
          if (state is AuthBranchButton) {
            // print("Selected Year ${state.branch}");
            branch = state.branch;

            context.read<AuthBloc>().add(
                AuthBranchAndYearSelectedEvent(branch: branch, year: year));
          }
          if (state is AuthButtonSelectIsWrapState) {
            isWrapSelected = state.isWrap;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonSelectionGroup(
                  titles: years,
                  onSelect: (selectedYear) {
                    context
                        .read<AuthBloc>()
                        .add(AuthYearButtonClicked(year: selectedYear));
                  },
                  height: 50,
                  width: 120,
                ),
                const SizedBox(
                  height: 20,
                ),
                isWrapSelected
                    ? ButtonSelectionGroup(
                        titles: branches,
                        onSelect: (selectedBranch) {
                          context
                              .read<AuthBloc>()
                              .add(AuthBranchClicked(branch: selectedBranch));
                        },
                        height: 50,
                        width: 100,
                        isWrap: true,
                      )
                    : SizedBox(
                        height: 0,
                      ),
                const SizedBox(
                  height: 20,
                ),
                Coredropdown(),
                DropDownGroup()
              ],
            ),
          );
        },
      ),
    );
  }
}
