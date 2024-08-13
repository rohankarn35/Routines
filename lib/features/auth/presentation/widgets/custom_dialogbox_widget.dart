import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routines/features/auth/presentation/widgets/buttonselect.dart';
import 'package:routines/features/auth/presentation/widgets/coreDropDown.dart';
import 'package:routines/features/auth/presentation/widgets/customSubmitButton.dart';
import 'package:routines/features/auth/presentation/widgets/droupdowngroup.dart';

class CustomDialogContent extends StatefulWidget {
  @override
  _CustomDialogContentState createState() => _CustomDialogContentState();
}

class _CustomDialogContentState extends State<CustomDialogContent> {
  final List<String> branches = ['CSE', 'CSSE', 'CSCE', 'IT'];
  final List<String> years = ['2nd Year', '3rd Year'];
  bool isWrapSelected = false;
  String year = "";
  String branch = "";
  String coreSection = "";
  List<String> electiveDetails = [];
  int num = 0;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
      title: Center(child: Text("Setup Routines")),
      content: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthYearButton) {
              isActive = false;
              coreSection = "";
              if (state.year == "2nd Year") {
                year = "second";
              } else if (state.year == "3rd Year") {
                year = "third";
              }

              if (year.isNotEmpty && branch.isNotEmpty) {
                context.read<AuthBloc>().add(
                    AuthBranchAndYearSelectedEvent(branch: branch, year: year));
              }
            } else if (state is AuthBranchButton) {
              isActive = false;
              electiveDetails.clear();
              coreSection = "";
              branch = state.branch;

              context.read<AuthBloc>().add(
                  AuthBranchAndYearSelectedEvent(branch: branch, year: year));
            } else if (state is AuthButtonSelectIsWrapState) {
              isWrapSelected = state.isWrap;
            } else if (state is AuthBranchAndYearSelectedState) {
              num = state.numbers[1];
            } else if (state is AuthCoreSectionDetailsState) {
              coreSection = state.coreSection;
            } else if (state is AuthElectiveSectionDetailsState) {
              if (num == state.electiveList.length) {
                electiveDetails = state.electiveList;
              }
            }
            if (coreSection.isNotEmpty && electiveDetails.length == num) {
              isActive = true;
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
                isWrapSelected
                    ? const SizedBox(
                        height: 20,
                      )
                    : SizedBox(),
                isWrapSelected
                    ? ButtonSelectionGroup(
                        titles: branches,
                        onSelect: (selectedBranch) {
                          context
                              .read<AuthBloc>()
                              .add(AuthBranchClicked(branch: selectedBranch));
                        },
                        height: 50,
                        width: 120,
                        isWrap: true,
                      )
                    : const SizedBox(
                        height: 0,
                      ),
                const SizedBox(
                  height: 20,
                ),
                Animate(
                    effects: [FadeEffect(), MoveEffect()],
                    child: Coredropdown()),
                DropDownGroup(),
                isActive
                    ? SizedBox(
                        height: 20,
                      )
                    : SizedBox(),
                isActive
                    ? Animate(
                        effects: [FadeEffect(), MoveEffect()],
                        child: CustomSubmitButton(
                          title: "Submit",
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "/config",
                                arguments: {
                                  "year": year,
                                  "coreSection": coreSection,
                                  "electiveDetails": electiveDetails
                                });
                          },
                        ),
                      )
                    : SizedBox()
              ],
            );
          },
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
        return Animate(
            effects: [MoveEffect(begin: Offset(0, -20))],
            child: CustomDialogContent());
      },
    );
  }
}
