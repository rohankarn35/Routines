import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color buttonColor;
  final Color textColor;

  const CustomSubmitButton({
    super.key,
    required this.title,
    required this.onTap,
    this.buttonColor = Colors.white, // Default button color
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 150,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Adjust radius as needed
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          textStyle: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
