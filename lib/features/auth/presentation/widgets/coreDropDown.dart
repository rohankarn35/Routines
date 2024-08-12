import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  @override
  void dispose() {
    _textEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final TextEditingController _textEditingController = TextEditingController();
  int number = 0;
  String branch = "";
  List<String> sub = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthBranchButton) {
          branch = state.branch;
        }
        if (state is AuthYearButton) {}
        if (state is AuthBranchAndYearSelectedState) {
          number = state.numbers[0];
          sub = List.generate(number, (index) => '$branch-${index + 1}');
        }
      },
      builder: (context, state) {
        return number > 0
            ? Animate(
                effects: [MoveEffect(), FadeEffect()],
                child: CustomDropDown(
                  title: "Select Core Section",
                  list: sub,
                  onChanged: (value) {
                    context
                        .read<AuthBloc>()
                        .add(AuthCoreSectionDetailsEvent(coreSection: value));
                  },
                  textEditingController: _textEditingController,
                ),
              )
            : SizedBox();
      },
    );
  }
}
