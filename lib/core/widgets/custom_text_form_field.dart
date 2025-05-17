import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusNode,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final FocusNode? focusNode;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsetsDirectional.only(
          start: 15,
          bottom: 0,
          top: 0,
        ),
        suffixIcon: suffixIcon,
        hintText: hintText,
        filled: true,
        hintStyle: const TextStyle(fontSize: 16),
        border: border,
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        errorBorder: errorBorder,
      ),
      validator: validator,
    );
  }
}
