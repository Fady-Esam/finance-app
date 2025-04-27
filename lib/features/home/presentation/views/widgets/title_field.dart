import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import 'custom_text_field.dart';

class TitleField extends StatelessWidget {
  const TitleField({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: S.of(context).details,
      color: Colors.purple,
      hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
      color: Colors.white),
      controller: titleController,
      textLabelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
