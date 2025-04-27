import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import 'amount_input_formatter.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.color,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.controller,
    this.textLabelStyle,
  });
  final String hintText;
  final Color color;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextStyle? textLabelStyle;

  // Creating a FocusNode
  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters:
          hintText != S.of(context).details
              ? [
                /*FilteringTextInputFormatter.allow(RegExp(r'[0-9.<]'))*/ AmountInputFormatter(),
              ]
              : null,
      controller: controller,
      style: textLabelStyle,
      textAlign:  Directionality.of(context) == TextDirection.rtl && hintText != S.of(context).details ? TextAlign.end : TextAlign.start,
      keyboardType:
          hintText == S.of(context).details
              ? TextInputType.text
              : TextInputType.numberWithOptions(decimal: true),
      maxLines: hintText == S.of(context).details ? 2 : 1,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: color,
        hintStyle: hintStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsetsDirectional.only(
          top: 24,
          bottom: 24,
          start: 32,
          end: 16,
        ),
      ),
    );
  }
}
