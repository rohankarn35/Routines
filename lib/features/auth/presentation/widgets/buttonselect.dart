import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routines/features/auth/presentation/widgets/custom_select_button.dart';

class ButtonSelectionGroup extends StatefulWidget {
  final List<String> titles;
  final void Function(String) onSelect;
  final double height;
  final double width;
  final bool isWrap;

  const ButtonSelectionGroup({
    Key? key,
    required this.titles,
    required this.onSelect,
    required this.height,
    required this.width,
    this.isWrap = false,
  }) : super(key: key);

  @override
  _ButtonSelectionGroupState createState() => _ButtonSelectionGroupState();
}

class _ButtonSelectionGroupState extends State<ButtonSelectionGroup> {
  String? selectedTitle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthButtonGroupSelected) {
          selectedTitle = state.title;
        }

        return widget.isWrap
            ? Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children: widget.titles.map((title) {
                  bool isSelected = title == selectedTitle;
                  return CustomSelectButtonWidget(
                    height: widget.height,
                    width: widget.width,
                    title: title,
                    isSelected: isSelected,
                    onTap: () {
                      context
                          .read<AuthBloc>()
                          .add(AuthButtonSelectionGroupSelected(title: title));

                      setState(() {
                        if (title == "2nd Year") {
                          selectedTitle = "second";
                        }
                        if (title == "3rd Year") {
                          selectedTitle = "third";
                        }
                      });
                      widget.onSelect(title);
                    },
                  );
                }).toList(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: widget.titles.map((title) {
                  bool isSelected = title == selectedTitle;
                  return CustomSelectButtonWidget(
                    height: widget.height,
                    width: widget.width,
                    title: title,
                    isSelected: isSelected,
                    onTap: () {
                      context
                          .read<AuthBloc>()
                          .add(AuthButtonSelectIsWrapEvent(isWrap: true));
                      context
                          .read<AuthBloc>()
                          .add(AuthButtonSelectionGroupSelected(title: title));
                      setState(() {
                        selectedTitle = title;
                      });
                      widget.onSelect(title);
                    },
                  );
                }).toList(),
              );
      },
    );
  }
}
