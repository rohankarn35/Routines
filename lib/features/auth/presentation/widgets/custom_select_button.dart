import 'package:flutter/material.dart';

class CustomSelectButtonWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final double height;
  final double width;

  const CustomSelectButtonWidget({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap, required this.height, required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.green.shade500 : Colors.transparent,
          side: BorderSide(color: isSelected ? Colors.greenAccent : Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
