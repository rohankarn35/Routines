import 'package:flutter/material.dart';

class CustomSelectButtonWidget extends StatefulWidget {
  final String title;
  const CustomSelectButtonWidget({super.key, required this.title});

  @override
  State<CustomSelectButtonWidget> createState() =>
      _CustomSelectButtonWidgetState();
}

class _CustomSelectButtonWidgetState extends State<CustomSelectButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        height: 50,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            textStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {},
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ));
  }
}
