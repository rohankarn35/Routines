import 'package:flutter/material.dart';
import 'package:routines/features/main/presentation/pages/widgets/CustomTimePicker.dart';

class Routinetimewidget extends StatefulWidget {
  const Routinetimewidget({super.key});

  @override
  State<Routinetimewidget> createState() => _RoutinetimewidgetState();
}

class _RoutinetimewidgetState extends State<Routinetimewidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTimePicker(
            title: 'Start Time',
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 30),
          ),
          CustomTimePicker(
            title: 'End Time',
          )
        ],
      ),
    );
  }
}
