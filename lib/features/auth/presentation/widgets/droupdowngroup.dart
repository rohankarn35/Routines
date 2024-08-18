import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  String branch = "";
  String year = "";
  List<String> electivesub = [];
  List<String> electiveDetails = [];
  final TextEditingController _textEditingController = TextEditingController();

  Map<String, dynamic> electiveMap = {};
  Map<String, Map<String, dynamic>> electivelist = {};
  int num = 0;
  int electiveprogress = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthBranchButton) {
          electiveprogress = 0;
          electiveDetails.clear();
          branch = state.branch;
        }
        if (state is AuthYearButton) {
          electiveprogress = 0;
          electiveDetails.clear();

          year = state.year;
        }
        if (state is AuthBranchAndYearSelectedState) {
          // num = 0;
          num = state.numbers[1];
          if (num != 0) {
            electiveDetails = List.filled(num, "");

            for (int i = 0; i < num; i++) {
              context.read<AuthBloc>().add(AuthGetElectiveSubjectsEvent(
                  branch: branch, year: year, elective: "elective${i + 1}"));
              sub = List.generate(num, (index) => 'Elective-${index + 1}');
              electiveMap = {for (var e in sub) e: ""};
            }
          }
        }
        if (state is AuthGetElectiveSubjectsState) {
          electivelist["Elective-${electiveprogress + 1}"] =
              state.electiveDetails;
          electiveprogress++;
          // print(state.electiveDetails);
        }
      },
      builder: (context, state) {
        return num > 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: sub
                    .map((e) => Animate(
                          effects: [FadeEffect(), MoveEffect()],
                          child: CustomDropDown(
                            electiveMap: electivelist[e],
                            title: e,
                            list: electivelist[e]!.keys.toList(),
                            onChanged: (value) {
                              electiveMap[e] = value;
                              electiveDetails[sub.indexOf(e)] = value;
                              context.read<AuthBloc>().add(
                                  AuthElectiveSectionDetailsEvent(
                                      electiveDetails: electiveMap));
                            },
                            textEditingController: _textEditingController,
                          ),
                        ))
                    .toList())
            : SizedBox();
      },
    );
  }
}
