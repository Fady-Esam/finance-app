import 'package:flutter/material.dart';

class CustomManageFinanceButton extends StatelessWidget {
  const CustomManageFinanceButton({
    super.key,
    required this.text,
    required this.color,
    this.onPressed,
  });
  final String text;
  final Color color;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8),
        backgroundColor: color, // Subtle background
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 43, 75, 44),
          ),
        ),
      ),
    );
  }
}
