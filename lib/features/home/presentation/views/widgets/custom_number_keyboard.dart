import 'package:flutter/material.dart';

import 'custom_key_board_item.dart';

class CustomNumberKeyboard extends StatefulWidget {
  const CustomNumberKeyboard({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  State<CustomNumberKeyboard> createState() => _CustomNumberKeyboardState();
}

class _CustomNumberKeyboardState extends State<CustomNumberKeyboard> {
  String getButtonNumber(int index) {
    if (index >= 0 && index <= 2) return (index + 7).toString();
    if (index >= 3 && index <= 5) return (index + 1).toString();
    if (index >= 6 && index <= 8) return (index - 5).toString();
    if (index == 9) return '.';
    if (index == 10) return '0';
    if (index == 11) return '<';
    return '';
  }

void handleKeyTap(String digit) {
    String currentText = widget.amountController.text;
    if (digit == '<') {
      if (currentText.isNotEmpty) {
        currentText = currentText.substring(0, currentText.length - 1);
      }
    } else {
      if (digit == '.') {
        if (currentText.contains('.')) {
          return; // Already has a dot, don't allow another one
        }
        if (currentText.isEmpty) {
          currentText = '0'; // Auto add '0' before dot if empty
        }
      } else {
        if (currentText.contains('.')) {
          int dotIndex = currentText.indexOf('.');
          if (currentText.length - dotIndex > 2) {
            return; // Already has 2 digits after dot
          }
        }
      }
      currentText += digit;
    }

    widget.amountController.text = currentText;
    widget.amountController.selection = TextSelection.fromPosition(
      TextPosition(offset: currentText.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.3,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        String digit = getButtonNumber(index);
        return GestureDetector(
          onTap: () {
            setState(() {
              handleKeyTap(digit);
            });
          },
          child: CustomKeyBoardItem(textNum: digit),
        );
      },
    );
  }
}
