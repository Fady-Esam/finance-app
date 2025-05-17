import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/views/widgets/custom_manage_finance_button.dart';

void showNameDialog(
  BuildContext context,
  TextEditingController controller,
  void Function()? onPressed,
  GlobalKey<FormState>? key,
  AutovalidateMode autovalidateMode,
  String? Function(String?)? validator,
) async {
  await showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(S.of(context).edit_name),
          content: Form(
            key: key,
            autovalidateMode: autovalidateMode,
            child: TextFormField(
              controller: controller,
              validator: validator,
              //decoration: InputDecoration(labelText: S.of(context).name),
              autofocus: true,
              decoration: InputDecoration(
                labelText: S.of(context).name,
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFB0BEC5),
                    width: 1.2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.greenAccent,
                    width: 1.2,
                  ),
                ),
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomManageFinanceButton(
                    text: S.of(context).cancel,
                    color: const Color.fromARGB(255, 244, 119, 161),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    fontSize: 16,
                    horizontalPadding: 8,
                    verticalPadding: 4,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomManageFinanceButton(
                    text: S.of(context).save,
                    color: const Color.fromARGB(255, 159, 210, 252),
                    onPressed: onPressed,
                    fontSize: 16,
                    horizontalPadding: 8,
                    verticalPadding: 4,
                  ),
                ),
              ],
            ),
          ],
        ),
  );
}
