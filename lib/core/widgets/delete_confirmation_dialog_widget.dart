import 'package:flutter/material.dart';

import '../../features/home/presentation/views/widgets/custom_manage_finance_button.dart';
import '../../generated/l10n.dart';

class DeleteConfirmationDialogWidget extends StatefulWidget {
  final String confirmationText;
  final bool Function() onCancel;
  final Future<bool> Function() onConfirm;

  const DeleteConfirmationDialogWidget({
    super.key,
    required this.confirmationText,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<DeleteConfirmationDialogWidget> createState() =>
      _DeleteConfirmationDialogWidgetState();
}

class _DeleteConfirmationDialogWidgetState
    extends State<DeleteConfirmationDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        S.of(context).confirm_delete,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(widget.confirmationText),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomManageFinanceButton(
                text: S.of(context).cancel,
                color: const Color.fromARGB(255, 159, 210, 252),
                onPressed: widget.onCancel,
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
                onPressed: () async => await widget.onConfirm(),
                fontSize: 14,
                horizontalPadding: 8,
                verticalPadding: 4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
