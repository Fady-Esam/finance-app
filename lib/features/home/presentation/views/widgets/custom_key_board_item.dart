import 'package:flutter/material.dart';

class CustomKeyBoardItem extends StatelessWidget {
  const CustomKeyBoardItem({super.key, required this.textNum});
  final String textNum;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 56, 52, 52),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          textNum,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
