import 'package:flutter/material.dart';
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
                  setState(() {
                    selectedTitle = title;
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
                  setState(() {
                    selectedTitle = title;
                  });
                  widget.onSelect(title);
                },
              );
            }).toList(),
          );
  }
}
