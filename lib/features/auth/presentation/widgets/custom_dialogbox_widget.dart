import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routines/features/auth/presentation/widgets/buttonselect.dart';

class CustomDialog {
  final List<String> branches = ['CSE', 'CSSE', 'CSCE', 'IT'];
  final List<String> years = ['2nd Year', '3rd Year'];
  bool isYearSelected = false;
  bool isBranchSelected = false;
  bool isWrapSelected = false;

  void customDialog(BuildContext context) {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
      title: 'Setup Your Routines',
      titleStyle: const TextStyle(fontSize: 20),
      content: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthYearButton) {
            print("Dialog selected title: ${state.year}");
          }
          if (state is AuthBranchButton) {
            print("Selected Year ${state.branch}");
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
                // DropDownGroup(),
              ],
            ),
          );
        },
      ),
    );
  }
}
