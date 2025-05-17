import 'package:finance_flutter_app/core/widgets/delete_confirmation_dialog_widget.dart';
import 'package:flutter/material.dart';

Future<bool?> showDeleteConfirmationDialog(
  BuildContext context,
  String confirmationText, {
  required bool Function() onCancel,
  required Future<bool> Function() onConfirm,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => DeleteConfirmationDialogWidget(
          confirmationText: confirmationText,
          onCancel: onCancel,
          onConfirm: onConfirm,
        ),
  );
}
