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
  String coreSection = "";
  List<String> electiveDetails = [];
  int num = 0;

  void customDialog(BuildContext context) {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
      title: 'Setup Your Routines',
      titleStyle: const TextStyle(fontSize: 20),
      content: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthYearButton) {
            coreSection = "";
            if (state.year == "2nd Year") {
              year = "second";
            }
            if (state.year == "3rd Year") {
              year = "third";
            }

            if (year.isNotEmpty && branch.isNotEmpty) {
              context.read<AuthBloc>().add(
                  AuthBranchAndYearSelectedEvent(branch: branch, year: year));
            }
          }
          if (state is AuthBranchButton) {
            electiveDetails.clear();
            coreSection = "";

            branch = state.branch;

            context.read<AuthBloc>().add(
                AuthBranchAndYearSelectedEvent(branch: branch, year: year));
          }
          if (state is AuthButtonSelectIsWrapState) {
            isWrapSelected = state.isWrap;
          }
          if (state is AuthBranchAndYearSelectedState) {
            num = state.numbers[1];
          }

          if (state is AuthCoreSectionDetailsState) {
            coreSection = state.coreSection;
          }
          if (state is AuthElectiveSectionDetailsState) {
            if (num == state.electiveList.length) {
              electiveDetails = state.electiveList;
            }
          }
        },
        builder: (context, state) {
          return Column(
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
                  : const SizedBox(
                      height: 0,
                    ),
              const SizedBox(
                height: 20,
              ),
              Coredropdown(),
              DropDownGroup(),
            ],
          );
        },
      ),
    );
  }
}
