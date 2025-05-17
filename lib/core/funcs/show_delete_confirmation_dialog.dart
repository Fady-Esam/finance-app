import 'package:flutter/material.dart';

import '../../features/home/presentation/views/widgets/custom_manage_finance_button.dart';
import '../../generated/l10n.dart';

Future<void> showDeleteConfirmationDialog(
  BuildContext context,
  String confirmationTex, {
  required bool Function() onCancel,
  required Future<bool> Function() onConfirm,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          S.of(context).confirm_delete,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(confirmationTex),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomManageFinanceButton(
                  text: S.of(context).cancel,
                  color: const Color.fromARGB(255, 159, 210, 252),
                  onPressed: onCancel,
                  fontSize: 14,
                  horizontalPadding: 8,
                  verticalPadding: 4,
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: CustomManageFinanceButton(
                  text: S.of(context).delete,
                  color: const Color.fromARGB(255, 244, 119, 161),
                  onPressed: onConfirm,
                  fontSize: 14,
                  horizontalPadding: 8,
                  verticalPadding: 4,
                ),
              ),
            ],
          ),
          // TextButton(
          //   onPressed: () => onCancel(),
          //   child: Text(S.of(context).cancel),
          // ),
          // ElevatedButton(
          //   onPressed: () => onConfirm(),
          //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          //   child:  Text(S.of(context).delete),
          // ),
        ],
      );
    },
  );
}
