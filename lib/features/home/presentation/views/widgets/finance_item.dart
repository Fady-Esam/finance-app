import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../../../data/models/finance_item_model.dart';

class FinanceItem extends StatelessWidget {
  const FinanceItem({super.key, required this.financeItemModel});
  final FinanceItemModel financeItemModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor:
            financeItemModel.amount > 0 ? Colors.green : Colors.blue,
      ),
      title: Text(
        financeItemModel.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        DateFormat('yyyy/MM/dd hh:mm a').format(financeItemModel.dateTime),
      ),
      trailing: Directionality(
        textDirection: TextDirection.ltr, // Force LTR for the number
        child: Text(
          financeItemModel.amount < 0
              ? '-${financeItemModel.amount.abs()}'
              : '+${financeItemModel.amount}',
          style: const TextStyle(
            fontSize: 18,
          ), // Optional: adjust style if needed
        ),
      ),
    );
  }
}
