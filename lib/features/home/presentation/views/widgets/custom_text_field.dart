import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import 'amount_input_formatter.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.controller,
    this.textLabelStyle,
  });
  final String? hintText;
  final Color? color;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextStyle? textLabelStyle;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    final bool isAmount = hintText != S.of(context).title && hintText != S.of(context).description;
    return TextField(
      enabled: !isAmount,
      inputFormatters: isAmount ? [AmountInputFormatter()] : null,
      style: textLabelStyle,
      controller: controller,
      textAlign: isRtl && isAmount ? TextAlign.end : TextAlign.start,
      keyboardType: !isAmount ? TextInputType.text : null,
      maxLines: hintText == S.of(context).description ? 3 : 1,
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
          top: isAmount ? 8 : 16,
          bottom: isAmount ? 8 : 16,
          start: 16,
          end: 8,
        ),
      ),
    );
  }
}
