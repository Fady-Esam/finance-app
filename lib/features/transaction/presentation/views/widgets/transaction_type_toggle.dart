import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';

class TransactionTypeToggle extends StatelessWidget {
  final ValueChanged<bool?> onTransactionTypeChanged;

  const TransactionTypeToggle({
    super.key,
    required this.onTransactionTypeChanged,
    required this.selectedTransactionType,
  });
  final bool? selectedTransactionType;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => onTransactionTypeChanged(null),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue,
              backgroundColor:
                  selectedTransactionType == null
                      ? Colors.blue.shade100
                      : Colors.white,
            ),
            child: Text(S.of(context).all),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () => onTransactionTypeChanged(true),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.green,
              backgroundColor:
                  selectedTransactionType == true
                      ? Colors.green.shade100
                      : Colors.white,
            ),
            child: Text(S.of(context).income),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () => onTransactionTypeChanged(false),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.red,
              backgroundColor:
                  selectedTransactionType == false
                      ? Colors.red.shade100
                      : Colors.white,
            ),
            child: Text(S.of(context).expense),
          ),
        ),
      ],
    );
  }
}
