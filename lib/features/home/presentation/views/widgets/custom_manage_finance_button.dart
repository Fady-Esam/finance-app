import 'package:flutter/material.dart';

class CustomManageFinanceButton extends StatelessWidget {
  const CustomManageFinanceButton({
    super.key,
    required this.text,
    required this.color,
    this.onPressed,
    this.fontSize = 16,
    this.horizontalPadding = 0.0,
  });
  final String text;
  final Color color;
  final void Function()? onPressed;
  final double fontSize;
  final double horizontalPadding;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding:  EdgeInsets.symmetric(vertical: 8, horizontal: horizontalPadding,
        ),
        backgroundColor: color, // Subtle background
        textStyle:  TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Color.fromARGB(255, 43, 75, 44),
          ),
        ),
      ),
    );
  }
}
