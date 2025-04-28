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

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    final bool isAmount = hintText != S.of(context).details;
    return TextField(
      enabled: !isAmount,
      //autofocus: !isAmount,
      // showCursor: !isAmount,
      // enableInteractiveSelection: !isAmount,
      // readOnly: isAmount,
      // onTap: () {
      //   if (isAmount) {
      //     FocusScope.of(context).unfocus();
      //   }
      // },
      inputFormatters:
          isAmount
              ? [
                /*FilteringTextInputFormatter.allow(RegExp(r'[0-9.<]'))*/
                AmountInputFormatter(),
              ]
              : null,
      style: textLabelStyle,
      controller: controller,
      textAlign: isRtl && isAmount ? TextAlign.end : TextAlign.start,
      // Simplify textAlign to rely on textDirection
      keyboardType: !isAmount ? TextInputType.text : null,
      maxLines: isAmount ? 1 : 2,
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
