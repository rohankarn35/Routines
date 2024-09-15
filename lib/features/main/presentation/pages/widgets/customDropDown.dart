import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/features/main/presentation/bloc/routine_bloc.dart';

class CustomDropDown extends StatefulWidget {
  final String? selectedDay;
  const CustomDropDown({super.key, this.selectedDay});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final TextEditingController dayTextController = TextEditingController();
  String? selectedDay;

  @override
  void initState() {
    super.initState();
    print(widget.selectedDay);
    selectedDay = widget.selectedDay;
  }

  @override
  void dispose() {
    dayTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: BlocConsumer<RoutineBloc, RoutineState>(
        listener: (context, state) {
          if (state is RoutineChangeDropDownValueState) {
            setState(() {
              selectedDay = state.day;
            });
          }
        },
        builder: (context, state) {
          return DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              selectedDay ??
                  'Select Weekday', // Display selected day if not null, else "Select Weekday"
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            items: [
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday'
            ]
                .map((String day) => DropdownMenuItem<String>(
                      value: day,
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedDay,
            onChanged: (value) {
              context
                  .read<RoutineBloc>()
                  .add(RoutineChangeDropDownValueEvent(day: value));
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.transparent,
                ),
                color: Colors.grey.withOpacity(0.2),
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.black,
              ),
              offset: const Offset(-10, -7),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                dayTextController.clear();
              }
            },
          );
        },
      ),
    );
  }
}
